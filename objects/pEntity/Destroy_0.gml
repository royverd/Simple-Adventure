/// @desc Drop Fragments &/or Items


if (entFragmentCount > NULL)
{
	show_debug_message("*DROPPED FRAGMENTS*");
	fragmentArray = array_create(entFragmentCount, entFragment);
	DropItems(x, y, fragmentArray);
}

if (entityDropList != EOF)
{
	DropItems(x, y, entityDropList);	
}

