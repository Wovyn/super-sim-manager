#tag Class
Protected Class App
Inherits Application
	#tag Event
		Function CancelClose() As Boolean
		  try
		    // Save the settings
		    var tsSettings as String = GenerateJSON(Settings)
		    
		    var tfSettings as FolderItem = DataFolder.Child("settings.json")
		    var tos as TextOutputStream = TextOutputStream.Create(tfSettings)
		    
		    tos.Write(tsSettings)
		    tos.Close
		    
		  catch ex as IOException
		    // Something has gone awry but we can't really recover from it
		    
		  end try
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  if Settings.Lookup("TwilioAuthSID", "") = "" then
		    // Not setup yet
		    winSettings.Show
		    
		  else
		    // Show list
		    winList.LoadClient
		    winList.Show
		    
		  end
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditPrefs() As Boolean Handles EditPrefs.Action
			winSettings.Show
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAbout() As Boolean Handles HelpAbout.Action
			var tmd as new MessageDialog
			tmd.Message = "About Super Sim Manager"
			tmd.Explanation = "Version: " + App.ShortVersion
			
			call tmd.ShowModal
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpDevelopedBy() As Boolean Handles HelpDevelopedBy.Action
			// Developed by Tim Parnell
			ShowURL("https://xojoconsulting.com")
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpGithubProject() As Boolean Handles HelpGithubProject.Action
			ShowURL("https://github.com/Wovyn/super-sim-manager")
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpSponsoredBy() As Boolean Handles HelpSponsoredBy.Action
			// Sponsored by Wovyn, L.L.C.
			ShowURL("https://wovyn.com/")
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function DataFolder() As FolderItem
		  if mfDataFolder = nil then
		    // Be a good Linux citizen
		    #if TargetLinux then
		      mfDataFolder = SpecialFolder.ApplicationData.Child("." + kBundleIdentifier)
		      
		    #else
		      mfDataFolder = SpecialFolder.ApplicationData.Child(kBundleIdentifier)
		      
		    #endif
		    
		    // Create data folder if necessary
		    if not mfDataFolder.Exists then
		      mfDataFolder.CreateFolder
		      
		    end
		    
		  end
		  
		  return mfDataFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Settings() As Dictionary
		  // Initialize settings
		  if mdictSettings = nil then
		    mdictSettings = new Dictionary
		    
		    // Read settings from JSON
		    var tfSettings as FolderItem = DataFolder.Child("settings.json")
		    if tfSettings.Exists then
		      try
		        var tis as TextInputStream = TextInputStream.Open(tfSettings)
		        var tsSettings as String = tis.ReadAll
		        tis.Close
		        
		        // Load the settings into the dictionary
		        mdictSettings = ParseJSON(tsSettings)
		        
		      catch ex as InvalidJSONException
		        // Bad json, no settings to load
		        
		      catch ex as IOException
		        // Bad file access, handle as desired
		        
		      end try
		      
		    end
		    
		  end
		  
		  return mdictSettings
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mdictSettings As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mfDataFolder As FolderItem
	#tag EndProperty


	#tag Constant, Name = kBundleIdentifier, Type = String, Dynamic = False, Default = \"com.wovyn.supersimmanager", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
