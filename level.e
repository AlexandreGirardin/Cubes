note
	description: "Summary description for {LEVEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEVEL

inherit

	SHARED
		undefine
			is_equal,
			copy
		end

	ARRAYED_LIST [ARRAYED_LIST [TILE]]

create
	make

feature -- Access

	player: PLAYER assign assign_player

	start_x: INTEGER assign assign_start_x

	start_y: INTEGER assign assign_start_y

	end_x: INTEGER

	end_y: INTEGER

	delta_x: INTEGER

	delta_y: INTEGER

	height: INTEGER
		do
			Result:= count
		end

	width: INTEGER assign assign_width

	tile_width: INTEGER assign assign_tile_width

	tile_height: INTEGER assign assign_tile_height

feature -- Routines

	update
		do
			delta_x := (player.position_x + (player.image.width // 2)) - controller.screen_surface.width // 2
			delta_y := (player.position_y + (player.image.height // 2)) - controller.screen_surface.height // 2

			player.surrounding_tiles := scan_surrounding_tiles (player.center_x, player.center_y, 3, 3)
		end

	display
		local
			l_tiles_to_display: LIST[TILE]
		do
			l_tiles_to_display:= scan_surrounding_tiles (player.center_x, player.center_y, (controller.screen_surface.width // tile_width + 2), controller.screen_surface.height // tile_height + 2)

			across
				l_tiles_to_display as la_tiles_to_display
			loop
				controller.screen_surface.draw_surface (la_tiles_to_display.item.image, la_tiles_to_display.item.position_x - delta_x, la_tiles_to_display.item.position_y - delta_y)
			end
		end

	display_player
		local
			image: GAME_SURFACE_IMG_FILE
		do
			create image.make_with_alpha ("Images/Tiles/Hard_tiles/square.png")
			across
				player.surrounding_tiles as la_surrounding_tiles
			loop
				controller.screen_surface.draw_surface (image, la_surrounding_tiles.item.position_x - delta_x , la_surrounding_tiles.item.position_y - delta_y)
			end
			controller.screen_surface.draw_surface (player.image, player.position_x - delta_x, player.position_y - delta_y)
		end

	scan_surrounding_tiles (a_x, a_y, a_number_per_row, a_number_per_column: INTEGER): ARRAYED_LIST [TILE]
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

	assign_player (a_player: PLAYER)
		do
			player := a_player
		end

	assign_tile_width (a_tile_width: INTEGER)
		do
			tile_width := a_tile_width
		end

	assign_tile_height (a_tile_height: INTEGER)
		do
			tile_height := a_tile_height
		end

	assign_start_x (a_start_x: INTEGER)
		do
			start_x := a_start_x
		end

	assign_start_y (a_start_y: INTEGER)
		do
			start_y := a_start_y
		end

	assign_width(a_width: INTEGER)
		do
			width:= a_width
		end

end
