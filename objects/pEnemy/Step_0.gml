/// @desc Execute Enemy State Machine

if (!global.gamePaused)
{
	if (enemyScript[state] != EOF) script_execute(enemyScript[state])
	depth = -bbox_bottom;
}






