function scr_player_fireass()
{
    image_speed = 0.35;
    alarm[5] = 2;
    alarm[7] = 60;
    
    if (place_meeting(x + hsp, y, obj_solid))
        image_xscale *= -1;
    
    if (sprite_index == spr_fireass || sprite_index == spr_scaredjump1 || sprite_index == spr_scaredjump2)
    {
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_fireass)
            create_particle(x, y + 25, UnknownEnum.Value_7, 0);
        
        move = key_left + key_right;
        
        if (move != 0)
            xscale = move;
        
        hsp = move * movespeed;
        movespeed = 4;
        
        if (place_meeting(x, y + 1, obj_haystack))
        {
            vsp = -20;
        }
        else if (grounded && vsp > 0)
        {
            movespeed = 6;
            
            if (sprite_index == spr_fireass)
            {
                sprite_index = spr_fireassground;
            }
            else
            {
                movespeed = 0;
                landAnim = 0;
                alarm[5] = 2;
                alarm[7] = 60;
                hurted = 1;
                state = UnknownEnum.Value_0;
                sprite_index = spr_idle;
                image_index = 0;
            }
            
            image_index = 0;
        }
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_scaredjump1)
        sprite_index = spr_scaredjump2;
    
    if (sprite_index == spr_fireassground)
    {
        hsp = xscale * movespeed;
        
        if (movespeed > 0)
            movespeed -= 0.25;
        
        if (floor(image_index) == (image_number - 1))
        {
            movespeed = 0;
            landAnim = 0;
            alarm[5] = 2;
            alarm[7] = 60;
            hurted = 1;
            state = UnknownEnum.Value_0;
            sprite_index = spr_idle;
            image_index = 0;
        }
    }
    
    if (sprite_index == spr_fireassend)
    {
        if (floor(image_index) == (image_number - 1))
        {
            movespeed = 0;
            landAnim = 0;
            alarm[5] = 2;
            alarm[7] = 60;
            hurted = 1;
            state = UnknownEnum.Value_0;
            sprite_index = spr_idle;
            image_index = 0;
        }
    }
}
