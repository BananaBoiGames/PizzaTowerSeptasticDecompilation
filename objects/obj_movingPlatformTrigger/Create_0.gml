var angle_flip;

depth = 15;
angle_flip = (sign(image_xscale) == -1) ? 180 : 0;
targetAngle = image_angle + angle_flip;
