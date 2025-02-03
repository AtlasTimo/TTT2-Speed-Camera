CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "submenu_addons_speed_camera_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "help_speed_camera_general")

	form:MakeSlider({
		label = "label_speed_camera_range",
		serverConvar = "ttt_speed_camera_range",
		min = 200,
		max = 1000,
		decimal = 0
	})

	form:MakeCheckBox({
		label = "label_speed_camera_show_range",
		serverConvar = "ttt_speed_camera_show_range"
	})

	form:MakeSlider({
		label = "label_speed_camera_charges",
		serverConvar = "ttt_speed_camera_charges",
		min = 1,
		max = 50,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_speed_camera_trigger_speed",
		serverConvar = "ttt_speed_camera_trigger_speed",
		min = 1,
		max = 1000,
		decimal = 0
	})

	local form2 = vgui.CreateTTT2Form(parent, "help_speed_camera_team")

	form2:MakeCheckBox({
		label = "label_speed_camera_friendly_fire",
		serverConvar = "ttt_speed_camera_friendly_fire"
	})

	form2:MakeSlider({
		label = "label_speed_camera_enemy_damage",
		serverConvar = "ttt_speed_camera_enemy_damage",
		min = 0,
		max = 300,
		decimal = 0
	})

	form2:MakeSlider({
		label = "label_speed_camera_teammates_damage",
		serverConvar = "ttt_speed_camera_teammates_damage",
		min = 0,
		max = 300,
		decimal = 0
	})
end
