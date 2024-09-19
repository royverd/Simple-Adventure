/// @desc Draw Textbox

draw_sprite_stretched(sprTextBoxBg, background, x1, y1, x2 - x1, y2 - y1)
InitText(fText, fa_center, fa_top, c_black);

// Message
var _print = string_copy(message, 1 , textProgress)

// If responses exist and message display is completed
if (responses[0] != -1) && (textProgress >= string_length(message))
{
	for (var i = 0; i < array_length_1d(responses); i++)
	{
		_print += "\n";
		if (i == responseSelected) _print += "> "; // Right Arrow for Text
		_print += responses[i];
		if (i == responseSelected) _print += " <"; // Left Arrow for Text
	}
}


draw_text(( x1 + x2) / 2, y1 + T_STROKE, _print);
draw_set_color(c_white);
draw_text(( x1 + x2) / 2, y1 + T_STROKE - T_ISTROKE, _print);




