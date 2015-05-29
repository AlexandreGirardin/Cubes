note
	description: "Tile of the game"
	author: "Alexandre Girardin"
	date: "May 28"

class
	TILE
inherit
	DISPLAYABLE
create
	make_tile

feature {NONE}

	make_tile (a_image: GAME_SURFACE; a_position_x, a_position_y: INTEGER)
		-- Initialize tile
		do
			image := a_image
			position_x:= a_position_x
			position_y:= a_position_y
		end

end
