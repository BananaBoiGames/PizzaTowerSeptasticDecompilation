var p;

if (!attacking && !invincible && lungehurt)
{
    p = other.playerid;
    
    with (p)
    {
        if (state == UnknownEnum.Value_43 && ds_list_find_index(hitlist, other.id) == -1)
        {
            ds_list_add(hitlist, other.id);
            
            with (other)
            {
                boss_hurt(15, p);
                hithsp = ((other.x + ((other.movespeed + 0.5) * 70 * other.xscale)) - x) / 60;
                hitvsp = (other.y - 180 - y) / 60;
                hit_connected = 1;
            }
            
            hit_connected = 1;
            lunge_hits++;
            lunge_hit_buffer = 100;
            tauntstoredvsp = 0;
            tauntstoredmovespeed = 4;
        }
    }
}
