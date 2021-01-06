#tag Class
Protected Class NetworkAccessProfile
	#tag Method, Flags = &h0
		Sub Constructor(tdictItem as Dictionary = nil)
		  // Setup object
		  dictLinks = new Dictionary
		  
		  if tdictItem <> nil then
		    sAccountSID = tdictItem.Lookup("account_sid", "")
		    sSID = tdictItem.Lookup("sid", "")
		    sUniqueName = tdictItem.Lookup("unique_name", "")
		    sURL = tdictItem.Lookup("url", "")
		    
		    // Links dictionary / key value pairs
		    if tdictItem.HasKey("links") then
		      try
		        var taroLinks as Dictionary = tdictItem.Value("links")
		        dictLinks = taroLinks
		        
		      catch ex as TypeMismatchException
		        // API 2.0 JSONItems are too ambigous for my taste.
		      end try
		      
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


	#tag Property, Flags = &h0
		dictLinks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		dtmCreated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		dtmUpdated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		sAccountSID As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
