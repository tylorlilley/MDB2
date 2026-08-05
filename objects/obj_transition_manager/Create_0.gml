#macro TRANSITION_WAIT_TIME		12
#macro TRANSITION_FLY_TIME		16
#macro TRANSITION_SCRAWL_TIME	56
#macro TRANSITION_REVEAL_WINDOW	0.5
#macro TRANSITION_CRAWL_OFFSET	0
#macro TRANSITION_GAP_FRAMES	6
#macro TRANSITION_ELLIPSIS		"... "

enum TRANSITION_STATES {
	INITIAL_WAIT,
	TOP_TEXT_FLY_IN,
	TOP_TEXT_SCRAWL,
	TOP_TEXT_FLY_OUT,
	MIDDLE_WAIT,
	BOTTOM_TEXT_FLY_IN,
	BOTTOM_TEXT_SCRAWL,
	BOTTOM_TEXT_FLY_OUT,
	FINAL_WAIT
}

enum TRANSITION_TEXT_PHASE { FLY_IN, SCRAWL, FLY_OUT }

state_durations = [
	TRANSITION_WAIT_TIME,		// INITIAL_WAIT
	TRANSITION_FLY_TIME,		// TOP_TEXT_FLY_IN
	TRANSITION_SCRAWL_TIME,		// TOP_TEXT_SCRAWL
	TRANSITION_FLY_TIME,		// TOP_TEXT_FLY_OUT
	TRANSITION_WAIT_TIME,		// MIDDLE_WAIT
	TRANSITION_FLY_TIME,		// BOTTOM_TEXT_FLY_IN
	TRANSITION_SCRAWL_TIME,		// BOTTOM_TEXT_SCRAWL
	TRANSITION_FLY_TIME,		// BOTTOM_TEXT_FLY_OUT
	infinity					// FINAL_WAIT
];

transition_timer = 0;
depth = -10;
global.controller.level_number--;
transition_max = 240;

transition_revealed_length = function(_name, _progress) {
	var _prefix_length = string_length(TRANSITION_ELLIPSIS), _total = _prefix_length + string_length(_name);
	if (_total <= 0) { return 0; }

	// Frames elapsed in the scrawl, and the frames left for typing once the gap is taken out.
	var _frame = _progress * TRANSITION_SCRAWL_TIME;
	var _typing_frames = max(1, (TRANSITION_SCRAWL_TIME * TRANSITION_REVEAL_WINDOW) - TRANSITION_GAP_FRAMES);
	var _gap_start = (_prefix_length * _typing_frames) / _total;

	if (_frame >= _gap_start && _frame < _gap_start + TRANSITION_GAP_FRAMES) { return _prefix_length; }

	// Multiply before dividing; dividing first accumulates float error and can drop the last character a frame late.
	var _typed_frames = (_frame < _gap_start) ? _frame : _frame - TRANSITION_GAP_FRAMES;
	return min(_total, floor((_typed_frames * _total) / _typing_frames));
}

transition_text_x = function(_phase, _progress, _width, _direction) {
	var _center = room_width / 2;
	var _clear_right = room_width + _width;	// Fully off the right edge.
	var _clear_left = -_width;							// Fully off the left edge.

	var _enter = (_direction > 0) ? _clear_right : _clear_left;
	var _exit = (_direction > 0) ? _clear_left : _clear_right;
	var _crawl_from = _center + (TRANSITION_CRAWL_OFFSET * _direction);
	var _crawl_to = _center - (TRANSITION_CRAWL_OFFSET * _direction);

	switch (_phase) {
		case TRANSITION_TEXT_PHASE.FLY_IN: { return lerp(_enter, _crawl_from, _progress); }
		case TRANSITION_TEXT_PHASE.SCRAWL: { return lerp(_crawl_from, _crawl_to, _progress); }
		case TRANSITION_TEXT_PHASE.FLY_OUT: { return lerp(_crawl_to, _exit, _progress); }
	}
}

draw_transition_line = function(_base, _name, _y, _phase, _progress, _direction) {
	var _revealed = 0;
	switch (_phase) {
		case TRANSITION_TEXT_PHASE.FLY_IN:{ _revealed = 0; break; }
		case TRANSITION_TEXT_PHASE.SCRAWL: { _revealed = transition_revealed_length(_name, _progress); break; }
		case TRANSITION_TEXT_PHASE.FLY_OUT: { _revealed = string_length(TRANSITION_ELLIPSIS + _name); break; }
	}

	var _text = _base + string_copy(TRANSITION_ELLIPSIS + _name, 1, _revealed);
	var _width = string_width(_text);
	draw_text(floor(transition_text_x(_phase, _progress, _width, _direction) - (_width / 2)), _y, _text);
}