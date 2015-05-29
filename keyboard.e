note
	description: "Allow objects to react with keyboard"
	author: "Alexandre Girardin"
	date: "May 28"

class
	KEYBOARD

inherit

	SHARED

create
	make

feature --Access

	left_key: BOOLEAN

	right_key: BOOLEAN

	space_key: BOOLEAN

feature --Routines

	make
		-- Initialize keyboard
		do
			controller.event_controller.on_key_down.extend (agent on_key_down)
			controller.event_controller.on_key_up.extend (agent on_key_up)
		end

	on_key_down (event: GAME_KEYBOARD_EVENT)
		-- Handle event when key is press
		do
			if event.is_left_key then
				left_key := true
			elseif event.is_right_key then
				right_key := true
			end
			if event.is_space_key then
				space_key := true
			end
		end

	on_key_up (event: GAME_KEYBOARD_EVENT)
		-- Handle event when key is press
		do
			if event.is_left_key then
				left_key := false
			elseif event.is_right_key then
				right_key := false
			end
			if event.is_space_key then
				space_key := false
			end
		end

end
