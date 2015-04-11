note
	description: "Summary description for {CHARACTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

inherit

	DISPLAYABLE

	HARD_MOBILE
		redefine update end

	SHARED

create
	make

feature {NONE} -- Initialization

	make (a_cell_position_x, a_cell_position_y: CELL [REAL])
		local
		do
			create {GAME_SURFACE_IMG_FILE} image.make_with_alpha (image_file)
			create vector.make (0, 0, 0.5, 0.97, 1, 15)
			cell_position_x := a_cell_position_x
			cell_position_y := a_cell_position_y
			position_x := cell_position_x.item.rounded
			position_y := cell_position_y.item.rounded

		end

	image_file: STRING
			-- The image file path.
		do
			Result := "Images/cube.png"
		end

feature -- Access

	level: LEVEL assign assign_level

	cell_position_x: CELL [REAL] assign assign_cell_position_x

	cell_position_y: CELL [REAL] assign assign_cell_position_y

	friction_source: AUDIO_SOURCE
		local
			l_sound: AUDIO_SOUND_WAV_FILE
		once
			audio_controller.add_source
			Result := audio_controller.last_source
			create l_sound.make ("Sounds/music.wav")
			Result.queue_sound_infinite_loop (l_sound)
		end

	touching_ground: BOOLEAN assign assign_touching_ground

	jumping: BOOLEAN assign assign_jumping

	go_left: BOOLEAN assign assign_go_left

	go_right: BOOLEAN assign assign_go_right

	surrounding_tiles: ARRAYED_LIST [TILE] assign assign_surrounding_tiles

feature -- Routines

	update
		do
			cell_position_y.put (position_y + vector.norm_y)
			position_y := cell_position_y.item.rounded
			detect_collision(true)

			cell_position_x.put (position_x + vector.norm_x)
			position_x := cell_position_x.item.rounded
			detect_collision(false)

			apply_gravity
			friction_source.set_gain (vector.norm_x.item.abs / vector.max_speed)
			if vector.norm_x.item.abs > 0 and not friction_source.is_playing then
				friction_source.play
			else
					--friction_source.pause
			end
			audio_controller.update
		end

	detect_collision(y:BOOLEAN)
		local
			l_surrounding_tiles: ARRAYED_LIST [TILE]
		do
			l_surrounding_tiles := level.scan_surrounding_tiles (center_x, center_y, 3, 3)
			across
				l_surrounding_tiles as la_surrounding_tiles
			loop
				if attached {HARD_TILE} la_surrounding_tiles.item as la_tile then
					if la_tile.check_collision (current) then
						if y then
							la_tile.apply_collision_y (current)
						else
							la_tile.apply_collision_x (current)
						end
					end
				end
			end
		end

	slow_down
		do
			vector.norm_x := (vector.norm_x * vector.deceleration_x)
		end

	apply_gravity
		do
			vector.norm_y := (vector.norm_y + vector.acceleration_y)
		end

	move_left
		do
			vector.norm_x := (vector.norm_x - vector.acceleration_x)
			if vector.norm_x <= - vector.max_speed then
				vector.norm_x := (- vector.max_speed)
			end
		end

	move_right
		do
			vector.norm_x := (vector.norm_x + vector.acceleration_x)
			if vector.norm_x >= vector.max_speed then
				vector.norm_x := vector.max_speed
			end
		end

	jump
		do
			vector.norm_y:= -15
		end

feature --Assigner

	assign_level (a_level: LEVEL)
		do
			level := a_level
		end

	assign_cell_position_x (a_cell_position_x: CELL [REAL])
		do
			cell_position_x := a_cell_position_x
		end

	assign_cell_position_y (a_cell_position_y: CELL [REAL])
		do
			cell_position_y := a_cell_position_y
		end

	assign_surrounding_tiles (a_surrounding_tiles: ARRAYED_LIST [TILE])
		do
			surrounding_tiles := a_surrounding_tiles
		end

	assign_go_left(a_go_left: BOOLEAN)
		do
			go_left:= a_go_left
		end

	assign_go_right(a_go_right: BOOLEAN)
		do
			go_right:= a_go_right
		end

	assign_touching_ground(a_touching_ground: BOOLEAN)
		do
			touching_ground:= a_touching_ground
		end

	assign_jumping(a_jumping: BOOLEAN)
		do
			jumping:= a_jumping
		end
end
