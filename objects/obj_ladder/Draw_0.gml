var _ignored_solids = [];
with (obj_player) { array_push(_ignored_solids, id); }
var _use_silhoutte = is_inside_solid(_ignored_solids);
image_alpha = (_use_silhoutte) ? 0.33 : 1;
set_shader_palette((_use_silhoutte) ? PALETTES.ALL_BLACK : main_palette);

draw_self();