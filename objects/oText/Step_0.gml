/// @desc

lerpProgress += (1 - lerpProgress) / 50; // Add 1/50th per frame, growing slower
textProgress += global.textSpeed;

// Get estimated value at % lerp progress 
x1 = lerp(x1, x1Target, lerpProgress);
x2 = lerp(x2, x2Target, lerpProgress);

// Cycle Through Responses
keyUp = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
keyDown = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));

// Handle Up/Down selection
responseSelected += (keyDown - keyUp);
var _max = array_length_1d(responses) - 1;
var _min = 0;
if (responseSelected > _max) responseSelected = _min;
if (responseSelected < _min) responseSelected = _max;

// Skip Text
if (keyboard_check_pressed(vk_space))
{
	var _messageLength = string_length(message);
	if (textProgress >= _messageLength)
	{
		if (responses[0] != -1)
		{
			with (originInstance)
			{
				DialogueResponses(other.responseScripts[other.responseSelected]);
			}
		}
		
		instance_destroy();
		// Decrement All Remaing Ticket's Values
		if (instance_exists(oTextQueued))
		{
			with (oTextQueued) ticket--;
		}
		else
		{
			with (oPlayer)
			{
				state = stateLast;
				skipStepEvent = true // In order to not re-open text in the same frame
			}
		}
	}
	else
	{
		if (textProgress > 2)
		{
			textProgress = _messageLength; // Accerate Message Display
		}
	}
}





