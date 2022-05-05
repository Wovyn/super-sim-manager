#tag Class
Protected Class SmsCommand
	#tag Method, Flags = &h0
		Sub Constructor(tdictItem as Dictionary = nil)
		  if tdictItem <> nil then
		    sAccountSID = tdictItem.Lookup("account_sid", "")
		    sID	= tdictItem.Lookup("sid", "")
		    simSID = tdictItem.Lookup("sim_sid", "")
		    payload = tdictItem.Lookup("payload", "")
		    direction = tdictItem.Lookup("direction", "")
		    dateCreated = tdictItem.Lookup("date_created", "")
		    dateUpdated = tdictItem.Lookup("date_updated", "")
		    url = tdictItem.Lookup("url", "")
		    
		    // Clean date created for Xojo
		    if tdictItem.HasKey("date_created") then
		      var tsDateCreated as String = tdictItem.Value("date_created")
		      tsDateCreated = tsDateCreated.Replace("T", " ")
		      tsDateCreated = tsDateCreated.Replace("Z", "")
		      
		      dtmCreated = DateTime.FromString(tsDateCreated, nil, new TimeZone("UTC"))
		      
		    end
		    
		    // Clean date updated for Xojo
		    if tdictItem.HasKey("date_updated") then
		      var tsDateUpdated as String = tdictItem.Value("date_updated")
		      tsDateUpdated = tsDateUpdated.Replace("T", " ")
		      tsDateUpdated = tsDateUpdated.Replace("Z", "")
		      
		      dtmUpdated = DateTime.FromString(tsDateUpdated, nil, new TimeZone("UTC"))
		      
		    end
		    
		    // Parse status
		    eStatus = StatusFromString(tdictItem.Lookup("status", ""))
		    status = tdictItem.Lookup("status", "")
		    
		  end
		  
		  // Store original values for comparing to update
		  mdictOriginal = tdictItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function StatusFromString(tsInput as String) As Twilio.SmsCommand.statusIndex
		  select case tsInput
		  case "queued"
		    return statusIndex.Queued
		    
		  case "sent"
		    return statusIndex.Sent
		    
		  case "delivered"
		    return statusIndex.Delivered
		    
		  case "received"
		    return statusIndex.Received
		    
		  case "failed"
		    return statusIndex.Failed
		    
		  case else
		    var ex as new UnsupportedFormatException
		    ex.Message = "SimCommand status not implemented"
		    raise ex
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UpdateFields() As Dictionary
		  
		  
		  var tdictUpdate as new Dictionary		  
		  
		  
		  return tdictUpdate
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		dtmCreated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		dtmUpdated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		eStatus As Twilio.SmsCommand.statusIndex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mdictOriginal As Dictionary
	#tag EndProperty
	
	#tag Property, Flags = &h0
		sAccountSID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		simSID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		payload As String
	#tag EndProperty

	#tag Property, Flags = &h0
		direction As String
	#tag EndProperty
	
	#tag Property, Flags = &h0
		dateCreated As String
	#tag EndProperty
	
	#tag Property, Flags = &h0
		dateUpdated As String
	#tag EndProperty
	
	#tag Property, Flags = &h0
		url As String
	#tag EndProperty
	
	#tag Property, Flags = &h0
		status As String
	#tag EndProperty

	#tag Enum, Name = StatusIndex, Type = Integer, Flags = &h0
		Unknown
		  Queued
		  Sent
		  Delivered
		  Received
		  Failed
	#tag EndEnum
	
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
			Name="sAccountSID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="simSID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="payload"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="eStatus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Twilio.SmsCommand.Status"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - Queued"
				"2 - Sent"
				"3 - Delivered"
				"4 - Received"
				"5 - Failed"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="status"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="url"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="dateCreated"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="dateUpdated"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
