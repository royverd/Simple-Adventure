function CollectCoins(_amount){
	global.playerMoney += _amount;
}

function CollectAmmo (_array)
{
	// _array = [type, amount]
	global.playerAmmo[_array[0]] += _array[1];
	
}

function PurchaseItem(_item, _amount, _cost){
	
	if (global.playerMoney >= _cost)
	{
		global.playerHasAnyItems = true;
		global.playerItemUnlocked[_item] = true;
		global.playerAmmo[_item] += _amount;
		global.playerMoney -= _cost;
		global.playerEquipped = _item;
		instance_destroy(activate);
		
		var _desc = "";
		switch (_item)
		{
			case ITEM.BOW: _desc = "You can now shoot stuff!\nGreat."; break;
			case ITEM.BOMB: _desc = "You can now blow up stuff!\nSuper."; break;
			case ITEM.HOOK: _desc = "You are now officially a hooker! Oof."; break;
			default: _desc = "No item description found!"; break;
		}
		NewTextBox(_desc, 1);
	}
	else
	{
		NewTextBox("Not enough dough... welp.", 1);	
	}
	
	
	
	
	
}