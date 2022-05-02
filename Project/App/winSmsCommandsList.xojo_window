#tag Window
Begin Window winSmsCommandsList
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   3
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   428
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   180
   MaximumWidth    =   3200
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   180
   MinimumWidth    =   448
   Resizeable      =   False
   Title           =   "View Sms Commands"
   Type            =   8
   Visible         =   False
   Width           =   814
   Begin Twilio.Client oClient
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      sSID            =   ""
      sToken          =   ""
      TabPanelIndex   =   0
   End
   Begin PushButton btnReload
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Reload"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   686
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   380
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin Listbox lbSims
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   True
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   6
      ColumnWidths    =   "140,140,140,*,80,110"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   314
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Sid	Account Sid	Sim Sid	Payload	Status	Created"
      Italic          =   False
      Left            =   38
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   738
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ProgressWheel pwWait
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   17
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   658
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   383
      Transparent     =   False
      Visible         =   False
      Width           =   16
   End
End
#tag EndWindow

#tag WindowCode

    #tag Property, Flags = &h21
		Private mbAuthenticationFailed As Boolean
	#tag EndProperty
	
	// the sids of selected sims in the Sims List; this list is needed for the reload button
	#tag Property, Flags = &h0
		selectedSimSIDs() As String
	#tag EndProperty	
	
    // the sims sids that needs to be processed
	#tag Property, Flags = &h0
		readRequestSimSIDs() As String
	#tag EndProperty	
	
	// contains all the smscommands for all the selected sims
	#tag Property, Flags = &h0
		simsSmsCommandsList() As Twilio.SmsCommand
	#tag EndProperty
	
	#tag Event
		Sub Open()
		
		  oClient.smsCommands.ResizeTo(-1)
		  oClient.sSID   = App.Settings.Lookup("TwilioAuthSID", "").StringValue
		  oClient.sToken = App.Settings.Lookup("TwilioAuthToken", "").StringValue
		  
		  System.DebugLog("winSmsCommands Open called.")
		  
		End Sub
	#tag EndEvent
	
	#tag Method, Flags = &h0
		Sub Load(simSids() as String)
		
		  System.DebugLog("winSmsCommands Load called.")
		  
		  simsSmsCommandsList.ResizeTo(-1)
		  oClient.smsCommands.ResizeTo(-1)
		  oClient.sSID   = App.Settings.Lookup("TwilioAuthSID", "").StringValue
		  oClient.sToken = App.Settings.Lookup("TwilioAuthToken", "").StringValue
		  
		  // the selected sim sids are stored in the winSmsCommandsList variable selectedSimSIDs and readRequestSimSIDs
		  // open winsmscommand window
		  // winsmscommand window fetches the smscommands for each sim sid
		  //   the spinner spins until all sms commands are fetched
		  //   how:
		  //      loop each sim sid and send a read sms command request to twilio until the readRequestSimSIDs is empty
		  //      add all the sms commands from the response to the simsSmsCommandsList of the winSmsCommandList window
		  //      remove the simSid from the readRequestSimSIDs
		  
		  selectedSimSIDs = simSids
		  readRequestSimSIDs = simSids
		  
		  System.DebugLog("winSmsCommands selected sims count: " + selectedSimSIDs.Count.ToString)
		  LoadSmsCommands()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadSmsCommands()
		  
		  System.DebugLog("winSmsCommands LoadSmsCommands called.")
		  // Reset load flags
		  mbAuthenticationFailed = false
		  // fetch the smscommands for each sim sid on
		  //   the spinner spins until all sms commands are fetched
		  //   how:
		  //      get the first sim sid from the readRequestSimSIDs(removing the item from the array after storing the sim id)
		  //      get from twilio the sms commands for the sim sid (oClient.FetchSMSCommands("", simSid))      
		  //      the oClient request success event will call the function that 
		  //         will add all the sms commands from the response to the simsSmsCommandsList of the winSmsCommandList window
		  //         the event function will check if there are more sims ids to process
		  //           if there are it will call oClient.FetchSMSCommands("", simSid) once more, the simSid being the next item on the readRequestSimSIDs
		  //           if there are no more items to process stop the spinner and re-enable the reload button
		  //      if there is an error and it can be retried add the oClient request error event will call the function that
		  //         will add the sim sid back to the readRequestSimSIDs and retry the request?
		  
		  if readRequestSimSIDs.Count < 1 then
		    System.DebugLog("winSmsCommands LoadSmsCommands: All readRequestSimSIDs has been processed.")
		    return
		  end
		  
		  var simSid as String = readRequestSimSIDs(0)
		  System.DebugLog("winSmsCommands LoadSmsCommands called for sim sid: " + simSid)
		  readRequestSimSIDs.RemoveAt(0)
		  oClient.FetchSMSCommands("", simSid)
		  //System.DebugLog("winSmsCommands LoadSmsCommands: after calling oClient.FetchSMSCommands")
		  
		End Sub
	#tag EndMethod

	#tag Constant, Name = kMultipleSelected, Type = String, Dynamic = False, Default = \"View %count% SMS Commands", Scope = Private
	#tag EndConstant

#tag EndWindowCode

#tag Events btnReload
	#tag Event
		Sub Action()
		  System.DebugLog("winSmsCommands btnReload clicked.")
		  //disable reload button
		  me.Enabled = false
		  // Reload Client
		  
		  simsSmsCommandsList.ResizeTo(-1)
		  oClient.smsCommands.ResizeTo(-1)
		  oClient.sSID   = App.Settings.Lookup("TwilioAuthSID", "").StringValue
		  oClient.sToken = App.Settings.Lookup("TwilioAuthToken", "").StringValue
		  
		  readRequestSimSIDs = selectedSimSIDs
		  LoadSmsCommands
		End Sub
	#tag EndEvent
#tag EndEvents

#tag Events oClient
	#tag Event
		Sub SimFetchSMSCommandsComplete(simSID as String)
		  // event listener for Twilio.SimFetchSMSCommandsComplete event
		  System.DebugLog("SimFetchSMSCommandsComplete called for sim '" + simSID + "'." )
		  // add to processedSelectedSimSIDs
		  
		  // me.smsCommands contains the sim's sms commands	   
		  
		  For Each smsCommand As Twilio.SmsCommand In me.smsCommands
			  System.DebugLog("Sms Command sid: " + smsCommand.sID)
			  // https://www.twilio.com/docs/iot/supersim/api/smscommand-resource#read-multiple-smscommand-resources
			  // add to the array that holds all the sms commands for all selected sims (simsSmsCommandsList)
			  //  AND add them to the table right away?
			  
			  simsSmsCommandsList.Add(smsCommand) 			  
		  Next smsCommand
		  
		 if( readRequestSimSIDs.Count < 1 ) then
		   // all sim's sms commands were fetched
		   System.DebugLog("SimFetchSMSCommandsComplete ALL sims sms commands fetched!" )
		   
		   btnReload.Enabled = true
		   pwWait.Visible = false 
		   // load items to table
		   
		 end
		 
		End Sub
	#tag EndEvent
	#tag Event
		Sub ServerResponse(toErr as Twilio.RequestError)
		  // Prevent multiple notifications
		  if mbAuthenticationFailed = true then return
		  
		  // Re-enable UI
		  btnReload.Enabled = true
		  pwWait.Visible = false
		  
		  // Tell user about error
		  var tmd as new MessageDialog
		  
		  if toErr.ErrorNumber = 20003 then
		    tmd.Message = "Authentication Failed"
		    tmd.Explanation = toErr.Message
		    
		    mbAuthenticationFailed = true
		    
		  else
		    tmd.Message = "Server Response Failure"
		    tmd.Explanation = toErr.Message
		    
		  end
		  
		  call tmd.ShowModalWithin(self)
		  
		  // Show settings window if auth failed
		  if toErr.ErrorNumber = 20003 then
		    winSettings.Show
		    self.Visible = false
		    
		  end
		End Sub
	#tag EndEvent
	#tag Event
		Sub RequestError(ex as RuntimeException)
		  // Re-enable UI
		  btnReload.Enabled = true
		  pwWait.Visible = false
		  
		  var tmd as new MessageDialog
		  tmd.Message = "Server Response Failure"
		  tmd.Explanation = ex.Message
		  
		  System.DebugLog("RequestError " + ex.Message)
		  
		  call tmd.ShowModalWithin(self)
		End Sub
	#tag EndEvent
#tag EndEvents 
// END oClient

#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
