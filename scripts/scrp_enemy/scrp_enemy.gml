/// scr_enemy

var xx = 128
var yy = 128

for (var i = 1; i <= 5; i++){
	for (var j = 1; j <= 11; j++){
		if(i == 1)
			instance_create_depth(xx+(95*j), yy+(96*i), 0, obj_enemy_top);
		if (i == 2 or i == 3)
			instance_create_depth(xx+(95*j), yy+(96*i), 0, obj_enemy_middle);
		if (i == 4 or i == 5)
			instance_create_depth(xx+(95*j), yy+(96*i), 0, obj_enemy_bottom);
	}
}