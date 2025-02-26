var choseattack, j;

if (phase == 0 && attacking)
{
    if (state == 226)
    {
        if (other.state == UnknownEnum.Value_84 && other.parry_inst != -4)
        {
            state = UnknownEnum.Value_0;
            boss_hurt(10, other.id);
            stunned = 50;
            
            with (other)
            {
                state = UnknownEnum.Value_147;
                sprite_index = choose(spr_parry1, spr_parry2, spr_parry3);
                image_index = 0;
                image_speed = 0.35;
                taunttimer = 20;
                movespeed = 8;
                parry_inst = -4;
                parry_count = parry_max;
                
                with (instance_create(x, y, obj_parryeffect))
                    image_xscale = other.xscale;
                
                flash = 1;
            }
            
            parrycount++;
            
            if (parrycount > 1)
            {
                parrycount = 0;
                
                if (lostattacks > 0)
                {
                    lostattacks--;
                    choseattack = -4;
                    j = 0;
                    
                    while (choseattack == -4)
                    {
                        j = irandom_range(1, array_length(phase1attacks)) - 1;
                        choseattack = phase1attacks[j];
                    }
                    
                    phase1attacks[j] = -4;
                    
                    with (instance_create(x, y, obj_pizzafacepart))
                    {
                        vsp = -11;
                        hsp = choose(-5, 5);
                        
                        switch (choseattack)
                        {
                            case 223:
                                sprite_index = spr_pizzafaceword;
                                break;
                            
                            case 224:
                                sprite_index = spr_sausageman_idle;
                                break;
                            
                            case 225:
                                sprite_index = spr_shroomcollect;
                                break;
                        }
                    }
                }
            }
        }
        else
        {
            state = UnknownEnum.Value_0;
            player_hurt(20, other.id);
        }
    }
    else
    {
        state = UnknownEnum.Value_0;
        player_hurt(20, other.id);
    }
}
else if (phase > 0)
{
    event_inherited();
}
