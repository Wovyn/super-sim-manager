#tag Window
Begin ContainerControl ccFleetStatusAccountSID
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
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   448
   Begin PopupMenu pmFleet
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
      InitialValue    =   "Fleet List"
      Italic          =   False
      Left            =   128
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   12
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   300
   End
   Begin Label lblFleet
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Fleet:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   13
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin Label lblStatus
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Status:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   46
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin PopupMenu pmStatus
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
      InitialValue    =   "Value"
      Italic          =   False
      Left            =   128
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   44
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin Label lblAccountSID
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Account SID:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   78
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin Label lblAccountSIDValue
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "#kMonospacedFont"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   128
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   True
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "value"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   78
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   300
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub LoadFleets(toClient as Twilio.Client)
		  pmFleet.Enabled = false
		  pmFleet.RemoveAllRows
		  
		  for each toFleet as Twilio.Fleet in toClient.aroFleets
		    pmFleet.AddRow(toFleet.sUniqueName)
		    pmFleet.RowTagAt(pmFleet.LastAddedRowIndex) = toFleet
		    
		  next toFleet
		  
		  // No fleets on this account
		  if pmFleet.RowCount < 1 then
		    pmFleet.AddRow("No Fleets")
		    
		  end
		  
		  pmFleet.SelectedRowIndex = 0
		  pmFleet.Enabled = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadMultiple(aroSelection() as Twilio.Sim)
		  const kMultipleSelected = "Multiple SIMs Selected"
		  
		  // Load default values
		  LoadSim(aroSelection(0))
		  
		  pmFleet.AddRowAt(0, kMultipleSelected)
		  pmFleet.AddRowAt(1, MenuItem.TextSeparator)
		  pmFleet.SelectedRowIndex = 0
		  
		  pmStatus.RemoveAllRows
		  
		  pmStatus.AddRow(kMultipleSelected)
		  pmStatus.AddRow(MenuItem.TextSeparator)
		  
		  pmStatus.AddRowAndTag(Twilio.Sim.Status.Ready.ToString, Twilio.Sim.Status.Ready)
		  pmStatus.AddRowAndTag(Twilio.Sim.Status.Active.ToString, Twilio.Sim.Status.Active)
		  pmStatus.AddRowAndTag(Twilio.Sim.Status.Inactive.ToString, Twilio.Sim.Status.Inactive)
		  
		  pmStatus.Width = 200
		  pmStatus.SelectedRowIndex = 0
		  
		  // Remove Ready if selection contains something not new or ready
		  for each toSim as Twilio.Sim in aroSelection
		    if not (toSim.eStatus = Twilio.Sim.Status.NewState or toSim.eStatus = Twilio.Sim.Status.Ready) then
		      pmStatus.RemoveRowAt(2)
		      exit for toSim
		      
		    end
		    
		  next toSim
		  
		  // Set Account SID to multiple if necessary
		  for each toSim as Twilio.Sim in aroSelection
		    if aroSelection(0).sAccountSID <> toSim.sAccountSID then
		      lblAccountSIDValue.Text = kMultipleSelected
		      exit for toSim
		      
		    end
		    
		  next toSim
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadSim(toSim as Twilio.Sim)
		  // Load SIM to UI
		  
		  // Fleet
		  for ti as Integer = 0 to (pmFleet.RowCount - 1)
		    var toTag as Twilio.Fleet = pmFleet.RowTagAt(ti)
		    if toTag = nil then continue for ti
		    
		    if toSim.oFleet <> nil and toTag.sSID = toSim.oFleet.sSID then
		      pmFleet.SelectedRowIndex = ti
		      exit for ti
		      
		    end
		    
		  next ti
		  
		  // Status
		  LoadStatusByCurrent(toSim.eStatus)
		  
		  // Account SID
		  lblAccountSIDValue.Text = toSim.sAccountSID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadStatusByCurrent(teCurrentStatus as Twilio.Sim.Status)
		  // The status menu options differ by current state
		  pmStatus.RemoveAllRows
		  
		  select case teCurrentStatus
		  case Twilio.Sim.Status.NewState
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.NewState.ToString, Twilio.Sim.Status.NewState)
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Ready.ToString, Twilio.Sim.Status.Ready)
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Active.ToString, Twilio.Sim.Status.Active)
		    
		    pmStatus.SelectedRowIndex = 0
		    
		  case Twilio.Sim.Status.Ready
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Ready.ToString, Twilio.Sim.Status.Ready)
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Active.ToString, Twilio.Sim.Status.Active)
		    
		    pmStatus.SelectedRowIndex = 0
		    
		  case Twilio.Sim.Status.Active
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Active.ToString, Twilio.Sim.Status.Active)
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Inactive.ToString, Twilio.Sim.Status.Inactive)
		    
		    pmStatus.SelectedRowIndex = 0
		    
		  case Twilio.Sim.Status.Inactive
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Active.ToString, Twilio.Sim.Status.Active)
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Inactive.ToString, Twilio.Sim.Status.Inactive)
		    
		    pmStatus.SelectedRowIndex = 1
		    
		  case Twilio.Sim.Status.Scheduled
		    pmStatus.AddRowAndTag(Twilio.Sim.Status.Scheduled.ToString, Twilio.Sim.Status.Scheduled)
		    pmStatus.Enabled = false
		    pmStatus.SelectedRowIndex = 0
		    
		  end select
		End Sub
	#tag EndMethod


#tag EndWindowCode

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
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
