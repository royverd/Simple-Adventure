/// @desc Update Camera

// Update Destination
if (instance_exists(camFollow))
{
	xTo = camFollow.x;
	yTo = camFollow.y;
}

// Update Object Pos
x += (xTo - x) / CAM_OFF;
y += (yTo - y) / CAM_OFF;

// Keep Camera Bound to Room Borders

x = clamp(x, viewWidthHalf, room_width - viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height - viewHeightHalf);

// Screenshake
x += random_range(-shakeRemain, shakeRemain);
y += random_range(-shakeRemain, shakeRemain);

shakeRemain = max(0, shakeRemain - ((1 / shakeLength) * shakeMagnitude));

camera_set_view_pos(pCam, x - viewWidthHalf, y - viewHeightHalf);








