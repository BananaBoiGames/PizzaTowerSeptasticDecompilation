if (other.state != UnknownEnum.Value_113)
{
    scr_hurtplayer(other);
    
    if (fake)
        instance_destroy();
}
else
{
    with (other)
    {
        state = UnknownEnum.Value_106;
        sprite_index = spr_bump;
        image_index = 0;
        hsp = -6 * xscale;
        vsp = -4;
        scr_soundeffect(57);
        
        repeat (3)
            create_debris(x, y, 1277);
    }
}
