image_speed = 0.5;

if (audio_is_playing(sfx_explosion))
    audio_stop_sound(sfx_explosion);

scr_soundeffect(42);
hurtplayer = 0;
