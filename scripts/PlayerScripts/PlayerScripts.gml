
function PlayerAnimateSprite(){
	
	var _cardinalDirection = CARDINAL_DIR;
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = localFrame + (_cardinalDirection * _totalFrames);
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;
	
	// If Animation Loop
	if (localFrame >= _totalFrames)
	{
		animationEnd = true;
		localFrame -= _totalFrames;
	} else animationEnd = false;
}
	
function PlayerCollision(){
	var _collision = false;
	var _entityList = ds_list_create();
	
	// Horizontal
	if (tilemap_get_at_pixel(collisionMap, x + hSpeed, y))
	{
		x -= x mod TILE_SIZE;
		if (sign(hSpeed) == 1) x += TILE_SIZE - 1;
		hSpeed = 0;
		_collision = true;
	}
	
	// Horizontal Entities
	var _entityCount = instance_position_list(x + hSpeed, y, pEntity, _entityList, false);
	var _snapX;
	
	while (_entityCount > NULL)
	{
		var _entityCheck = _entityList[| NULL];
		if (_entityCheck.entCollision == true)
		{
			// Snap as Close as Possible
			if (sign(hSpeed) == EOF) _snapX = _entityCheck.bbox_right + 1;
			else _snapX = _entityCheck.bbox_left-1;
			
			x = _snapX;
			hSpeed = 0;
			_collision = true;
			_entityCount = 0;
		}
		// else
		ds_list_delete(_entityList, NULL);
		_entityCount--;
	}
	
	
	// Horizontal Move Commit
	x += hSpeed;
	
	ds_list_clear(_entityList);
	
	// Vertical
	if (tilemap_get_at_pixel(collisionMap, x, y + vSpeed))
	{
		y -= y mod TILE_SIZE;
		if (sign(vSpeed) == 1) y += TILE_SIZE - 1;
		vSpeed = 0;
		_collision = true;
	}
	
	// Vertical Entities
	var _entityCount = instance_position_list(x , y + vSpeed, pEntity, _entityList, false);
	var _snapY;
	
	while (_entityCount > NULL)
	{
		var _entityCheck = _entityList[| NULL];
		if (_entityCheck.entCollision == true)
		{
			// Snap as Close as Possible
			if (sign(vSpeed) == EOF) _snapY = _entityCheck.bbox_bottom + 1;
			else _snapY = _entityCheck.bbox_top -1;
			
			y = _snapY;
			vSpeed = 0;
			_collision = true;
			_entityCount = 0;
		}
		// else
		ds_list_delete(_entityList, NULL);
		_entityCount--;
	}
	
	
	// Vertical Move Commit
	y += vSpeed;
	
	// Memory Cleanup
	ds_list_destroy(_entityList);
	
	return _collision;
}

function PlayerActOutAnimation(_sprite, _end_script = EOF){

	//Carry out an Animation and Optionally Carry out a Script When the Animation Ends

	state = PlayerStateAct;

	sprite_index = _sprite;

	animationEndScript = _end_script;

	localFrame = 0;

	image_index = 0;

	PlayerAnimateSprite();

}
	
function PlayerThrow(){

	with (global.iLifted)
	{
		lifted = false;
		persistent = false;
		thrown = true;
		z = CARRY_HEIGHT;
		throwPeakHeight = z + 10;
		throwDistance = entThrowDistance;
		throwDistanceTravelled = PROGRESS_PERCENTAGE_ZERO;
		throwStartPercent = (CARRY_HEIGHT / throwPeakHeight) * HALF;
		throwPercent = throwStartPercent;
		direction = other.direction;
		xstart = x;
		ystart = y;
	}
	
	PlayerActOutAnimation(sprPlayerLift);
	global.iLifted = noone;
	
	//Reset Sprite
	spriteIdle = sprPlayer;
	spriteRun = sprPlayerRun;
	
}
	
/// @function Deal Damage to Player's 
/// @param _direction What direction the damage is coming from
/// @param _force The amount of knockback inflicted
/// @param _damage Amount of damage to be dealt
	
function HurtPlayer(_direction, _force, _damage){
	
	if (oPlayer.invulnerable <= 0)
	{
		global.playerHealth = max(0, global.playerHealth - _damage);
		
		if (global.playerHealth > 0)
		{
			with (oPlayer)
			{
				state = PlayerStateBonk;
				direction = _direction - FULL_CIRCLE / 2;
				moveDistanceRemaining = _force;
				ScreenShake(2, 10);
				flash = 0.7;
				invulnerable = 60;
				flashShader = shRedFlash;
				
			}
		}
		else
		{
			// Kill Player
			with (oPlayer)
			{
				state = PlayerStateDead;	
			}
			
		}
		
	}
	
}

function PlayerDropItem(){
	
	with (oPlayer)
	{
		global.iLifted = noone;
		spriteIdle = sprPlayer;
		spriteRun = sprPlayerRun;
	}
}