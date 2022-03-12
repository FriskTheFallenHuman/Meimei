/// @description Draw our Input
if (surface_exists(global.textsurface))
	surface_set_target(global.textsurface);

//gpu_set_blendenable(0);
draw_clear_alpha(c_black, 0);

draw_set_valign(fa_middle);
//draw_set_alpha(1);
draw_set_color(c_white);
draw_text(x+25, y, ">");
draw_text_color(x-70, y-1, "remote@monika:       ", c_green, c_green, c_green, c_green, 1);
var temptext = "setup";
var xtext = 70;
if ( offert )
{
	temptext = "agreement";
	xtext = 100;
}
draw_text_color(x+xtext, y-1, temptext, c_white, c_white, c_white, c_white, 1);
draw_text(x, y+25, message);
draw_text(x+(string_width(message) / 2), y+25, cursor);

surface_reset_target();
gpu_set_blendmode(bm_dest_alpha);
draw_surface(global.textsurface, 0, 0);