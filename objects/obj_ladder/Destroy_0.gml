event_inherited();

with (obj_ladder) { update_connections(); }
if (instance_exists(manager)) { manager.should_redraw = true; }