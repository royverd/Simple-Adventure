/// @function Creates New Text Box & Text
/// @param message Message String to Display
/// @param background Frame Number of Text Box Background Sprite
/// @param responses_arr[] Array to store Responses
function NewTextBox(_message, _background = 1, _responses_arr = [-1]){
	var _obj;
	if (instance_exists(oText)) _obj = oTextQueued;
	else _obj = oText;
	
	with (instance_create_layer(0, 0, "Instances", _obj))
	{
		message = _message;
		// Get Caller Id if Any
		if (instance_exists(other)) originInstance = other.id else originInstance = noone;
		// Set Background (obsolete)  
		if (argument_count > 1) background = _background;
		else background = DEFAULT_TBG_FRAME;
		// Responses
		if (_responses_arr[0] != -1)
		{
			// Tokenize Responses
			
			// Transfer Responses to Correct Array
			responses = [];
			array_copy(responses, 0, _responses_arr, 0, array_length(_responses_arr));
			
			for (var i = 0; i < array_length_1d(responses); i++)
			{
				var _markerPosition = string_pos(":", responses[i]);
				// Convert to Real Text
				responseScripts[i] = real(string_copy(responses[i], 1, _markerPosition - 1));
				responses[i] = string_delete(responses[i], 1, _markerPosition); 
				breakpoint = 10;
			}
		}
		else
		{
			responses = [-1];
			responseScripts = [-1];
		}
	}
	
	with (oPlayer)
	{
		if (state != PlayerStateLocked)
		{
			lastState = state;
			state = PlayerStateLocked;
		}
	}
	
}

/// @function Handles All Dialogue Responses
/// @param _response Response String
function DialogueResponses(_response){
	
	switch(_response)
	{
		case 0: break;
		case 1: NewTextBox("You gave response A!", 1); break;
		case 2: NewTextBox("You gave response B! Any further response?", 1, ["3:Yes!", "0:No."]); break;
		case 3: NewTextBox("Thanks for your responses!", 0); break;
		case 4:
		{
			NewTextBox("Thanks!", 2);
			NewTextBox("I think I left it in that scary cave to the north east!", 2);
			global.questStatus[? "SimpleFavor"] = 1;
			break;
		}
		case 5: NewTextBox(":<", 2); break;
		case 6: PurchaseItem(activate.item, activate.itemAmount, activate.itemCost);break;
		default: break;
		
		
	}

}