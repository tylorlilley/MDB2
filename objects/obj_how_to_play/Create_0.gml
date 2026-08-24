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
return_to_title = false;
restarted = false;
text_pos_timer = 0;

// Latched copy of the demo's inputs for the on-screen control display
shown_key_left = false;
shown_key_right = false;
shown_key_up = false;
shown_key_down = false;

next_text_trigger = INTRO_WAIT + DISPLAY_TIME + TEXT_WAIT;
text_pos = 0;
text_box_strings = [
	"Welcome to Mighty Dive Bomber!\nWatch this demo to learn to play.",
	"Press LEFT or RIGHT to\nmove in that direction.",
	"You cannot climb walls that\nare two or more tiles tall.",
	"Press LEFT or RIGHT to\nclimb up walls one tile tall.",
	"Fall a distance of one tile\nto safely land on the ground.",
	"Fall two or more tiles to dive!\nYou damage tiles you dive into.",
	"Press UP or DOWN to get on a\nladder you exactly overlap.",
	"Press UP or DOWN while on a\nladder to move in that direction.",
	"Press LEFT or RIGHT to get off\nabove an empty ground tile.",
	"In midair, you automatically grab\nladders you exactly overlap.",
	"Press DOWN to climb off the bottom\nof ladders above empty tiles.",
	"Some tiles will only be destroyed\nafter they are hit multiple times.",
	"Some types of tiles can't\nbe damaged at all.",
	"Exactly overlap a key\nto collect it.",
	"Destroying tiles will also destroy\nany objects resting above them!",
	"If you are stuck, press ENTER\nor SELECT to restart the level.",
	"Press ESC to pause. From there you\ncan return to the title screen.",
	"Unlock the level's door\nby collecting all the keys.",
	"Exactly overlap the unlocked\ndoor to win the level.",
	"Good luck! Close the door\nwith UP on your way out."
];
