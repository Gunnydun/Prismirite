/// Movement/shots

var dir = 0;

// Moving left
if (keyboard_check(vk_left)) {
  dir -= 1;
}

// Moving right
if (keyboard_check(vk_right)) {
  dir += 1;
}

// Move player
x += dir * x_speed;

// If the player is outside the screen, move them to the edge
if (bbox_left < 0) {
  x -= bbox_left
} else if (bbox_right > room_width) {
  x += (room_width - bbox_right)
}

// Shoot bullet
if (keyboard_check_pressed(vk_space) && global.alive = true) {
  if (!instance_exists(obj_player_bullet)){
	  instance_create_depth(x, bbox_top, 0, obj_player_bullet);
  }
}

