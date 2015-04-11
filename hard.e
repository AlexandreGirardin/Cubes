note
	description: "Summary description for {HARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HARD

feature -- ACCESS

	image: GAME_SURFACE
		deferred
		end

	position_x: INTEGER assign assign_position_x
		deferred
		end

	position_y: INTEGER assign assign_position_y
		deferred
		end

	left_x: INTEGER
		do
			Result := position_x
		end

	right_x: INTEGER
		do
			Result := position_x + image.width
		end

	top_y: INTEGER
		do
			Result := position_y
		end

	bottom_y: INTEGER
		do
			Result := position_y + image.height
		end

	center_x: INTEGER
		do
			Result := position_x + half_width
		end

	center_y: INTEGER
		do
			Result := position_y + half_height
		end

	half_width: INTEGER
		do
			Result := image.width // 2
		end

	half_height: INTEGER
		do
			Result := image.height // 2
		end

feature -- Routines

	check_collision (a_object: HARD_MOBILE): BOOLEAN
		do
			if (a_object.center_y - center_y).abs < (a_object.half_height + half_height) and (a_object.center_x - center_x).abs < (a_object.half_width + half_width) then
				Result := true
			end
		end


	apply_collision_y (a_object: HARD_MOBILE)
		do
			if (a_object.center_y - center_y).abs <= (half_height + a_object.half_height).abs then
				if a_object.center_y <= center_y - 1 then
					a_object.position_y :=  center_y - (a_object.image.height + half_height)
					a_object.vector.norm_y := 0
					if attached {PLAYER} a_object as la_a_object then
						la_a_object.touching_ground:= true
					end
				else
					a_object.position_y := center_y + half_height
					a_object.vector.norm_y := 0
				end
			end
		end

	apply_collision_x(a_object: HARD_MOBILE)
		do
			if (a_object.center_x - center_x).abs <= (half_width + a_object.half_width).abs then
				if a_object.center_x <= center_x then
					a_object.position_x := center_x - (a_object.image.width + half_width)
					a_object.vector.norm_x := 0
				else
					a_object.position_x := center_x + half_width
					a_object.vector.norm_x := 0
				end
			end
		end

feature -- Assigners

	assign_position_x (a_position_x: INTEGER)
		deferred
		end

	assign_position_y (a_position_y: INTEGER)
		deferred
		end

end
