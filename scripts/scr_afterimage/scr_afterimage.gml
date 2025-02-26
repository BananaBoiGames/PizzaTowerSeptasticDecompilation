function create_afterimage(argument0, argument1, argument2, argument3)
{
    var q;
    
    q = 
    {
        x: argument0,
        y: argument1,
        sprite_index: argument2,
        image_index: argument3,
        alarm: [15, 3, -1],
        image_blend: choose(global.afterimage_color1, global.afterimage_color2),
        image_xscale: 1,
        identifier: UnknownEnum.Value_0,
        visible: true,
        alpha: 1
    };
    ds_list_add(global.afterimage_list, q);
    return q;
}

function create_mach3effect(argument0, argument1, argument2, argument3, argument4 = false)
{
    var q;
    
    q = 
    {
        x: argument0,
        y: argument1,
        sprite_index: argument2,
        image_index: argument3,
        alarm: [15, 6, -1],
        image_blend: choose(global.mach_color1, global.mach_color2),
        image_xscale: 1,
        visible: true,
        identifier: UnknownEnum.Value_1,
        playerid: 245,
        alpha: 1
    };
    
    if (argument4)
        q.identifier = UnknownEnum.Value_0;
    
    ds_list_add(global.afterimage_list, q);
    return q;
}

function create_heatattack_afterimage(argument0, argument1, argument2, argument3, argument4)
{
    var _velocity;
    
    _velocity = 6;
    
    with (create_afterimage(argument0, argument1, argument2, argument3))
    {
        identifier = UnknownEnum.Value_2;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = argument4;
        hsp = _velocity;
        vsp = 0;
    }
    
    with (create_afterimage(argument0, argument1, argument2, argument3))
    {
        identifier = UnknownEnum.Value_2;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = argument4;
        hsp = -_velocity;
        vsp = 0;
    }
    
    with (create_afterimage(argument0, argument1, argument2, argument3))
    {
        identifier = UnknownEnum.Value_2;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = argument4;
        hsp = 0;
        vsp = _velocity;
    }
    
    with (create_afterimage(argument0, argument1, argument2, argument3))
    {
        identifier = UnknownEnum.Value_2;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = argument4;
        hsp = 0;
        vsp = -_velocity;
    }
}

function create_firemouth_afterimage(argument0, argument1, argument2, argument3, argument4)
{
    with (create_afterimage(argument0, argument1, argument2, argument3))
    {
        identifier = UnknownEnum.Value_3;
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_xscale = argument4;
        image_blend = make_color_rgb(248, 112, 24);
        alpha = 1.25;
    }
}

function create_noise_afterimage(argument0, argument1, argument2, argument3, argument4)
{
    var b;
    
    b = create_afterimage(argument0, argument1, argument2, argument3);
    
    with (b)
    {
        fadeout = false;
        fadeoutstate = -4;
        identifier = UnknownEnum.Value_8;
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_xscale = argument4;
        image_blend = c_white;
        alpha = 0.9;
        basealpha = 1;
        playerid = -4;
        vertical = false;
        maxmovespeed = 10;
    }
    
    return b;
}

function create_blur_afterimage(argument0, argument1, argument2, argument3, argument4)
{
    var b;
    
    b = create_afterimage(argument0, argument1, argument2, argument3);
    
    with (b)
    {
        identifier = UnknownEnum.Value_4;
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_blend = c_white;
        image_xscale = argument4;
        alpha = 0.8;
        playerid = -4;
    }
    
    return b;
}
