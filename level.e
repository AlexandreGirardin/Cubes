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

	position_x: INTEGER

	position_y: INTEGER

	start_x: INTEGER assign assign_start_x

	start_y: INTEGER assign assign_start_y

	end_x: INTEGER

	end_y: INTEGER

	delta_x: INTEGER

	left_x: INTEGER

	height: INTEGER

	width: INTEGER

	tile_width: INTEGER assign assign_tile_width

	tile_height: INTEGER assign assign_tile_height

feature -- Routines

	update
		do
			delta_x := ((player.x_int + (player.width // 2)) - left_x) - controller.screen_surface.width // 2
		end

	display
		do
			across
				current as la_current
			loop
				across
					la_current.item as la_sub_current
				loop
					controller.screen_surface.draw_surface (la_sub_current.item.image, la_sub_current.item.position_x - delta_x, la_sub_current.item.position_y)
				end
			end
		end

	display_player
		local
			l_surrounding_tiles: ARRAYED_LIST [TILE]
			image: GAME_SURFACE_IMG_FILE
		do
			create image.make_with_alpha ("Images/Tiles/Hard_tiles/square.png")
			l_surrounding_tiles := scan_surrounding_tiles (player.center_x, player.center_y)
			across
				l_surrounding_tiles as la_surrounding_tiles
			loop
				controller.screen_surface.draw_surface (image, la_surrounding_tiles.item.position_x - delta_x, la_surrounding_tiles.item.position_y)
			end
			controller.screen_surface.draw_surface (player.image, player.x_int - delta_x, player.position_y)
		end

	scan_surrounding_tiles (a_x, a_y: INTEGER): ARRAYED_LIST [TILE]
		local
			l_column: INTEGER
			l_row: INTEGER
			l_i: INTEGER
			l_j: INTEGER
		do
			create Result.make (4)
			l_column := (a_x // tile_width) + 1
			l_row := (a_y // tile_height) + 1
			from
				l_j := l_row - 1
			until
				l_j > l_row + 1
			loop

				from
					l_i := l_column - 1
				until
					l_i > l_column + 1
				loop
					if l_i > 0 and l_i <= at (1).count and l_j > 0 and l_j <= count then
						Result.extend (at (l_j).at (l_i))
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

end
