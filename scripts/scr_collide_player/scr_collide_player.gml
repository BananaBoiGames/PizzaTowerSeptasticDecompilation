function scr_collide_player()
{
    var vsp_final, target_y, bbox_size_y, t, sv, hsp_final, target_x, bbox_size_x, sh, down, k;
    
    grounded = false;
    grinding = false;
    collision_flags = 0;
    vsp_final = vsp + vsp_carry;
    vsp_carry = 0;
    target_y = round(y + vsp_final);
    bbox_size_y = bbox_bottom - bbox_top;
    t = abs(target_y - y) / bbox_size_y;
    sv = sign(vsp_final);
    
    if (!scr_solid_player(x, y + (bbox_size_y * sv)))
    {
        y += (bbox_size_y * sv);
        
        if ((vsp_final > 0 && y >= target_y) || (vsp_final < 0 && y <= target_y))
            y = target_y;
    }
    
    repeat (abs(target_y - y))
    {
        if (!scr_solid_player(x, y + sv))
        {
            y += sv;
        }
        else
        {
            vsp = 0;
            break;
        }
    }
    
    hsp_final = hsp + hsp_carry;
    hsp_carry = 0;
    target_x = round(x + hsp_final);
    bbox_size_x = bbox_right - bbox_left;
    t = abs(target_x - x) / bbox_size_x;
    sh = sign(hsp_final);
    down = scr_solid_player(x, y + 1);
    
    repeat (abs(target_x - x))
    {
        if (!scr_solid_player(x + (bbox_size_x * sh), y) && down == scr_solid_player(x + (bbox_size_x * sh), y + 1) && !place_meeting(x + (bbox_size_x * sh), y, obj_slope) && !place_meeting(x, y, obj_slope) && !place_meeting(x + (bbox_size_x * sh), y + 1, obj_slope))
        {
            x += (bbox_size_x * sh);
            
            if ((hsp_final > 0 && x >= target_x) || (hsp_final < 0 && x <= target_x))
                x = target_x;
        }
        
        repeat (abs(target_x - x))
        {
            for (k = 1; k <= 4; k++)
            {
                if (scr_solid_player(x + sh, y) && !scr_solid_player(x + sh, y - k))
                    y -= k;
                
                if (state != UnknownEnum.Value_16 && state != UnknownEnum.Value_184)
                {
                    if (!scr_solid_player(x + sh, y) && !scr_solid_player(x + sh, y + 1) && scr_solid_player(x + sh, y + (k + 1)))
                        y += k;
                }
            }
            
            if (!scr_solid_player(x + sh, y))
            {
                x += sh;
            }
            else
            {
                hsp = 0;
                break;
            }
        }
    }
    
    if (vsp < 20)
        vsp += grav;
    
    if (platformid != -4)
    {
        if (vsp < -1 || !instance_exists(platformid) || (!place_meeting(x, y + 16, platformid) || !place_meeting(x, y + 32, platformid)))
        {
            platformid = -4;
            y = floor(y);
        }
        else
        {
            grounded = true;
            vsp = grav;
            
            if (platformid.vsp > 0)
                vsp_carry = platformid.vsp;
            
            y = platformid.y - 46;
            
            if (!place_meeting(x, y + 1, platformid))
                y++;
            
            if (platformid.v_velocity != 0)
            {
                if (scr_solid(x, y))
                {
                    for (i = 0; scr_solid(x, y); i++)
                    {
                        y--;
                        
                        if (i > 32)
                            break;
                    }
                }
                
                if (scr_solid(x, y))
                {
                    for (i = 0; scr_solid(x, y); i++)
                    {
                        y++;
                        
                        if (i > 64)
                            break;
                    }
                }
            }
        }
    }
    
    grounded |= scr_solid_player(x, y + 1);
    grounded |= (vsp > 0 && !place_meeting(x, y, obj_platform) && place_meeting(x, y + 1, obj_platform));
    grinding = !place_meeting(x, y, obj_grindrail) && place_meeting(x, y + 1, obj_grindrail);
    grounded |= grinding;
    
    if (platformid != -4 || (place_meeting(x, y + 1, obj_movingPlatform) && !place_meeting(x, y - 3, obj_movingPlatform)) || place_meeting(x, y + 8, 216 && !place_meeting(x, y + 6, obj_movingPlatform)))
        grounded = true;
    
    if (grounded && platformid == -4)
        y = floor(y);
}
