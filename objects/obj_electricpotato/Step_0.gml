var spd, _dir;

playerid = instance_nearest(x, y, obj_player);

if (move)
{
    spd = 1;
    
    if (distance_to_object(playerid) < 264)
        velocity = Approach(velocity, spd, 0.25);
    else
        velocity = Approach(velocity, 0, 0.25);
    
    _dir = point_direction(x, y, playerid.x, playerid.y);
    x += (lengthdir_x(1, _dir) * velocity);
    y += (lengthdir_y(1, _dir) * velocity);
}
