function shine() {
	anim_timer--;
	if (anim_timer == 0) {
		image_index = 1;
		anim_timer = 120 + irandom(16);
	}
	else {
		image_index = 0;
	}
}

function draw_sprite_silhoutte(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha) {
	gpu_set_fog(true, _silhoutte_color, 0, 0);
	draw_sprite_ext(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha);
	gpu_set_fog(false, _silhoutte_color, 0, 0);
}