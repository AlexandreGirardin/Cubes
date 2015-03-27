note
	description: "Cubes application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

inherit

	ARGUMENTS
	SHARED

create
	make

feature {NONE} -- Initialization

	make
		local
			engine: ENGINE
		do
			create engine.make
			engine.run_game
			engine := Void
			audio_controller.quit_library
			image_controller.quit_library
			controller.quit_library
		end

end
