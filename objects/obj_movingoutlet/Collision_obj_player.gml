with (obj_player)
{
    if ((state == UnknownEnum.Value_47 || state == UnknownEnum.Value_48 || state == UnknownEnum.Value_38) && cutscene == 0)
    {
        with (instance_create(x, y, obj_knightdebris))
            image_index = 0;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 1;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 2;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 3;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 4;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 5;
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
        else
            obj_player.hsp = 5;
        
        vsp = -3;
        image_index = 0;
        obj_player.image_index = 0;
        obj_player.flash = 1;
        state = UnknownEnum.Value_106;
    }
    else if (state == UnknownEnum.Value_51 && hurted == 0)
    {
        instance_create(x, y, obj_bombexplosion);
    }
    else if (state == UnknownEnum.Value_33)
    {
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 0;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 1;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 2;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 3;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 4;
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
        else
            obj_player.hsp = 5;
        
        vsp = -3;
        image_index = 0;
        obj_player.image_index = 0;
        obj_player.flash = 1;
        state = UnknownEnum.Value_106;
    }
    else if (state == UnknownEnum.Value_24 || state == UnknownEnum.Value_25)
    {
        obj_player.grav = 0.5;
        
        repeat (8)
        {
            with (create_debris(x, y, 1283))
            {
                vsp = random_range(-5, 0);
                hsp = random_range(-3, 3);
            }
        }
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
        else
            obj_player.hsp = 5;
        
        vsp = -3;
        image_index = 0;
        obj_player.image_index = 0;
        obj_player.flash = 1;
        state = UnknownEnum.Value_106;
    }
    else if (state != UnknownEnum.Value_107 && hurted == 0 && cutscene == 0 && state != UnknownEnum.Value_106)
    {
        global.hurtcounter += 1;
        alarm[8] = 60;
        alarm[7] = 120;
        hurted = 1;
        
        if (xscale == other.image_xscale)
            sprite_index = spr_hurtjump;
        else
            sprite_index = spr_hurt;
        
        movespeed = 8;
        vsp = -5;
        
        if (global.collect > 100)
            global.collect -= 100;
        else
            global.collect = 0;
        
        if (global.collect != 0)
        {
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
        }
        
        instance_create(x, y, obj_spikehurteffect);
        state = UnknownEnum.Value_107;
        image_index = 0;
        flash = 1;
    }
}
