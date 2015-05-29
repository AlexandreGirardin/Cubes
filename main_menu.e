note
	description: "Allow to create main menu"
	author: "Alexandre Girardin"
	date: "May 28"

class
	MAIN_MENU

inherit

	MENU

create
	make

feature --Initialization {NONE}

	make
		-- Initialize main menu
		do
			initialize_event_controller
			create title_font.make ("Fonts/Super Cube.ttf", 130)
			create text_font.make ("Fonts/text.ttf", 45)
			create font_color.make_rgb (0, 0, 0)
			create title_background_color.make_rgb (0, 0, 153)
			create text_background_color.make_rgb (255, 153, 0)
			title := create {GAME_SURFACE_TEXT}.make_blended ("Cubes", title_font, font_color)
			text_1 := create {GAME_SURFACE_TEXT}.make_blended ("Host serveur", text_font, font_color)
			text_2 := create {GAME_SURFACE_TEXT}.make_blended ("Join serveur", text_font, font_color)
		end

feature -- Access

	is_host: BOOLEAN

	is_client: BOOLEAN

	title_font, text_font: GAME_FONT

	font_color, title_background_color, text_background_color: GAME_COLOR

	title, text_1, text_2: GAME_SURFACE

	text_1_x: INTEGER
		do
			Result := ((controller.screen_surface.width / 2) - (text_1.width / 2)).rounded
		end

	text_1_y: INTEGER
		do
			Result := (title.height * 3) + text_1.height
		end

	text_2_x: INTEGER
		do
			Result := ((controller.screen_surface.width / 2) - (text_2.width / 2)).rounded
		end

	text_2_y: INTEGER
		do
			Result := (title.height * 4)
		end

feature

	display
		-- Display main menu
		do
			controller.screen_surface.fill_rect (title_background_color, ((controller.screen_surface.width / 2) - (title.width / 2)).rounded - 5, title.height - 2, title.width + 10, title.height - 6)
			controller.screen_surface.fill_rect (text_background_color, ((controller.screen_surface.width / 2) - (title.width / 2)).rounded - 5, (title.height * 3) - 2, title.width + 10, (title.height * 2) - 6)
			controller.screen_surface.draw_surface (title, ((controller.screen_surface.width / 2) - (title.width / 2)).rounded, title.height)
			controller.screen_surface.draw_surface (text_1, text_1_x, text_1_y)
			controller.screen_surface.draw_surface (text_2, text_2_x, text_2_y)
			controller.flip_screen
		end

	on_mouse_down (is_left_button, is_right_button, is_middle_button: BOOLEAN; mouse_x, mouse_y: NATURAL_16)
		-- Handle mouse event when mouse buttons is pressed
		do
			if is_left_button then
				if mouse_x >= text_1_x and mouse_x <= text_1_x + text_1.width then
					if mouse_y >= text_1_y and mouse_y <= text_1_y + text_1.height then
						is_host:= true
						controller.stop
					end
				end

				if mouse_x >= text_2_x and mouse_x <= text_2_x + text_2.width then
					if mouse_y >= text_2_y and mouse_y <= text_2_y + text_2.height then
						is_client:= true
						controller.stop
					end
				end
			end
		end

	on_mouse_up (is_left_button, is_right_button, is_middle_button: BOOLEAN; mouse_x, mouse_y: NATURAL_16)
		-- Handle mouse envent when mouse buttons is released
		do
		end

end
