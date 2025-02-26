function boss_noise_decide_attack()
{
    var c;
    
    if (attack_cooldown > 0)
    {
        attack_cooldown--;
    }
    else if (attack_cooldown == 0)
    {
        current_attack = get_attack();
        c = attack_type[current_attack];
        current_behaviour = c[angry];
        attack_cooldown = -1;
    }
}

function get_attack()
{
    var chance, c, minphase, p;
    
    chance = irandom(100) > 40;
    c = UnknownEnum.Value_0;
    
    if (chance)
    {
        c = attack_pool[phase - 1][irandom(array_length(attack_pool[phase - 1]) - 1)];
    }
    else
    {
        minphase = !angry ? 0 : 6;
        p = irandom(phase - 2);
        p = clamp(p, minphase, max_phase - 1);
        c = attack_pool[p][irandom(array_length(attack_pool[p]) - 1)];
    }
    
    return c;
}

function boss_noise_do_attack()
{
    targetstunned = 0;
    state = current_attack;
    attack_cooldown = attack_max[phase - 1];
    current_behaviour = UnknownEnum.Value_0;
    image_xscale = (targetplayer.x != x) ? sign(targetplayer.x - x) : image_xscale;
    
    if (!angry)
        noise_do_attack_normal();
    else
        noise_do_attack_angry();
}

function noise_do_attack_normal()
{
    switch (state)
    {
        case UnknownEnum.Value_42:
            slide = irandom(100) > 50;
            movespeed = 15;
            sprite_index = spr_playerN_spin;
            image_index = 0;
            break;
        
        case UnknownEnum.Value_92:
            slidejump = 1;
            movespeed = 6;
            vsp = -11;
            sprite_index = spr_playerN_jump;
            image_index = 0;
            break;
        
        case UnknownEnum.Value_77:
            skateboard_turns = 0;
            movespeed = 0;
            sprite_index = spr_playerN_mach1;
            image_index = 0;
            break;
        
        case 167:
            state = UnknownEnum.Value_77;
            skateboard_turns = 1;
            movespeed = 0;
            sprite_index = spr_playerN_mach1;
            image_index = 0;
            break;
        
        case 168:
            state = UnknownEnum.Value_74;
            sprite_index = spr_playerN_noisebombkick;
            image_index = 0;
            break;
        
        case UnknownEnum.Value_74:
            sprite_index = spr_playerN_noisebombthrow;
            image_index = 0;
            
            with (instance_create(x, y, obj_noisebossbomb))
            {
                movespeed = 6;
                image_xscale = other.image_xscale;
            }
            
            break;
        
        case 169:
            state = UnknownEnum.Value_58;
            bombpogo = 1;
            pogospeed = 0;
            pogospeedprev = 0;
            pogochargeactive = 0;
            pogo_buffer = pogo_max + (room_speed * irandom(pogo_random));
            break;
        
        case UnknownEnum.Value_58:
            bombpogo = 0;
            pogospeed = 0;
            pogospeedprev = 0;
            pogochargeactive = 0;
            pogo_buffer = pogo_max + (room_speed * irandom(pogo_random));
            break;
        
        case 172:
            state = 170;
            jetpackcancel = 1;
            sprite_index = spr_playerN_jetpackstart;
            image_index = 0;
            movespeed = 0;
            break;
        
        case 170:
            jetpackcancel = 0;
            sprite_index = spr_playerN_jetpackstart;
            image_index = 0;
            movespeed = 0;
            break;
        
        case 173:
            movespeed = 10;
            state = 173;
            scr_soundeffect(40);
            scr_soundeffect(127);
            vsp = -15;
            sprite_index = spr_playerN_noisebombspinjump;
            image_index = 0;
            particle_set_scale(UnknownEnum.Value_5, image_xscale, 1);
            create_particle(x, y, UnknownEnum.Value_5, 0);
            break;
    }
}

function noise_do_attack_angry()
{
    switch (state)
    {
        case UnknownEnum.Value_42:
            spinskateboard = 0;
            slide = irandom(100) > 50;
            movespeed = 15;
            spin_count = 1;
            spin_buffer = spin_max;
            sprite_index = spr_playerN_spin;
            image_index = 0;
            break;
        
        case UnknownEnum.Value_92:
            spinskateboard = 0;
            slidejump = 1;
            slideskateboard = 1;
            spin_count = 0;
            movespeed = 6;
            vsp = -11;
            sprite_index = spr_playerN_jump;
            image_index = 0;
            break;
        
        case 167:
            state = UnknownEnum.Value_42;
            slide = 0;
            skateboard_turns = 1;
            spinskateboard = 1;
            movespeed = 15;
            spin_count = 0;
            spin_buffer = spin_max;
            sprite_index = spr_playerN_spin;
            image_index = 0;
            break;
        
        case UnknownEnum.Value_77:
            state = UnknownEnum.Value_42;
            slide = 0;
            spinskateboard = 1;
            skateboard_turns = 0;
            movespeed = 15;
            spin_count = 0;
            spin_buffer = spin_max;
            sprite_index = spr_playerN_spin;
            image_index = 0;
            break;
        
        case 168:
            bombcount = 1;
            state = UnknownEnum.Value_74;
            sprite_index = spr_playerN_noisebombkick;
            image_index = 0;
            break;
        
        case UnknownEnum.Value_74:
            bombcount = 1;
            sprite_index = spr_playerN_noisebombthrow;
            image_index = 0;
            
            with (instance_create(x, y, obj_noisebossbomb))
            {
                movespeed = 6;
                image_xscale = other.image_xscale;
            }
            
            break;
        
        case 169:
            state = UnknownEnum.Value_58;
            bombpogo = 1;
            pogospeed = 0;
            pogospeedprev = 0;
            pogochargeactive = 0;
            pogo_buffer = pogo_max + (room_speed * irandom(pogo_random));
            break;
        
        case UnknownEnum.Value_58:
            bombpogo = 0;
            pogospeed = 0;
            pogospeedprev = 0;
            pogochargeactive = 0;
            pogo_buffer = pogo_max + (room_speed * irandom(pogo_random));
            break;
        
        case 172:
            jumpcount = 1;
            state = 170;
            jetpackcancel = 1;
            sprite_index = spr_playerN_jetpackstart;
            image_index = 0;
            movespeed = 0;
            break;
        
        case 170:
            jetpackcancel = 0;
            sprite_index = spr_playerN_jetpackstart;
            image_index = 0;
            movespeed = 0;
            break;
        
        case 173:
            jumpcount = 1;
            movespeed = 10;
            state = 173;
            scr_soundeffect(40);
            scr_soundeffect(127);
            vsp = -15;
            sprite_index = spr_playerN_noisebombspinjump;
            image_index = 0;
            particle_set_scale(UnknownEnum.Value_5, image_xscale, 1);
            create_particle(x, y, UnknownEnum.Value_5, 0);
            break;
    }
}

function noise_behaviour_none()
{
    var targetspeed;
    
    move = 0;
    
    if (distance_to_object(targetplayer) < 300)
        move = -sign(targetplayer.x - x);
    
    if (distance_to_object(targetplayer) > 332)
        move = sign(targetplayer.x - x);
    
    hsp = move * movespeed;
    
    if (x != targetplayer.x)
        image_xscale = sign(targetplayer.x - x);
    
    targetspeed = (move == image_xscale) ? (normal_spd - 2) : normal_spd;
    
    if (move != 0)
    {
        if (movespeed < targetspeed)
            movespeed += 0.25;
        else if (movespeed > targetspeed)
            movespeed -= 0.5;
        
        if (movespeed < 3)
            image_speed = 0.35;
        else if (movespeed > 3 && movespeed < 6)
            image_speed = 0.45;
        else
            image_speed = 0.6;
    }
    else if (movespeed > 0)
    {
        movespeed -= 0.1;
    }
    else if (movespeed <= 0)
    {
        movespeed = 0;
    }
    
    sprite_index = (hsp != 0) ? walkspr : idlespr;
    image_xscale = (hsp != 0) ? sign(hsp) : image_xscale;
    
    if (!grounded)
        sprite_index = fallspr;
    
    boss_decide_taunt(220);
}

function noise_behaviour_close()
{
    var dx;
    
    dx = abs(targetplayer.x - x);
    move = (dx > 80) ? sign(targetplayer.x - x) : 0;
    hsp = move * movespeed;
    
    if (move != 0)
    {
        if (movespeed < normal_spd)
            movespeed += 0.5;
        
        if (movespeed < 3)
            image_speed = 0.35;
        else if (movespeed > 3 && movespeed < 6)
            image_speed = 0.45;
        else
            image_speed = 0.6;
    }
    else if (movespeed > 0)
    {
        movespeed -= 0.1;
    }
    else if (movespeed <= 0)
    {
        movespeed = 0;
    }
    
    sprite_index = (hsp != 0) ? walkspr : idlespr;
    image_xscale = (hsp != 0) ? sign(hsp) : image_xscale;
    
    if (!grounded)
        sprite_index = fallspr;
    
    boss_decide_taunt(220);
    
    if (state != UnknownEnum.Value_84)
    {
        if (dx < 192 && attack_cooldown == -1)
            boss_noise_do_attack();
    }
}

function noise_behaviour_anywhere()
{
    image_speed = 0.35;
    sprite_index = idlespr;
    boss_decide_taunt(220);
    
    if (state != UnknownEnum.Value_84)
        boss_noise_do_attack();
}

function noise_behaviour_far()
{
    var dx, i;
    
    dx = abs(targetplayer.x - x);
    image_speed = 0.35;
    sprite_index = idlespr;
    
    if (dx < 200)
    {
        i = 0;
        
        while (current_behaviour == UnknownEnum.Value_2)
        {
            attack_cooldown = 0;
            boss_noise_decide_attack();
            i++;
            
            if (i > 20)
                break;
            else
                continue;
        }
    }
    else
    {
        boss_noise_do_attack();
    }
}

function boss_noise_normal()
{
    boss_noise_decide_attack();
    
    switch (current_behaviour)
    {
        case UnknownEnum.Value_0:
            noise_behaviour_none();
            break;
        
        case UnknownEnum.Value_1:
            noise_behaviour_close();
            break;
        
        case UnknownEnum.Value_3:
            noise_behaviour_anywhere();
            break;
        
        case UnknownEnum.Value_2:
            noise_behaviour_far();
            break;
    }
}

function boss_noise_handstandjump()
{
    image_speed = 0.35;
    hsp = image_xscale * movespeed;
    
    if (!spinskateboard && slidejump == 0 && movespeed > 0)
        movespeed -= 0.35;
    
    if (image_index > (image_number - 1))
    {
        state = UnknownEnum.Value_0;
        movespeed = 0;
        
        if (slidejump == 1)
        {
            movespeed = 6;
            state = UnknownEnum.Value_92;
            slidejump = 2;
            sprite_index = spr_playerN_fall;
        }
    }
    
    if (slide && movespeed < 10 && spin_count <= 0)
    {
        state = UnknownEnum.Value_102;
        sprite_index = spr_playerN_crouchslip;
        image_index = 0;
        movespeed = 15;
    }
    
    if (spin_count > 0 || spinskateboard)
    {
        if (spin_buffer > 0)
        {
            spin_buffer--;
        }
        else if (spinskateboard)
        {
            state = UnknownEnum.Value_77;
            sprite_index = spr_playerN_mach3;
            image_index = 0;
            movespeed = 16;
            spinskateboard = 0;
        }
        else
        {
            spin_count--;
            state = UnknownEnum.Value_42;
            movespeed = 15;
            sprite_index = spr_playerN_spin;
            image_index = 0;
        }
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid))
    {
        state = UnknownEnum.Value_106;
        hsp = -image_xscale * 6;
        vsp = -4;
        sprite_index = bumpspr;
        image_index = 0;
    }
}

function boss_noise_crouchslide()
{
    image_speed = 0.35;
    hsp = image_xscale * movespeed;
    
    if (movespeed > 0)
    {
        movespeed -= 0.35;
    }
    else
    {
        movespeed = 0;
        state = UnknownEnum.Value_0;
        
        if (slideskateboard)
        {
            state = UnknownEnum.Value_77;
            skateboard_turns = 1;
            movespeed = 0;
            sprite_index = spr_playerN_mach1;
            image_index = 0;
        }
    }
    
    if (slideskateboard && place_meeting(x + (sign(hsp) * 116), y, obj_solid))
    {
        state = 167;
        skateboard_turns = 1;
        movespeed = 12;
        sprite_index = spr_playerN_machslideboost;
        image_index = 0;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid))
    {
        state = UnknownEnum.Value_106;
        hsp = -image_xscale * 6;
        vsp = -4;
        sprite_index = bumpspr;
        image_index = 0;
    }
}

function boss_noise_jump()
{
    image_speed = 0.35;
    hsp = image_xscale * movespeed;
    
    if (sprite_index == spr_playerN_jump && image_index > (image_number - 1))
    {
        sprite_index = spr_playerN_fall;
        image_index = 0;
    }
    
    if (slidejump == 1 && vsp >= 0)
    {
        state = UnknownEnum.Value_42;
        slide = 0;
        sprite_index = spr_playerN_spin;
        image_index = 0;
        movespeed = 10;
    }
    
    if (grounded)
    {
        state = UnknownEnum.Value_0;
        
        if (slidejump == 2)
        {
            slidejump = 0;
            movespeed = 15;
            state = UnknownEnum.Value_102;
            image_index = 0;
            sprite_index = spr_playerN_crouchslip;
        }
    }
}

function boss_noise_skateboard()
{
    image_speed = 0.35;
    hsp = image_xscale * movespeed;
    
    if (movespeed < 18)
        movespeed += 0.5;
    
    if (skateboard_turns > 0 && place_meeting(x + (sign(hsp) * 116), y, obj_solid))
    {
        state = 167;
        movespeed = 12;
        sprite_index = spr_playerN_machslideboost;
        image_index = 0;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid))
    {
        state = UnknownEnum.Value_106;
        hsp = -image_xscale * 6;
        vsp = -4;
        sprite_index = bumpspr;
        image_index = 0;
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
    }
    
    if (sprite_index == spr_playerN_mach1 && image_index > (image_number - 1))
        sprite_index = spr_playerN_mach;
}

function boss_noise_skateboardturn()
{
    hsp = image_xscale * movespeed;
    
    if (movespeed > 0)
        movespeed -= 0.4;
    else
        movespeed = 0;
    
    image_speed = 0.35;
    
    if (image_index > (image_number - 1))
    {
        if (sprite_index == spr_playerN_machslideboost)
        {
            sprite_index = !angry ? spr_playerN_mach1 : spr_playerN_mach3;
            state = UnknownEnum.Value_77;
            skateboard_turns--;
            movespeed = !angry ? 12 : 15;
            image_xscale *= -1;
        }
    }
}

function boss_noise_throwing()
{
    image_speed = 0.35;
    hsp = image_xscale * movespeed;
    
    if (movespeed > 0)
        movespeed -= 0.5;
    
    if (sprite_index == spr_playerN_noisebombkick && floor(image_index) == 4 && !bombkick)
    {
        bombkick = 1;
        
        with (instance_create(x + 20, y, obj_noisebossbomb))
        {
            movespeed = 10;
            kick = 1;
            sprite_index = spr_playerN_noisebombslide;
            image_xscale = other.image_xscale;
        }
    }
    
    if (image_index > (image_number - 1))
    {
        state = UnknownEnum.Value_0;
        bombkick = 0;
        
        if (bombcount > 0)
        {
            bombcount--;
            state = UnknownEnum.Value_74;
            
            if (sprite_index == spr_playerN_noisebombkick)
            {
                sprite_index = spr_playerN_noisebombthrow;
                image_index = 0;
                
                with (instance_create(x, y, obj_noisebossbomb))
                {
                    movespeed = 6;
                    image_xscale = other.image_xscale;
                }
            }
            else
            {
                sprite_index = spr_playerN_noisebombkick;
                image_index = 0;
            }
        }
    }
}

function boss_noise_pogo()
{
    var maxpogo, dx, tx;
    
    image_speed = 0.35;
    hsp = image_xscale * movespeed;
    maxpogo = !bombpogo ? 24 : 15;
    
    if (movespeed < 6 && !grounded)
        movespeed += 0.5;
    
    if (place_meeting(x + sign(hsp), y, obj_solid))
        image_xscale *= -1;
    
    if (grounded && sprite_index != spr_playerN_pogobounce && sprite_index != spr_playerN_pogobouncemach)
    {
        scr_soundeffect(125);
        image_index = 0;
        vsp = 0;
        movespeed = 0;
        pogospeedprev = 0;
        sprite_index = pogomach ? spr_playerN_pogobouncemach : spr_playerN_pogobounce;
        create_particle(x, y, UnknownEnum.Value_12, 0);
    }
    
    if (!pogospeedprev && (sprite_index == spr_playerN_pogobounce || sprite_index == spr_playerN_pogobouncemach) && floor(image_index) == 4)
    {
        vsp = bombpogo ? -12 : -6;
        
        if (pogospeed < maxpogo)
            pogospeed += (!angry ? 4 : 8);
        
        movespeed = pogospeed;
        pogospeedprev = 1;
    }
    
    if (image_index > (image_number - 1) && (sprite_index == spr_playerN_pogobounce || sprite_index == spr_playerN_pogobouncemach || sprite_index == spr_playerN_pogofallmach || sprite_index == spr_playerN_pogofall))
        sprite_index = pogochargeactive ? spr_playerN_pogofallmach : spr_playerN_pogofall;
    
    if (pogospeed > 12 && !pogochargeactive)
        pogochargeactive = 1;
    
    if (pogospeed > maxpogo)
        pogospeed = maxpogo;
    
    if (bombpogo && vsp < 5 && !grounded)
    {
        dx = abs(targetplayer.x - x);
        tx = 64;
        
        if (dx < tx && !bombpogoinst)
        {
            with (instance_create(x, y, obj_noisebossbomb))
            {
                movespeed = 0;
                drop = 1;
                image_xscale = other.image_xscale;
            }
            
            bombpogoinst = 1;
        }
        else if (dx > tx)
        {
            bombpogoinst = 0;
        }
    }
    
    if (pogo_buffer > 0)
    {
        pogo_buffer--;
    }
    else if (grounded)
    {
        movespeed = normal_spd;
        state = UnknownEnum.Value_0;
    }
}

function boss_noise_jetpackstart()
{
    image_speed = 0.5;
    hsp = 0;
    vsp = 0;
    
    if (image_index > (image_number - 1))
    {
        state = 171;
        movespeed = !angry ? 15 : 20;
        sprite_index = !angry ? spr_playerN_jetpackboost : spr_playerN_crazyrun;
    }
}

function boss_noise_jetpack()
{
    var maxjetpack, tx, dx;
    
    image_speed = 0.5;
    maxjetpack = 15;
    hsp = image_xscale * movespeed;
    
    if (movespeed > maxjetpack)
        movespeed -= 0.1;
    
    vsp = 0;
    tx = (y != targetplayer.y) ? sign(targetplayer.y - y) : 0;
    
    if (tx != 0)
        vsp = 3 * tx;
    
    if (place_meeting(x + sign(hsp), y, obj_solid))
    {
        state = UnknownEnum.Value_106;
        hsp = -image_xscale * 6;
        vsp = -4;
        sprite_index = bumpspr;
        image_index = 0;
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
    }
    
    if (jetpackcancel)
    {
        dx = abs(targetplayer.x - x);
        
        if (dx < 200)
        {
            state = 173;
            scr_soundeffect(40);
            scr_soundeffect(127);
            vsp = -15;
            sprite_index = spr_playerN_noisebombspinjump;
            image_index = 0;
            particle_set_scale(UnknownEnum.Value_5, image_xscale, 1);
            create_particle(x, y, UnknownEnum.Value_5, 0);
        }
    }
}

function boss_noise_jetpackspin()
{
    var dx;
    
    image_speed = 0.35;
    move = 0;
    dx = abs(targetplayer.x - x);
    
    if (dx > 16)
        move = sign(targetplayer.x - x);
    
    hsp = move * movespeed;
    
    if (move != 0)
    {
        if (movespeed < normal_spd)
            movespeed += 0.1;
    }
    else if (movespeed > 0)
    {
        movespeed -= 0.1;
    }
    else
    {
        movespeed = 0;
    }
    
    if (hsp != 0)
        image_xscale = sign(hsp);
    
    if (grounded)
    {
        state = UnknownEnum.Value_0;
        jetpackcancel = 0;
        
        if (jumpcount > 0)
        {
            jumpcount--;
            movespeed = 10;
            state = 173;
            scr_soundeffect(40);
            scr_soundeffect(127);
            vsp = -15;
            sprite_index = spr_playerN_noisebombspinjump;
            image_index = 0;
            particle_set_scale(UnknownEnum.Value_5, image_xscale, 1);
            create_particle(x, y, UnknownEnum.Value_5, 0);
        }
    }
}
