function scr_player_revolver()
{
    hsp = xscale * movespeed;
    landAnim = 0;
    
    if (grounded)
    {
        if (movespeed > 0)
            movespeed -= 0.1;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_playerV_revolverstart)
        sprite_index = spr_playerV_revolverhold;
    
    if ((sprite_index == spr_playerV_revolverhold || sprite_index == spr_playerV_airrevolverstart || sprite_index == spr_playerV_revolverstart) && !key_slap)
    {
        if (grounded)
            sprite_index = spr_playerV_revolvershoot;
        else
            sprite_index = spr_playerV_airrevolver;
        
        image_index = 0;
        
        with (instance_create(x + (xscale * 20), y + 20, obj_shotgunbullet))
        {
            is_solid = 0;
            image_xscale = other.xscale;
        }
        
        scr_soundeffect(54);
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_playerV_revolvershoot)
    {
        image_index = 0;
        state = UnknownEnum.Value_0;
        sprite_index = spr_playerV_revolverend;
        movespeed = 2;
    }
    
    if ((sprite_index == spr_playerV_airrevolverend || sprite_index == spr_playerV_airrevolver || sprite_index == spr_playerV_airrevolverstart) && grounded)
    {
        if (key_attack && movespeed >= 6)
            state = UnknownEnum.Value_104;
        else
            state = UnknownEnum.Value_0;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_playerV_airrevolver)
    {
        if (key_attack && movespeed >= 6)
        {
            state = UnknownEnum.Value_104;
        }
        else
        {
            image_index = 0;
            state = UnknownEnum.Value_0;
        }
    }
    
    image_speed = 0.4;
}
