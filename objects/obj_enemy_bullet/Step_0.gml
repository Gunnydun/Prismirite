/// @description Move

y += y_speed;

// If the bullet goes past the bottom of the screen, delete it
if (bbox_top > room_width) {
  instance_destroy();
}