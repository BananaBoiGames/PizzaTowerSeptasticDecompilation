function scr_playerN_machcancelstart()
{
    hsp = 0;
    vsp = 0;
    movespeed = 0;
    image_speed = 0.5;
    
    if (floor(image_index) == (image_number - 1))
    {
        state = UnknownEnum.Value_306;
        sprite_index = spr_playerN_jetpackboost;
        instance_create(x, y, obj_jumpdust);
        movespeed = 15;
    }
}

function scr_playerN_machcancel()
{
    var xx;
    
    noisemachcancelbuffer = 10;
    hsp = movespeed;
    move = key_right + key_left;
    
    if (move != 0)
        savedmove = move;
    
    if (sprite_index == spr_playerN_divebomb || sprite_index == spr_playerN_divebombland || sprite_index == spr_playerN_divebombfall)
    {
        if (move != 0)
        {
            if (abs(movespeed) < 12)
                movespeed = Approach(movespeed, move * 12, 1);
            else
                movespeed = Approach(movespeed, move * abs(movespeed), 1);
        }
        else
        {
            movespeed = Approach(movespeed, 0, 0.25);
        }
        
        xx = movespeed;
        
        if (xx == 0)
            xx = xscale;
        
        if (grounded && vsp > 0 && place_meeting(x + xx, y, obj_solid))
        {
            mask_index = spr_crouchmask;
            
            if (!place_meeting(x + xx, y, obj_solid) || place_meeting(x + xx, y, obj_destructibles))
            {
                state = UnknownEnum.Value_5;
                sprite_index = spr_machroll;
                image_index = 0;
                instance_destroy(instance_place(x + xx, y, obj_destructibles));
                
                if (movespeed != 0)
                    xscale = sign(movespeed);
                
                movespeed = abs(movespeed);
                
                if (movespeed < 6)
                    movespeed = 6;
            }
            
            mask_index = spr_player_mask;
        }
    }
    else if (move != 0)
    {
        movespeed = Approach(movespeed, move * 8, 1);
    }
    else
    {
        movespeed = Approach(movespeed, 0, 0.5);
    }
    
    if (scr_noise_machcancel_grab())
        exit;
    
    if (scr_check_groundpound2() && sprite_index != spr_playerN_divebombfall && !grounded)
    {
        sprite_index = spr_playerN_divebombfall;
        state = UnknownEnum.Value_306;
        vsp = 20;
        input_buffer_slap = 0;
        input_buffer_jump = 0;
        image_index = 0;
        exit;
    }
    
    if (grounded && sprite_index == spr_playerN_divebombfall)
    {
        image_index = 0;
        sprite_index = spr_playerN_divebombland;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_playerN_divebombland)
    {
        image_index = 0;
        sprite_index = spr_playerN_divebomb;
    }
    
    if (grounded && !scr_check_groundpound2() && vsp >= 0 && sprite_index != spr_playerN_wallbounce)
    {
        vsp = -7;
        
        if (move != 0)
            xscale = move;
        
        with (instance_create(x, y + 20, obj_noiseeffect))
            sprite_index = spr_noisewalljumpeffect;
        
        sprite_index = spr_playerN_wallbounce;
        GamepadSetVibration(0, 0.5, 0.5);
        scr_soundeffect(197);
    }
    
    if (grounded && key_attack && vsp >= 0 && sprite_index == spr_playerN_wallbounce)
    {
        input_buffer_slap = 0;
        
        if (move != 0)
            xscale = move;
        else if (savedmove != 0)
            xscale = savedmove;
        
        jumpstop = true;
        state = UnknownEnum.Value_121;
        movespeed = 12;
        sprite_index = spr_playerN_mach3;
        
        with (instance_create(x, y, obj_noiseeffect))
        {
            sprite_index = spr_noisegrounddasheffect;
            image_xscale = other.xscale;
        }
        
        flash = true;
        image_index = 0;
        
        with (instance_create(x, y, obj_crazyrunothereffect))
            image_xscale = other.xscale;
        
        scr_soundeffect(212);
        scr_soundeffect(188);
    }
    
    noisedoublejump = true;
    
    if (input_buffer_slap > 0 && key_up && (!global.pistol || !ispeppino))
    {
        input_buffer_slap = 0;
        state = UnknownEnum.Value_80;
        image_index = 0;
        sprite_index = spr_breakdanceuppercut;
        vsp = -21;
        movespeed = hsp;
        particle_set_scale(4, xscale, 1);
        create_particle(x, y, 4, 0);
    }
    
    if (!ispeppino && key_up && input_buffer_jump < 8 && !scr_check_groundpound2())
    {
        input_buffer_jump = 8;
        freefallstart = 0;
        railmomentum = false;
        
        if (place_meeting(x, y + 1, obj_railparent))
            railmomentum = true;
        
        scr_player_do_noisecrusher();
    }
    
    if (grounded && !key_attack && vsp >= 0 && sprite_index == spr_playerN_wallbounce)
    {
        state = UnknownEnum.Value_0;
        movespeed = abs(hsp);
    }
    
    if (sprite_index == spr_playerN_divebomb || sprite_index == spr_playerN_divebombland || sprite_index == spr_playerN_divebombfall)
    {
        if (!instance_exists(dashcloudid) && grounded)
        {
            with (instance_create(x, y, obj_dashcloud))
            {
                image_xscale = other.move;
                other.dashcloudid = id;
            }
        }
        
        image_speed = (abs(movespeed) / 40) + 0.4;
    }
    else
    {
        image_speed = 0.5;
    }
    
    if (punch_afterimage > 0)
    {
        punch_afterimage--;
    }
    else
    {
        punch_afterimage = 5;
        instance_create(x + random_range(5, -5), y + random_range(20, -20), obj_tornadoeffect);
        
        if (grounded && (sprite_index == spr_playerN_divebomb || sprite_index == spr_playerN_divebombland || sprite_index == spr_playerN_divebombfall))
        {
            repeat (2)
            {
                with (instance_create(x + random_range(3, -3), y + 45, obj_noisedebris))
                    sprite_index = spr_noisedrilldebris;
            }
        }
        
        create_noise_afterimage(x, y, sprite_index, image_index, xscale);
    }
    
    scr_dotaunt();
}

function scr_noise_machcancel_grab()
{
    if (ispeppino)
        exit;
    
    image_speed = 0.5;
    move = key_left + key_right;
    
    if (input_buffer_slap > 0 && !key_up)
    {
        if (!shotgunAnim || move != 0)
        {
            if (move != 0)
                xscale = move;
            
            input_buffer_slap = 0;
            key_slap = false;
            key_slap2 = false;
            jumpstop = true;
            
            if (vsp > -5)
                vsp = -5;
            
            state = UnknownEnum.Value_104;
            movespeed = 12;
            sprite_index = spr_playerN_sidewayspin;
            
            with (instance_create(x, y, obj_crazyrunothereffect))
                image_xscale = other.xscale;
            
            image_index = 0;
            particle_set_scale(UnknownEnum.Value_5, xscale, 1);
            create_particle(x, y, UnknownEnum.Value_5, 0);
            scr_soundeffect(196);
        }
        else if (savedmove != 0)
        {
            xscale = savedmove;
        }
        
        return true;
    }
    
    return false;
}
