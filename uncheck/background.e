note
	description: "Summary description for {BACKGROUND2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BACKGROUND

inherit

	SHARED
		undefine
			copy,is_equal
		end

	ARRAYED_LIST [TILE]
		rename
			make as make_arrayed_list
		end

create
	make, make_arrayed_list

feature {NONE} -- Initialization

	make
		local
			i, j: INTEGER
		do
			make_arrayed_list (30)
			from
				i := controller.screen_surface.start_x - (2 * image_factory.background.width)
			until
				i > controller.screen_surface.width + (2 * image_factory.background.width)
			loop
				from
					j := controller.screen_surface.start_y - (2 * image_factory.background.height)
				until
					j > controller.screen_surface.height + (2 * image_factory.background.height)
				loop
					current.extend (create {TILE}.make_tile (image_factory.background, i, j))
					j := j + image_factory.background.height
				end
				i := i + image_factory.background.width
			end
		end

feature -- Access

--	delta_position_x: CELL [REAL] assign set_delta_position_x

	delta_x: REAL

--	delta_position_y: CELL [REAL] assign set_delta_position_y

	delta_y: REAL

feature -- Routine

	display_dynamic(a_x, a_y: INTEGER)
		local
			i: INTEGER
		do
			delta_x := ((a_x/5).rounded \\ at (1).image.width)
			delta_y := ((a_y/5).rounded \\ at (1).image.height)
			from
				i := 1
			until
				i > count
			loop
				controller.screen_surface.draw_surface (at (i).image, (at (i).position_x - delta_x).rounded, (at (i).position_y - delta_y).rounded)
				i:= i + 1
			end
		end

	display_static
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				controller.screen_surface.draw_surface (at (i).image, (at (i).position_x), (at (i).position_y))
				i:= i + 1
			end
		end

feature -- Assigner

--	set_delta_position_x (a_delta_position_x: CELL [REAL])
--		do
--			delta_position_x := a_delta_position_x
--		end

--	set_delta_position_y (a_delta_position_y: CELL [REAL])
--		do
--			delta_position_y := a_delta_position_y
--		end

end
