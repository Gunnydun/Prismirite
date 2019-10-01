// Move
x += dir * x_speed;

if (global.enemy <= 27){
	x_speed = 2;
}

if (global.enemy <= 13){
	x_speed = 3;
}

if (bbox_left < 0) {
	with (obj_enemy_top){
		dir *= -1;
		y = y + 29;
	}
} else if (bbox_right > room_width) {
	with (obj_enemy_top){
		dir *= -1;
		y = y + 29;
}


}

if (atk_mode = true){
	image_angle = point_direction(x,y,obj_player.x, obj_player.y)
	move_towards_point(obj_player.x, obj_player.y, x_speed);
}

	