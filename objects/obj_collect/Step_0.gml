if (room == rm_editor)
    exit;

if (global.collectsound < 10)
    global.collectsound += 1;

if (global.timeattack == 1)
    instance_destroy();

if (place_meeting(x, y, obj_destructibles))
    depth = 102;
else
    depth = 2;

if (abs(distance_to_object(obj_player1)) < 25 && !place_meeting(x, y, obj_destructibles) && !place_meeting(x, y, obj_iceblock) && image_alpha >= 1)
{
    if (!gotowardsplayer)
        scr_ghostcollectible();
    
    gotowardsplayer = true;
}

if (gotowardsplayer == 1)
{
    move_towards_point(obj_player.x, obj_player.y, movespeed);
    movespeed++;
}

if (object_index == obj_escapecollect)
{
    if (global.panic == 1)
        image_alpha = 1;
}
