note
	description: "Run the game"
	author: "Alexandre Girardin"
	date: "May 28"

class
	ENGINE

inherit

	SHARED

create
	make

feature {NONE} -- Initialization

	make
		-- Initiaize Engine class
		do
			create surface.make_with_bit_per_pixel (1024, 768, 16, true)
			controller.create_screen_surface (surface.width, surface.height, 16, true, true, false, true, false)
		end

feature -- Access

	surface: GAME_SURFACE

	level: LEVEL

	main_menu: MAIN_MENU

feature -- Routines

	run_game
		-- Execute the game
		do
			create main_menu.make
			controller.launch
			if main_menu.is_host then
				network.host_server
			elseif main_menu.is_client then
				network.connect_client
			end
			level_factory.build_level (1)
			controller.launch
		end

end
