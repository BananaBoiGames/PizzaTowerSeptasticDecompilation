instance_create(x - 50, y + random_range(0, obj_chickenpickup), obj_cheesedragonflames);
scr_soundeffect(127);

if (attackcycle == 2 && floor(image_index) > 13 && floor(image_index) < 21 && sprite_index == spr_cheesedragon_flames)
    alarm[1] = 30;
else
    alarm[1] = -1;
