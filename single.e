note
	description: "Contain all singleton"
	author: "Alexandre Girardin"
	date: "May 28"

class
	SINGLE
create
	make
feature {NONE} -- Initialization

	make
		-- Initialise single
		do
			number_of_instance.put (number_of_instance.item + 1)
		end

	number_of_instance:CELL[INTEGER]
		-- Contain number of instance
		once
			create Result.put (0)
		end

feature -- Access
	local_player: PLAYER assign set_local_player

	online_player: PLAYER assign set_online_player

feature -- Assigners

	set_local_player(a_local_player: PLAYER)
		do
			local_player:= a_local_player
		end

	set_online_player(a_online_player: PLAYER)
		do
			online_player:= a_online_player
		end

invariant
	unique_instance: number_of_instance.item = 1

end
