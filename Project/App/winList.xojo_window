#tag Window
Begin Window winList
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   3
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   786071551
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Twilio Super Sim Manager"
   Type            =   0
   Visible         =   False
   Width           =   800
   Begin Twilio.Client oClient
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   1
      TabPanelIndex   =   0
   End
   Begin PushButton btnReload
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Reload"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin SearchField txtSearch
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      ClearMenuItemValue=   "Clear"
      Enabled         =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   504
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   276
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
      ColumnCount     =   7
      ColumnWidths    =   "*,*,60,*,80"
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
      Height          =   322
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	iccid	Status	Fleet	Data Limit	NAP	Date Created\n"
      Italic          =   False
      Left            =   20
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
      Top             =   58
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   760
      _ScrollWidth    =   -1
   End
   Begin ProgressWheel pwWait
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   22
      Transparent     =   False
      Visible         =   False
      Width           =   16
   End
End
#tag EndWindow

#tag WindowCode
	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			self.Close
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub HandleLoadResponse()
		  // Wait for all the parts to load, then assemble the associations
		  if not mbLoadedFleets then return
		  if not mbLoadedProfiles then return
		  if not mbLoadedSims then return
		  
		  // Parts are loaded, apply associations
		  oClient.ApplyAssociations
		  
		  // Reload list
		  ReloadList
		  
		  // Re-enable UI
		  btnReload.Enabled = true
		  pwWait.Visible = false
		  txtSearch.Enabled = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadClient()
		  // Disable UI
		  btnReload.Enabled = false
		  lbSims.Enabled = false
		  pwWait.Visible = true
		  txtSearch.Enabled = false
		  txtSearch.Text = ""
		  
		  // Reset load flags
		  mbLoadedFleets = false
		  mbLoadedProfiles = false
		  mbLoadedSims = false
		  
		  // Set client auth and reload sim list
		  oClient.sSID   = App.Settings.Lookup("TwilioAuthSID", "").StringValue
		  oClient.sToken = App.Settings.Lookup("TwilioAuthToken", "").StringValue
		  
		  oClient.ListFleets
		  oClient.ListProfiles
		  oClient.ListSims
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReloadList()
		  lbSims.Enabled = false
		  lbSims.RemoveAllRows
		  
		  var tsSearch as String = txtSearch.Text.Trim
		  
		  // Load Listbox
		  for each toSim as Twilio.Sim in oClient.aroSims
		    // Handle search
		    if tsSearch <> "" and toSim.sUniqueName.IndexOf(tsSearch) < 0 then continue
		    
		    // Add row
		    var tarsRow() as String
		    
		    // Name or iccid if empty
		    if toSim.sUniqueName.Trim <> "" then
		      tarsRow.Add(toSim.sUniqueName)
		      
		    else
		      tarsRow.Add(toSim.sICCID)
		      
		    end
		    
		    tarsRow.Add(toSim.sICCID)
		    tarsRow.Add(toSim.sStatus)
		    
		    // Fleet
		    if toSim.oFleet <> nil then
		      tarsRow.Add(toSim.oFleet.sUniqueName)
		      tarsRow.Add(toSim.oFleet.FormattedDataLimit)
		      
		      // Network Access Profile
		      if toSim.oFleet.oNetworkAccessProfile <> nil then
		        tarsRow.Add(toSim.oFleet.oNetworkAccessProfile.sUniqueName)
		        
		      else
		        tarsRow.Add("No Network Access Profile")
		        
		      end
		      
		    else
		      tarsRow.Add("No Fleet")
		      tarsRow.Add("0 MB")
		      tarsRow.Add("")
		      
		    end
		    
		    // Date created
		    if toSim.dtmCreated <> nil then
		      tarsRow.Add(toSim.dtmCreated.SQLDate)
		      
		    else
		      tarsRow.Add("Unknown")
		      
		    end
		    
		    // Add row and retain objects
		    lbSims.AddRow(tarsRow)
		    lbSims.RowTagAt(lbSims.LastAddedRowIndex) = toSim
		    
		  next toSim
		  
		  lbSims.Enabled = true
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mbLoadedFleets As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbLoadedProfiles As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbLoadedSims As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events oClient
	#tag Event
		Sub SimListComplete()
		  // Sort the Sims by name
		  var tarsNames() as String
		  for each toSim as Twilio.Sim in me.aroSims
		    tarsNames.Add(toSim.sUniqueName)
		    
		  next toSim
		  
		  tarsNames.SortWith(me.aroSims)
		  
		  // Check if ready to merge data
		  mbLoadedSims = true
		  HandleLoadResponse
		End Sub
	#tag EndEvent
	#tag Event
		Sub ServerResponse(toErr as Twilio.RequestError)
		  // Re-enable UI
		  btnReload.Enabled = true
		  pwWait.Visible = false
		  
		  // Tell user about error
		  var tmd as new MessageDialog
		  
		  if toErr.ErrorNumber = 20003 then
		    tmd.Message = "Authentication Failed"
		    tmd.Explanation = toErr.Message
		    
		  else
		    tmd.Message = "Server Response Failure"
		    tmd.Explanation = toErr.Message
		    
		  end
		  
		  call tmd.ShowModalWithin(self)
		End Sub
	#tag EndEvent
	#tag Event
		Sub FleetListComplete()
		  // Check if ready to merge data
		  mbLoadedFleets = true
		  HandleLoadResponse
		End Sub
	#tag EndEvent
	#tag Event
		Sub ProfileListComplete()
		  // Check if ready to merge data
		  mbLoadedProfiles = true
		  HandleLoadResponse
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnReload
	#tag Event
		Sub Action()
		  // Reload Client
		  LoadClient
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtSearch
	#tag Event
		Sub TextChanged()
		  // Handle search
		  if me.Enabled then
		    ReloadList
		    
		  end
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lbSims
	#tag Event
		Sub Open()
		  // Set alignment
		  me.ColumnAlignmentAt(2) = Listbox.Alignments.Center
		  me.ColumnAlignmentAt(4) = Listbox.Alignments.Center
		End Sub
	#tag EndEvent
#tag EndEvents
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
