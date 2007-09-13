#tag ClassClass CFDictionaryInherits CFTypeImplements CFPropertyList	#tag Method, Flags = &h0		Function Value(key as CFType) As CFType		  if me.Equals(nil) then		    return nil		  end if		  		  #if TargetCarbon		    soft declare function CFDictionaryGetValueIfPresent lib CarbonFramework (theDict as Ptr, key as Ptr, ByRef value as Ptr) as Boolean		    		    dim theValue as Ptr		    if CFDictionaryGetValueIfPresent(me, key, theValue) then		      return theValue		    else		      raise new KeyNotFoundException		    end if		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function HasKey(key as Ptr) As Boolean		  if me.Equals(nil) then		    return false		  end if		  		  #if TargetCarbon		    soft declare function CFDictionaryContainsKey lib CarbonFramework (theDict as Ptr, key as Ptr) as Boolean		    		    return CFDictionaryContainsKey(me, key)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Key(index as Integer) As Ptr		  if me.Equals(nil) then		    return nil		  end if		  		  #if TargetMacOS		    soft declare function CFDictionaryGetCount lib CarbonFramework (theDict as Ptr) as Integer		    		    if index < 0 or index > CFDictionaryGetCount(me) - 1 then		      raise new OutOfBoundsException		    end if		    		    if me.keyList Is nil then		      soft declare sub CFDictionaryGetKeysAndValues lib CarbonFramework (theDict as Ptr, keys as Ptr, values as Ptr)		      		      me.keyList = new MemoryBlock(4*CFDictionaryGetCount(me)) //if Count = 0 then guard clause raised an exception		      CFDictionaryGetKeysAndValues me, me.keyList, nil		    End if		    return me.keyList.Ptr(4*index)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(theKeys() as CFType, theValues() as CFType)		  if UBound(theKeys) <> UBound(theValues) then		    return		  end if		  		  #if targetMacOS		    const defaultKeyCallBacks = "kCFTypeDictionaryKeyCallBacks"		    const defaultValueCallBacks = "kCFTypeDictionaryValueCallBacks"		    		    dim keyCallbacks as Ptr = me.DefaultCallbacks(defaultKeyCallBacks)		    dim valueCallbacks as Ptr = me.DefaultCallbacks(defaultValueCallBacks)		    		    soft declare function CFDictionaryCreate lib CarbonFramework (allocator as Ptr, keys as Ptr, values as Ptr, numValues as Integer, keyCallBacks as Ptr, valueCallBacks as Ptr) as Ptr		    		    if UBound(theKeys) > -1 then		      dim keyBlock as new MemoryBlock(4*(1 + UBound(theKeys)))		      dim valueBlock as new MemoryBlock(4*(1 + UBound(theValues)))		      dim offset as Integer = 0		      for i as Integer = 0 to UBound(theKeys)		        keyBlock.Ptr(offset) = theKeys(i)		        valueBlock.Ptr(offset) = theValues(i)		        offset = offset + 4		      next		      		      me.Operator_Convert CFDictionaryCreate(nil, keyBlock, valueBlock, 1 + UBound(theKeys), keyCallbacks, valueCallbacks)		      		    else		      me.Operator_Convert CFDictionaryCreate(nil, nil, nil, 0, keyCallbacks, valueCallbacks)		    end if		  #endif		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(theDictionary as CFDictionary)		  if theDictionary Is nil then		    return		  end if		  		  #if TargetMacOS		    soft declare function CFDictionaryCreateCopy lib CarbonFramework (allocator as Ptr, theDict as Ptr) as Ptr		    		    me.Operator_Convert CFDictionaryCreateCopy(nil, me)		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Function DefaultCallbacks(name as String) As Ptr		  if name = "" then		    return nil		  end if		  		  dim CarbonFrameworkBundle as CFBundle = CFBundle.NewCFBundle(CarbonBundleID)		  if CarbonFrameworkBundle <> nil then		    return CarbonFrameworkBundle.DataPointer(name)		  else		    return nil		  end if		End Function	#tag EndMethod	#tag Method, Flags = &h0		 Shared Function ClassID() As UInt32		  soft declare function CFDictionaryGetTypeID lib CarbonFramework () as UInt32		  		  return CFDictionaryGetTypeID		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function MutableClone() As Dictionary		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Clone() As CFDictionary		  #if targetMacOS		    soft declare function CFDictionaryCreateCopy lib CarbonFramework (allocator as Ptr, theDict as Ptr) as Ptr		    		    dim theCopy as CFDictionary  = CFDictionaryCreateCopy(nil, me)		    return theCopy		  #endif		End Function	#tag EndMethod	#tag Property, Flags = &h21		Private keyList As MemoryBlock	#tag EndProperty	#tag ComputedProperty, Flags = &h0		#tag Getter			Get			if me.Equals(nil) then			return 0			end if						#if TargetCarbon			soft declare function CFDictionaryGetCount lib CarbonFramework (theDict as Ptr) as Integer						return CFDictionaryGetCount(me)			#endif			End Get		#tag EndGetter		Count As Integer	#tag EndComputedProperty	#tag Constant, Name = ClassName, Type = String, Dynamic = False, Default = \"CFDictionary", Scope = Private	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Count"			Group="Behavior"			InitialValue="0"			Type="Integer"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass