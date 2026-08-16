#macro INTERRUPTION_FRAME 180

event_inherited();

actor_strings = [
	"PRINCESS",
	"DR. MISCHIVEO",
]
	
text_box_strings = [
	"Mighty Dive Bomber!", // Princess
	"Thank you for coming to save me, but you are too late!",
	"Dr. Mischevio has gotten away in his flying saucer.",
	"He will live on, to terrorize our people once again.",
	"Dive Bomber!? What are you doing!?",
	"Dive Bomber, no! You can only fall straight down - you'll die!",
	"...Dive Bomber?",
	"WHAT!? You can FLY!?",
	"Yahoo! Mighty Dive Bomber, you did it!",
	"Aargh! You fools!", // Mischiveo
	"You have no idea what you have just done.",
	"This whole island is rigged to blow. You have doomed us all!",
	"Quickly, Mighty Dive Bomber!", // Princess
	 "Let's escape across the clouds - back to Metro City!",
	 "No! After them, you fools! Don't let them get away!" // Mischiveo
];

text_pos_timer = 0;
text_pos = 0;
actor = 0;
next_text_trigger = FIRST_WAIT + DISPLAY_TIME + TEXT_WAIT;
text_time = TEXT_WAIT/2;