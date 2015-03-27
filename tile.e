note
	description: "Summary description for {TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TILE

create
	make_tile

feature {NONE}

	make_tile (a_image: GAME_SURFACE_IMG_FILE; a_position_x, a_position_y: INTEGER)
		do
			image := a_image
			position_x:= a_position_x
			position_y:= a_position_y
		end

feature -- Access

	image: GAME_SURFACE_IMG_FILE

	position_x: INTEGER

	position_y: INTEGER

	width: INTEGER
		do
			Result := image.width
		end

	height: INTEGER
		do
			Result := image.height
		end

end
