/// @description Move

y += y_speed;
x += x_speed;

if (bbox_left < 0) {
  instance_destroy();
  instance_create_depth(x, bbox_top, 0, obj_rghtbullet);
} 

if (bbox_bottom < 0) {
  instance_destroy();
}