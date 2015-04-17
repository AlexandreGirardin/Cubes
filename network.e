note
	description: "Summary description for {NETWORK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NETWORK

inherit
	RECEIVER

	TRANSMITTER

feature -- Access

feature -- Routines

	host_server(a_host_ip : STRING; a_host_port : INTEGER)
		do
			create socket.make_bound(l_port)
			socket.close
		end

end
