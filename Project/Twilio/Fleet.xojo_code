#tag Class
Protected Class Fleet
	#tag Method, Flags = &h0
		Sub Constructor(tdictItem as Dictionary = nil)
		  if tdictItem <> nil then
		    bCommandsEnabled = tdictItem.Lookup("commands_enabled", false)
		    bDataEnabled = tdictItem.Lookup("data_enabled", false)
		    
		    iDataLimit = tdictItem.Lookup("data_limit", 1000)
		    
		    sAccountSID = tdictItem.Lookup("account_sid", "")
		    sCommandsMethod = tdictItem.Lookup("commands_method", "")
		    sCommandsURL = tdictItem.Lookup("commands_url", "")
		    sDataMetering = tdictItem.Lookup("data_metering", "")
		    sNetworkAccessProfileID = tdictItem.Lookup("network_access_profile_sid", "")
		    sSID = tdictItem.Lookup("sid", "")
		    sUniqueName = tdictItem.Lookup("unique_name", "")
		    sURL = tdictItem.Lookup("url", "")
		    
		    // Cleanup commands url
		    if sCommandsURL.Trim = "null" then
		      sCommandsURL = ""
		      
		    end
		    
		    // Clean date created for Xojo
		    if tdictItem.HasKey("date_created") then
		      var tsDateCreated as String = tdictItem.Value("date_created")
		      tsDateCreated = tsDateCreated.Replace("T", " ")
		      tsDateCreated = tsDateCreated.Replace("Z", "")
		      
		      dtmCreated = DateTime.FromString(tsDateCreated)
		      
		    end
		    
		    // Clean date updated for Xojo
		    if tdictItem.HasKey("date_updated") then
		      var tsDateUpdated as String = tdictItem.Value("date_updated")
		      tsDateUpdated = tsDateUpdated.Replace("T", " ")
		      tsDateUpdated = tsDateUpdated.Replace("Z", "")
		      
		      dtmUpdated = DateTime.FromString(tsDateUpdated)
		      
		    end
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FormattedDataLimit() As String
		  if iDataLimit < 1000 then
		    return iDataLimit.ToString + " MB"
		    
		  end
		  
		  var tdGB as Double = iDataLimit / 1000
		  return Format(tdGB, "####.0#") + " GB"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		bCommandsEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		bDataEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		dtmCreated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		dtmUpdated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		iDataLimit As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		sAccountSID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sCommandsMethod As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sCommandsURL As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sDataMetering As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sNetworkAccessProfileID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sSID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sUniqueName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sURL As String
	#tag EndProperty


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="sUniqueName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sAccountSID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sURL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sSID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sNetworkAccessProfileID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="sDataMetering"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="sCommandsURL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="bDataEnabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="bCommandsEnabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="sCommandsMethod"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="iDataLimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
