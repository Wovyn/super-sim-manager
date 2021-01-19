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
   Height          =   420
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   786071551
   MenuBarVisible  =   True
   MinimumHeight   =   240
   MinimumWidth    =   800
   Resizeable      =   True
   Title           =   "Super Sim Manager"
   Type            =   0
   Visible         =   False
   Width           =   1024
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
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   914
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
      Left            =   720
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   284
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
      ColumnWidths    =   "*,170,60,0.8*,80,110,150"
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
      Top             =   54
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   984
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ProgressWheel pwWait
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   17
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   886
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
   Begin CheckBox chkAll
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   " Select All"
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
      Left            =   23
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   28
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   100
   End
   Begin PushButton btnEdit
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#kEditSims"
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   380
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label lblSelected
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
      Left            =   254
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
      Text            =   "Selection"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   380
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   516
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  // Can only export if we have data
		  FileExport.Enabled = (lbSims.RowCount > 0)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  SetEnabledState
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			self.Close
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			// Get TSV from hidden Xojo feature
			var tsTSV as String = lbSims.CellValueAt(-1, -1)
			var tsCSV as String = tsTSV.ReplaceAll(Encodings.UTF8.Chr(9), ",")
			
			var tfCSV as new FileType
			tfCSV.Name = "CSV"
			tfCSV.Extensions = ".csv"
			
			var tmd as new SaveFileDialog
			tmd.Filter = tfCSV
			tmd.SuggestedFileName = "Sim Export.csv"
			
			var tfDest as FolderItem = tmd.ShowModal
			
			// User cancelled
			if tfDest = nil then return true
			
			try
			var tos as TextOutputStream = TextOutputStream.Create(tfDest)
			tos.Write(tsCSV)
			tos.Close
			
			catch ex as IOException
			MessageBox("Export Error" + EndOfLine + EndOfLine + ex.Message)
			
			end try
			
			return true
			
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
		  
		  // Clear existing selection
		  chkAll.Value = false
		  chkAll.Enabled = false
		  
		  // Reset load flags
		  mbAuthenticationFailed = false
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
		  
		  // Retain selections
		  var tarsSelectedSids() as String
		  for ti as Integer = (lbSims.RowCount - 1) downto 0
		    if lbSims.CellCheckBoxValueAt(ti, 0) = true then
		      var toTag as Twilio.Sim = lbSims.RowTagAt(ti)
		      tarsSelectedSids.Add(toTag.sSID)
		      
		    end
		    
		  next ti
		  
		  // Clear
		  lbSims.RemoveAllRows
		  
		  // Correct sort indicator
		  lbSims.HasHeader = false
		  lbSims.SortingColumn = 0
		  lbSims.ColumnSortDirectionAt(0) = Listbox.SortDirections.Ascending
		  lbSims.HasHeader = true
		  
		  // Cache search
		  var tsSearch as String = txtSearch.Text.Trim
		  
		  // Load Listbox
		  for each toSim as Twilio.Sim in oClient.aroSims
		    // Handle search entirely in Xojo code, is fast, is fine.
		    if tsSearch <> "" then
		      if  (toSim.sUniqueName.IndexOf(tsSearch) < 0) and _
		        (toSim.sICCID.IndexOf(tsSearch) < 0) then
		        
		        // Check fleet
		        if toSim.oFleet <> nil then
		          if toSim.oFleet.sUniqueName.IndexOf(tsSearch) < 0 then
		            
		            // Check Network Access Profile
		            if toSim.oFleet.oNetworkAccessProfile <> nil then
		              if toSim.oFleet.oNetworkAccessProfile.sUniqueName.IndexOf(tsSearch) < 0 then
		                // Not a match
		                continue for toSim
		                
		              else
		                // Allow: search match Network Access Profile
		                
		              end
		              
		            else
		              // No Network Access Profile, not a match
		              continue for toSim
		              
		            end
		            
		          else
		            // Allow: search match Fleet
		            
		          end
		          
		        else
		          // No fleet, not a match
		          continue for toSim
		          
		        end
		        
		      else
		        // Allow: search match Name or iccid
		        
		      end
		      
		    end
		    
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
		      tarsRow.Add(toSim.dtmCreated.SQLDateTime)
		      
		    else
		      tarsRow.Add("Unknown")
		      
		    end
		    
		    // Add row and retain objects
		    lbSims.AddRow(tarsRow)
		    lbSims.RowTagAt(lbSims.LastAddedRowIndex) = toSim
		    
		    // Restore selection
		    if tarsSelectedSids.IndexOf(toSim.sSID) > -1 then
		      lbSims.CellCheckBoxValueAt(lbSims.LastAddedRowIndex, 0) = true
		      
		    end
		    
		  next toSim
		  
		  SyncCheckAllState
		  SetEnabledState
		  lbSims.Enabled = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetEnabledState()
		  // Sets bulk action button states
		  btnEdit.Enabled = false
		  
		  var tiSelectedCount as Integer
		  
		  for ti as Integer = (lbSims.RowCount - 1) downto 0
		    if lbSims.CellCheckBoxValueAt(ti, 0) = true then
		      // Something is selected
		      btnEdit.Enabled = true
		      
		      // Count selection
		      tiSelectedCount = tiSelectedCount + 1
		      
		    end
		    
		  next ti
		  
		  // Set plural state
		  btnEdit.Caption = if(tiSelectedCount = 1, kEditSim, kEditSims)
		  
		  // Set selection count
		  if tiSelectedCount < 1 then
		    lblSelected.Text = "No Selection"
		    
		  else
		    lblSelected.Text = tiSelectedCount.ToString + " / " + lbSims.RowCount.ToString + " Selected"
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncCheckAllState()
		  // Syncs the chkAll state to the Listbox selection
		  var tbChecked, tbUnchecked as Boolean
		  
		  // Determine state (Checked, Unchecked, or Indeterminate (both))
		  for ti as Integer = (lbSims.RowCount - 1) downto 0
		    if lbSims.CellCheckBoxValueAt(ti, 0) = true then
		      tbChecked = true
		      
		    else
		      tbUnchecked = true
		      
		    end
		    
		  next ti
		  
		  chkAll.Enabled = false
		  
		  if tbChecked and not tbUnchecked then
		    chkAll.VisualState = CheckBox.VisualStates.Checked
		    
		  elseif not tbChecked and tbUnchecked then
		    chkAll.VisualState = CheckBox.VisualStates.Unchecked
		    
		  else
		    chkAll.VisualState = CheckBox.VisualStates.Indeterminate
		    
		  end
		  
		  chkAll.Enabled = true
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mbAuthenticationFailed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbLoadedFleets As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbLoadedProfiles As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbLoadedSims As Boolean
	#tag EndProperty


	#tag Constant, Name = kEditSim, Type = String, Dynamic = False, Default = \"Edit Sim", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kEditSims, Type = String, Dynamic = False, Default = \"Edit Sims", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kMonospacedFont, Type = String, Dynamic = False, Default = \"Courier New", Scope = Private
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Menlo"
	#tag EndConstant


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
		Sub FleetListComplete()
		  // Sort the fleets by name for assignment list
		  var tarsNames() as String
		  for each toFleet as Twilio.Fleet in me.aroFleets
		    tarsNames.Add(toFleet.sUniqueName)
		    
		  next toFleet
		  
		  tarsNames.SortWith(me.aroFleets)
		  
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
		  
		  me.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  if me.Enabled = false then return
		  
		  // Sync Check All state
		  if column = 0 then
		    SyncCheckAllState
		    
		  end
		  
		  SetEnabledState
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  #pragma unused row
		  #pragma unused x
		  #pragma unused y
		  
		  if column = 1 or column = 6 then
		    g.FontName = kMonospacedFont
		    
		  end
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events chkAll
	#tag Event
		Sub Action()
		  // Set Check All state
		  if me.Enabled = false then return
		  
		  lbSims.Enabled = false
		  
		  for ti as Integer = (lbSims.RowCount - 1) downto 0
		    lbSims.CellCheckBoxValueAt(ti, 0) = me.Value
		    
		  next ti
		  
		  lbSims.Enabled = true
		  
		  SetEnabledState
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnEdit
	#tag Event
		Sub Action()
		  // Request the new status
		  var toSelectNew as new winBulkSetStatus
		  toSelectNew.ShowModalWithin(self)
		  
		  // User cancelled
		  if toSelectNew.sNewStatus = "" then return
		  
		  var tmd as new MessageDialog
		  tmd.Message = "Not Yet Implemented"
		  tmd.Explanation = "This feature has not yet been implemented while we await API write permission."
		  
		  call tmd.ShowModalWithin(self)
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
