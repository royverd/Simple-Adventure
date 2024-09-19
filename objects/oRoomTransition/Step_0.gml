/// @desc

if (instance_exists(oPlayer)) && (position_meeting(oPlayer.x, oPlayer.y, id))
{
	if (!instance_exists(oTransition)) && (oPlayer.state != PlayerStateDead)		
	{
		
		// Force Stop Player
		if (!keepWalking)
		{
			with(oPlayer)
			{
				show_debug_message("PLAYER HALTED");
				vSpeed = 0;
				hSpeed = 0;
			}
		}
		
		// Transition
		global.targetRoom = targetRoom;
		global.targetX = targetX;
		global.targetY = targetY;
		global.targetDirection = oPlayer.direction;
	
		with (oPlayer) state = PlayerStateTransition;
		RoomTransition(TRANSITION_TYPE.SLIDE, targetRoom);
	
		instance_destroy();
		
		
	}
	
	
	
}





