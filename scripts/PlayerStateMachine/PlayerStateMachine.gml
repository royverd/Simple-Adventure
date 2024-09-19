
function PlayerStateFree(){
	
	// Player Movement
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	// Check for Collision & Move/Don't
	PlayerCollision();

	// Update Sprite Index

	var _oldSprite = sprite_index;

	if (inputMagnitude != 0)
	{
		direction = inputDirection;
		sprite_index = spriteRun;
	}
	else sprite_index = spriteIdle;

	if (_oldSprite != sprite_index) localFrame = 0;

	// Update Image Index
	PlayerAnimateSprite();
	
	// Attack Logic
	if (keyAttack)
	{
		state = PlayerStateAttack;
		PlayerStateAttack = AttackSlash;
	}
	
	
	// Change State
	if (keyActivate)
	{
		
		// 1 - Check for Entity
		// 2 - No Entity or non-interactable Entity
			// 2a - If Carrying Something, Throw
			// 2b - Otherwise, Roll
		// 3 - Interactable Entity
		// 4 - If NPC Entity, Face Player
		
		// 1 - Check for Entities
		activate = noone;
		var _activateX = x + lengthdir_x(INTERACTION_DISTANCE, direction);
		var _activateY = y + lengthdir_y(INTERACTION_DISTANCE, direction);
		var _activateSize = INTERACTION_RADIUS
		var _activateList = ds_list_create();
		var _entitiesFound = collision_rectangle_list( // For Radius = 4, 8x8 Rectangle
			_activateX - _activateSize,
			_activateY - _activateSize,
			_activateX + _activateSize,
			_activateY + _activateSize,
			pEntity,
			false,
			true,
			_activateList,
			true
			);
		
		// If First Instance is the Lifted Entity OR has no Script, Iterate List
		while (_entitiesFound > 0)
		{
			var _check = _activateList[| --_entitiesFound];
			
			if (_check != global.iLifted) && (_check.entActivateScript != EOF)
			{
				activate = _check;
				break;
			}
		}
		
		
		ds_list_destroy(_activateList);
		
		// Alternative Radial Check
		//activate = collision_circle(x + _activateX, y - INTERACTION_DISTANCE + _activateY, INTERACTION_RADIUS, pEntity, false, true);
		
		// 2 - No Entity or non-interactable Entity 
		if (activate == noone)
		{
			// 2a - Throw if Carrying
			if (global.iLifted != noone)
			{
				show_debug_message("ATTEMPTING THROW");
				PlayerThrow();
			}
			else // 2b - Otherwise
			{
				show_debug_message("ROLLING");
				state = PlayerStateRoll; // Roll Instead
				moveDistanceRemaining = distanceRoll;
			}

		}
		// 3 - Interactable Entity
		else
		{	
						
			// Face Entity
			direction = point_direction(x, y, activate.x, activate.y);
			image_index = CARDINAL_DIR;
			
			show_debug_message("INTERACTABLE ENTITY");
			script_execute_ext(activate.entActivateScript, activate.entActivateArgs);
			
			// 4 - If NPC Entity, Face Player
			
			if (activate.entNPC)
			{
				show_debug_message("NPC");
				with(activate)
				{
					direction = point_direction(x, y, other.x, other.y);
					image_index = CARDINAL_DIR;
				}
			}

		}
	}
	
	if (keyItem) && (!keyActivate) && (global.playerHasAnyItems) && (global.playerEquipped != ITEM.NONE)
	{
		switch (global.playerEquipped)
		{
			case ITEM.BOMB:
				UseItemBomb();
				break;
				
			case ITEM.BOW:
				UseItemBow();
				break;
				
			case ITEM.HOOK:
				UseItemHook();
				break;
				
			default:
				break;
			
		}
		
	}
	
	// Cycle Items
	if (global.playerHasAnyItems)
	{
		
		var _cycleDirection = keyItemSelectUp - keyItemSelectDown;
		if (_cycleDirection != 0)
		{
			do
			{
				global.playerEquipped += _cycleDirection;
				if (global.playerEquipped < 1) global.playerEquipped = ITEM.TYPE_COUNT-1;
				if (global.playerEquipped >= ITEM.TYPE_COUNT) global.playerEquipped = 1;
				
			} until (global.playerItemUnlocked[global.playerEquipped]);
		}	
	}
}

function PlayerStateRoll(){
	
	// Get Current Direction
	if (inputDirection == 0) inputDirection = direction;
	
	hSpeed = lengthdir_x(speedRoll, inputDirection);
	vSpeed = lengthdir_y(speedRoll, inputDirection);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedRoll);
	var _collided = PlayerCollision();
	
	//Update Sprite
	sprite_index = spriteRoll;
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = (CARDINAL_DIR * _totalFrames) + ((1 - (moveDistanceRemaining / distanceRoll)) * _totalFrames);
	
	// Change State
	if (moveDistanceRemaining <= 0)
	{
		state = PlayerStateFree;
	}
	
	// Collision Interactions
	if (_collided)
	{
		state = PlayerStateBonk;
		moveDistanceRemaining = distanceBonk;
		ScreenShake( 3, 30);
	}
}

function PlayerStateBonk(){
	
	// Get Current Direction
	//if (inputDirection == 0) inputDirection = direction;
	
	hSpeed = lengthdir_x(speedBonk, direction - FULL_CIRCLE/2);
	vSpeed = lengthdir_y(speedBonk, direction - FULL_CIRCLE/2);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedBonk);
	var _collided = PlayerCollision();
	
	//Update Sprite
	if(sprite_index != sprPlayerHurt) sprite_index = sprPlayerHurt;
	image_index = CARDINAL_DIR - 2;
	
	// Change Height (Arc)
	z = sin(((moveDistanceRemaining / distanceBonk) * pi)) * distanceBonkHeight;
	
	// Change State
	if (moveDistanceRemaining <= 0)
	{
		state = PlayerStateFree;
	}
	
}

function PlayerStatePause(){
	
}

function PlayerStateLocked(){
	// Does Nothing
}
	
function PlayerStateAttack(){
	script_execute(stateAttack);
}

function PlayerStateTransition(){
	// Movement
	PlayerCollision();
	
	// Update Image Index
	PlayerAnimateSprite();
	
}
	
function PlayerStateAct(){
	// Update Sprite
	PlayerAnimateSprite();
	
	// If There is an Ending Animation
	if (animationEnd)
	{
		state = PlayerStateFree;
		animationEnd = false;
		if (animationEndScript != -1)
		{
			script_execute(animationEndScript);
			animationEndScript = EOF;
		}
	}
}
	
function PlayerStateDead(){
	hSpeed = 0;
	vSpeed = 0;
	
	// If Entering State
	if (sprite_index != sprPlayerDie) && (sprite_index != sprPlayerDead)
	{
		// Update Sprite
		sprite_index = sprPlayerDie;
		image_index = 0;
		image_speed = 0.7; // Gradual Fade Spin

	}
	
	// Animation End Frame Check
	if (image_index + image_speed > image_number)
	{
		if (sprite_index == sprPlayerDie)
		{
			image_speed = max(0, image_speed - 0.03);
			if (image_speed < 0.07)
			{
				image_index = 0;
				sprite_index = sprPlayerDead;
				image_speed = 1.0;
			}
		}
		else
		{
			image_speed = 0;
			image_index = image_number - 1;
			global.targetX = EOF;
			global.targetY = EOF;
			RoomTransition(TRANSITION_TYPE.SLIDE, rVillage);	
		}
	}
}
	
function PlayerStateHook(){
	
	hSpeed = 0;
	vSpeed = 0;
	
	// If Just Arriving
	
	if (sprite_index != sprPlayerHook)
	{
		hook = 0;
		hookX = 0;
		hookY = 0;
		hookStatus = HOOKSTATUS.EXTENDING;
		hookedEntity = noone;
		
		// Update Sprite
		sprite_index = sprPlayerHook;
		image_index = CARDINAL_DIR;
		image_speed = 0;
		
	}
	
	// Extend/Retract Hook
	
	var _speedHookTemp = speedHook;
	if (hookStatus != HOOKSTATUS.EXTENDING) _speedHookTemp *= -1;
	hook += _speedHookTemp;
	switch (image_index)
	{
		case 0: hookX = hook; break;
		case 1: hookY = -hook; break;
		case 2: hookX = -hook; break;
		case 3: hookY = hook; break;
		
	}
	
	// HookShot State Machine
	
	switch (hookStatus)
	{
		case HOOKSTATUS.EXTENDING:
		{
			// Finish Extending
			if (hook >= distanceHook) hookStatus = HOOKSTATUS.MISSED;
			
			// Check For Hit
			var _hookHit = collision_circle(x + hookX, y + hookY, 4, pEntity, false, true);
			if (_hookHit != noone) && (global.iLifted != _hookHit)
			{
				// Act Depending on Hit Instance
				switch (_hookHit.entHookable) {
					
					default: //Not Hookable
					{
						if (object_is_ancestor(_hookHit.object_index, pEnemy))
						{
							HurtEnemy(_hookHit, HOOK_DMG , id , HOOK_KNB);
							hookStatus = HOOKSTATUS.MISSED;
						}
						else
						{
							if (_hookHit.entHitScript != -1)
							{
								with (_hookHit) script_execute(entHitScript);
								hookStatus = HOOKSTATUS.MISSED;								
							}				
						}
					} break;
					
				    case 1:
					{
						hookStatus = HOOKSTATUS.PULLTOPLAYER;
						hookedEntity = _hookHit;
					} break;

				    case 2:
					{
						hookStatus = HOOKSTATUS.PULLTOENTITY;
						hookedEntity = _hookHit;
					}break;
				}
			}
		} break;
		
		// Pull Entity
		
		case HOOKSTATUS.PULLTOPLAYER:
		{
			with (hookedEntity)
			{
				x = other.x + other.hookX;
				y = other.y + other.hookY;
				
			} break;
			
			
		}
		
		case HOOKSTATUS.PULLTOENTITY:
		{
			switch (image_index)
			{
				case 0: x += speedHook; break;
				case 1: y -= speedHook; break;
				case 2: x -= speedHook; break;
				case 3: y += speedHook; break;
			}
		} break;
	}
	
	// Finish Retract & End State
	
	if (hook <= 0)
	{
		hookedEntity = noone;
		state = PlayerStateFree;
		
	}
}