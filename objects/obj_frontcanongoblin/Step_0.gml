var thr, dir, xs;

thr = 20;

if (!(captain_x > (captain_xto - thr) && captain_x < (captain_xto + thr) && captain_y > (captain_yto - thr) && captain_y < (captain_yto + thr)))
{
    dir = point_direction(captain_x, captain_y, captain_xto, captain_yto);
    captain_x += lengthdir_x(5, dir);
    captain_y += lengthdir_y(5, dir);
}

switch (state)
{
    case UnknownEnum.Value_0:
        xs = saved_xs;
        
        if (alarm[0] < 0)
            alarm[0] = shoot_max + irandom(floor(shoot_max / 2));
        
        wave_x = Wave(0, wave_xlimit, 1.5, 32);
        crosshair_x = obj_player1.x + (xs * 124) + (wave_x * xs);
        crosshair_y = obj_player1.y;
        break;
    
    case UnknownEnum.Value_8:
        if (floor(captain_index) == (sprite_get_number(captain_sprite) - 1))
        {
            captain_sprite = spr_captainbomb;
            state = UnknownEnum.Value_0;
            
            with (instance_create(crosshair_x, camera_get_view_y(view_camera[0]) - 32, obj_frontcanonbomb))
                y_to = other.crosshair_y;
        }
        
        break;
    
    case UnknownEnum.Value_89:
        if (floor(captain_index) == (sprite_get_number(captain_sprite) - 1))
            instance_destroy();
        
        break;
}
