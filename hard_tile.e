note
	description: "Summary description for {HARD_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HARD_TILE

inherit
	TILE
	HARD

create
	make_hard_tile

feature {NONE} -- Initialization

	make_hard_tile (a_image: GAME_SURFACE; a_position_x, a_position_y: INTEGER)
		do
			image := a_image
			position_x:= a_position_x
			position_y:= a_position_y
		end

end
