if (!horseyfinish && start)
{
    with (obj_horsey)
    {
        spd = 0;
        hsp = 0;
        vsp = 0;
    }
    
    with (obj_horseyright)
        used = 1;
    
    with (obj_racestart)
        ds_list_add(global.saveroom, id);
    
    global.horse = 0;
    instance_destroy(obj_horseyblock);
}
