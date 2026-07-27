if (visible && cape_depth >= depth) { draw_cape_graphics(); }
event_inherited();
if (visible && cape_depth < depth) { draw_cape_graphics(); }

