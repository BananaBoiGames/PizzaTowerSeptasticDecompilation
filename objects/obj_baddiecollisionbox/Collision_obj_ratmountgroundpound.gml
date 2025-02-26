var lag;

if (instance_exists(baddieID) && baddieID.invtime == 0 && baddieID.state != UnknownEnum.Value_4 && !baddieID.invincible && baddieID.instantkillable)
{
    scr_soundeffect(74);
    
    if (!baddieID.important)
    {
        global.style += (5 + global.combo);
        global.combo += 1;
        global.combotime = 60;
        global.heattime = 60;
    }
    
    instance_destroy(baddieID);
    instance_destroy(other);
    lag = 10;
    baddieID.hitLag = lag;
    baddieID.hitX = baddieID.x;
    baddieID.hitY = baddieID.y;
    baddieID.hp -= 1;
    instance_create(baddieID.x, baddieID.y, obj_parryeffect);
    baddieID.alarm[3] = 3;
    baddieID.state = UnknownEnum.Value_137;
    baddieID.image_xscale = -other.image_xscale;
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    baddieID.hitvsp = -8;
    baddieID.hithsp = other.image_xscale * 15;
}
