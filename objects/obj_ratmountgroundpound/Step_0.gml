instance_destroy(instance_place(x, y + 16, obj_destructibles));
instance_destroy(instance_place(x, y + vsp, obj_destructibles));
instance_destroy(instance_place(x, y + 16, obj_metalblock));
instance_destroy(instance_place(x, y + vsp, obj_metalblock));
scr_collide();

if (grounded && !place_meeting(x, y + 1, obj_destructibles) && !place_meeting(x, y + 1, obj_metalblock))
    instance_destroy();
