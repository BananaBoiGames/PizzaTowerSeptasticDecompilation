if (!instance_exists(baddieid))
    refresh--;

if (refresh <= 0)
{
    image_speed = 0.35;
    
    if (floor(image_index) == 5)
    {
        with (instance_create(x, y - 20, content))
        {
            if (other.platformid != -4)
                platformid = other.platformid;
            
            image_xscale = other.image_xscale;
            state = UnknownEnum.Value_138;
            stunned = 50;
            vsp = -5;
            other.baddieid = id;
            important = 1;
        }
        
        refresh = 100;
    }
}

scr_collide();
