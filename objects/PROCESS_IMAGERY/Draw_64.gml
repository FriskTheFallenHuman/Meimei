display_set_gui_size(-1, -1);
var _h = display_get_gui_height();
var _w = display_get_gui_width();

if (!surface_exists(global.textsurface))
    global.textsurface = surface_create(_w, _h);

//activating the shader

//if (os_device == os_macosx){
//	shader_set(shdBktGlitchMac);
//}else{
shader_set(shdBktGlitch);
//}

//setting the resolution
BktGlitch_set_resolution_of_application_surface();

randomise();

//passing time to the shader (making sure nothing stays static)
BktGlitch_set_time(current_time * 0.06);

//quickly setting all parameters at once using a preset
BktGlitch_config_preset(preset);

//additional tweaking
BktGlitch_set_jumbleness(0.5);
BktGlitch_set_jumble_speed(.25);
BktGlitch_set_jumble_resolution(random_range(0.2, 0.4));
BktGlitch_set_jumble_shift(random_range(0.2, 0.4));
BktGlitch_set_channel_shift(0.01);
BktGlitch_set_channel_dispersion(.1);
BktGlitch_set_rng_seed(seed);

BktGlitch_set_intensity(0.05 + intensity); //adding additional intensity when the ball bounces!

//drawing the application surface
draw_surface(application_surface, 0, 0);
//gpu_set_blendmode(bm_dest_alpha);
draw_surface(global.textsurface, 0, 0);
//gpu_set_blendmode(bm_normal);

//done using the shader
shader_reset();

surface_set_target(global.textsurface);
draw_clear_alpha(c_black, 0);
surface_reset_target();