note
	description: "Summary description for {CHARACTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

inherit

	SHARED

create
	make

feature {NONE} -- Initialization

	make (a_position_x: CELL [REAL]; a_position_y: INTEGER)
		local
		do
			create image.make_with_alpha (image_file)
			width := image.width
			height := image.height
			position_x := a_position_x
			position_y := a_position_y
		end

	image_file: STRING
			-- The image file path.
		do
			Result := "Images/cube.png"
		end

feature -- Access

	image: GAME_SURFACE_IMG_FILE

	width: INTEGER

	height: INTEGER

	position_y: INTEGER

	position_x: CELL [REAL] assign assign_position_x

	right_x: INTEGER
		do
			Result := x_int + width
		end

	left_x: INTEGER
		do
			Result:= x_int
		end

	top_y: INTEGER

	bottom_y: INTEGER

	x_int: INTEGER
		do
			Result := position_x.item.rounded
		end

	y_int: INTEGER
		do
			Result := position_y
		end

	center_x: INTEGER
		do
			Result:= x_int + (width // 2)
		end

	center_y: INTEGER
		do
			Result:= y_int + (width // 2)
		end

	vector_x: REAL

	max_speed: REAL
		do
			Result := 10
		end

	acceleration_x: REAL
		do
			Result := 0.2
		end

	friction_source: AUDIO_SOURCE
		local
			l_sound: AUDIO_SOUND_WAV_FILE
		once
			audio_controller.add_source
			Result := audio_controller.last_source
			create l_sound.make ("Sounds/music.wav")
			Result.queue_sound_infinite_loop (l_sound)
		end

feature -- Routines

	update
		do
			position_x.put (position_x.item + vector_x)
			friction_source.set_gain (vector_x.item.abs / max_speed)
			if vector_x.item.abs > 0 and not friction_source.is_playing then
				friction_source.play
			else
--				friction_source.pause
			end
			audio_controller.update
		end

	slow_down
		do
			vector_x := (vector_x * 0.97)
		end

	move_left
		do
			vector_x := (vector_x - 0.5)
			if vector_x <= - max_speed then
				vector_x := (- max_speed)
			end
		end

	move_right
		do
			vector_x := (vector_x + 0.5)
			if vector_x >= max_speed then
				vector_x := (max_speed)
			end
		end

	assign_position_x (a_position_x: CELL [REAL])
		do
			position_x := a_position_x
		end

end
