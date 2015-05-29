note
	description: "Create Images"
	author: "Alexandre Girardin"
	date: "May 28"

class
	IMAGE_FACTORY

create
	make

feature {NONE}

	make
		-- Initialize image factory
		do
			number_of_instances.put (number_of_instances.item + 1)
		end

	number_of_instances: CELL[INTEGER]
		-- Contain the number of instance
		once
			create Result.put(0)
		end

feature -- Player

	blue_cube_animation(a_path:STRING; a_image_number:INTEGER): GAME_SURFACE
		do
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Animations/" + a_path + a_image_number.out + ".png")
		end

feature -- Background

	background: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/background.png")
		end

feature -- Level

	space: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/default.png")
		end

	square: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/Hard_tiles/square.png")
		end

	top: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/Hard_tiles/top.png")
		end

	bottom: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/Hard_tiles/bottom.png")
		end

	left: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/Hard_tiles/left.png")
		end

	right: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/Hard_tiles/right.png")
		end

	tl_corner: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/tl_corner.png")
		end

	tr_corner: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/tr_corner.png")
		end

	bl_corner: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/bl_corner.png")
		end

	br_corner: GAME_SURFACE
		once
			create {GAME_SURFACE_IMG_FILE} Result.make_with_alpha ("Images/Tiles/br_corner.png")
		end

invariant
	unique_instance:number_of_instances.item = 1
end
