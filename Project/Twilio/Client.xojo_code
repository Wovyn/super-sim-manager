#tag Class
Protected Class Client
	#tag Method, Flags = &h0
		Sub ApplyAssociations()
		  // Iterate Fleets and apply associated profile data
		  for each toFleet as Twilio.Fleet in me.aroFleets
		    // Find profile
		    for each toProfile as Twilio.NetworkAccessProfile in me.aroProfiles
		      if toProfile.sSID = toFleet.sNetworkAccessProfileID then
		        toFleet.oNetworkAccessProfile = toProfile
		        exit for toProfile
		        
		      end
		      
		    next toProfile
		    
		  next toFleet
		  
		  // Iterate Sims and apply associated fleet data
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
		Private Sub CleanupRequests()
		  // Iterate backwards as to not disturb the array
		  for ti as Integer = maroRequests.LastIndex downto 0
		    if maroRequests(ti).bDone then
		      // Request is complete, destroy
		      maroRequests(ti) = nil
		      maroRequests.RemoveAt(ti)
		      
		    end
		    
		  next ti
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FleetsResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  // Gather the Sim resources
		  #pragma unused toSender
		  
		  if tdictResponse.HasKey("fleets") then
		    var tardictFleets() as Object = tdictResponse.Value("fleets")
		    
		    // API 2.0 JSONItems are too ambigous for my taste.
		    for each tdictFleet as Object in tardictFleets
		      if tdictFleet isa Dictionary then
		        var toFleet as new Twilio.Fleet(Dictionary(tdictFleet))
		        aroFleets.Add(toFleet)
		        
		      end
		      
		    next tdictFleet
		    
		  end
		  
		  // Check for next page
		  if tdictResponse.HasKey("meta") then
		    var tdictMeta as Dictionary = tdictResponse.Value("meta")
		    var tvNextPage as Variant = tdictMeta.Lookup("next_page_url", nil)
		    
		    if tvNextPage = nil then
		      // No more pages, complete!
		      RaiseEvent FleetListComplete
		      
		    else
		      // Process the next page
		      ListFleets(tvNextPage.StringValue)
		      
		    end
		    
		  end
		  
		  // Cleanup sockets
		  SocketComplete(toSender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleError(toSender as Twilio.NetRequest, ex as RuntimeException)
		  RaiseEvent RequestError(ex)
		  
		  // Cleanup sockets
		  SocketComplete(toSender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleServerResponse(toSender as NetRequest, toErr as RequestError)
		  // Re-raise server responses
		  RaiseEvent ServerResponse(toErr)
		  
		  // Cleanup sockets
		  SocketComplete(toSender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListFleets(tsNextPage as String = "")
		  // Asynchronous event to fetch all Fleet resources
		  var toReq as NetRequest = NewRequest
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf FleetsResponse
		  
		  // Request async
		  if tsNextPage = "" then
		    // Initial request
		    aroFleets.ResizeTo(-1)
		    toReq.Send("GET", "https://supersim.twilio.com/v1/Fleets?PageSize=" + kPageSize.ToString)
		    
		  else
		    // Subsequent page request
		    toReq.Send("GET", tsNextPage)
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListProfiles(tsNextPage as String = "")
		  // Asynchronous event to fetch all Sim resources
		  var toReq as NetRequest = NewRequest
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf ProfilesResponse
		  
		  // Request async
		  if tsNextPage = "" then
		    // Initial request
		    aroProfiles.ResizeTo(-1)
		    toReq.Send("GET", "https://supersim.twilio.com/v1/NetworkAccessProfiles?PageSize=" + kPageSize.ToString)
		    
		  else
		    // Subsequent page request
		    toReq.Send("GET", tsNextPage)
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListSims(tsNextPage as String = "")
		  // Asynchronous event to fetch all Sim resources
		  var toReq as NetRequest = NewRequest
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf SimsResponse
		  
		  // Request async
		  if tsNextPage = "" then
		    // Initial request
		    aroSims.ResizeTo(-1)
		    toReq.Send("GET", "https://supersim.twilio.com/v1/Sims?PageSize=" + kPageSize.ToString)
		    
		  else
		    // Subsequent page request
		    toReq.Send("GET", tsNextPage)
		    
		  end
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
		  AddHandler toSock.Error, WeakAddressOf HandleError
		  AddHandler toSock.ServerResponse, WeakAddressOf HandleServerResponse
		  
		  return toSock
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProfilesResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  // Gather the Profiles
		  #pragma unused toSender
		  
		  if tdictResponse.HasKey("network_access_profiles") then
		    var tardictProfiles() as Object = tdictResponse.Value("network_access_profiles")
		    
		    // API 2.0 JSONItems are too ambigous for my taste.
		    for each tdictProfile as Object in tardictProfiles
		      if tdictProfile isa Dictionary then
		        var toProfile as new Twilio.NetworkAccessProfile(Dictionary(tdictProfile))
		        aroProfiles.Add(toProfile)
		        
		      end
		      
		    next tdictProfile
		    
		  end
		  
		  // Check for next page
		  if tdictResponse.HasKey("meta") then
		    var tdictMeta as Dictionary = tdictResponse.Value("meta")
		    var tvNextPage as Variant = tdictMeta.Lookup("next_page_url", nil)
		    
		    if tvNextPage = nil then
		      // No more pages, complete!
		      RaiseEvent ProfileListComplete
		      
		    else
		      // Process the next page
		      ListProfiles(tvNextPage.StringValue)
		      
		    end
		    
		  end
		  
		  // Cleanup sockets
		  SocketComplete(toSender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SimsResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  // Gather the Sim resources
		  #pragma unused toSender
		  
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
		  
		  // Check for next page
		  if tdictResponse.HasKey("meta") then
		    var tdictMeta as Dictionary = tdictResponse.Value("meta")
		    var tvNextPage as Variant = tdictMeta.Lookup("next_page_url", nil)
		    
		    if tvNextPage = nil then
		      // No more pages, complete!
		      RaiseEvent SimListComplete
		      
		    else
		      // Process the next page
		      ListSims(tvNextPage.StringValue)
		      
		    end
		    
		  end
		  
		  // Cleanup sockets
		  SocketComplete(toSender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SocketComplete(toSocket as Twilio.NetRequest)
		  // Cleanup sockets
		  toSocket.bDone = true
		  
		  // Call on the next event loop
		  // This could lead to mysterious NilObjectExceptions
		  Timer.CallLater(10, WeakAddressOf CleanupRequests)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCredentials()
		  // Get Credentials
		  var tsAuth as String = EncodeBase64(sSID + ":" + sToken, 0)
		  
		  var toReq as new NetRequest
		  toReq.RequestHeader("Authorization") = "Basic " + tsAuth
		  
		  // Retain the request
		  maroRequests.Add(toReq)
		  
		  // Handle server responses that aren't 200
		  AddHandler toReq.ServerResponse, WeakAddressOf TestResponseError
		  AddHandler toReq.Error, WeakAddressOf TestResponseError
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf TestResponse
		  
		  // Request async
		  toReq.Send("GET", "https://supersim.twilio.com/v1/Sims")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  #pragma unused toSender
		  
		  if tdictResponse.HasKey("sims") then
		    RaiseEvent CredentialResponse(true, "")
		    
		  end
		  
		  // Cleanup sockets
		  SocketComplete(toSender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestResponseError(toSender as Twilio.NetRequest, toErr as RuntimeException)
		  #pragma unused toSender
		  
		  RaiseEvent CredentialResponse(false, toErr.Message)
		  
		  // Cleanup sockets
		  SocketComplete(toSender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateResponse(toSender as Twilio.NetRequest, tdictResponse as Dictionary)
		  #pragma unused toSender
		  
		  var toNew as new Twilio.Sim(tdictResponse)
		  
		  RaiseEvent SimUpdateSuccess(toNew)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateSim(toSim as Twilio.Sim)
		  var tdictValues as Dictionary = toSim.UpdateFields
		  
		  // No changes
		  if tdictValues.KeyCount < 1 then
		    
		  end
		  
		  // Build body
		  var tarsPost() as String
		  for each tvKey as Variant in tdictValues.Keys
		    tarsPost.Add(tvKey.StringValue + "=" + tdictValues.Value(tvKey))
		    
		  next tvKey
		  
		  var tsBody as String = String.FromArray(tarsPost, "&")
		  
		  // Asynchronous event to fetch all Sim resources
		  var toReq as NetRequest = NewRequest
		  toReq.oTag = toSim
		  
		  toReq.RequestHeader("Content-Type") = "application/x-www-form-urlencoded; charset=utf-8"
		  toReq.SetRequestContent(tsBody, "application/x-www-form-urlencoded")
		  
		  // Handle response
		  AddHandler toReq.Completed, WeakAddressOf UpdateResponse
		  
		  // Request async
		  toReq.Send("POST", "https://supersim.twilio.com/v1/Sims/" + toSim.sSID)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CredentialResponse(tbAuthenticated as Boolean, tsError as String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event FleetListComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ProfileListComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RequestError(ex as RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServerResponse(toErr as Twilio.RequestError)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SimListComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SimUpdateSuccess(toSim as Twilio.Sim)
	#tag EndHook


	#tag Property, Flags = &h0
		aroFleets() As Twilio.Fleet
	#tag EndProperty

	#tag Property, Flags = &h0
		aroProfiles() As Twilio.NetworkAccessProfile
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
