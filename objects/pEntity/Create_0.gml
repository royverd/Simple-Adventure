/// @desc Essential Entity Setup

z = 0;
flash = 0;
lifted = 0;
thrown = false;
flashShader = shWhiteFlash;
uFlash = shader_get_uniform(flashShader, "flash");
entityDropList = EOF;

collisionMap = layer_tilemap_get_id(layer_get_id("Collision"));