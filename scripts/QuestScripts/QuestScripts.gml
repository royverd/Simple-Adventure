
function ActivateHatCat(){
	
	var _hasHat = (global.iLifted != noone) && (global.iLifted.object_index == oHat);
	switch (global.questStatus[? "SimpleFavor"])
	{	
		case 0: // Not Started
		{	
			// Player Might Have Brought the Hat Back Anyway
			if (_hasHat)
			{
				// Quest Complete
				NewTextBox("Wow, you found my hat without me even asking you to!", 2);
				NewTextBox("You are a true hero indeed!", 2);
				global.questStatus[? "SimpleFavor"] = 2;
				with (oQuestNPC) sprite_index = sprQuestyHat;
				with (oHat) instance_destroy();
				global.iLifted = noone;
				with (oPlayer)
				{	
					spriteIdle = sprPlayer;
					spriteRun = sprPlayerRun;
				}
			}
			else
			{
				// Offer Quest
				NewTextBox("Hello there! You look like a brave adventurer!\nWhat with the cape and all.", 2);
				NewTextBox("Could you help me find my missing hat?", 2, ["4:Of Course!", "5:This tast is beneath me"]);
			}
			
			break;
		}
		
		case 1: // Quest in Progress
		{	
			
			if (_hasHat)
			{
				// Quest Complete
				NewTextBox("Wow, you found my hat!", 2);
				NewTextBox("You are a hero!", 2);
				global.questStatus[? "SimpleFavor"] = 2;
				with (oQuestNPC) sprite_index = sprQuestyHat;
				with (oHat) instance_destroy();
				global.iLifted = noone;
				with (oPlayer)
				{	
					spriteIdle = sprPlayer;
					spriteRun = sprPlayerRun;
				}
			}
			else
			{
				// Clue Reminder
				NewTextBox("I think I left my hat in that scary cave\nto the northe east.", 2);
				NewTextBox("You might need some items to get there.", 2);
			
			}
			break;
		}
		
		case 2: // Quest Completed
		{
			NewTextBox("Thanks again!", 2);
			break;
		}
		
		default:
			break;
	}

}