event_inherited();

if (!global.controller.is_logic_frame()) { exit; }

if (cutscene_timer >= INTERRUPTION_FRAME) {
	with (obj_player) { 
		if (is_hop_up_state() || is_hop_down_state()) {
			var _image_index = image_index;
			sprite_index = spr_player_dying;
			image_index = _image_index;
			cape_sprite_index = spr_cape_crushed;
			cape_image_index = 0;
		}
		else if (!is_left) {
			is_left = false;
			other.text_pos_timer++;
		}
	}
}