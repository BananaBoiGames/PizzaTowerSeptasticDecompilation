var _w, _h, x1, y1, _playerportrait;

draw_set_color(c_white);

if (!surface_exists(dialogue_surface))
{
    trace("dialogue surface created");
    dialogue_surface = surface_create(770, 140);
}
else
{
    surface_set_target(dialogue_surface);
    draw_sprite_tiled(spr_dialogue_bg, 0, scroll, scroll);
    surface_reset_target();
    _w = obj_camera.original_cam_width;
    _h = obj_camera.original_cam_height;
    display_set_gui_size(_w, _h);
    draw_set_font(global.smallfont);
    x1 = 480 - (sprite_get_width(spr_dialogue_frame) / 2);
    y1 = 540 - sprite_get_height(spr_dialogue_frame) - padding;
    draw_sprite(portrait, talking, x1 + 13, y1 + 6);
    _playerportrait = spr_dialogue_peppino;
    
    if (obj_player1.isgustavo)
        _playerportrait = spr_dialogue_gustavo;
    
    if (!obj_player1.ispeppino)
        _playerportrait = spr_dialogue_noise;
    
    shader_set(global.Pal_Shader);
    pal_swap_set(obj_player1.spr_palette, obj_player1.paletteselect, false);
    draw_sprite_ext(_playerportrait, !talking, (x1 + sprite_get_width(spr_dialogue_frame)) - 16, y1 + 6, -1, 1, 0, c_white, 1);
    shader_reset();
    draw_surface(dialogue_surface, x1 + 23, y1 + 5);
    draw_sprite(spr_dialogue_frame, 0, x1, y1);
    shader_set(global.Pal_Shader);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    pal_swap_set(pal_dialogue, fontselect, false);
    
    if (talking)
    {
        pal_swap_set(pal_dialogue, 0, false);
        
        if (_playerportrait == spr_dialogue_gustavo)
            pal_swap_set(pal_dialogue, 1, false);
        else if (_playerportrait == spr_dialogue_noise)
            pal_swap_set(pal_dialogue, 2, false);
    }
    
    draw_text_scribble(x1 + padding + 6, y1 + padding, string_upper(currenttext), currentpos);
    shader_reset();
    
    if (currentpos >= string_length_scribble(currenttext))
        draw_sprite(spr_dialogue_arrow, 0, x1, y1);
}
