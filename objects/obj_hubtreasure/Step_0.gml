if (place_meeting(x, y, obj_player) && obj_player.state != UnknownEnum.Value_46)
{
    sprite_index = sprgot;
    alarm[0] = 150;
    obj_player.sprite_index = obj_player.spr_gottreasure;
    obj_player.state = UnknownEnum.Value_46;
    method(self, got_func);
    
    with (obj_tv)
    {
        message = "YOU GOT A TOWER SECRET TREASURE!!!";
        alarm[0] = 200;
        showtext = 1;
    }
}
