var i, b, _doorfinish;

switch (state)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_144:
        with (obj_player)
            state = UnknownEnum.Value_46;
        
        if (cutscene_count > 0)
        {
            cutscene_count--;
        }
        else
        {
            with (obj_player)
            {
                state = UnknownEnum.Value_0;
                image_index = 0;
            }
            
            state = 145;
            round_count = 10;
        }
        
        break;
    
    case 145:
        if (round_count > 0)
            round_count--;
        else
            state = 142;
        
        break;
    
    case 142:
        if (!ds_list_empty(baddielist))
        {
            for (i = 0; i < ds_list_size(baddielist); i++)
            {
                b = ds_list_find_value(baddielist, i);
                
                if (b[0] == wave)
                {
                    instance_activate_object(b[1]);
                    
                    if (instance_exists(b[1]))
                    {
                        with (instance_create(b[1].x, b[1].y, obj_arena_pizzaportal))
                        {
                            stored_id = b[1];
                            alarm[0] = other.round_max;
                        }
                        
                        instance_deactivate_object(b[1]);
                    }
                }
                else
                {
                    instance_deactivate_object(b[1]);
                }
            }
        }
        
        wave_minutes = minutes;
        wave_seconds = seconds;
        round_count = round_max;
        state = 143;
        
        with (obj_arenadoor)
        {
            wave = other.wave;
            alarm[0] = 10;
            finish = 0;
            
            if (objectlist[wave] == -4)
            {
                alarm[0] = -1;
                finish = 1;
            }
        }
        
        break;
    
    case 143:
        _doorfinish = 1;
        
        with (obj_arenadoor)
        {
            if (!finish)
                _doorfinish = 0;
        }
        
        if (!instance_exists(obj_baddie) && !instance_exists(obj_arena_pizzaportal) && (!instance_exists(obj_arenadoor) || _doorfinish))
        {
            wave++;
            
            if (wave > maxwave)
            {
                instance_destroy();
                instance_destroy(block_inst);
                
                with (obj_arenagate)
                {
                    image_index = 0;
                    sprite_index = spr_arenagate_open;
                    instance_destroy(block_inst);
                }
                
                cutscene_count = outro_max;
                
                with (obj_player)
                {
                    with (obj_music)
                        arena = 0;
                }
            }
            else
            {
                state = 142;
                round_count = round_max;
            }
        }
        
        break;
    
    case UnknownEnum.Value_8:
        if (floor(image_index) == (image_number - 1))
            state = UnknownEnum.Value_98;
        
        break;
    
    case UnknownEnum.Value_98:
        instance_destroy();
        break;
    
    default:
}

if (state != UnknownEnum.Value_0 && state != UnknownEnum.Value_144)
    visible = false;
