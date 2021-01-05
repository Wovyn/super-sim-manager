#tag Module
Protected Module TwilioSim
	#tag Method, Flags = &h21
		Private Sub Credentials()
		  // Centralized way to get settings from dictionary
		  var tsSID as String   = App.Settings.Lookup("TwilioAuthSID", "").StringValue
		  var tsToken as String = App.Settings.Lookup("TwilioAuthToken", "").StringValue
		  
		End Sub
	#tag EndMethod


End Module
#tag EndModule
