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
   Width           =   600
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
      Left            =   304
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
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
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
      InitialValue    =   "Unique Name"
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
      Width           =   560
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
	#tag Method, Flags = &h0
		Sub LoadSims()
		  // Disable UI
		  btnReload.Enabled = false
		  lbSims.Enabled = false
		  pwWait.Visible = true
		  txtSearch.Enabled = false
		  
		  // Set client auth and reload sim list
		  oClient.sSID   = App.Settings.Lookup("TwilioAuthSID", "").StringValue
		  oClient.sToken = App.Settings.Lookup("TwilioAuthToken", "").StringValue
		  
		  oClient.ListSims
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events oClient
	#tag Event
		Sub SimListComplete(taroSims() as Twilio.Sim)
		  // Re-enable UI
		  btnReload.Enabled = true
		  pwWait.Visible = false
		  txtSearch.Enabled = true
		  
		  lbSims.RemoveAllRows
		  
		  // Load Listbox
		  for each toSim as Twilio.Sim in taroSims
		    lbSims.AddRow(toSim.sUniqueName)
		    lbSims.RowTagAt(lbSims.LastAddedRowIndex) = toSim
		    
		  next toSim
		  
		  lbSims.Enabled = true
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
#tag EndEvents
#tag Events btnReload
	#tag Event
		Sub Action()
		  // Reload Sims
		  LoadSims
		End Sub
	#tag EndEvent
#tag EndEvents
