/// @description Draw our Input

surface_set_target(global.textsurface);

draw_set_valign(fa_middle);
//draw_set_alpha(1);
draw_set_color(c_white);
draw_text(x-180, y, ">");
draw_text_color(x-70, y-1, "remote@monika:", c_green, c_green, c_green, c_green, 1);
var temptext = "setup";
var xtext = 70;
if ( offert )
{
	temptext = "agreement";
	xtext = 100;
}
draw_text_color(x+xtext, y-1, temptext, c_white, c_white, c_white, c_white, 1);
draw_text(x, y+25, message);
draw_text(x+(string_width(message)/2), y+25, cursor);
draw_set_valign(fa_top);

surface_reset_target();