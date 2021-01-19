#tag Class
Protected Class Sim
	#tag Method, Flags = &h0
		Sub Constructor(tdictItem as Dictionary = nil)
		  if tdictItem <> nil then
		    sAccountSID = tdictItem.Lookup("account_sid", "")
		    sFleetSID = tdictItem.Lookup("fleet_sid", "")
		    sICCID = tdictItem.Lookup("iccid", "")
		    sSID = tdictItem.Lookup("sid", "")
		    sUniqueName = tdictItem.Lookup("unique_name", "")
		    sURL = tdictItem.Lookup("url", "")
		    
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
		    select case tdictItem.Lookup("status", "")
		    case "new"
		      eStatus = Status.NewState
		      
		    case "ready"
		      eStatus = Status.Ready
		      
		    case "active"
		      eStatus = Status.Active
		      
		    case "inactive"
		      eStatus = Status.Inactive
		      
		    case "scheduled"
		      eStatus = Status.Scheduled
		      
		    case else
		      var ex as new UnsupportedFormatException
		      ex.Message = "Sim status not implemented"
		      raise ex
		      
		    end select
		    
		  end
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		dtmCreated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		dtmUpdated As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		eStatus As Twilio.Sim.Status
	#tag EndProperty

	#tag Property, Flags = &h0
		oFleet As Twilio.Fleet
	#tag EndProperty

	#tag Property, Flags = &h0
		sAccountSID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sFleetSID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sICCID As String
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


	#tag Enum, Name = Status, Type = Integer, Flags = &h0
		Unknown
		  NewState
		  Ready
		  Active
		  Inactive
		Scheduled
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
			Name="sFleetSID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sICCID"
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
			Name="eStatus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="sURL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
