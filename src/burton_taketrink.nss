//::///////////////////////////////////////////////
//:: FileName burton_taketrink
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/7/2002 12:36:37 AM
//:://////////////////////////////////////////////
void main()
{

	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "burtontrinket");
	if(GetIsObjectValid(oItemToTake) != 0)
		ActionTakeItem(oItemToTake, GetPCSpeaker());
}
