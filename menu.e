note
	description: "Allow objects to have menu caracteristics"
	author: "Alexandre Girardin"
	date: "May 28"

deferred class
	MENU

inherit
	SHARED
	CAN_QUIT

feature --

	initialize_event_controller
		-- Initialize menu event
		do
			controller.clear_event_controller
			controller.event_controller.on_quit_signal.extend (agent on_quit)
			controller.event_controller.on_mouse_button_down.extend (agent on_mouse_down)
			controller.event_controller.on_mouse_button_up.extend (agent on_mouse_up)
			controller.event_controller.on_iteration.extend (agent display)
		end

	display
		-- Display menu
		deferred
		end

	on_mouse_down(is_left_button, is_right_button, is_middle_button: BOOLEAN; mouse_x, mouse_y: NATURAL_16)
		-- Handle mouse event when mouse buttons is pressed
		deferred
		end

	on_mouse_up(is_left_button, is_right_button, is_middle_button: BOOLEAN; mouse_x, mouse_y: NATURAL_16)
		-- Handle mouse event when mouse buttons is released
		deferred
		end

end
