#tag Window
Begin Window winUpdate
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   3
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   False
   Height          =   260
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   128
   MinimumWidth    =   420
   Resizeable      =   True
   Title           =   "Updating SIMs"
   Type            =   8
   Visible         =   False
   Width           =   420
   Begin PushButton btnStop
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Stop"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   320
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   220
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Twilio.Client oClient
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   1
      sSID            =   ""
      sToken          =   ""
      TabPanelIndex   =   0
   End
   Begin Timer tmrRelay
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   250
      RunMode         =   1
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Listbox lbQueue
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "*,80"
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
      Height          =   180
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "SIM	Status"
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   380
      _ScrollWidth    =   -1
      Begin ProgressWheel pwProcessing
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "lbQueue"
         Left            =   310
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   -100
         Transparent     =   False
         Visible         =   True
         Width           =   16
      End
   End
   Begin Label lblSummary
      AllowAutoDeactivate=   True
      Bold            =   True
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Status Summary"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   220
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   288
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  // Paint the background behind the status label
		  #pragma unused areas
		  
		  if lblSummary.Visible then
		    // Desaturate the color
		    var tcSource as Color = if(mbError, Color.Red, Color.Green)
		    var tcDraw as Color = Color.RGB(tcSource.Red, tcSource.Green, tcSource.Blue, 150)
		    
		    g.DrawingColor = tcDraw
		    g.FillRectangle(lblSummary.Left, lblSummary.Top, lblSummary.Width, lblSummary.Height)
		    
		  end
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandleQueue()
		  // Relayed stop
		  if mbStop then
		    btnStop.Caption = "Close"
		    btnStop.Enabled = true
		    return
		    
		  end
		  
		  if aroUpdateSims.LastIndex > -1 then
		    // Grab and update the next Sim
		    // Cache in case of request error
		    moCurrent = aroUpdateSims(0)
		    aroUpdateSims.RemoveAt(0)
		    
		    UpdateSim(moCurrent)
		    
		  else
		    // Queue complete!
		    // Allows a cycle but condenses reload/close code paths
		    btnStop.Enabled = false
		    StopAndClose
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Prepare()
		  // Sort the sims by name
		  var tarsNames() as String
		  for each toSim as Twilio.Sim in aroUpdateSims
		    tarsNames.Add(toSim.sUniqueName)
		    
		  next toSim
		  
		  tarsNames.SortWith(aroUpdateSims)
		  
		  // Prepare the listbox
		  for each toSim as Twilio.Sim in aroUpdateSims
		    lbQueue.AddRow(toSim.sUniqueName)
		    lbQueue.RowTagAt(lbQueue.LastAddedRowIndex) = toSim
		    
		  next toSim
		  
		  // Hide the status
		  lblSummary.Visible = false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetRowStatus(toFind as Twilio.Sim, tsStatus as String)
		  // Find the SIM row
		  for ti as Integer = 0 to lbQueue.LastRowIndex
		    var toRowSim as Twilio.Sim = lbQueue.RowTagAt(ti)
		    if toFind.sSID = toRowSim.sSID then
		      lbQueue.CellValueAt(ti, 1) = tsStatus
		      pwProcessing.Top = -100
		      
		      exit for ti
		      
		    end
		    
		  next ti
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StopAndClose()
		  mbStop = true
		  
		  if mbError then
		    lblSummary.Text = "An error occurred, please review."
		    System.Beep
		    
		  else
		    lblSummary.Text = "Successfully updated all selected SIMs."
		    
		  end
		  
		  lblSummary.Visible = true
		  self.Invalidate
		  
		  HandleQueue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSim(toSim as Twilio.Sim)
		  // Move the ProgressWheel
		  // Scroll the list
		  // Update the sim
		  
		  var tiContentHeight as Integer = lbQueue.Height - lbQueue.HeaderHeight
		  var tiProgressWheelLeft as Integer = lbQueue.Left + lbQueue.ColumnAt(0).WidthActual + _
		  (lbQueue.ColumnAt(1).WidthActual / 2)
		  
		  for ti as Integer = 0 to lbQueue.LastRowIndex
		    var toTag as Twilio.Sim = lbQueue.RowTagAt(ti)
		    if toTag.sSID = toSim.sSID then
		      // This row
		      var tiRowTop as Integer = (ti * lbQueue.RowHeight) + lbQueue.HeaderHeight
		      if tiRowTop < tiContentHeight then
		        // 3px margin to horizontally center progress wheel
		        pwProcessing.Top = tiRowTop + lbQueue.Top + 3
		        
		      else
		        lbQueue.ScrollPosition = tiRowTop + lbQueue.RowHeight
		        tiRowTop = lbQueue.Top + lbQueue.Height - lbQueue.RowHeight
		        pwProcessing.Top = tiRowTop
		        
		      end
		      
		      pwProcessing.Left = tiProgressWheelLeft
		      
		      exit for ti
		      
		    end
		    
		  next ti
		  
		  oClient.UpdateSim(toSim)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		aroUpdateSims() As Twilio.Sim
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbDarkMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbError As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbStop As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private moCurrent As Twilio.Sim
	#tag EndProperty


#tag EndWindowCode

#tag Events btnStop
	#tag Event
		Sub Action()
		  if me.Caption = "Stop" then
		    me.Enabled = false
		    StopAndClose
		    
		  elseif me.Caption = "Close" then
		    winList.LoadClient
		    self.Close
		    
		  end
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events oClient
	#tag Event
		Sub RequestError(ex as RuntimeException)
		  // Only announce once
		  if not mbError then
		    var tmd as new MessageDialog
		    tmd.Message = "Server Response Failure"
		    tmd.Explanation = ex.Message
		    
		    call tmd.ShowModal
		    
		  end
		  
		  mbError = true
		  
		  SetRowStatus(moCurrent, "Fail")
		  
		  // Next
		  HandleQueue
		End Sub
	#tag EndEvent
	#tag Event
		Sub SimUpdateSuccess(toSim as Twilio.Sim)
		  SetRowStatus(toSim, "Success")
		  
		  HandleQueue
		End Sub
	#tag EndEvent
	#tag Event
		Sub ServerResponse(toErr as Twilio.RequestError)
		  // Only announce once
		  if not mbError then
		    var tmd as new MessageDialog
		    tmd.Message = "Unexpected Server Response"
		    tmd.Explanation = toErr.Message
		    
		    call tmd.ShowModal
		    
		  end
		  
		  mbError = true
		  
		  SetRowStatus(moCurrent, "Fail")
		  
		  // Next
		  HandleQueue
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tmrRelay
	#tag Event
		Sub Action()
		  // Timer to relay start of processing due to ShowModal
		  HandleQueue
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lbQueue
	#tag Event
		Sub Open()
		  me.ColumnAlignmentAt(1) = Listbox.Alignments.Center
		  me.ColumnSortTypeAt(0) = Listbox.SortTypes.NotSortable
		  me.ColumnSortTypeAt(1) = Listbox.SortTypes.NotSortable
		End Sub
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  // Cache Dark Mode setting (it's expensive)
		  if row = 0 and column = 0 then
		    mbDarkMode = Color.IsDarkMode
		    
		  end
		  
		  g.DrawingColor = if(mbDarkMode, &c111111, &cf2f2f2)
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  return true
		End Function
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
