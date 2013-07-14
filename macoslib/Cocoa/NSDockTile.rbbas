#tag Class
Class NSDockTile
Inherits NSObject
	#tag Method, Flags = &h0
		Sub Display()
		  
		  #if TargetMacOS
		    declare sub display lib CocoaLib selector "display" (obj_id as Ptr)
		    
		    display self
		    
		  #endif
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS
			    declare function badgeLabel lib CocoaLib selector "badgeLabel" (obj_id as Ptr) as CFStringRef
			    
			    return badgeLabel(self)
			    
			  #endif
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS
			    declare sub setBadgeLabel lib CocoaLib selector "setBadgeLabel:" (obj_id as Ptr, aString as CFStringRef)
			    
			    setBadgeLabel self, value
			    
			  #else
			    #pragma unused value
			  #endif
			  
			End Set
		#tag EndSetter
		BadgeLabel As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS
			    declare function contentView lib CocoaLib selector "contentView" (obj_id as Ptr) as Ptr
			    
			    return contentView(self)
			    
			  #endif
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS
			    declare sub setContentView lib CocoaLib selector "setContentView:" (obj_id as Ptr, aView as Ptr)
			    
			    setContentView self, value
			    
			  #else
			    #pragma unused value
			  #endif
			  
			End Set
		#tag EndSetter
		ContentView As Ptr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS
			    declare function owner lib CocoaLib selector "owner" (obj_id as Ptr) as Ptr
			    
			    return owner(self)
			    
			  #endif
			  
			End Get
		#tag EndGetter
		Owner As Ptr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS
			    declare function showsApplicationBadge lib CocoaLib selector "showsApplicationBadge" (obj_id as Ptr) as Boolean
			    
			    return showsApplicationBadge(self)
			    
			  #endif
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS
			    declare sub setShowsApplicationBadge lib CocoaLib selector "setShowsApplicationBadge:" (obj_id as Ptr, flag as Boolean)
			    
			    setShowsApplicationBadge self, value
			    
			  #else
			    #pragma unused value
			  #endif
			  
			End Set
		#tag EndSetter
		ShowsApplicationBadge As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS
			    declare function size lib CocoaLib selector "size" (obj_id as Ptr) as Cocoa.NSSize
			    
			    return size(self)
			    
			  #endif
			  
			End Get
		#tag EndGetter
		Size As Cocoa.NSSize
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="BadgeLabel"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="NSObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowsApplicationBadge"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
