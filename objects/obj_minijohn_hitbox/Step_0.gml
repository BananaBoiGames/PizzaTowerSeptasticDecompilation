if (!instance_exists(ID))
    instance_destroy();

if (instance_exists(ID))
{
    x = ID.x;
    y = ID.y;
    image_xscale = ID.image_xscale;
    image_index = ID.image_index;
    
    with (ID)
    {
        if (state != 141 && state != UnknownEnum.Value_125)
        {
            hitboxcreate = 0;
            instance_destroy(other);
        }
    }
}
