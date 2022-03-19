/// @description Debug Information/Actual drawing

if (!surface_exists(global.textsurface))
	return;

surface_set_target(global.textsurface);

draw_set_font(fnt_main);
draw_set_halign(fa_left);
//draw_set_alpha(1);
draw_set_color(c_white);

if ( debug )
{
	scr_krispy_debug_mode_text();
	draw_text(0, 40, "Persistent: " + string(ddlc_persistent));
	draw_text(0, 65, "Complete: " + string(is_done));
	draw_text(0, 90, "Event: " + string(con));
	draw_text(0, 115, "Alarm: " + string(alarm_get(0)));
	draw_text(0, 140, "Vessel: " + string(vessel));
}

draw_set_halign(fa_center);
var tempy = 150;
if ( center_text )
	tempy = 0;
for (var i = 0; i < array_length(talk); i++)
{
	draw_text(((surface_get_width(application_surface)/2)), ((surface_get_height(application_surface)/2) + tempy), talk[i]);
	tempy += 30;
}
if ( prompt != "" )
{
	draw_set_color(c_gray);
	draw_text(((surface_get_width(application_surface)/2)), ((surface_get_height(application_surface)/2) + tempy), prompt);
}

surface_reset_target();