/// @desc Check if Unlocked First
event_inherited();

if(!global.playerItemUnlocked[collectScriptArg[0]]) instance_change(oCoin, true);