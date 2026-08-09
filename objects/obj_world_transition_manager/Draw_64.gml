// Draw Cutscene Letterbox
var _bar_height = floor(SCREEN_HEIGHT/4);
draw_set_color(C_BLACK);
draw_rectangle(0, 0, SCREEN_WIDTH, _bar_height, false);
draw_rectangle(0, _bar_height * 3, SCREEN_WIDTH, SCREEN_HEIGHT, false);

// Setup for Drawing Text
var _top_base = "Leaving", _top_extra = TRANSITION_ELLIPSIS + from_string, _top_y = _bar_height - 24;
var _bottom_base = "Entering", _bottom_extra = TRANSITION_ELLIPSIS + to_string, _bottom_y = (_bar_height * 3);
draw_set_color(C_WHITE);
draw_set_font(ft_pixel);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Determine current state
var _state = TRANSITION_STATES.FINAL_WAIT, _time_in_state = 0, _elapsed = 0;
for (var _i = 0; _i < array_length(state_durations); _i++) {
	if (cutscene_timer < _elapsed + state_durations[_i]) {
		_state = _i;
		_time_in_state = cutscene_timer - _elapsed;
		break;
	}
	_elapsed += state_durations[_i];
}
var _progress = (_time_in_state + 1) / state_durations[_state];

// Setup Strings
switch (_state) {
	case TRANSITION_STATES.TOP_TEXT_FLY_IN: {
		draw_transition_line(_top_base, from_string, _top_y, TRANSITION_TEXT_PHASE.FLY_IN, _progress, -1);
		break;
	}
	case TRANSITION_STATES.TOP_TEXT_SCRAWL: {
		draw_transition_line(_top_base, from_string, _top_y, TRANSITION_TEXT_PHASE.SCRAWL, _progress, -1);
		break;
	}
	case TRANSITION_STATES.TOP_TEXT_FLY_OUT: {
		draw_transition_line(_top_base, from_string, _top_y, TRANSITION_TEXT_PHASE.FLY_OUT, _progress, -1);
		break;
	}
	case TRANSITION_STATES.BOTTOM_TEXT_FLY_IN: {
		draw_transition_line(_bottom_base, to_string, _bottom_y, TRANSITION_TEXT_PHASE.FLY_IN, _progress, 1);
		break;
	}
	case TRANSITION_STATES.BOTTOM_TEXT_SCRAWL: {
		draw_transition_line(_bottom_base, to_string, _bottom_y, TRANSITION_TEXT_PHASE.SCRAWL, _progress, 1);
		break;
	}
	case TRANSITION_STATES.BOTTOM_TEXT_FLY_OUT: {
		draw_transition_line(_bottom_base, to_string, _bottom_y, TRANSITION_TEXT_PHASE.FLY_OUT, _progress, 1);
		break;
	}
}