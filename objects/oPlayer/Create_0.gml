/// @description Player Creation Logic

state = PlayerStateFree;
stateLast = state;
stateAttack = AttackSlash;

hitByAttack = EOF;
skipStepEvent = false;
invulnerable = PLAYER_INVULNERABLE_DUR;
z = 0;

flash = 0;
flashShader = shWhiteFlash;
animationEndScript = EOF;

collisionMap = layer_tilemap_get_id(layer_get_id("Collision"));

image_speed = 0;

hSpeed = 0;
vSpeed = 0;
speedWalk = 2.0;
speedRoll = 3.0;
speedBonk = 1.5;
speedHook = 3.0;

distanceRoll = 52;
distanceBonk = 30;
distanceBonkHeight = 12;
distanceHook = 88;

sprRun = sPlayerRun;
sprIdle = sPlayer;
sprRoll = sPlayerRoll;

localFrame = 0;
animationEndScript = EOF;

hook = 0;
hookX = 0;
hookY = 0;
hookSize = sprite_get_width(sHookChain);

if (global.targetX != EOF)
{
	x = global.targetX;
	y = global.targetY;
	direction = global.targetDirection;
	
}


if (global.iLifted != noone)
{
	sprIdle = sPlayerCarry;
	sprRun = sPlayerRunCarry;
	sprite_index = sprIdle;
	
}




