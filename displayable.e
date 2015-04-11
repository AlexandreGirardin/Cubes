note
	description: "Summary description for {DISPLAYABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAYABLE

feature -- Access

	image: GAME_SURFACE

	position_x: INTEGER assign assign_position_x

	position_y: INTEGER assign assign_position_y

feature -- Routines

	assign_position_x (a_position_x: INTEGER)
		do
			position_x := a_position_x
		end

	assign_position_y (a_position_y: INTEGER)
		do
			position_y := a_position_y
		end
end
