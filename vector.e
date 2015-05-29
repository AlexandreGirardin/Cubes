note
	description: "Give objects capability to move"
	author: "Alexandre Girardin"
	date: "May 28"

class
	VECTOR

create
	make

feature -- Initialization

	make (a_norm_x, a_norm_y, a_acceleration_x, a_deceleration_x, a_acceleration_y, a_max_speed: REAL)
		-- Initialize vector
		do
			norm_x := a_norm_x
			norm_y := a_norm_y
			acceleration_x := a_acceleration_x
			deceleration_x:= a_deceleration_x
			acceleration_y := a_acceleration_y
			max_speed := a_max_speed
		end

feature -- Access

	norm_x: REAL assign set_norm_x

	norm_y: REAL assign set_norm_y

	acceleration_x: REAL

	deceleration_x: REAL

	acceleration_y: REAL

	max_speed: REAL

feature -- Assigners

	set_norm_x(a_norm_x:REAL)
		do
			norm_x:= a_norm_x
		end

	set_norm_y(a_norm_y:REAL)
		do
			norm_y:= a_norm_y
		end

end
