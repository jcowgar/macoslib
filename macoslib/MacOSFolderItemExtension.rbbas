#tag ModuleProtected Module MacOSFolderItemExtension	#tag Method, Flags = &h0		Function IsNetworkVolume(f as FolderItem) As Boolean		  if f Is nil then		    return false		  end if		  		  #if TargetMacOS		    soft declare function PBHGetVolParmsSync lib CarbonFramework (ByRef paramBlock as HIOParam) as Short		    		    dim paramBlock as HIOParam		    paramBlock.ioVRefNum = f.MacVRefNum		    //the following line is a trick to work around the inability to assign a pointer to a structure		    //to a field of type Ptr.		    dim infoBuffer as new MemoryBlock(GetVolParmsInfoBuffer.Size)		    paramBlock.ioBuffer = infoBuffer		    paramBlock.ioReqCount = infoBuffer.Size		    		    dim OSError as Integer = PBHGetVolParmsSync(paramBlock)		    if OSError <> 0 then		      return false		    end if		    return (infoBuffer.Long(10) <> 0)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function POSIXPath(extends f as FolderItem) As String		  		End Function	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule