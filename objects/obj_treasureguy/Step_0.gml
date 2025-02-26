var player;

if (room == rm_editor)
    exit;

switch (state)
{
    case UnknownEnum.Value_130:
        scr_enemy_turn();
        break;
    
    case UnknownEnum.Value_134:
        scr_enemy_walk();
        break;
    
    case UnknownEnum.Value_136:
        scr_enemy_land();
        break;
    
    case UnknownEnum.Value_137:
        scr_enemy_hit();
        break;
    
    case UnknownEnum.Value_138:
        scr_enemy_stun();
        break;
    
    case UnknownEnum.Value_129:
        scr_pizzagoblin_throw();
        break;
    
    case UnknownEnum.Value_4:
        scr_enemy_grabbed();
        break;
    
    case UnknownEnum.Value_125:
        scr_enemy_rage();
        break;
    
    case 189:
        player = instance_nearest(x, y, obj_player);
        hsp = 0;
        
        if (underground)
        {
            sprite_index = spr_minijohn_underground;
            
            if (player.x > (x - 50) && player.x < (x + 50) && y <= (player.y + 60) && y >= (player.y - 60) && player.state == UnknownEnum.Value_111)
            {
                sprite_index = spr_minijohn_undergroundout;
                image_index = 0;
                underground = 0;
                
                if (player.x != x)
                    image_xscale = sign(x - player.x);
            }
        }
        else if (sprite_index == spr_minijohn_undergroundout)
        {
            if (floor(image_index) == (image_number - 1))
            {
                sprite_index = spr_treasureguy_stun;
                vsp = -4;
                
                repeat (3)
                    create_debris(x, y, 1271);
            }
        }
        else if (grounded)
        {
            state = UnknownEnum.Value_134;
            sprite_index = idlespr;
        }
        
        break;
}

if (state == UnknownEnum.Value_138 && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != UnknownEnum.Value_138)
    birdcreated = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

targetplayer = global.coop ? instance_nearest(x, y, obj_player) : 245;

if (state == UnknownEnum.Value_134)
{
    sprite_index = walkspr;
    hsp = 0;
}

if (state == UnknownEnum.Value_126)
{
    if (sprite_index == scaredspr)
    {
        if (image_index > (image_number - 1))
            state = 141;
    }
    else
    {
        sprite_index = spr_treasureguy_idle;
        image_speed = 0.35;
    }
}

if (state != UnknownEnum.Value_126 && state != 189 && state != UnknownEnum.Value_4 && state != UnknownEnum.Value_137 && state != UnknownEnum.Value_138 && state != 141 && !running)
{
    if (x < (targetplayer.x + threshold_x) && x > (targetplayer.x - threshold_x) && y < (targetplayer.y + threshold_y) && y > (targetplayer.y - threshold_y))
    {
        state = UnknownEnum.Value_126;
        image_index = 0;
        sprite_index = scaredspr;
        scaredbuffer = scared_max;
        
        if (x != targetplayer.x)
            image_xscale = sign(x - targetplayer.x);
    }
}

if (state == 141)
{
    image_speed = 0.5;
    
    if (hsp != 0)
        sprite_index = spr_treasureguy_escape;
    else
        sprite_index = spr_treasureguy_escape;
    
    if (runmovespeed < runmovespeed_max)
        runmovespeed += accel;
    else
        runmovespeed = runmovespeed_max;
    
    hsp = image_xscale * runmovespeed;
    
    if (grounded)
    {
        if (scr_solid(x + sign(hsp), y) && (!place_meeting(x + sign(hsp), y, obj_slope) || place_meeting(x + sign(hsp), y - 4, obj_slope)))
        {
            if (!jumped)
            {
                vsp = -11;
                jumped = 1;
            }
            else
            {
                runmovespeed = 0;
                image_xscale *= -1;
                jumped = 0;
            }
        }
        else
        {
            jumped = 0;
        }
    }
    
    if (distance_to_object(targetplayer) > idle_threshold)
        state = UnknownEnum.Value_134;
}

if (state != UnknownEnum.Value_4)
    depth = 0;

if (state != UnknownEnum.Value_138)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = other.sprite_index;
        baddieID = other.id;
        other.boundbox = 1;
    }
}

if (state == 189)
{
    invincible = 1;
    
    if (sprite_index != spr_minijohn_underground && sprite_index != spr_minijohn_undergroundout)
        image_blend = c_gray;
}
else
{
    invincible = 0;
    image_blend = c_white;
}
