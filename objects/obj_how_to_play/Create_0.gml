event_inherited();

#macro cancel_string "PRESS ANY KEY TO RETURN"
#macro FIRST_WAIT 48
#macro PLAYER_WAIT 16
#macro TEXT_WAIT 40
#macro DISPLAY_TIME 180

// Override Parent Variables
cutscene_timer_max = 9999; // TODO: Update this at end?
text_pos_timer = 0;
next_text_trigger = FIRST_WAIT + DISPLAY_TIME + TEXT_WAIT;
text_pos = 0;
text_box_strings = [
	"Press LEFT or RIGHT to\nmove in that direction.",
	"Press LEFT or RIGHT to\nclimb up walls one tile tall.",
	"Press UP or DOWN to grab onto\na ladder while overlapping it.",
	"Press UP or DOWN on a ladder\nto move in that direction.",
	"Press LEFT or RIGHT while grounded\nto get off it in that direction.",
	"You auto-grab ladders when\nyou exactly overlap them in midair.",
	"Press DOWN to climb off\nthe bottom of midair ladders.",
	"Fall a distance of 1 tile\nto land on the ground safely.",
	"Fall for 2 or more tiles to dive\nbomb any tiles you land on.",
	"Some types of tiles are destroyed\nafter fewer hits than others.",
	"Some types of tiles can't\nbe damaged at all.",
	"Collect a key by\exactly overlapping it.",
	"Unlock the level's door\nby collecting all the keys.",
	"Exactly overlap the unlocked\ndoor to win the level",
	"Destroying the tile under\nthe door will destroy it too",
	"If you are stuck, press ENTER\nor START to restart the level",
	"You also restart the level\nif you fall off the bottom of the screen",
	"Good luck, and happy dive bombing!"
];