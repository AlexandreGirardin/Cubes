note
	description: "Player of the game"
	author: "Alexandre Girardin"
	date: "May 28"

class
	PLAYER

inherit

	ANIMATED

	DISPLAYABLE

	HARD_MOBILE

	SHARED

create
	make

feature {NONE} -- Initialization

	make (a_position_x, a_position_y: INTEGER)
		-- Initialize player
		local
		do
			create vector.make (0, 0, 0.51, 0.97, 1, 15)
			position_x := a_position_x
			position_y := a_position_y
			generate_animation ("Cubes/Blue/cube", 24)
		end

feature -- Access

	surrounding_tiles: LIST [TILE] assign set_surrounding_tiles

	scream_source: AUDIO_SOURCE
		once
			audio_controller.add_source
			Result := audio_controller.last_source
			Result.queue_sound_loop (sound_factory.long_scream,1)
		end

feature -- Routines

	update_local_player
		-- Update local player
		do
			reset_collisions
			update_Y
			update_x
			apply_gravity
			read_keyboard
			play_sound
			network.send ("p")
			network.send (position_x.out + " " + position_y.out)
		end

	update_online_player
		-- Update online player
		do
			position_x:= network.last_x
			position_y:= network.last_y
		end

	reset_collisions
		-- Reset all the collision flags
		do
			collision_top := false
			collision_bottom := false
			collision_left := false
			collision_right := false
		end

	read_keyboard
		-- Handle keyboard
		do
			if keyboard.left_key or keyboard.right_key then
				if keyboard.left_key then
					move_left
				end
				if keyboard.right_key then
					move_right
				end
			else
				slow_down
			end

			if keyboard.space_key then
				jump
			end
		end

	update_x
		-- Update player position x
		do
			position_x := (position_x + vector.norm_x).ceiling
			detect_collision (false)
		end

	update_y
		-- Update player position y
		do
			position_y:= (position_y + vector.norm_y).floor
			detect_collision (true)
		end

	detect_collision (y: BOOLEAN)
		--Detect collision
		do
			across
				surrounding_tiles as la_surrounding_tiles
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
			if single.online_player.check_collision (current) then
				if y then
							single.online_player.apply_collision_y (current)
						else
							single.online_player.apply_collision_x (current)
						end
			end
		end

	slow_down
		-- Slow down the player
		do
			vector.norm_x := (vector.norm_x * vector.deceleration_x)
		end

	apply_gravity
		-- Apply gravity to player
		do
			if collision_left or collision_right then
				vector.norm_y := 5
			else
				vector.norm_y := (vector.norm_y + vector.acceleration_y)
			end
		end

	move_left
		-- Move the player to the left
		do
			vector.norm_x := (vector.norm_x - vector.acceleration_x)
			if vector.norm_x <= - vector.max_speed then
				vector.norm_x := (- vector.max_speed)
			end
		end

	move_right
		-- Move the player to the right
		do
			vector.norm_x := (vector.norm_x + vector.acceleration_x)
			if vector.norm_x >= vector.max_speed then
				vector.norm_x := vector.max_speed
			end
		end

	jump
		-- Allow the player to jump
		do
			if collision_bottom then
				vector.norm_y := -15
			else
				if collision_left then
					vector.norm_y := -15
					vector.norm_x := 10
				end
				if collision_right then
					vector.norm_y := -15
					vector.norm_x := -10
				end
			end
		end

	play_sound
		-- Play player sound
		do
			if not collision_top and not collision_bottom and not collision_left and not collision_right then
				if vector.norm_y > 25 then
					scream_source.set_gain ((vector.norm_y/50).min(1))
					if not scream_source.is_playing then
						scream_source.play
					end
				end
			else
				scream_source.pause
			end
			audio_controller.update
		end

feature --Assigner

	set_surrounding_tiles (a_surrounding_tiles: LIST [TILE])
		do
			surrounding_tiles := a_surrounding_tiles
		end

end
