if (global.enemy <= 0){
	audio_play_sound(snd_win , 10, true)
	scrp_enemy();
	global.enemy = 55;
	global.win = true
}


if (global.lose = true){
	audio_stop_all();
	room = lose;
	  
}

