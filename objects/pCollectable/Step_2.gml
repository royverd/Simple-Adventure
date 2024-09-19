/// @desc

flash = max(0, flash - 0.05);
fric = 0.05;
if (z == 0) fric = 0.10;

// Magnetise
if (instance_exists(oPlayer))
{
	var _px = oPlayer.x;
	var _py = oPlayer.y;
	var _dist = point_distance(x, y, _px, _py);
	if (_dist < DEF_MAGNET_RADIUS)
	{
		spd += 0.25;
		direction = point_direction(x, y, _px, _py);
	 	spd = min(spd, 3);
		fric = 0;
		if (_dist < PLAYER_COLLECT_RADIUS)
		{
			// If Collectable has Script
			if (collectScriptArg != EOF)
			{
				script_execute(collectScript, collectScriptArg);
				
			}
			else // If No-script Collectible
			{
				if (collectScript != EOF) script_execute(collectScript);
				
			}
			instance_destroy();
		}
	}
}

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


// Movement Commit
x += lengthdir_x(spd, direction);
y += lengthdir_y(spd, direction);
spd = max(spd - fric, 0);
depth = -bbox_bottom;