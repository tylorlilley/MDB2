var _mouse_x = get_mouse_room_x(), _mouse_y = get_mouse_room_y();
if (_mouse_x < 0 || _mouse_y < 0 || _mouse_x >= room_width || _mouse_y >= room_height) { exit; }

var _hit_portal = false;
with (obj_portal) {
	if (position_meeting(_mouse_x, _mouse_y, id)) {
		portal_color++;
		if (portal_color >= 12) { portal_color = 0; }
		_hit_portal = true;
	}
}

if (!debug_enabled || _hit_portal) { exit; }

with (obj_game_object) {
	if (object_index == obj_portal || object_index == obj_door) { continue; }
	if (position_meeting(_mouse_x, _mouse_y, id)) { powerfall_on(); }
}