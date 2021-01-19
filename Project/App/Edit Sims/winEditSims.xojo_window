#tag Window
Begin Window winEditSims
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
   Height          =   330
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   180
   MaximumWidth    =   3200
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   180
   MinimumWidth    =   448
   Resizeable      =   False
   Title           =   "Bulk Action: Set Fleet"
   Type            =   8
   Visible         =   False
   Width           =   448
   Begin ccOKCancel ctlOK
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      HasBackgroundColor=   False
      Height          =   22
      InitialParent   =   ""
      Left            =   255
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   288
      Transparent     =   True
      Visible         =   True
      Width           =   173
   End
   Begin ccIndividualName ctlIndividual
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackgroundColor=   False
      Height          =   109
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   1
      Transparent     =   True
      Visible         =   True
      Width           =   448
   End
   Begin Label lblMultiple
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#kMultipleSelected"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   -47
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   408
   End
   Begin ccFleetStatusAccountSID ctlFleetStatus
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackgroundColor=   False
      Height          =   110
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   110
      Transparent     =   True
      Visible         =   True
      Width           =   448
   End
   Begin ccTimestamps ctlTimestamps
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackgroundColor=   False
      Height          =   68
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   219
      Transparent     =   True
      Visible         =   True
      Width           =   448
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub InsertUnique(toSim as Twilio.Sim)
		  for ti as Integer = 0 to aroUpdates.LastIndex
		    if aroUpdates(ti).sSID = toSim.sSID then
		      // Already in array, exit
		      return
		      
		    end
		    
		  next ti
		  
		  // Not in array, append
		  aroUpdates.Add(toSim)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load(toClient as Twilio.Client)
		  const kBottomHeight = 44
		  
		  // Load the fleet and status view
		  ctlFleetStatus.LoadFleets(toClient)
		  
		  // Set single / multiple interface
		  var tiCount as Integer = aroSims.Count
		  if tiCount = 1 then
		    ctlIndividual.LoadSim(aroSims(0))
		    ctlFleetStatus.LoadSim(aroSims(0))
		    ctlTimestamps.LoadSim(aroSims(0))
		    
		    // Set individual flag
		    mbIndividual = true
		    
		    // Padding for fields is in the container
		    ctlFleetStatus.Top = ctlIndividual.Top + ctlIndividual.Height - 12
		    ctlTimestamps.Top = ctlFleetStatus.Top + ctlFleetStatus.Height - 12
		    
		    // Set height
		    self.Height = ctlTimestamps.Top + ctlTimestamps.Height + kBottomHeight
		    
		  else
		    // Remove individual interface
		    ctlIndividual.Close
		    ctlTimestamps.Close
		    
		    // Set multiple to popup menus
		    ctlFleetStatus.LoadMultiple(aroSims)
		    
		    // Multiple header
		    lblMultiple.Text = kMultipleSelected.Replace("%count%", aroSims.Count.ToString)
		    lblMultiple.Top = 20
		    
		    // Padding for fields is in the container
		    ctlFleetStatus.Top = lblMultiple.Top + lblMultiple.Height
		    
		    // Set height
		    self.Height = ctlFleetStatus.Top + ctlFleetStatus.Height + kBottomHeight
		    
		  end
		  
		  ctlOK.DefaultButton.Caption = "Save"
		  ctlOK.DefaultButton.Enabled = false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrepareSave()
		  // Check each sim for changes and pass it to the updates array to upload them
		  for each toSim as Twilio.Sim in aroSims
		    // Name
		    if mbIndividual then
		      if toSim.sUniqueName.Compare(ctlIndividual.sUniqueName, ComparisonOptions.CaseSensitive) <> 0 then
		        toSim.sUniqueName = ctlIndividual.sUniqueName
		        InsertUnique(toSim)
		        
		      end
		      
		    end
		    
		    // Fleet
		    if   ctlFleetStatus.GetFleet <> nil and _ // Fleet was set
		      (toSim.oFleet = nil or (toSim.oFleet.sSID <> ctlFleetStatus.GetFleet.sSID)) then // Fleet doesn't match existing
		      toSim.oFleet = ctlFleetStatus.GetFleet
		      InsertUnique(toSim)
		      
		    end
		    
		    // Status
		    if  ctlFleetStatus.GetStatus <> Twilio.Sim.Status.Unknown and _ // Status was set
		      toSim.eStatus <> ctlFleetStatus.GetStatus then // Status doesn't match existing
		      toSim.eStatus = ctlFleetStatus.GetStatus
		      InsertUnique(toSim)
		      
		    end
		    
		  next toSim
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		aroSims() As Twilio.Sim
	#tag EndProperty

	#tag Property, Flags = &h0
		aroUpdates() As Twilio.Sim
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbIndividual As Boolean
	#tag EndProperty


	#tag Constant, Name = kMultipleSelected, Type = String, Dynamic = False, Default = \"Editing %count% Sims", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ctlOK
	#tag Event
		Sub ClickedCancel()
		  self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClickedDefault()
		  PrepareSave
		  
		  self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ctlIndividual
	#tag Event
		Sub ValueChanged()
		  ctlOK.DefaultButton.Enabled = true
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ctlFleetStatus
	#tag Event
		Sub ValueChanged()
		  ctlOK.DefaultButton.Enabled = true
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
