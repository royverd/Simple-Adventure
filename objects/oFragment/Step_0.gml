/// @desc

if (!global.gamePaused)
{
	
	// Bounce
	
	if (bounceCount != 0)
	{
		bounce += (pi * bounceSpeed);
		if (bounce >= pi)
		{
			bounce -= pi;
			bounceHeight *= BOUNCE_HEIGHT_FALLOFF;
			bounceCount--;
			
		}
		z = abs(sin(bounce)) * bounceHeight;
	}
	else z = NULL;
	
	// Deteriorate
	deteriorate++;
	if (deteriorate > deteriorateAfter)
	{
		image_alpha -= 1 / deteriorateTime;
		if (image_alpha <= 0) instance_destroy();
		
	}
	
	// Friction
	fric = 0.05;
	if (z = NULL) fric = 0.1;
	
	// Move
	x += lengthdir_x(spd, direction);
	y += lengthdir_y(spd, direction);
	// Check Collision
	if (tilemap_get_at_pixel(collisionMap, x, y) > 0) spd = NULL;
	spd = max(spd - fric, 0);
	
	
	
	
	
	
	
	
}



