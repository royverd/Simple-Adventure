
function UseItemBomb(){
	
	if (global.playerAmmo[ITEM.BOMB] > 0) && (global.iLifted == noone)
	{
		global.playerAmmo[ITEM.BOMB]--;
		var _bomb = instance_create_layer(x, y, "Instances", oBomb);
		ActivateLiftable(_bomb);
	}

}


function UseItemBow(){
	
	if (global.playerAmmo[ITEM.BOW] > 0) && (global.iLifted == noone)
	{
		global.playerAmmo[ITEM.BOW]--;
		PlayerActOutAnimation(sprPlayerBow, PlayerFireArrow);

	}
}

function PlayerFireArrow(){
	
	with (instance_create_depth(floor(x), floor(y) - ARROW_OFFSET, depth, oArrow))
	{
		direction = other.direction;
		direction = CARDINAL_DIR * 90;
		image_speed = 0;
		image_index = CARDINAL_DIR;
		speed = ARROW_SPEED;
	}

	
}

function UseItemHook(){
	
	state = PlayerStateHook;
	localFame = 0;

}