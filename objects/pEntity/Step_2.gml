/// @desc Entity Loop

if (!global.gamePaused)
{
	depth = -bbox_bottom;
	
	if (lifted) && (instance_exists(oPlayer))
	{
		if (oPlayer.sprite_index != sprPlayerLift)
		{
			x = oPlayer.x;
			y = oPlayer.y;
			z = CARRY_HEIGHT;
			depth = oPlayer.depth - 1;
		}
	}
	
	if (!lifted)
	{
		// Be Thrown
		if (thrown)
		{
			throwDistanceTravelled = min(throwDistanceTravelled + THROW_SPEED, throwDistance);
			x = xstart + lengthdir_x(throwDistanceTravelled, direction);
			y = ystart + lengthdir_y(throwDistanceTravelled, direction);
			if (tilemap_get_at_pixel(collisionMap, x, y) > 0)
			{
				thrown = false;
				grav = THROW_GRAVITY;
			}
			
			throwPercent = throwStartPercent + lerp(0, 1 - throwStartPercent, throwDistanceTravelled / throwDistance);
			z = throwPeakHeight * sin(throwPercent * pi);
			
			if (throwDistance == throwDistanceTravelled)
			{
				thrown = false;
				if (entThrowBreak) instance_destroy();
			}
		}
		else
		{
			// Fall Back to Earth if Above Zero Z
			if (z > 0)
			{
				z = max(z - grav, 0);
				grav += THROW_GRAVITY;
				if (z == 0) && (entThrowBreak) instance_destroy();
			}
			else
			{
				grav = THROW_GRAVITY;
			}
		}
	}
}

if (flash == FLASH_DURATION)
{
	show_debug_message("ENTITY HIT");
	flash = max(flash - FLASH_DECAY, 0);
	
} else if (flash != PROGRESS_PERCENTAGE_ZERO) flash = max(flash - FLASH_DECAY, 0);

	







