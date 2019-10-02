/// Lives

// Lost Life
if (lives == 0) {
    image_index = 1;
	global.lose = true
}

// Gained Life
else if (lives == 1) {
    image_index = 2;
}