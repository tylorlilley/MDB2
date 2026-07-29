if (visible && has_cape && cape_depth >= depth) { draw_cape_graphics(); }
event_inherited();
if (visible && has_cape && cape_depth < depth) { draw_cape_graphics(); }

