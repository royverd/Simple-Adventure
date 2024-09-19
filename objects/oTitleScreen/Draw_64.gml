/// @desc

if (titleVisible > 0)
{
	draw_sprite(sprTitle, 0 ,0 , -RESOLUTION_H + titleVisible * RESOLUTION_H);
	draw_set_alpha(titleVisible * abs(sin(get_timer() * 0.000001 * pi)));
	draw_sprite(sprTitle, 1 , 0 , 0);
	draw_set_alpha(1.0);
	
	
}

if (slotsVisible > 0)
{
	// Draw Save Slots
	draw_set_alpha(slotsVisible);
	
	for (var _slot = 0; _slot <= 2; _slot++)
	{
		// Draw Background Boxes
		var _y = 16 + _slot * 48; // Magic
		var _x = 160; // Magic
		var _img = 2;
		if (slotSelected == _slot)
		{
			_img = 3;
			image_speed = 0.1;
			draw_sprite(sprMenuPlayer, -1 , _x - 32, _y + 34); // Magic
			
		}
		//NineSliceBoxStretched(strTextBoxBg, _x, _y, 312, _y + 48, _img) // Magic
		draw_sprite_stretched(sprTextBoxBg, _img, _x, _y, 312, 48);
	
		// Draw Save Data
		InitText(fText, fa_left, fa_top, c_white);
		if (slotData[_slot] == EOF) // Empty Save Slot
		{
			draw_text(_x + 8, _y + 8, "Start New Game"); // Magic	
		}
		else
		{
			draw_text(_x + 8, _y + 8, RoomToAreaName(slotData[_slot][? "room"]));
			
			// Draw HP
			var _playerHealth = slotData[_slot][? "playerHealth"];
			var _playerHealthMax = slotData[_slot][? "playerHealthMax"];
			var _playerHealthFrac = frac(_playerHealth);
			_playerHealth -= _playerHealthFrac;
			
			for (var i = 1; i <= _playerHealthMax; i++)
			{
				var _imageIndex = (i > _playerHealth);
				if (i == _playerHealth + 1)
				{
					_imageIndex += (_playerHealthFrac > 0);
					_imageIndex += (_playerHealthFrac > 0.25);
					_imageIndex += (_playerHealthFrac > 0.5);
					
				}
				draw_sprite(sprHealth, _imageIndex, _x + 48 + (( i - 1 ) * 16), _y + 24);
	
			}
			
			// Draw Money
			draw_sprite(sprCoinUI, 0 , _x + 8, _y + 28); //Magic
			draw_text(_x + 20, _y + 24, slotData[_slot][? "playerMoney"]); // Magic
			
		}
		
	}
	draw_set_alpha(1.0)
	
}