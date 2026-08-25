// Draw Solids Over Player
shader_reset();
gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
with (obj_player) {
    var _x = floor(virtual_x), _y = floor(virtual_y + virtual_y_offset);
    with (obj_static_area_manager) {
        if (is_occluder && surface_exists(static_area_surface)) {
            draw_surface_part_ext(static_area_surface, _x, _y, 16, 16, _x, _y, 1, 1, c_white, 1);
        }
    }
}
gpu_set_blendmode(bm_normal);