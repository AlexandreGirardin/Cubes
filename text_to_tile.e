note
	description: "Summary description for {TEXT_TO_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_TO_TILE

inherit

	HASH_TABLE [GAME_SURFACE_IMG_FILE, CHARACTER]
		rename
			make as make_hash_table
		export
			{NONE} all
			{ANY} item, put, valid_key, keys, compare_objects, changeable_comparison_criterion
			{HASH_TABLE} content, deleted_marks, indexes_map, capacity, iteration_position, deleted_item_position, item_position, count, search, found, found_item, object_comparison, has_default
		end

	ANY
		undefine
			is_equal,
			copy
		end

create {HASH_TABLE}
	make_hash_table

create
	make

feature {NONE} -- Initialization

	make
		do
			make_hash_table (0)
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/default.png"), '$')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/default.png"), ' ')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/bl_corner.png"), '1')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/Hard_tiles/bottom.png"), '2')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/br_corner.png"), '3')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/Hard_tiles/left.png"), '4')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/Hard_tiles/square.png"), '5')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/Hard_tiles/right.png"), '6')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/tl_corner.png"), '7')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/Hard_tiles/top.png"), '8')
			put (create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("Images/Tiles/tr_corner.png"), '9')
		end

end
