var player, targetplayer;

player = instance_nearest(x, y, obj_player);

switch (state)
{
    case UnknownEnum.Value_126:
        scr_enemy_idle();
        break;
    
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
    
    case 141:
        scr_enemy_chase();
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
    
    case UnknownEnum.Value_80:
        if (sprite_index == spr_minijohn_punchstart)
        {
            image_speed = 0.35;
            hsp = Approach(hsp, 0, 1);
            
            if (floor(image_index) == (image_number - 1))
            {
                punchspd = 8;
                hsp = punchspd * image_xscale;
                sprite_index = spr_minijohn_punch;
                image_index = 0;
                image_speed = 0.25;
                
                with (instance_create(x, y, obj_forkhitbox))
                {
                    sprite_index = spr_bighitbox;
                    mask_index = spr_bighitbox;
                    ID = other.id;
                }
            }
        }
        else if (sprite_index == spr_minijohn_punch)
        {
            image_speed = 0.25;
            punchspd = Approach(punchspd, 0, 0.25);
            hsp = punchspd * image_xscale;
            
            with (instance_place(x + hsp, y, obj_destructibles))
                instance_destroy();
            
            if (floor(image_index) == (image_number - 1))
            {
                state = 141;
                ragecooldown = 100;
                sprite_index = spr_minijohn_charge;
            }
        }
        
        break;
    
    case 189:
        hsp = 0;
        
        if (underground)
        {
            sprite_index = spr_minijohn_underground;
            
            if (player.x > (x - 200) && player.x < (x + 200) && y <= (player.y + 60) && y >= (player.y - 60))
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
                sprite_index = spr_minijohn_stun;
                vsp = -4;
                
                repeat (3)
                    create_debris(x, y, 1271);
            }
        }
        else if (grounded)
        {
            state = 141;
            sprite_index = spr_minijohn_charge;
        }
        
        break;
}

if (state == UnknownEnum.Value_138 && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state == 141 && ragecooldown <= 0)
{
    if (player.x > (x - 400) && player.x < (x + 400) && y <= (player.y + 60) && y >= (player.y - 60))
    {
        if (x != player.x)
            image_xscale = sign(player.x - x);
        
        if (global.stylethreshold >= 3)
        {
            sprite_index = spr_minijohn_rage1;
            image_index = 0;
            vsp = -8;
            flash = 1;
            alarm[4] = 5;
            ragecooldown = 100;
            state = UnknownEnum.Value_125;
            create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
            
            with (instance_create(x, y, obj_forkhitbox))
            {
                sprite_index = spr_bighitbox;
                mask_index = spr_bighitbox;
                ID = other.id;
            }
        }
        else
        {
            sprite_index = spr_minijohn_punchstart;
            image_index = 0;
            ragecooldown = 100;
            state = UnknownEnum.Value_80;
        }
    }
}

if (ragecooldown > 0)
    ragecooldown--;

if (state != UnknownEnum.Value_138)
    birdcreated = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != 141)
    momentum = 0;

if (state == UnknownEnum.Value_134 || state == UnknownEnum.Value_126)
{
    targetplayer = 245;
    
    if (obj_player1.spotlight == 0)
        targetplayer = 244;
    
    movespeed = 4;
    
    if (targetplayer.x != x)
        image_xscale = -sign(x - targetplayer.x);
    
    state = 141;
}

if (instance_exists(obj_player2))
{
    if (obj_player2.x > (x - 400) && obj_player2.x < (x + 400) && y <= (obj_player2.y + 60) && y >= (obj_player2.y - 60))
    {
        if (state != UnknownEnum.Value_126 && obj_player2.state == UnknownEnum.Value_121)
        {
            state = UnknownEnum.Value_126;
            sprite_index = scaredspr;
            
            if (x != obj_player2.x)
                image_xscale = -sign(x - obj_player2.x);
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
