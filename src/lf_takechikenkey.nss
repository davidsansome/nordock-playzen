//::///////////////////////////////////////////////
//:: FileName lf_takechikenkey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/15/2002 12:26:59 PM
//:://////////////////////////////////////////////
void main()
{

	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SecretChickenKey");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
	// Set the variables
	SetLocalInt(GetPCSpeaker(), "start_chicken", 0);

}
