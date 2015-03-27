note
	description: "Summary description for {BACKGROUND2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BACKGROUND

inherit

	ARRAYED_LIST [TILE]
		rename
			make as make_arrayed_list
		end

create
	make, make_arrayed_list

feature {NONE} -- Initialization

	make
		do
			make_arrayed_list (30)
		end

feature -- Access

	delta_position_x: CELL [REAL] assign assign_delta_position_x

	delta_x: REAL_64

	position_y: INTEGER

feature -- Routine

	update
		do
			delta_x := ((delta_position_x.item/5).rounded \\ at (1).image.width)
		end

	display (a_controller: GAME_LIB_CONTROLLER)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				a_controller.screen_surface.draw_surface (at (i).image, (at (i).position_x - delta_x).rounded, at (i).position_y)
				i:= i + 1
			end
		end

feature -- Assigner

	assign_delta_position_x (a_delta_position_x: CELL [REAL])
		do
			delta_position_x := a_delta_position_x
		end

end
