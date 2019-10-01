/// @description Move

y += y_speed;
x += x_speed;

if (bbox_right > room_width) {
  instance_destroy();
  instance_create_depth(x, bbox_top, 0, obj_lftbullet);
}



// If the bullet goes past the top of the screen, delete it
if (bbox_bottom < 0) {
  instance_destroy();
}