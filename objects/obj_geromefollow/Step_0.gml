if (sprite_index == spr_gerome_collected && floor(image_index) == (image_number - 1))
    sprite_index = spr_gerome_keyidle;

if (room == rank_room || room == timesuproom)
    visible = false;

if (obj_player1.spotlight == 1)
    playerid = 245;
else
    playerid = 244;

image_speed = 0.35;
depth = -6;
