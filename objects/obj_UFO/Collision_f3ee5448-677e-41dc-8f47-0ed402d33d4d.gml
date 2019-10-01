if (lives <= 2){
	lives ++;
}
else if (lives == 3){
	global.points = global.points + choose(50, 100, 150, 200, 90);
}

instance_destroy();