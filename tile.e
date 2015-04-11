note
	description: "Summary description for {TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TILE
inherit
	DISPLAYABLE
create
	make_tile

feature {NONE}

	make_tile (a_image: GAME_SURFACE; a_position_x, a_position_y: INTEGER)
		do
			image := a_image
			position_x:= a_position_x
			position_y:= a_position_y
		end

end
