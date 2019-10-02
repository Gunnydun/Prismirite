/// enemy collison

if(lives > 1){
	audio_play_sound(die , 10, false)
}
global.alive = false;
instance_create_depth(x, y, 0, obj_explode);
visible = false
lives--;
with(obj_enemy_bullet){
	instance_destroy();
}




alarm[1] = respawn_time;
	

