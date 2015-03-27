note
	description: "Summary description for {SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED

feature {PLAYER}

	level: LEVEL

feature

	controller: GAME_LIB_CONTROLLER
		once
			create Result.make
			Result.enable_video
		end

	image_controller: GAME_IMG_CONTROLLER
		once
			create Result.make
			Result.enable_image (true, false, false)
		end

	audio_controller: AUDIO_CONTROLLER
		once
			create Result.make
			Result.enable_sound
		end

	image_factory: IMAGE_FACTORY
		once
			create Result.make
		end

end