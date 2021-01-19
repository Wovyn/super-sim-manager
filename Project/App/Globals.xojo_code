#tag Module
Protected Module Globals
	#tag Method, Flags = &h0
		Sub AddRowAndTag(extends tpmTarget as PopupMenu, tsCaption as String, tvTag as Variant)
		  if tpmTarget <> nil then
		    tpmTarget.AddRow(tsCaption)
		    tpmTarget.RowTagAt(tpmTarget.RowCount - 1) = tvTag
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(extends teStatus as Twilio.Sim.Status) As String
		  select case teStatus
		  case Twilio.Sim.Status.Unknown
		    return "Unknown"
		    
		  case Twilio.Sim.Status.NewState
		    return "New"
		    
		  case Twilio.Sim.Status.Ready
		    return "Ready"
		    
		  case Twilio.Sim.Status.Active
		    return "Active"
		    
		  case Twilio.Sim.Status.Inactive
		    return "Inactive"
		    
		  case Twilio.Sim.Status.Scheduled
		    return "Scheduled"
		    
		  case else
		    var ex as new UnsupportedFormatException
		    ex.Message = "Sim status not implemented"
		    raise ex
		    
		  end select
		End Function
	#tag EndMethod


	#tag Constant, Name = kMonospacedFont, Type = String, Dynamic = False, Default = \"Courier New", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Menlo"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Module
#tag EndModule
