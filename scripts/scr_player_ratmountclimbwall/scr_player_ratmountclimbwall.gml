function scr_player_ratmountclimbwall()
{
    if (wallspeed < 0)
        image_speed = 0.1;
    
    hsp = 0;
    vsp = 0;
    
    if (sprite_index != spr_player_ratmountbounceside)
    {
        sprite_index = spr_player_ratmountbounceside;
        image_index = 0;
    }
    else if (floor(image_index) == (image_number - 1))
    {
        image_index = image_number - 1;
    }
    
    if (!grounded && !place_meeting(x + 1, y, obj_solid) && !place_meeting(x - 1, y, obj_solid))
    {
        state = UnknownEnum.Value_192;
        jumpAnim = 0;
        sprite_index = spr_player_ratmountfall;
    }
    
    if (sticktime > 0)
    {
        sticktime--;
    }
    else
    {
        state = UnknownEnum.Value_192;
        sprite_index = spr_player_ratmountfall;
    }
    
    if (key_attack && floor(image_index) == (image_number - 1))
    {
        state = UnknownEnum.Value_198;
        xscale *= -1;
        vsp = -14;
        ratmount_fallingspeed = 0;
        movespeed = 10;
        hsp = move * 10;
        sprite_index = spr_player_ratmountwalljump;
    }
}
