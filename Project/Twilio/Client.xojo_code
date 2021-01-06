#tag Class
Protected Class Client
	#tag Method, Flags = &h0
		Sub ApplyAssociations()
		  // Method iterates Sims and applies associated fleet data
		  for each toSim as Twilio.Sim in me.aroSims
		    // Find fleet
		    for each toFleet as Twilio.Fleet in me.aroFleets
		      if toFleet.sSID = toSim.sFleetSID then
		        toSim.oFleet = toFleet
		        exit for toFleet
		        
		      end
		      
		    next toFleet
		    
		  next toSim
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FleetsResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  #pragma unused toSender
		  
		  // Gather the Sim resources
		  aroFleets.ResizeTo(-1)
		  
		  if tdictResponse.HasKey("fleets") then
		    var tardictSims() as Object = tdictResponse.Value("fleets")
		    
		    // API 2.0 JSONItems are too ambigous for my taste.
		    for each tdictSim as Object in tardictSims
		      if tdictSim isa Dictionary then
		        var toFleet as new Twilio.Fleet(Dictionary(tdictSim))
		        aroFleets.Add(toFleet)
		        
		      end
		      
		    next tdictSim
		    
		  end
		  
		  // Make the list available
		  RaiseEvent FleetListComplete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleServerResponse(toSender as NetRequest, toErr as RequestError)
		  // Re-raise server responses
		  #pragma unused toSender
		  RaiseEvent ServerResponse(toErr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListFleets()
		  // Asynchronous event to fetch all Fleet resources
		  var toReq as NetRequest = NewRequest
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf FleetsResponse
		  
		  // Request async
		  toReq.Send("GET", "https://supersim.twilio.com/v1/Fleets")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListSims()
		  // Asynchronous event to fetch all Sim resources
		  var toReq as NetRequest = NewRequest
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf SimsResponse
		  
		  // Request async
		  toReq.Send("GET", "https://supersim.twilio.com/v1/Sims")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewRequest() As NetRequest
		  // Centralized way to get settings from dictionary
		  var tsAuth as String = EncodeBase64(sSID + ":" + sToken, 0)
		  
		  var toSock as new NetRequest
		  toSock.RequestHeader("Authorization") = "Basic " + tsAuth
		  
		  // Retain the request
		  maroRequests.Add(toSock)
		  
		  // Handle server responses that aren't 200
		  AddHandler toSock.ServerResponse, WeakAddressOf HandleServerResponse
		  
		  return toSock
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SimsResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  #pragma unused toSender
		  
		  // Gather the Sim resources
		  aroSims.ResizeTo(-1)
		  
		  if tdictResponse.HasKey("sims") then
		    var tardictSims() as Object = tdictResponse.Value("sims")
		    
		    // API 2.0 JSONItems are too ambigous for my taste.
		    for each tdictSim as Object in tardictSims
		      if tdictSim isa Dictionary then
		        var toSim as new Twilio.Sim(Dictionary(tdictSim))
		        aroSims.Add(toSim)
		        
		      end
		      
		    next tdictSim
		    
		  end
		  
		  // Make the list available
		  RaiseEvent SimListComplete
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event FleetListComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServerResponse(toErr as Twilio.RequestError)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SimListComplete()
	#tag EndHook


	#tag Property, Flags = &h0
		aroFleets() As Twilio.Fleet
	#tag EndProperty

	#tag Property, Flags = &h0
		aroSims() As Twilio.Sim
	#tag EndProperty

	#tag Property, Flags = &h21
		Private maroRequests() As NetRequest
	#tag EndProperty

	#tag Property, Flags = &h0
		sSID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sToken As String
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
			Name="sSID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sToken"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
