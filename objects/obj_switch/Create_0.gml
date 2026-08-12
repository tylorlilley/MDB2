event_inherited();

// Game Maker Variable Overrides
depth = SWITCH_DEPTH;
sprite_index = spr_switch;
image_index = 0;

// New Variables
pressed = false

// New Functions
press_switch = function() {
	if (!pressed) { global.controller.pressed_switch_colors[switch_color] = true; }
	else { global.controller.blocked_switch_colors[switch_color] = true; }
}