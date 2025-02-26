var b_hp, p_hp;

if (state == UnknownEnum.Value_8)
    exit;

if (state == UnknownEnum.Value_98)
    exit;

seconds--;

if (seconds == -1)
{
    if (minutes > 0)
    {
        seconds = 59;
        minutes--;
    }
    else
    {
        seconds = 0;
        minutes = 0;
    }
}

if (minutes == 0 && seconds == 0)
{
    instance_destroy(obj_baddiespawner);
    instance_destroy(obj_noisey);
    
    if (endroundfunc != -4)
        endroundfunc();
    
    if (round_count < round_max)
    {
        round_count++;
        minutes = maxminutes;
        seconds = maxseconds;
        state = 145;
        timer_buffer = timer_max;
        
        with (par_boss)
        {
            phase++;
            phase = clamp(phase, 0, max_phase);
            
            if (colliding && state != 180 && state != 181)
                state = 145;
        }
    }
    else if (instance_exists(bossID))
    {
        b_hp = (bossID.hp / bossID.max_hp) * 100;
        p_hp = (player_hp / player_hpmax) * 100;
        
        if (b_hp <= p_hp)
        {
            depth = obj_player1.depth + 1;
            state = UnknownEnum.Value_8;
            
            with (bossID)
            {
                with (lastplayerid)
                {
                    xscale = 1;
                    suplexmove = 1;
                    sfx_gain(suplexdashsnd);
                    state = UnknownEnum.Value_42;
                    movespeed = 10;
                    image_index = random_range(0, image_number - 1);
                    sprite_index = spr_player_groundedattack;
                }
                
                hp = 0;
                boss_destroy(lastplayerid);
            }
        }
        else
        {
            with (bossID)
            {
                sprite_index = defeatplayerspr;
                fakedeath = 0;
            }
            
            fakedeath = 0;
            player_hp = 0;
        }
    }
}

if (state != 145 && state != UnknownEnum.Value_98 && state != UnknownEnum.Value_8)
    alarm[0] = room_speed;
