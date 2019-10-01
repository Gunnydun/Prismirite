/// @description Move

y += y_speed;

// If the bullet goes past the top of the screen, delete it
if (bbox_bottom < 0) {
  instance_destroy();
}