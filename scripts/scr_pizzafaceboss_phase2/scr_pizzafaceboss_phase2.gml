function boss_pizzaface_phase2transition()
{
    var tx, ty;
    
    switch (transitionstate)
    {
        case 0:
            hsp = 0;
            vsp = 0;
            tx = room_width / 2;
            ty = room_height / 2;
            x = Approach(x, tx, 8);
            y = Approach(y, ty, 8);
            
            if (x == tx && y == ty)
            {
                transitionstate++;
                transitionbuffer = 120;
            }
            
            break;
        
        case 1:
            phase = 1;
            sprite_index = spr_pizzahead_transition1;
            hsp = 0;
            vsp = 0;
            
            if (transitionbuffer > 0)
            {
                transitionbuffer--;
            }
            else
            {
                transitionstate++;
                hsp = 0;
                vsp = -11;
            }
            
            break;
        
        case 2:
            sprite_index = spr_pizzahead_transition2;
            
            if (grounded)
                state = UnknownEnum.Value_0;
            
            break;
    }
}

function boss_pizzahead_phase2normal()
{
    sprite_index = spr_pizzahead_giddy;
    hsp = image_xscale * 9;
    
    if (place_meeting(x + (sign(hsp) * 82), y, obj_solid))
    {
        state = 228;
        fish = 1;
        lookbuffer = 80;
        saveddir = -image_xscale;
    }
    
    if (hp < (max_hp / 3))
    {
        phase = 2;
        attackbuffer = 40;
    }
}

function boss_pizzahead_look()
{
    hsp = 0;
    sprite_index = spr_pizzahead_look;
    
    if (lookbuffer > 0)
    {
        lookbuffer--;
    }
    else if (!fish)
    {
        image_xscale *= -1;
        state = UnknownEnum.Value_0;
    }
    else
    {
        fishingbuffer = 60;
        state = 229;
    }
}

function boss_pizzahead_fishing()
{
    var ty, xs, tx;
    
    sprite_index = spr_pizzahead_fishing;
    
    if (fishingbuffer > 0)
    {
        fishingbuffer--;
    }
    else
    {
        state = choose(235, 236, 238, 237, 231, 232, 233, 234);
        
        switch (state)
        {
            case 231:
                sprite_index = spr_pizzahead_bombrun;
                bombtimer = 200;
                hasbomb = 1;
                break;
            
            case 232:
                shot = 0;
                image_xscale *= -1;
                break;
            
            case 233:
                shot = 0;
                portraitthrow = 50;
                image_xscale *= -1;
                break;
            
            case 235:
                substate = UnknownEnum.Value_0;
                picturebuffer = 70;
                break;
            
            case 237:
                substate = UnknownEnum.Value_0;
                eatbuffer = 150;
                eatID = instance_create(x, y, obj_pizzahead_eathitbox);
                
                with (eatID)
                    baddieID = other.id;
                
                break;
            
            case 236:
                substate = UnknownEnum.Value_0;
                pullbuffer = 60;
                
                with (obj_camera)
                {
                    shake_mag = 5;
                    shake_mag_acc = 2 / room_speed;
                }
                
                break;
            
            case 238:
                sprite_index = spr_pizzahead_surprisebox;
                image_index = 0;
                shot = 0;
                break;
            
            case 234:
                ty = 402;
                
                if (x > (room_width / 2))
                {
                    xs = 1;
                    tx = 124;
                }
                else
                {
                    xs = -1;
                    tx = room_width - 124;
                }
                
                with (obj_player)
                {
                    if (check_player_coop())
                    {
                        x = tx;
                        y = ty;
                        xscale = xs;
                        state = UnknownEnum.Value_47;
                        sprite_index = spr_knightpepidle;
                        create_particle(x, y, UnknownEnum.Value_1);
                    }
                }
                
                with (instance_create(x, y, obj_enguardehitbox))
                    baddieID = other.id;
                
                image_xscale *= -1;
                enguard_buffer = 300;
                movespeed = 4;
                momentum = 0;
                break;
        }
    }
}

function boss_pizzahead_bombrun()
{
    var spd;
    
    spd = 8;
    
    if (hasbomb)
    {
        hsp = -sign(x - targetplayer.x) * spd;
        
        if (hsp != 0)
            image_xscale = sign(hsp);
        
        if (bombtimer > 0)
        {
            bombtimer--;
        }
        else
        {
            state = UnknownEnum.Value_0;
            instance_create(x, y, obj_pizzaheadbomb_explosion);
        }
        
        sprite_index = spr_pizzahead_bombrun;
        
        if (bombtimer > 0)
        {
            with (instance_place(x, y, obj_player))
            {
                other.hasbomb = 0;
                state = UnknownEnum.Value_52;
                bombgrabID = instance_create(x, y, obj_pizzaheadbomb);
                bombgrabID.cooldown = floor(other.bombtimer * 0.5);
                bombgrabID.defused = 1;
                bombgrabID.state = UnknownEnum.Value_4;
                bombgrabID.playerid = id;
            }
        }
    }
    else
    {
        with (obj_pizzaheadbomb)
        {
            if (state != UnknownEnum.Value_4 && grounded)
                other.bombgrabID = id;
        }
        
        if (!instance_exists(bombgrabID))
            hsp = sign(x - targetplayer.x) * spd;
        else
            hsp = sign(bombgrabID.x - x) * spd;
        
        if (!instance_exists(obj_pizzaheadbomb))
            state = UnknownEnum.Value_0;
        
        with (instance_place(x, y, obj_pizzaheadbomb))
        {
            if (state != UnknownEnum.Value_4 && grounded)
            {
                destroy = 0;
                instance_destroy();
                other.hasbomb = 1;
                other.bombtimer = floor(cooldown * 2);
            }
        }
        
        if (hsp != 0)
            image_xscale = sign(hsp);
        
        sprite_index = spr_pizzahead_bombrunaway;
    }
    
    if (state == UnknownEnum.Value_0)
        image_xscale = saveddir;
}

function boss_pizzahead_npcthrow()
{
    sprite_index = spr_pizzahead_throw;
    
    if (!shot)
    {
        with (instance_create(x, y + 48, obj_pizzaheadnpc))
            image_xscale = other.image_xscale;
        
        shot = 1;
        npcbuffer = 50;
    }
    else if (npcbuffer > 0)
    {
        npcbuffer--;
    }
    else
    {
        state = UnknownEnum.Value_0;
    }
}

function boss_pizzahead_portraitthrow()
{
    if (portraitthrow > 0)
    {
        portraitthrow--;
        sprite_index = spr_pizzahead_portraitthrow;
    }
    else
    {
        sprite_index = spr_pizzahead_throw;
        
        if (!shot)
        {
            with (instance_create(x, y, obj_pizzaheadportrait))
            {
                image_xscale = other.image_xscale;
                vsp = -11;
            }
            
            shot = 1;
            npcbuffer = 50;
        }
        else if (npcbuffer > 0)
        {
            npcbuffer--;
        }
        else
        {
            state = UnknownEnum.Value_0;
        }
    }
}

function boss_pizzahead_enguarde()
{
    sprite_index = spr_pizzahead_enguarde;
    
    if (x != targetplayer.x && !(image_xscale == -sign(x - targetplayer.x)))
    {
        image_xscale = -sign(x - targetplayer.x);
        momentum = -image_xscale * movespeed;
    }
    
    hsp = (image_xscale * movespeed) + momentum;
    vsp = 0;
    momentum = Approach(momentum, 0, 0.05);
    
    if (enguard_buffer > 0)
    {
        enguard_buffer--;
    }
    else
    {
        state = UnknownEnum.Value_0;
        
        with (obj_player)
        {
            if (check_player_coop())
                state = UnknownEnum.Value_0;
        }
        
        instance_destroy(obj_enguardehitbox);
    }
}

function boss_pizzahead_sexypicture()
{
    if (picturebuffer > 0)
    {
        picturebuffer--;
    }
    else if (substate == UnknownEnum.Value_0)
    {
        substate++;
        picturebuffer = 50;
    }
    else
    {
        state = UnknownEnum.Value_0;
        image_xscale *= -1;
    }
    
    if (substate == UnknownEnum.Value_0)
        sprite_index = spr_pizzahead_sexypicture1;
    else
        sprite_index = spr_pizzahead_sexypicture2;
}

function boss_pizzahead_pullinglevel()
{
    var e, tx;
    
    if (substate == UnknownEnum.Value_0)
    {
        sprite_index = spr_pizzahead_pullinglevel1;
        
        if (pullbuffer > 0)
        {
            pullbuffer--;
        }
        else
        {
            pullbuffer = 200;
            spawnbuffer = 0;
            substate = UnknownEnum.Value_1;
        }
    }
    else
    {
        sprite_index = spr_pizzahead_pullinglevel2;
        
        if (spawnbuffer > 0)
        {
            spawnbuffer--;
        }
        else
        {
            spawnbuffer = 40;
            e = spawnpool[irandom_range(1, array_length(spawnpool)) - 1];
            tx = irandom_range(52, room_width - 52);
            
            with (instance_create(tx, -20, e))
            {
                state = UnknownEnum.Value_138;
                stunned = 50;
            }
        }
        
        if (pullbuffer > 0)
        {
            pullbuffer--;
        }
        else
        {
            image_xscale *= -1;
            state = UnknownEnum.Value_0;
        }
    }
}

function boss_pizzahead_eat()
{
    var b;
    
    b = instance_exists(eatID);
    
    if (substate == UnknownEnum.Value_0)
    {
        if (!b)
        {
            state = UnknownEnum.Value_0;
            image_xscale *= -1;
        }
        
        sprite_index = spr_pizzahead_eat1;
        
        if (eatbuffer > 0)
        {
            eatbuffer--;
        }
        else
        {
            if (b)
                hp += 200;
            
            substate = UnknownEnum.Value_1;
            eatbuffer = 60;
        }
    }
    else
    {
        sprite_index = spr_pizzahead_eat2;
        
        if (eatbuffer > 0)
        {
            eatbuffer--;
        }
        else
        {
            instance_destroy(eatID);
            state = UnknownEnum.Value_0;
            image_xscale *= -1;
        }
    }
}

function boss_pizzahead_surprisebox()
{
    if (floor(image_index) == 7 && !shot)
    {
        shot = 1;
        
        with (instance_create(x - (300 * image_xscale), y + 72, obj_surprisebox_boss))
            image_xscale = other.image_xscale;
    }
    
    if (floor(image_index) > 11 && shot)
    {
        shot = 0;
        instance_destroy(obj_surprisebox_boss);
    }
    
    if (floor(image_index) == (image_number - 1))
    {
        state = UnknownEnum.Value_0;
        image_xscale *= -1;
    }
}
