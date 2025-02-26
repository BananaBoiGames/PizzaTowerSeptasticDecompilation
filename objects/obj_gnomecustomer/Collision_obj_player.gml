var xx, yy, player, door, _xscale, door_xscale;

if (other.state == UnknownEnum.Value_186)
    exit;

if (global.pizzadelivery && ds_list_find_index(global.saveroom, id) == -1)
{
    other.vsp = 10;
    xx = x + (customer_x * image_xscale);
    yy = y + (customer_y * image_yscale);
    player = other.id;
    door = id;
    global.heattime = 60;
    xscale = sign(image_xscale);
    
    if (!instance_exists(obj_cutscene_handler))
    {
        _xscale = player.xscale;
        
        if (player.x != x)
            _xscale = sign(x - player.x);
        
        with (instance_create(0, 0, obj_cutscene_handler))
        {
            door_xscale = -sign(door.image_xscale * 16);
            depth = other.depth - 1;
            scene_info = [[cutscene_customer_check, door.gnome_id, player, door], [cutscene_customer_start, player], [cutscene_customer_create, xx, yy, other.spr_idle, other.spr_happy, -door_xscale], [cutscene_customer_end, player]];
        }
    }
}
