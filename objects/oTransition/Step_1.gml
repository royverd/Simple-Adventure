/// @desc Progress Transition

with (oPlayer)
{
	if (state != PlayerStateDead) state = PlayerStateTransition;
}

if (leading == OUT)
{
	percent = min(1, percent + TRANSITION_SPEED);
	
	if (percent >= PROGRESS_PERCENTAGE_ONE) // If Screen Fully Obscured
	{
		room_goto(targetRoom);
		leading = IN;
	}
	
}
else // leading == IN
{
	percent = max(0, percent - TRANSITION_SPEED);
	
	if (percent <= PROGRESS_PERCENTAGE_ZERO) // If Screen Fully Revealed
	{
		with (oPlayer) state = PlayerStateFree;
		instance_destroy();
	}
	
}








