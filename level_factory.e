note
	description: "Summary description for {LEVEL_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEVEL_FACTORY

inherit
	SHARED

create
	make

feature {NONE}

	make
		do
			number_of_instances.put (number_of_instances.item + 1)
		end

	number_of_instances: CELL [INTEGER]
		once
			create Result.put (0)
		end

feature --Access
	current_level:LEVEL

feature --Routines

	build_level(a_level_number:INTEGER):LEVEL
		local
			i, j: INTEGER
			level_file: FILE
			line: STRING
			l_tile: TILE
			l_agent_tile: FUNCTION [ANY, TUPLE, TILE]
			tiles_list: ARRAYED_LIST [TILE]
		do
			level_file := create {PLAIN_TEXT_FILE}.make_with_name ("Levels/level_" + a_level_number.out + ".txt")
				-- gestion erreur
			level_file.open_read
			create Result.make (0)
			j := 0
			from
			until
				level_file.end_of_file
			loop
				i := 0
				level_file.read_line
				line := level_file.last_string
				if not line.starts_with ("!") then
					create tiles_list.make (0)
					across
						line as la_line
					loop
						l_agent_tile := tile_factory.converter [la_line.item]
						l_tile:= l_agent_tile(i * 64, j * 64)
						tiles_list.extend (l_tile)
						if la_line.item = '$' then
							Result.start_x := (i * l_tile.image.width)
							Result.start_y := (j * l_tile.image.height)
						end
						i := i + 1
					end
					Result.extend (tiles_list)
					Result.width:= tiles_list.count.max (Result.width)
					j := j + 1
				end
			end
			Result.tile_width:= Result.at (1).at (1).image.width
			Result.tile_height:= Result.at (1).at (1).image.height
		end


end
