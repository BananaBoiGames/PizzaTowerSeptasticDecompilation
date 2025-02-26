var targetplayer;

if (room == rm_editor)
    exit;

switch (state)
{
    case UnknownEnum.Value_126:
        scr_enemy_idle();
        break;
    
    case UnknownEnum.Value_130:
        scr_enemy_turn();
        break;
    
    case UnknownEnum.Value_134:
        if (!grounded)
            sprite_index = spr_ufogrounded_fall;
        
        if (sprite_index != spr_ufogrounded_fall && sprite_index != spr_ufogrounded_land)
        {
            invincible = 0;
            scr_enemy_walk();
        }
        else if (sprite_index == spr_ufogrounded_fall)
        {
            hsp = 0;
            
            if (grounded)
            {
                sprite_index = spr_ufogrounded_land;
                image_index = 0;
            }
        }
        else
        {
            if (image_index > 11)
                hsp = sign(image_xscale);
            
            if (floor(image_index) == (image_number - 1))
            {
                sprite_index = spr_ufogrounded_walk;
                invincible = 0;
            }
        }
        
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
    
    case UnknownEnum.Value_154:
        scr_enemy_pummel();
        break;
    
    case UnknownEnum.Value_155:
        scr_enemy_staggered();
        break;
    
    case UnknownEnum.Value_125:
        scr_enemy_rage();
        break;
}

if (state != UnknownEnum.Value_134)
    invincible = 0;

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

scr_scareenemy();
targetplayer = global.coop ? instance_nearest(x, y, obj_player) : 245;

if (bombreset > 0)
    bombreset--;

if (x != targetplayer.x && state != UnknownEnum.Value_129 && bombreset == 0 && grounded)
{
    if (targetplayer.x > (x - 400) && targetplayer.x < (x + 400) && y <= (targetplayer.y + 20) && y >= (targetplayer.y - 20))
    {
        if (state == UnknownEnum.Value_134 || state == UnknownEnum.Value_126)
        {
            sprite_index = spr_ufogrounded_shoot;
            image_index = 0;
            image_xscale = -sign(x - targetplayer.x);
            state = UnknownEnum.Value_129;
        }
    }
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
