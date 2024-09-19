/// @desc

// Inherit the parent event
event_inherited();

state = ENEMYSTATE.WANDER;

// Enemy Sprites
sprMove = sprSlime;
sprAttack = sprSlimeAttack;
sprHurt = sprSlimeHurt;
sprDie = sprSlimeDie;

// Enemy Functions

enemyScript[ENEMYSTATE.WANDER] = SlimeWander;
enemyScript[ENEMYSTATE.CHASE] = SlimeChase;
enemyScript[ENEMYSTATE.ATTACK] = SlimeAttack;
enemyScript[ENEMYSTATE.HURT] = SlimeHurt;
enemyScript[ENEMYSTATE.DIE] = SlimeDie;