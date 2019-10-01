/// @description Shoot and set timer


if global.alive = true{
	instance_create_depth(x, bbox_bottom, 0, obj_enemy_bullet);
}

alarm[0] = shoot_time_min + random(shoot_time_range)




