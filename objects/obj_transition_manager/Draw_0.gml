// Draw Cutscene Bards
var _bar_height = floor(room_height/4);
draw_set_color(C_BLACK);
draw_rectangle(0, 0, room_width, _bar_height, false);
draw_rectangle(0, _bar_height * 3, room_width, room_height, false);

// Setup for Drawing Text
var _top_base = "Now Leaving", _top_extra = "... " + from_string, _top_y = _bar_height - 24;
var _bottom_base = "Now Entering", _bottom_extra = "... " + to_string, _bottom_y = (_bar_height * 3);// + 24;
draw_set_color(C_WHITE);
draw_set_font(ft_nirmala_ui);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Determine current state
var _state = TRANSITION_STATES.FINAL_WAIT, _time_in_state = 0, _elapsed = 0;
for (var _i = 0; _i < array_length(state_durations); _i++) {
	if (transition_timer < _elapsed + state_durations[_i]) {
		_state = _i;
		_time_in_state = transition_timer - _elapsed;
		break;
	}
	_elapsed += state_durations[_i];
}
var _progress = (_time_in_state + 1) / state_durations[_state];

// Setup Strings
switch (_state) {
	case TRANSITION_STATES.TOP_TEXT_FLY_IN: {
		draw_transition_line(_top_base, from_string, _top_y, TRANSITION_TEXT_PHASE.FLY_IN, _progress, 1);
		break;
	}
	case TRANSITION_STATES.TOP_TEXT_SCRAWL: {
		draw_transition_line(_top_base, from_string, _top_y, TRANSITION_TEXT_PHASE.SCRAWL, _progress, 1);
		break;
	}
	case TRANSITION_STATES.TOP_TEXT_FLY_OUT: {
		draw_transition_line(_top_base, from_string, _top_y, TRANSITION_TEXT_PHASE.FLY_OUT, _progress, 1);
		break;
	}
	case TRANSITION_STATES.BOTTOM_TEXT_FLY_IN: {
		draw_transition_line(_bottom_base, to_string, _bottom_y, TRANSITION_TEXT_PHASE.FLY_IN, _progress, -1);
		break;
	}
	case TRANSITION_STATES.BOTTOM_TEXT_SCRAWL: {
		draw_transition_line(_bottom_base, to_string, _bottom_y, TRANSITION_TEXT_PHASE.SCRAWL, _progress, -1);
		break;
	}
	case TRANSITION_STATES.BOTTOM_TEXT_FLY_OUT: {
		draw_transition_line(_bottom_base, to_string, _bottom_y, TRANSITION_TEXT_PHASE.FLY_OUT, _progress, -1);
		break;
	}
}

/*
// Determine X POS
var _top_x_pos = room_width, _bottom_x_pos = 0, _second_scrawl_start = INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME + TRANSITION_WAIT;
if (transition_timer < INITIAL_WAIT) { _top_x_pos = 9999; }
else if (transition_timer < INITIAL_WAIT + TEXT_SCRAWL_TIME) {
	var _time_in_state = transition_timer - INITIAL_WAIT, _time_in_state_max = TEXT_SCRAWL_TIME;
	_top_x_pos = room_width;
	_top_x_pos -= ((room_width/3) / _time_in_state_max) * _time_in_state;
}
else if (transition_timer < INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME + 16) {
	var _time_in_state = transition_timer - (INITIAL_WAIT + TEXT_SCRAWL_TIME), _time_in_state_max = ELIPSES_TIME + 16;
	_top_x_pos = (room_width/3);
	_top_x_pos -= ((room_width/3) / _time_in_state_max) * _time_in_state;
}
else {
	var _time_in_state = transition_timer - (INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME + 16), _time_in_state_max = TEXT_SCRAWL_TIME;
	_top_x_pos = 2*(room_width/3);
	_top_x_pos -= ((room_width/3) / _time_in_state_max) * _time_in_state;
}

if (transition_timer < _second_scrawl_start) {
	_bottom_x_pos += ((room_width/2) / INITIAL_WAIT) * (transition_timer - (INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME));
}
else if (transition_timer < _second_scrawl_start + TEXT_SCRAWL_TIME) {
	_bottom_x_pos += (room_width/2) + (transition_timer - _second_scrawl_start);
}
else {
	_bottom_x_pos += ((room_width/2) + TEXT_SCRAWL_TIME) + ((room_width/2) / INITIAL_WAIT) * (transition_timer - _second_scrawl_start - TEXT_SCRAWL_TIME);
}

// Draw Text
draw_set_valign(fa_top);
var _string = "Now Leaving...", x_pos = room_width/2;
/*
if (transition_timer < INITIAL_WAIT) { }
else if (transition_timer < (INITIAL_WAIT + TEXT_SCRAWL_TIME)) {
	draw_text(_top_x_pos, _third_height-24, string_copy(_string, 1, min((transition_timer - TEXT_SCRAWL_TIME) div 2, string_length(_string))));
}
else if (transition_timer < (INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME)) {
	draw_text(_top_x_pos, _third_height-24, string_copy(_string, 1, 11 + min((transition_timer - INITIAL_WAIT - TEXT_SCRAWL_TIME)  div 8, string_length(_string))));
}
else {
	_string += " " + from_string;
	draw_text(_top_x_pos, _third_height-24, _string);
}
*/

/*
draw_set_valign(fa_bottom);
var _string2 = "Now Entering...";
if (transition_timer < _second_scrawl_start) { }
else if (transition_timer < _second_scrawl_start + TEXT_SCRAWL_TIME) {
	draw_text(_bottom_x_pos, (_third_height*3)+24, string_copy(_string2, 1, min((transition_timer - _second_scrawl_start) div 2, string_length(_string))));
}
else if (transition_timer < (_second_scrawl_start + TEXT_SCRAWL_TIME + ELIPSES_TIME)) {
	draw_text(_bottom_x_pos, (_third_height*3)+24, string_copy(_string2, 1, 12 + min((transition_timer - _second_scrawl_start - TEXT_SCRAWL_TIME)  div 8, string_length(_string))));
}
else {
	_string2 += " " + to_string;
	draw_text(_bottom_x_pos, (_third_height*3)+24, _string2);
}
*/