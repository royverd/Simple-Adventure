/// @desc

if (entShadow) draw_sprite(sprShadow, 0, x, y);

if (flash != NULL)
{
	shader_set(flashShader);
	uFlash = shader_get_uniform(flashShader, "flash");
	shader_set_uniform_f(uFlash, flash);
}

// Adjust Draw Height
draw_sprite_ext(
	sprite_index,
	image_index,
	floor(x),
	floor(y - z),
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
	
);

if (shader_current() != EOF)
{
	shader_reset();
}





