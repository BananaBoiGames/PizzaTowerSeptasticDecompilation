pal_swap_init_system(shd_pal_swapper);
global.roommessage = "WELCOME TO PIZZA TOWER";

if (!obj_secretmanager.init)
{
    obj_secretmanager.init = 1;
    secret_add(function()
    {
        touchedtriggers = 0;
    }, function()
    {
        if (touchedtriggers >= 6)
            secret_open_portal(0);
    });
    secret_add(-4, function()
    {
        secret_open_portal(1);
    });
    secret_add(-4, function()
    {
        if (secret_check_trigger(2))
            secret_open_portal(2);
    });
}
