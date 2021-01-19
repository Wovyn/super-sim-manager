#tag Class
Private Class NetRequest
Inherits URLConnection
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  // Catch response, handle any shared errors,
		  // and raise an event with the json item response
		  #pragma unused URL
		  var tsContent as String = content.DefineEncoding(Encodings.UTF8)
		  
		  try
		    var tdictResponse as Dictionary = ParseJSON(tsContent)
		    
		    // Server responded
		    if HTTPStatus = 200 then
		      RaiseEvent Completed(tdictResponse)
		      return
		      
		    else
		      // But it was an error message
		      var toErr as new RequestError(tdictResponse)
		      RaiseEvent ServerResponse(toErr)
		      return
		      
		    end
		    
		  catch ex as InvalidJSONException
		    RaiseEvent Error(ex)
		    return
		    
		  end try
		  
		  // Bad response error
		  var ex as new Twilio.RequestError
		  ex.Message = "Socket response was bad."
		  
		  RaiseEvent Error(ex)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error(e As RuntimeException)
		  RaiseEvent Error(e)
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Completed(tdictResponse as Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(ex as RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServerResponse(toErr as RequestError)
	#tag EndHook


	#tag Property, Flags = &h0
		bDone As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		oTag As Variant
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
			Name="AllowCertificateValidation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="bDone"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
