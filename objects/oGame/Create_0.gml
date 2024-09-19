/// @desc Initialization & Global Variables

// Randomize Game Seed
randomize();

global.gameSaveSlot = 0;

global.gamePaused = false;
global.textSpeed = 0.75;
global.targetRoom = EOF;
global.targetX = EOF;
global.targetY = EOF;
global.targetDirection = NULL;
global.iLifted = noone;

global.playerHasAnyItems = false;
global.playerEquipped = ITEM.BOMB;
global.playerAmmo = array_create(ITEM.TYPE_COUNT, EOF);
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);
global.playerAmmo[ITEM.BOMB] = 0;
global.playerAmmo[ITEM.BOW] = 0;

/*TEMP
global.playerHasAnyItems = true;
global.playerItemUnlocked[ITEM.BOMB] = true;
global.playerAmmo[ITEM.BOMB] = 5;
global.playerItemUnlocked[ITEM.HOOK] = true;
global.playerItemUnlocked[ITEM.BOW] = true;
global.playerAmmo[ITEM.BOW] = 15;
TEMP*/

global.playerMoney = 1000;
global.playerHealthMax = DEFAULT_PLAYER_HP_MAX;
global.playerHealth = DEFAULT_PLAYER_HP;

global.questStatus = ds_map_create();
global.questStatus[? "SimpleFavor"] = 0;


global.insCamera = instance_create_layer(0, 0, layer, oCamera);
global.iUI = instance_create_layer(0, 0, layer, oUI);

// Resize Application Surface to Defined Resolution
surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);

// Go To First Room 
room_goto(ROOM_START);










