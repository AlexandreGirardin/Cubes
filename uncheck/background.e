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

	delta_x: REAL

	delta_position_y: CELL [REAL] assign assign_delta_position_y

	delta_y: REAL

feature -- Routine

	update
		do
			delta_x := ((delta_position_x.item/5).rounded \\ at (1).image.width)
			delta_y := ((delta_position_y.item/5).rounded \\ at (1).image.height)
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
				a_controller.screen_surface.draw_surface (at (i).image, (at (i).position_x - delta_x).rounded, (at (i).position_y - delta_y).rounded)
				i:= i + 1
			end
		end

feature -- Assigner

	assign_delta_position_x (a_delta_position_x: CELL [REAL])
		do
			delta_position_x := a_delta_position_x
		end

	assign_delta_position_y (a_delta_position_y: CELL [REAL])
		do
			delta_position_y := a_delta_position_y
		end

end
