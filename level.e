note
	description: "Level of the game"
	author: "Alexandre Girardin"
	date: "May 28"

class
	LEVEL

inherit

	SHARED
		undefine
			is_equal,
			copy
		end

	CAN_QUIT
		undefine
			is_equal,
			copy
		end

	ARRAYED_LIST [ARRAYED_LIST [TILE]]

create
	make, make_level

feature {NONE}

	make_level(a_qte: INTEGER)
		-- Initialize level
		do
			initialize_event_controller
			create background.make
			make(a_qte)
		end


feature -- Access

	background: BACKGROUND

	start_x: INTEGER assign set_start_x

	start_y: INTEGER assign set_start_y

	end_x: INTEGER

	end_y: INTEGER

	delta_x: INTEGER

	delta_y: INTEGER

	height: INTEGER
		do
			Result:= count
		end

	width: INTEGER assign set_width

	tile_width: INTEGER assign set_tile_width

	tile_height: INTEGER assign set_tile_height

feature -- Routines

	initialize_event_controller
		-- Initialize event controller
		do
			controller.clear_event_controller
			controller.event_controller.on_quit_signal.extend (agent on_quit)
			controller.event_controller.on_iteration.extend (agent display)
		end

	initialize_player
		-- Initialize local and online players
		local
			l_player: PLAYER
			l_online_player: PLAYER
		do
			l_player := create {PLAYER}.make (start_x, start_y)
			from

			until
				network.is_ready
			loop

			end
			network.send ("p")
			network.send (l_player.position_x.out + " " + l_player.position_y.out)
			l_online_player := create {PLAYER}.make (network.last_x, network.last_y)
			single.local_player:= l_player
			single.online_player:= l_online_player
		end

	display
		-- Display everthing in level
		local
			l_tiles_to_display: LIST[TILE]
		do
			background.display_dynamic(0, 0)


			delta_x := (single.local_player.position_x + (single.local_player.image.width // 2)) - controller.screen_surface.width // 2
			delta_y := (single.local_player.position_y + (single.local_player.image.height // 2)) - controller.screen_surface.height // 2

			l_tiles_to_display:= scan_surrounding_tiles (single.local_player.center_x, single.local_player.center_y, (controller.screen_surface.width // tile_width + 2), controller.screen_surface.height // tile_height + 2)

			across
				l_tiles_to_display as la_tiles_to_display
			loop
				controller.screen_surface.draw_surface (la_tiles_to_display.item.image, la_tiles_to_display.item.position_x - delta_x, la_tiles_to_display.item.position_y - delta_y)
			end
			display_player
			display_player_online
			controller.flip_screen
		end

	display_player
		-- Display local player
		do
			single.local_player.surrounding_tiles:= scan_surrounding_tiles (single.local_player.center_x, single.local_player.center_y, 3, 3)
			single.local_player.update_local_player
			controller.screen_surface.draw_surface (single.local_player.animation_image, single.local_player.position_x - delta_x, single.local_player.position_y - delta_y)
		end

	display_player_online
		-- Display online player
		do
			single.online_player.update_online_player
			controller.screen_surface.draw_surface (single.online_player.animation_image, single.online_player.position_x - delta_x, single.online_player.position_y - delta_y)
		end


	scan_surrounding_tiles (a_x, a_y, a_number_per_row, a_number_per_column: INTEGER): ARRAYED_LIST [TILE]
		-- Scan around given position and return a list of tile
		local
			l_row: INTEGER
			l_column: INTEGER
			l_i: INTEGER
			l_j: INTEGER
		do
			create Result.make (0)
			l_row := (a_x // tile_width) + 1
			l_column := (a_y // tile_height) + 1
			from
				l_j := l_column - (a_number_per_column // 2)
			until
				l_j > l_column + (a_number_per_column //2)
			loop

				from
					l_i := l_row - (a_number_per_row // 2)
				until
					l_i > l_row + (a_number_per_row // 2)
				loop
					if l_j > 0 and l_j <= count then
						if l_i > 0  and l_i <= at(l_j).count then
							Result.extend (at (l_j).at (l_i))
						end
					end
					l_i := l_i + 1
				end
				l_j := l_j + 1
			end
		end

feature -- Assigner

	set_tile_width (a_tile_width: INTEGER)
		do
			tile_width := a_tile_width
		end

	set_tile_height (a_tile_height: INTEGER)
		do
			tile_height := a_tile_height
		end

	set_start_x (a_start_x: INTEGER)
		do
			start_x := a_start_x
		end

	set_start_y (a_start_y: INTEGER)
		do
			start_y := a_start_y
		end

	set_width(a_width: INTEGER)
		do
			width:= a_width
		end

end
