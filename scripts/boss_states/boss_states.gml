function state_boss_chainsaw()
{
    hsp = 0;
    vsp = 0;
    image_speed = 0;
    x = hitX + irandom_range(-4, 4);
    y = hitY + irandom_range(-4, 4);
    hitLag--;
    
    if (hitLag <= 0)
    {
        image_speed = 0.35;
        x = hitX;
        y = hitY;
        state = hitstate;
        hsp = hithsp;
        vsp = hitvsp;
    }
}

//function state_boss_walk(argument0)
function state_boss_walk(cooldown_end_script)
{
    var b;
    
    image_speed = 0.35;
    sprite_index = fallspr;
    
    if (grounded)
    {
        if (object_index != obj_mrstickboss)
        {
            b = ds_map_find_value(player_hurtstates, targetplayer.state);
            
            if (!is_undefined(b))
                boss_decide_taunt(130);
        }
        
        if (state != UnknownEnum.Value_84)
        {
            if (attack_cooldown <= 0)
            {
                //argument0();
				cooldown_end_script();
                
                if (object_index != obj_mrstickboss)
                    image_xscale = (targetplayer.x != x) ? sign(targetplayer.x - x) : targetxscale;
            }
            else
            {
                state = UnknownEnum.Value_0;
            }
        }
    }
}

function state_boss_bump()
{
    movespeed = 0;
    sprite_index = bumpspr;
    image_speed = 0.35;
    
    if (grounded && vsp > 0)
        hsp = 0;
    
    if (floor(image_index) == (image_number - 1))
        state = UnknownEnum.Value_0;
}

function state_boss_arenaround()
{
    var is_playerside;
    
    image_speed = 0.35;
    is_playerside = (targetplayer.x > (room_width / 2)) ? (x > (room_width / 5)) : (x < (room_width - (room_width / 5)));
    
    if (is_playerside)
    {
        hsp = (targetplayer.x > (room_width / 2)) ? -normal_spd : normal_spd;
    }
    else if (!is_playerside && hsp != 0)
    {
        image_xscale = -sign(hsp);
        hsp = 0;
    }
    
    if (hsp != 0 && grounded)
    {
        sprite_index = walkspr;
        image_xscale = sign(hsp);
    }
    else if (grounded)
    {
        sprite_index = idlespr;
    }
    else
    {
        sprite_index = fallspr;
    }
}

function boss_decide_taunt(argument0)
{
    var b;
    
    b = distance_to_pos(x, y, targetplayer.x, targetplayer.y, argument0, argument0);
    
    if (b && chooseparry_buffer <= 0)
    {
        taunt_storedhsp = hsp;
        taunt_storedstate = state;
        state = UnknownEnum.Value_84;
        taunt_buffer = taunt_max;
        chooseparry_buffer = chooseparry_max[phase - 1] + irandom(chooseparry_random * room_speed);
        sprite_index = tauntspr;
        image_index = irandom(image_number - 1);
        scr_soundeffect(112);
        
        with (instance_create(x, y, obj_baddietaunteffect))
        {
            if (other.object_index == obj_pepperman)
                y -= 5;
            
            image_xscale = other.image_xscale;
        }
    }
}

function state_boss_taunt()
{
    var playerinst, s;
    
    image_speed = 0;
    hsp = 0;
    vsp = 0;
    
    if (taunt_buffer > 0 && state == UnknownEnum.Value_84)
    {
        taunt_buffer--;
        
        if (place_meeting(x, y, obj_player))
        {
            playerinst = instance_place(x, y, obj_player);
            s = ds_map_find_value(player_hurtstates, playerinst.state);
            
            if (!is_undefined(s))
            {
                attack_cooldown = floor(attack_max[phase - 1] / 2);
                image_xscale = -playerinst.xscale;
                sprite_index = parryspr;
                image_index = 0;
                scr_soundeffect(129);
                taunt_buffer = 10;
                player_hurt(30, playerinst);
            }
        }
        
        if (place_meeting(x, y, obj_lungehitbox))
        {
            playerinst = instance_place(x, y, obj_lungehitbox);
            
            if (instance_exists(playerinst))
            {
                playerinst = playerinst.playerid;
                attack_cooldown = floor(attack_max[phase - 1] / 2);
                image_xscale = -playerinst.xscale;
                sprite_index = parryspr;
                image_index = 0;
                scr_soundeffect(129);
                taunt_buffer = 10;
                player_hurt(30, playerinst);
            }
        }
    }
    else
    {
        image_speed = 0.35;
        state = taunt_storedstate;
        hsp = taunt_storedhsp;
    }
}

function state_boss_parry()
{
    image_speed = 0.35;
    hsp = movespeed * -image_xscale;
    
    if (image_index > (image_number - 1))
    {
        state = taunt_storedstate;
        hsp = taunt_storedhsp;
    }
    
    if (movespeed > 0)
        movespeed -= 0.5;
    else
        movespeed = 0;
}

function state_player_arenaround()
{
    var _normal_spd, is_bossside;
    
    _normal_spd = 6;
    is_bossside = (x < (room_width / 2)) ? (x > (room_width / 5)) : (x < (room_width - (room_width / 5)));
    
    if (is_bossside)
    {
        hsp = (x < (room_width / 2)) ? -_normal_spd : _normal_spd;
    }
    else if (!is_bossside && hsp != 0)
    {
        xscale = -sign(hsp);
        hsp = 0;
    }
    
    if (hsp != 0 && grounded)
    {
        image_speed = 0.6;
        sprite_index = spr_move;
        xscale = sign(hsp);
    }
    else
    {
        image_speed = 0.35;
        
        if (grounded)
            sprite_index = spr_idle;
        else
            sprite_index = spr_fall;
    }
}
