note
	description: "Summary description for {ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENGINE

inherit

	SHARED

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize_controller
			initialize_background
			initialize_level
			initialize_player
			background.delta_position_x := player.cell_position_x
			background.delta_position_y := player.cell_position_y
			player.level := level
			level.player := player
		end

feature -- Initialization

	initialize_controller
		do
			controller.event_controller.on_quit_signal.extend (agent on_quit)
			create surface.make_with_bit_per_pixel (1024, 768, 16, true)
			controller.event_controller.on_iteration.extend (agent main_loop) -- Activate the main loop
			controller.create_screen_surface (surface.width, surface.height, 16, true, true, false, true, false)
		end

	initialize_background
		local
			i, j: INTEGER
			image: GAME_SURFACE_IMG_FILE
			model: TILE
		do
			create image.make_with_alpha ("Images/background.png")
			create model.make_tile (image,0 ,0)
			create background.make
			from
				i := surface.start_x - (2 * model.image.width)
			until
				i > surface.width + (2 * model.image.width)
			loop
				from
					j := surface.start_y - (2 * model.image.height)
				until
					j > surface.height + (2 * model.image.height)
				loop
					background.extend (create {TILE}.make_tile (image, i, j))
					j := j + model.image.height
				end
				i := i + model.image.width
			end
		end

	initialize_level
		do
			level:= level_factory.build_level (1)
		end

	initialize_player
		local
			l_cell_position_x: CELL [REAL]
			l_cell_position_y: CELL [REAL]
		do
			create l_cell_position_x.put (level.start_x)
			create l_cell_position_y.put (level.start_y)
			create player_to_draw.make (2)
			player := create {PLAYER}.make (l_cell_position_x, l_cell_position_y)
		end

feature -- Access

	surface: GAME_SURFACE

	level:LEVEL

	background: BACKGROUND

	player_to_draw: ARRAYED_LIST [PLAYER]

	player: PLAYER

	source: AUDIO_SOURCE

feature -- Routines

	run_game
		do
			controller.event_controller.on_key_down.extend (agent on_key_down)
			controller.event_controller.on_key_up.extend (agent on_key_up)
			controller.launch -- The controller will loop until the stop controller.method is called (in method on_quit)

		end

	main_loop
		do
			if player.go_left then
				player.move_left
			end

			if player.go_right then
				player.move_right
			end

			if not player.go_left and not player.go_right then
				player.slow_down
			end

			background.update
			level.update
			player.update

			background.display (controller)
			level.display
			level.display_player
			controller.flip_screen -- Show the screen in the window
		end

	on_key_down (event: GAME_KEYBOARD_EVENT)
		do
			if event.is_left_key then
				player.go_left := true
			elseif event.is_right_key then
				player.go_right := true
			end

			if event.is_space_key then
				player.jump
			end
		end

	on_key_up (event: GAME_KEYBOARD_EVENT)
		do
			if event.is_left_key then
				player.go_left := false
			elseif event.is_right_key then
				player.go_right := false
			end
		end

	on_quit
		do
			controller.stop
		end

end
