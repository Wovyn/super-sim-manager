#tag Class
Protected Class Sim
	#tag Method, Flags = &h0
		Sub Constructor(tdictItem as Dictionary = nil)
		  if tdictItem <> nil then
		    sAccountSID = tdictItem.Lookup("account_sid", "")
		    sFleetSID = tdictItem.Lookup("fleet_sid", "")
		    sICCID = tdictItem.Lookup("iccid", "")
		    sSID = tdictItem.Lookup("sid", "")
		    sStatus = tdictItem.Lookup("status", "")
		    sUniqueName = tdictItem.Lookup("unique_name", "")
		    sURL = tdictItem.Lookup("url", "")
		    
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
		sStatus As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
