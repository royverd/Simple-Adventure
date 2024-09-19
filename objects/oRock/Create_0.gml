/// @desc

// Inherit the parent event
event_inherited();

entityDropList = choose(
	[oBombDrop],
	[oCoin],[oCoin],[oCoin],[oCoin],[oCoin],[oCoin],
	[oCoin, oCoin],[oCoin, oCoin],
	[oCoin, oCoin, oCoin],
	[oArrowDrop],[oArrowDrop],[oArrowDrop],
	[oArrowBundleDrop]
)