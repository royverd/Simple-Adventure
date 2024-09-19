/// @function ScreenShake(_magnitude, _frames)
/// @param _magnitude set the stength
/// @param _frames sets the length of the shake in frames
function ScreenShake(_magnitude, _frames){
	
	with (global.insCamera)
	{
	if (_magnitude > shakeRemain)
		{
			shakeMagnitude = _magnitude;
			shakeRemain = shakeMagnitude;
			shakeLength = _frames;
		}
	}


}

/// @function Initializes Text Properties
/// @param _font The font to use
/// @param _hpos Horizontal Alignment
/// @param _vpos Vertical Alignment
/// @param _color Color of the text
function InitText(_font, _hpos, _vpos, _color){
	draw_set_font(_font);
	draw_set_halign(_hpos);
	draw_set_valign(_vpos);
	draw_set_color(_color);
}
	
/// @function Handles All Instance Drops
/// @param _x
/// @param _y
/// @param _items_arr = [] Array of Items to Drop
function DropItems(_x, _y, _items_arr){
	
	var _items = array_length_1d(_items_arr);

	if (_items >= 1)
	{
		var _anglePerItem = FULL_CIRCLE/_items;
		var _angle = random(FULL_CIRCLE);
		for (var _i = 0; _i < _items; _i++)
		{
			with (instance_create_layer(_x, _y, "Instances", _items_arr[_i]))
			{
				direction = _angle;
				spd = 0.75 + (_items * 0.1) + random(0.1);
			}
			_angle += _anglePerItem;
		}
		
		
	}
	else
	{
		instance_create_layer(_x, _y, "Instances", _items_arr[0]);
	}

}
	
/// @function Handles All Room Transitions
/// @param _type Type of Transition
/// @param _target_room Room Transitioning to
function RoomTransition(_type, _target_room){
	
	if (!instance_exists(oTransition))
	{
		with (instance_create_depth(0, 0, -9999, oTransition))
		{
			type = _type;
			targetRoom = _target_room;
			
		}
	}
	else
	{
		show_debug_message("Trying to Transition while another transition is occuring");
		
	}
	
}
	
/// @function Handles Liftable Instances
/// @param _id The ID of the Instance Being Lifted
function ActivateLiftable(_id){
	
	// If not Carrying Anything
	if (global.iLifted == noone)
	{
		PlayerActOutAnimation(sprPlayerLift);
		
		spriteIdle = sprPlayerCarry;
		spriteRun = sprPlayerRunCarry;
		
		global.iLifted = _id;
		
		with (global.iLifted)
		{
			lifted = true;
			persistent = true;
		}
	}
	
}