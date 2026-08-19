event_inherited();

// Game Maker Variable Overrides
set_depth(SWITCH_DEPTH);
sprite_index = spr_switch;
image_index = 0;

// New Variables
pressed = false;

// New Functions
press_switch = function() {
	if (!pressed) { array_push(global.controller.pressed_switch_colors[switch_color], id); }
	else {  array_push(global.controller.blocked_switch_colors[switch_color], id); }
}