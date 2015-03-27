note
	description: "Summary description for {FILE_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_PARSER

--lambda(agent)
--image_factory

feature --Routine

	parse_level (level_number: NATURAL_8): LEVEL
		local
			i, j: INTEGER
			level_file: FILE
			line: STRING
			l_tile: TILE
			tiles_list: ARRAYED_LIST [TILE]
			converter: TEXT_TO_TILE
		do
			level_file := create {PLAIN_TEXT_FILE}.make_with_name ("Levels/level_" + level_number.out + ".txt")
				-- gestion erreur
			level_file.open_read
			create Result.make (0)
			create converter.make
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
						l_tile := create {TILE}.make_tile (converter [la_line.item], i * converter [la_line.item].width, j * converter [la_line.item].height)
						tiles_list.extend (l_tile)
						if la_line.item = '$' then
							Result.start_x := (i * l_tile.width)
							Result.start_y := (j * l_tile.height)
						end
						i := i + 1
					end
					Result.extend (tiles_list)
					j := j + 1
				end
			end
			Result.tile_width:= Result.at (1).at (1).image.width
			Result.tile_height:= Result.at (1).at (1).image.height
		end

end
