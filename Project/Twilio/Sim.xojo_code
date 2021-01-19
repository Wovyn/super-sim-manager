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
		    eStatus = StatusFromString(tdictItem.Lookup("status", ""))
		    
		  end
		  
		  // Store original values for comparing to update
		  mdictOriginal = tdictItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function StatusFromString(tsInput as String) As Twilio.Sim.Status
		  select case tsInput
		  case "new"
		    return Status.NewState
		    
		  case "ready"
		    return Status.Ready
		    
		  case "active"
		    return Status.Active
		    
		  case "inactive"
		    return Status.Inactive
		    
		  case "scheduled"
		    return Status.Scheduled
		    
		  case else
		    var ex as new UnsupportedFormatException
		    ex.Message = "Sim status not implemented"
		    raise ex
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UpdateFields() As Dictionary
		  var tsOriginalName, tsOriginalFleet as String
		  var teOriginalStatus as Sim.Status
		  
		  if mdictOriginal <> nil then
		    teOriginalStatus = StatusFromString(mdictOriginal.Lookup("status", ""))
		    tsOriginalFleet = mdictOriginal.Lookup("fleet_sid", "")
		    tsOriginalName = mdictOriginal.Lookup("unique_name", "")
		    
		  end
		  
		  var tdictUpdate as new Dictionary
		  
		  // Status changes
		  if teOriginalStatus <> me.eStatus then
		    select case me.eStatus
		    case Status.Active
		      tdictUpdate.Value("Status") = "active"
		      
		    case Status.Inactive
		      tdictUpdate.Value("Status") = "inactive"
		      
		    case Status.Ready
		      tdictUpdate.Value("Status") = "ready"
		      
		    end select
		    
		  end
		  
		  // Fleet
		  if me.oFleet <> nil and me.oFleet.sSID <> tsOriginalFleet then
		    tdictUpdate.Value("Fleet") = me.oFleet.sSID.Encoding
		    
		  end
		  
		  // Name
		  if me.sUniqueName.Compare(tsOriginalName, ComparisonOptions.CaseSensitive) <> 0 then
		    tdictUpdate.Value("UniqueName") = EncodeURLComponent(me.sUniqueName)
		    
		  end
		  
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
		eStatus As Twilio.Sim.Status
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mdictOriginal As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private moFleet As Twilio.Fleet
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return moFleet
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  moFleet = value
			  
			  if moFleet = nil then
			    me.sFleetSID = ""
			    
			  else
			    me.sFleetSID = moFleet.sSID
			    
			  end
			End Set
		#tag EndSetter
		oFleet As Twilio.Fleet
	#tag EndComputedProperty

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
			Type="Twilio.Sim.Status"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - NewState"
				"2 - Ready"
				"3 - Active"
				"4 - Inactive"
				"5 - Scheduled"
			#tag EndEnumValues
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
