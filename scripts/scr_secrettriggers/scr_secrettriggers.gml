function secret_add(argument0, argument1)
{
    with (obj_secretmanager)
    {
        ds_list_add(secrettriggers, [argument1]);
        
        if (argument0 != -4)
            method(id, argument0)();
    }
}

function secret_add_touchall(argument0, argument1, argument2)
{
    with (obj_secretmanager)
        ds_list_add(touchall, [argument0, argument1, argument2]);
}

function secret_add_touchall_requirement(argument0, argument1)
{
    touchrequirement[argument0] = [argument1, 0];
}

function secret_check_touchall()
{
    var xx, t, i, b;
    
    if (touchrequirement != -4 && is_array(touchrequirement))
    {
        for (xx = 0; xx < array_length(touchrequirement); xx++)
        {
            t = 0;
            
            for (i = 0; i < ds_list_size(touchall); i++)
            {
                b = ds_list_find_value(touchall, i);
                
                if (b[1] == xx)
                    t++;
            }
            
            if (t == touchrequirement[xx][0])
                touchrequirement[xx][1] = 1;
        }
        
        b = 1;
        i = 0;
        
        while (i < array_length(touchrequirement))
        {
            if (!touchrequirement[i][1])
            {
                b = 0;
                break;
            }
            else
            {
                i++;
                continue;
            }
        }
        
        if (b)
            return 1;
    }
    
    return 0;
}

function secret_check_trigger(argument0)
{
    with (obj_secrettrigger)
    {
        if (trigger == argument0 && !active)
            return 0;
    }
    
    return 1;
}

function secret_open_portal(argument0)
{
    with (obj_secretportal)
    {
        if (trigger == argument0 && ds_list_find_index(global.saveroom, id) == -1 && !place_meeting(x, y, obj_marbleblock) && !place_meeting(x, y, obj_secretblock) && !place_meeting(x, y, obj_secretbigblock) && !place_meeting(x, y, obj_secretmetalblock) && !place_meeting(x, y, obj_secretdestroyable))
            active = 1;
    }
}

function secret_close_portal(argument0, argument1 = 0)
{
    exit;
    
    with (obj_secretportal)
    {
        if (trigger == argument0 && sprite_index != spr_pizzaportalend && sprite_index != spr_pizzaportal_disappear)
        {
            sprite_index = spr_pizzaportal_disappear;
            
            if (!argument1)
                image_index = 0;
            else
                image_index = 7;
            
            active = 0;
        }
    }
}

function secret_close_portalID(argument0)
{
    exit;
    
    with (argument0)
    {
        sprite_index = spr_pizzaportal_disappear;
        image_index = 7;
        active = 0;
    }
}
