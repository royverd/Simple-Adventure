/// @desc

// Inherit the parent event
event_inherited();

flashShader = shRedFlash;
bombStage = 0;
bombTickRate =
[FRAME_RATE,FRAME_RATE,FRAME_RATE,FRAME_RATE/2,
FRAME_RATE/2,FRAME_RATE/2,FRAME_RATE/2,FRAME_RATE/6,
FRAME_RATE/6,FRAME_RATE/6,FRAME_RATE/6,FRAME_RATE/6,
FRAME_RATE/6,-1];

bombTick = bombTickRate[0];
