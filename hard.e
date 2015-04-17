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

	collision_top: BOOLEAN assign assign_collision_top

	collision_bottom: BOOLEAN assign assign_collision_bottom

	collision_left: BOOLEAN assign assign_collision_left

	collision_right: BOOLEAN assign assign_collision_right

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
				if a_object.center_y <= center_y then
					a_object.collision_bottom:= true
					a_object.position_y :=  center_y - (a_object.image.height + half_height)
					a_object.vector.norm_y := 0
				else
					a_object.collision_top:= true
					a_object.position_y := center_y + half_height
					a_object.vector.norm_y := 0
				end
			end
		end

	apply_collision_x(a_object: HARD_MOBILE)
		do
			if (a_object.center_x - center_x).abs <= (half_width + a_object.half_width).abs then
				if a_object.center_x <= center_x then
					a_object.collision_right:= true
					a_object.position_x := center_x - (a_object.image.width + half_width)
					a_object.vector.norm_x := 0
				else
					a_object.collision_left:= true
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

	assign_collision_top (a_collision_top: BOOLEAN)
		do
			collision_top:= a_collision_top
		end

	assign_collision_bottom (a_collision_bottom: BOOLEAN)
		do
			collision_bottom:= a_collision_bottom
		end

	assign_collision_left (a_collision_left: BOOLEAN)
		do
			collision_left:= a_collision_left
		end

	assign_collision_right (a_collision_right: BOOLEAN)
		do
			collision_right:= a_collision_right
		end

end
