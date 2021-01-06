#tag Class
Protected Class RequestError
Inherits RuntimeException
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(tdict as Dictionary)
		  // Calling the main constructor.
		  me.Constructor
		  
		  // Load from JSONItem
		  if tdict.HasKey("code") then
		    me.ErrorNumber = tdict.Value("code")
		    
		  end
		  
		  if tdict.HasKey("detail") then
		    me.Message = tdict.Value("detail")
		    
		  end
		End Sub
	#tag EndMethod


End Class
#tag EndClass
