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

	#tag Constant, Name = kMonospacedFont, Type = String, Dynamic = False, Default = \"Courier New", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Menlo"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Module
#tag EndModule
