/// @desc

// Inherit the parent event
event_inherited();

state = ENEMYSTATE.WANDER;

// Enemy Sprites
sprMove = sprBat;
sprAttack = sprBat;
sprHurt = sprBatHurt;
sprDie = sprBatDie;

// Enemy Functions

enemyScript[ENEMYSTATE.WANDER] = BatWanderer;
enemyScript[ENEMYSTATE.CHASE] = BatChase;
enemyScript[ENEMYSTATE.ATTACK] = EOF;
enemyScript[ENEMYSTATE.HURT] = SlimeHurt; // Generic Enemy Hurt
enemyScript[ENEMYSTATE.DIE] = SlimeDie; // Generic Enemy Die