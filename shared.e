note
	description: "Contain all shared class"
	author: "Alexandre Girardin"
	date: "May 28"

class
	SHARED

feature -- Access

	single: SINGLE
		once
			create Result.make
		end

	network: NETWORK
		once
			create Result.make_network
		end

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

	level_factory: LEVEL_FACTORY
		once
			create Result.make
		end

	image_factory: IMAGE_FACTORY
		once
			create Result.make
		end

	sound_factory: SOUND_FACTORY
		once
			create Result.make
		end

	tile_factory: TILE_FACTORY
		once
			create Result.make
		end

feature{PLAYER}

	keyboard: KEYBOARD
		once
			create Result.make
		end

end
