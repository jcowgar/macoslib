#tag Class
Protected Class MacTCPSocket
Inherits TCPSocket
	#tag Event
		Sub Connected()
		  // We're connected to a TCPSocket.
		  //
		  // Let's create a CFSocket here that should help getting the
		  // DataAvailable perform faster when new data has come in.
		  
		  #if TargetMacOS
		    // We only need this for incoming data - we handle sending the
		    // "normal" way.
		    mCFSock = new CFSocket (me.handle, CFSocket.kReadCallBack)
		    AddHandler mCFSock.IncomingData, AddressOf SocketDataCallback
		  #endif
		  raiseEvent Connected()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error()
		  #if TargetMacOS
		    mCFSock.Close()
		    mCFSock = nil
		  #endif
		  
		  raiseEvent Error()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub SocketDataCallback(sender as CFSocket, incomingData as CFData)
		  // This gets called when the CFSocket detects new incoming data.
		  //
		  // We then invoke the TCPSocket's Poll method in order to trigger
		  // the checking of new data, which will then invoke then DataAvailable
		  // event.
		  
		  if incomingData <> nil then
		    // Oops - when does this happen?
		    // This is unexpected because we'd have no way to pass
		    // this data on to the Poll, unless we overwrite the Read...
		    // functions to supply that data there.
		    dim mb as MemoryBlock = incomingData.Data
		    break // let's look at what we got here
		  end if
		  
		  me.Poll()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Connected()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error()
	#tag EndHook


	#tag Note, Name = About
		This is an optimized version of TCPSocket that reduces the
		latency of incoming data when building for Carbon (as opposed
		to Cocoa, which doesn't seem to need this).
		
		It uses CFSocket for reacting to incoming data, then calling
		the Poll method to handle the new data.
		
		The problem with RB's default Socket implementation (as of
		RB 2010r5) is that it does not tell the OS to activate the app
		as soon as new data has come in on a socket. Instead, the
		RB runtime keeps waiting passively for a while until other
		events awake the app, at which point the runtime also checks
		if any of its sockets has data waiting.
		
		This improved socket version uses CFSocket to register its
		own special event with the OS, telling it to awake this app as
		soon as data on this socket is ready, and then calling our
		SocketDataCallback function here, which in turn invokes the
		standard Poll method, thereby forcing the standard Socket
		code to detect the new incoming data and calling the
		DataAvailable event.
		
		
		This class was perceived and implemented by Joe Ranieri,
		with documentation added by Thomas Tempelmann
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mCFSock As CFSocket
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Address"
			Visible=true
			Group="Behavior"
			Type="String"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
