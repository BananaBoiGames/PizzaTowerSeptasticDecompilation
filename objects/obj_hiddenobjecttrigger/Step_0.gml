var _sound;

_sound = false;

if (place_meeting(x, y, obj_player))
{
    with (obj_hiddenobject)
    {
        if (!activated && trigger == other.trigger)
        {
            _sound = vsfxP_transfo1;
            event_user(0);
        }
    }
}

if (_sound)
    scr_soundeffect(46);
