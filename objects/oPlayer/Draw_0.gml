/// @desc

// Draw Shadow
draw_sprite(sprShadow, 0, floor(x), floor(y));

// Hookshot (Pre-Player)
if (state == PlayerStateHook) && (image_index != 3) DrawHookChain();

// Every 8 Frames, Act for 3 Frames	
if (invulnerable != 0) && ((invulnerable mod 8 < 2) == 0) && (flash == 0)
{
	// Skip Draw//	
}
else
{
	if (flash != 0)
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
	
	if (shader_current() != EOF) shader_reset();
}

// Hookshot (Pre-Player)
if (state == PlayerStateHook) && (image_index == 3) DrawHookChain();

function DrawHookChain(){
	
	var _originX = floor(x);
	var _originY = floor(y) - HOOK_THROW_OFFSET;
	
	var _chains = hook div hookSize;
	var _hookDirX = sign(hookX);
	var _hookDirY = sign(hookY);
	
	for (var i = 0; i < _chains; i++)
	{
		draw_sprite
		(
			sprHookChain,
			0,
			_originX + hookX - (i * hookSize * _hookDirX),
			_originY + hookY - (i * hookSize * _hookDirY)
		);	
		
	}
	draw_sprite(sprHookBlade, image_index, _originX + hookX, _originY + hookY);
	
}





