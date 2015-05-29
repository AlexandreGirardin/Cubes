note
	description: "Allow objects to quit the game"
	author: "Alexandre Girardin"
	date: "May 28"

class
	CAN_QUIT
inherit
	SHARED

feature -- Routines

	on_quit
		-- Allow to quit
		do
			if network.is_ready then
				network.stop
			end
			controller.stop
		end

end
