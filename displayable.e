note
	description: "Give objects position and image"
	author: "Alexandre Girardin"
	date: "May 28"

 class
	DISPLAYABLE

feature -- Access

	image: GAME_SURFACE

	position_x: INTEGER assign set_position_x

	position_y: INTEGER assign set_position_y

feature -- Setters

	set_position_x (a_position_x: INTEGER)
		-- set x position of displayable objects
		do
			position_x := a_position_x
		end

	set_position_y (a_position_y: INTEGER)
	-- set x position of displayable objects
		do
			position_y := a_position_y
		end
end
