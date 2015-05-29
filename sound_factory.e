note
	description: "Create sound"
	author: "Alexandre Girardin"
	date: "May 28"

class
	SOUND_FACTORY

create
	make

feature {NONE}

	make
		-- Initialize sound factory
		do
			number_of_instances.put (number_of_instances.item + 1)
		end

	number_of_instances: CELL[INTEGER]
		-- Contain number of instance
		once
			create Result.put(0)
		end

feature -- Routines

	scream:AUDIO_SOUND
		once
			create {AUDIO_SOUND_SND_FILE} Result.make ("Sounds/Wilhelm_Scream.ogg")
		end

	long_scream:AUDIO_SOUND
		once
			create {AUDIO_SOUND_SND_FILE} Result.make ("Sounds/Long_Scream.wav")
		end

	death_scream:AUDIO_SOUND
		once
			create {AUDIO_SOUND_SND_FILE} Result.make ("Sounds/The_Howie_Long_Scream.ogg")
		end

invariant
	unique_instance: number_of_instance.item = 1
end
