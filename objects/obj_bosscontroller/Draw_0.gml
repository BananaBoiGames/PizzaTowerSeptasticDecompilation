var cx, cy, cw, ch;

if (state == UnknownEnum.Value_8 || state == UnknownEnum.Value_98 || state == UnknownEnum.Value_89)
{
    draw_set_alpha(fade);
    cx = camera_get_view_x(view_camera[0]);
    cy = camera_get_view_y(view_camera[0]);
    cw = camera_get_view_width(view_camera[0]);
    ch = camera_get_view_height(view_camera[0]);
    draw_rectangle_color(cx, cy, cx + cw, cy + ch, c_white, c_white, c_white, c_white, 0);
    draw_set_alpha(1);
}
