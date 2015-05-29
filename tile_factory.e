note
	description: "Create multiple tile"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TILE_FACTORY

inherit

	SHARED

create
	make

feature {NONE}

	make
		--Initialize tile factory
		do
			number_of_instances.put (number_of_instances.item + 1)
			create converter.make(0)
			converter.put (agent space, '$')
			converter.put (agent space, ' ')
			converter.put (agent bl_corner, '1')
			converter.put (agent bottom, '2')
			converter.put (agent br_corner, '3')
			converter.put (agent left, '4')
			converter.put (agent square, '5')
			converter.put (agent right, '6')
			converter.put (agent tl_corner, '7')
			converter.put (agent top, '8')
			converter.put (agent tr_corner, '9')
		end

	number_of_instances: CELL [INTEGER]
		-- Contain number of instance
		once
			create Result.put (0)
		end

feature -- Access

	converter:HASH_TABLE[FUNCTION [ANY, TUPLE, TILE], CHARACTER]

feature -- Routines

	space(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {TILE}.make_tile (image_factory.space, a_position_x, a_position_y)
		end

	bl_corner(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {TILE}.make_tile (image_factory.bl_corner, a_position_x, a_position_y)
		end

	bottom(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {HARD_TILE}.make_hard_tile (image_factory.bottom, a_position_x, a_position_y)
		end

	br_corner(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {TILE}.make_tile (image_factory.br_corner, a_position_x, a_position_y)
		end

	left(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {HARD_TILE}.make_hard_tile (image_factory.left, a_position_x, a_position_y)
		end

	square(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {HARD_TILE}.make_hard_tile (image_factory.square, a_position_x, a_position_y)
		end

	right(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {HARD_TILE}.make_hard_tile (image_factory.right, a_position_x, a_position_y)
		end

	tl_corner(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {TILE}.make_tile (image_factory.tl_corner, a_position_x, a_position_y)
		end

	top(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {HARD_TILE}.make_hard_tile (image_factory.top, a_position_x, a_position_y)
		end

	tr_corner(a_position_x, a_position_y:INTEGER): TILE
		do
			Result := create {TILE}.make_tile (image_factory.tr_corner, a_position_x, a_position_y)
		end

end
