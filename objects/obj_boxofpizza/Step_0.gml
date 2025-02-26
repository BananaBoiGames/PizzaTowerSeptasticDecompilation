var _box;

if (global.horse)
    exit;

with (obj_player)
{
    if (other.image_yscale == 1)
    {
        if (((key_down && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other) && (state == UnknownEnum.Value_100 || character == "S" || character == "M" || state == UnknownEnum.Value_65 || state == UnknownEnum.Value_5)) || ((state == UnknownEnum.Value_102 || state == UnknownEnum.Value_108 || state == UnknownEnum.Value_111 || state == UnknownEnum.Value_306) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other))) && !instance_exists(obj_fadeout) && state != UnknownEnum.Value_112 && state != UnknownEnum.Value_95)
        {
            obj_player1.lastroom = room;
            obj_player2.lastroom = room;
            other.depth = -10;
            scr_soundeffect(113);
            obj_player1.box = 1;
            obj_player2.box = 1;
            mach2 = 0;
            obj_camera.chargecamera = 0;
            x = other.x;
            obj_player1.targetDoor = other.targetDoor;
            obj_player1.targetRoom = other.targetRoom;
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            
            if (global.coop == 1)
            {
                _box = other.id;
                
                with (obj_player)
                {
                    x = _box.x;
                    y = _box.y - 76;
                }
                
                obj_player1.sprite_index = obj_player1.spr_downpizzabox;
                obj_player1.image_index = 0;
                obj_player1.state = UnknownEnum.Value_112;
                obj_player2.sprite_index = obj_player2.spr_downpizzabox;
                obj_player2.image_index = 0;
                
                if (obj_player2.state != UnknownEnum.Value_186)
                    obj_player2.state = UnknownEnum.Value_112;
            }
            else
            {
                sprite_index = spr_downpizzabox;
                image_index = 0;
                state = UnknownEnum.Value_112;
            }
        }
    }
    
    if (other.image_yscale == -1)
    {
        if (((key_up && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 10, other) && (state == UnknownEnum.Value_0 || state == UnknownEnum.Value_306 || state == UnknownEnum.Value_58 || state == UnknownEnum.Value_92 || state == UnknownEnum.Value_103 || state == UnknownEnum.Value_104 || state == UnknownEnum.Value_121 || state == UnknownEnum.Value_99 || (state == UnknownEnum.Value_80 && sprite_index == spr_player_breakdanceuppercut))) || ((state == UnknownEnum.Value_97 || state == UnknownEnum.Value_123) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other))) && !instance_exists(obj_fadeout) && state != UnknownEnum.Value_112 && state != UnknownEnum.Value_95)
        {
            obj_player1.lastroom = room;
            obj_player2.lastroom = room;
            scr_soundeffect(113);
            other.depth = -10;
            obj_player1.box = 1;
            obj_player2.box = 1;
            other.depth = -8;
            mach2 = 0;
            obj_camera.chargecamera = 0;
            x = other.x;
            y = other.y + 24;
            obj_player1.targetDoor = other.targetDoor;
            obj_player1.targetRoom = other.targetRoom;
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            
            if (global.coop == 1)
            {
                _box = other.id;
                
                with (obj_player)
                {
                    x = _box.x;
                    y = _box.y + 24;
                }
                
                obj_player1.sprite_index = obj_player1.spr_uppizzabox;
                obj_player1.image_index = 0;
                obj_player1.state = UnknownEnum.Value_112;
                obj_player2.sprite_index = obj_player2.spr_uppizzabox;
                obj_player2.image_index = 0;
                
                if (obj_player2.state != UnknownEnum.Value_186)
                    obj_player2.state = UnknownEnum.Value_112;
            }
            else
            {
                sprite_index = spr_uppizzabox;
                image_index = 0;
                state = UnknownEnum.Value_112;
            }
        }
    }
}
