note
	description: "Allow the game to be play online"
	author: "Alexandre Girardin"
	date: "28 May"

class
	NETWORK

inherit

	THREAD

create
	make_network

feature {NONE} -- Initialization

	make_network
		do
		end

feature -- Access

	is_ready: BOOLEAN

	read_socket: NETWORK_DATAGRAM_SOCKET

	send_socket: NETWORK_DATAGRAM_SOCKET

	read_mode: PROCEDURE[ANY, TUPLE]

	last_string: STRING

	last_x: INTEGER

	last_y: INTEGER

	must_stop: BOOLEAN

feature -- Routines

	host_server
		-- Start host server
		local
			l_port: INTEGER
			l_host: STRING
		do
			last_string:= ""
			l_port := 12345
			l_host := "localhost"
			create read_socket.make_bound (l_port)

			read_mode:= agent read_string

			make
			launch
		end

	connect_client
		-- Connect client to host server
		local
			l_port: INTEGER
			l_port_2: INTEGER
			l_host: STRING
			l_info: STRING
		do
			last_string:= ""
			l_port := 12345
			l_host := "localhost"
			create send_socket.make_targeted (l_host, l_port)

			l_port_2 := 12346
			create read_socket.make_bound (l_port_2)
			send("c")
			l_info:= l_host + " " + l_port_2.out
			send(l_info)

			read_mode:= agent read_string

			is_ready:= true

			make
			launch
		end

	execute
		-- Execute thread
		do
			from
				must_stop := false
			until
				must_stop
			loop
				read_mode.call
				analyze
			end
		end

	analyze
		-- Select the read mode to use
		do
			if last_string.is_equal ("p") then
				read_mode:= agent read_position
				last_string:= ""
			elseif last_string.is_equal ("c") then
				read_mode:= agent connection
				last_string:= ""
			elseif last_string.is_equal ("stop") then
				read_mode := agent stop
				last_string:= ""
			else
				read_mode := agent read_string
			end
		end

	connection
		--Allow connection between host and client
		local
			l_host: STRING
			l_port: INTEGER
		do
			read_string
			l_host:= last_string.split (' ').at (1)
			l_port:= last_string.split (' ').at (2).to_integer
			create send_socket.make_targeted (l_host, l_port)
			is_ready:= true
		end

	read_string
		-- Allow to read string
		do
			read_socket.read_integer
			read_socket.read_stream (read_socket.last_integer)
			last_string:= read_socket.last_string
		end

	read_position
		-- Allow to read position
		do
			read_string
			last_x:= last_string.split (' ').at (1).to_integer
			last_y:= last_string.split (' ').at (2).to_integer
		end

	send (a_information: STRING)
		-- Allow to send information on net work
		do
			send_socket.put_integer (a_information.count)
			send_socket.put_string (a_information)
		end

	stop
	-- Stop the network
		do
			must_stop := true
			send ("stop")
			join
			is_ready:= false
			send_socket.close
			read_socket.close
		end

end
