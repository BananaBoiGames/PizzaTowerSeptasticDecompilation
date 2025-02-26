function scr_player_animatronic()
{
    sprite_index = spr_pepanimatronic;
    move = key_left + key_right;
    hsp = move * movespeed;
    
    if (vsp < 0 && !key_jump2 && !jumpstop)
    {
        jumpstop = 1;
        vsp /= 10;
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (move != 0)
    {
        xscale = move;
        movespeed = 4;
    }
    else
    {
        movespeed = 0;
    }
    
    if (animatronic_buffer > 0)
    {
        animatronic_buffer--;
    }
    else
    {
        repeat (3)
            create_debris(x, y, 1636);
        
        state = UnknownEnum.Value_0;
    }
    
    if (grounded && vsp > 0 && input_buffer_jump < 8)
    {
        input_buffer_jump = 8;
        vsp = -11;
        jumpstop = 0;
    }
}
