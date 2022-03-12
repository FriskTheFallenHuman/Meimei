/// @description Debug Information/Actual drawing
var _h = display_get_gui_height();
var _w = display_get_gui_width();

if (!surface_exists(global.textsurface))
    global.textsurface = surface_create(_w, _h);

surface_set_target(global.textsurface);

//gpu_set_blendenable(0);
draw_clear_alpha(c_black, 0);

draw_set_font(fnt_main);
draw_set_halign(fa_left);
//draw_set_alpha(1);
draw_set_color(c_white);

if ( debug )
{
	draw_text_ext_color(((view_xport[0]) + 240), y+10, ">> DEBUG MODE <<", 5, 300, c_purple, c_purple, c_white, c_white, 1);
	draw_text(0, y+40, "Persistent: " + string(ddlc_persistent));
	draw_text(0, y+65, "Complete: " + string(is_done));
	draw_text(0, y+90, "Event: " + string(con));
	draw_text(0, y+115, "Alarm: " + string(alarm_get(0)));
	draw_text(0, y+140, "Vessel: " + string(vessel));
	
}

draw_set_halign(fa_center);
var tempy = 150;
if ( center_text )
	tempy = 0;
draw_text(((surface_get_width(application_surface)/2)), ((surface_get_height(application_surface)/2) + (y+tempy)), talk[0]);
if ( subtitle )
{
	draw_set_color(c_gray);
	//draw_set_alpha(alpha);
	draw_text(((surface_get_width(application_surface)/2)), ((surface_get_height(application_surface)/2) + (y+180)), talk[1]);
}

surface_reset_target();
gpu_set_blendmode(bm_dest_alpha);
draw_surface(global.textsurface, 0, 0);