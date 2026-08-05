display_set_gui_maximise();

draw_set_color(C_BLACK);
draw_set_font(ft_nirmala_ui);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _gui_width = display_get_gui_width(), gui_height = display_get_gui_height();
draw_text(_gui_width/2, -40, "MIGHTY DIVE BOMBER");