var _actor;

_actor = 0;

with (obj_player)
{
    if (state == UnknownEnum.Value_146)
        _actor = 1;
}

if (_actor)
    exit;

if (global.horse)
    exit;

if (!place_meeting(x, y, obj_doorblocked))
{
    with (other)
    {
        if (key_up && other.sprite_index == spr_doorkeyopen && grounded && (state == UnknownEnum.Value_0 || state == UnknownEnum.Value_103 || state == UnknownEnum.Value_104 || state == UnknownEnum.Value_58 || state == UnknownEnum.Value_121 || state == UnknownEnum.Value_99) && ((character != "M" && y == (other.y + 50)) || (character == "M" && y == (other.y + 55))) && !instance_exists(obj_noisesatellite) && !instance_exists(obj_fadeout) && state != UnknownEnum.Value_112 && state != UnknownEnum.Value_95)
        {
            obj_player1.lastroom = room;
            obj_player2.lastroom = room;
            scr_soundeffect(103);
            obj_camera.chargecamera = 0;
            ds_list_add(global.saveroom, id);
            
            if (object_index == obj_player1)
                obj_player1.sprite_index = obj_player1.spr_lookdoor;
            
            if (object_index == obj_player2)
                obj_player2.sprite_index = obj_player2.spr_lookdoor;
            
            obj_player1.targetDoor = other.targetDoor;
            obj_player1.targetRoom = other.targetRoom;
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            obj_player.image_index = 0;
            obj_player.state = UnknownEnum.Value_112;
            obj_player.mach2 = 0;
            
            if (instance_exists(obj_player2) && global.coop == 1)
            {
                if (object_index == obj_player2)
                {
                    obj_player1.x = obj_player2.x;
                    obj_player1.y = obj_player2.y;
                }
                
                if (object_index == obj_player1)
                {
                    obj_player2.x = obj_player1.x;
                    obj_player2.y = obj_player1.y;
                }
            }
            
            other.visited = 1;
            instance_create(x, y, obj_fadeout);
        }
    }
}
