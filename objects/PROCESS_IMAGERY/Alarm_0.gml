/// @description Alter window caption

randomise();
if irandom(20) == 9
{
	var index = irandom_range(1, string_length(original_caption));
	interpolated_caption = string_delete(interpolated_caption, index, 1);
	interpolated_caption = string_insert("  ", interpolated_caption, index);
}
window_set_caption((irandom(30) == 12 ? interpolated_caption : zalgoizer_zalgoize(interpolated_caption)));
interpolated_caption = original_caption;
alarm[0] = 2;