 /// 

function AttackSlash(){
	
	// Attack Initiated
	if (sprite_index != sprPlayerAttackSlash)
	{
		show_debug_message("ATTACK: SLASHING");
		// Handle Animation
		sprite_index = sprPlayerAttackSlash;
		localFrame = 0;
		image_index = 0;
		
		// Clear Hit List
		if (!ds_exists(hitByAttack, ds_type_list)) hitByAttack = ds_list_create();
		ds_list_clear(hitByAttack);
	}
	
	CalculateAttack(sprPlayerAttackSlashHB);
	
	// Update Sprite
	PlayerAnimateSprite();
	
	if (animationEnd)
	{
		state = PlayerStateFree;
		animationEnd = false;
	}
}

/// @function Use Attack Hitbox & Check for Hits
/// @param _coll_spr Sprite to check for collision with others in list

function CalculateAttack(_coll_spr){
	
	depth = bbox_top;
	mask_index = _coll_spr;
	
	var _hitByAttackNow = ds_list_create();
	var _hits = instance_place_list(x, y, pEntity, _hitByAttackNow, false);
	
	if (_hits > 0)
	{
		// If Instance Not Yet Been Hit, Activate
		for (var _i = 0; _i < _hits; _i++)
		{
			var _hitID = _hitByAttackNow[| _i];
			// Check if Hit by CURRENT Attack
			if (ds_list_find_index(hitByAttack, _hitID) == EOF)
			{
				ds_list_add(hitByAttack, _hitID);
				
				// Activation Logic
				with(_hitID){
					
					if (object_is_ancestor(object_index, pEnemy))
					{
						HurtEnemy(id, PLAYER_SWIPE_ATTACK_DAMAGE, other.id, PLAYER_SWIPE_ATTACK_KNOCKBACK);
						
					}
					//image_blend = c_red;
					else if (entHitScript != EOF) script_execute(entHitScript);
					
				}
			}
		}
	}
	
	// Cleanup
	ds_list_destroy(_hitByAttackNow);
	mask_index = sprPlayer;

}
	
/// @function Handle Attacked Entity

function EntityHitDestroy(){

	instance_destroy();

}

/// @function White Flash on Hit

function EntityHitSolid(){

	flash = FLASH_DURATION

}
	
/// @function Attack Interactable Entity
/// @param _enemy What Entity to Hit
/// @param _damage Amount of DMG to Deal
/// @param _source Where the DMG Comes From
/// @param _knockback Amount of Knockback to Apply

function HurtEnemy(_enemy, _damage, _source, _knockback){
	
	with (_enemy)
	{
		if (state != ENEMYSTATE.DIE)
		{
			enemyHP -= _damage;
			flash = PROGRESS_PERCENTAGE_ONE;
			
			// Hurt OR Dead
			if (enemyHP <= 0)
			{
				state = ENEMYSTATE.DIE;	
				
			}
			else
			{
				if (state != ENEMYSTATE.HURT) statePrevious = state;
				state = ENEMYSTATE.HURT;
			}
			
			image_index = 0; // Reset Sprite Animation
			
			if (_knockback != 0)
			{
				var _knockDirection = point_direction(x, y, (_source).x, (_source).y);
				xTo = x - lengthdir_x(_knockback, _knockDirection);
				yTo = y - lengthdir_y(_knockback, _knockDirection);
				
				
			}
			
		}
	}
	
	
}