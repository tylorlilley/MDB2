event_inherited();
play_global_sound(bgm_old_how_to_play);

#macro cancel_string "ANY KEY TO QUIT DEMO"
#macro INTRO_WAIT TRANSITION_DURATION
#macro FIRST_WAIT 48
#macro PLAYER_WAIT 16
#macro TEXT_WAIT 32
#macro DISPLAY_TIME 148
#macro MIN_KEY_HOLD 12

// Override Parent Variables
cutscene_timer_max = 9999; // TODO: Update this at end?
restarted = false;
text_pos_timer = 0;
textbox = noone;

// Latched copy of the demo's inputs for the on-screen control display
shown_key_left = false;
shown_key_right = false;
shown_key_up = false;
shown_key_down = false;

next_text_trigger = INTRO_WAIT + DISPLAY_TIME + TEXT_WAIT;
text_pos = 0;
text_box_strings = [
	"Welcome to Mighty Dive Bomber!\nWatch this demo to learn to play.",
	"Press LEFT or RIGHT to move in that direction.",
	"Moving into a wall two or more tiles tall will stop you.",
	"Press LEFT or RIGHT to climb up walls that are one tile tall.",
	"Fall a distance of one tile\nand you will safely land on the ground.",
	"Fall two or more tiles to dive! You damage tiles you dive into.",
	"Press UP or DOWN to get on a ladder that you overlap.",
	"Press UP or DOWN while on a ladder to move in that direction.",
	"Press LEFT or RIGHT to get off above an empty ground tile.",
	"In midair, you automatically grab ladders that you overlap.",
	"You can climb off the bottom of midair ladders with DOWN.",
	"Some types of tiles will only be destroyed after multiple hits.",
	"Some types of tiles can't be destroyed at all.",
	"Overlap a key to collect it.",
	"If you destroy a tile above an empty space, you will dive again!",
	"If you are stuck, press ENTER or SELECT to restart the level.",
	"Press ESC if you need to pause or return to the main menu.",
	"Unlock a level's door by collecting all the keys.",
	"Overlap an open, grounded door\nto win the level!",
	"Good luck! Use UP to\nclose the door and move on."
];
