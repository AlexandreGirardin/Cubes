note
	description: "Cubes application root class"
	author: "Alexandre Girardin"
	date: "May 28"

class
	GAME

inherit

	ARGUMENTS
	SHARED

create
	cubes

feature {NONE} -- Initialization

	cubes
		-- Main target
		local
			engine: ENGINE
			l_text_controller: GAME_TEXT_CONTROLLER
		do
			create l_text_controller.make
			l_text_controller.enable_text
			create engine.make
			engine.run_game
			engine := Void
			audio_controller.quit_library
			image_controller.quit_library
			l_text_controller.quit_library
			controller.quit_library
		end


end
