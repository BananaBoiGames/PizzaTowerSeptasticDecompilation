var combototal;

if (room == rm_editor)
    exit;

trace("destroy");

if (ds_list_find_index(global.baddieroom, id) == -1 && important == 0)
{
    trace("destroy important");
    
    if (instance_exists(obj_hardmode))
        global.heatmeter_count++;
    
    combototal = 10 * (global.stylethreshold + 1);
    global.collect += combototal;
    global.comboscore += combototal;
    scr_soundeffect(51);
    
    repeat (3)
    {
        with (create_debris(x, y, 1288))
        {
            hsp = random_range(-5, 5);
            vsp = random_range(-10, 10);
        }
    }
    
    instance_create(x, y, obj_bangeffect);
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    with (instance_create(x, y, obj_sausageman_dead))
    {
        sprite_index = other.spr_dead;
        spr_palette = other.spr_palette;
        paletteselect = other.paletteselect;
    }
    
    if (object_index == obj_tank)
    {
        repeat (3)
        {
            with (instance_create(x, y, obj_sausageman_dead))
                sprite_index = other.spr_content_dead;
        }
    }
    
    ds_list_add(global.baddieroom, id);
}
else if (ds_list_find_index(global.baddieroom, id) == -1 && important == 1)
{
    trace("destroy unimportant");
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    scr_soundeffect(51);
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    ds_list_add(global.baddieroom, id);
    
    with (instance_create(x, y, obj_sausageman_dead))
    {
        sprite_index = other.spr_dead;
        spr_palette = other.spr_palette;
        paletteselect = other.paletteselect;
    }
}
