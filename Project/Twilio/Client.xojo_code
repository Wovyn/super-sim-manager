#tag Class
Protected Class Client
	#tag Method, Flags = &h21
		Private Sub HandleServerResponse(toSender as NetRequest, toErr as RequestError)
		  // Re-raise server responses
		  #pragma unused toSender
		  RaiseEvent ServerResponse(toErr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  #pragma unused toSender
		  
		  // Gather the Sim resources
		  var taroSims() as Twilio.Sim
		  
		  if tdictResponse.HasKey("sims") then
		    var tardictSims() as Object = tdictResponse.Value("sims")
		    
		    // API 2.0 JSONItems are too ambigous for my taste.
		    for each tdictSim as Object in tardictSims
		      if tdictSim isa Dictionary then
		        var toSim as new Twilio.Sim(Dictionary(tdictSim))
		        taroSims.Add(toSim)
		        
		      end
		      
		    next tdictSim
		    
		  end
		  
		  // Make the list available
		  RaiseEvent SimListComplete(taroSims)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListSims()
		  // Asynchronous event to fetch all Sim resources
		  var toReq as NetRequest = NewRequest
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf ListResponse
		  
		  // Retain the request
		  maroRequests.Add(toReq)
		  
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
		  
		  // Handle server responses that aren't 200
		  AddHandler toSock.ServerResponse, WeakAddressOf HandleServerResponse
		  
		  return toSock
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ServerResponse(toErr as Twilio.RequestError)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SimListComplete(taroSims() as Twilio.Sim)
	#tag EndHook


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
