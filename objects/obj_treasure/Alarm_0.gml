var roomname, namestring;

audio_stop_all();

if (global.timeattack == 1)
    obj_timeattack.stop = 1;

targetDoor = "none";
obj_camera.alarm[2] = -1;
roomname = room_get_name(room);
namestring = string_letters(roomname);
namestring = string_copy(namestring, 1, string_length(namestring) - string_length("treasure"));
scr_savescore(namestring);

if (!instance_exists(obj_endlevelfade))
    instance_create(x, y, obj_endlevelfade);

obj_player1.state = UnknownEnum.Value_112;
obj_player1.sprite_index = obj_player1.spr_victory;
obj_player1.image_index = 0;

if (instance_exists(obj_player2))
{
    obj_player2.state = UnknownEnum.Value_112;
    obj_player2.sprite_index = obj_player2.spr_victory;
    obj_player2.image_index = 0;
}

obj_endlevelfade.alarm[0] = 235;
image_index = 0;
global.panic = 0;
global.snickchallenge = 0;
