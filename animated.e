note
	description: "Allow to create animated objects"
	author: "Alexandre Girardin"
	date: "May 28"

class
	ANIMATED

inherit

	SHARED

feature -- Access

	path: STRING
		do
			Result := "Images/Animations/"
		end

	animation_index: INTEGER

	animation_list: LIST [GAME_SURFACE]

feature


	generate_animation (a_path: STRING; a_image_quantity: INTEGER)
		-- Generate an animation from a folder
		local
			l_image_number: INTEGER
		do
			animation_list := create {ARRAYED_LIST [GAME_SURFACE]}.make (24)
			from
				l_image_number := 1
			until
				l_image_number > a_image_quantity
			loop
				animation_list.extend (IMAGE_FACTORY.blue_cube_animation (a_path, l_image_number))
				l_image_number := l_image_number + 1
			end
		end

	animation_image: GAME_SURFACE
		-- Execute the animation
		do
			animation_index := (animation_index + 1) \\ 24
			Result := animation_list.at ((animation_index) + 1)
		end

end
