
xx = choose(-10, room_width + 10)

ufo = instance_create_depth(xx, 150, 0, obj_UFO);
if (xx == -10)
	ufo.dir = 1;
if (xx == room_width + 10)
	ufo.dir = -1;

alarm[0] = UFO_delay