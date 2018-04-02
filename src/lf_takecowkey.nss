//::///////////////////////////////////////////////
//:: FileName lf_takecowkey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/15/2002 12:27:33 PM
//:://////////////////////////////////////////////
void main()
{

	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SecretCowKey");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
	// Set the variables
	SetLocalInt(GetPCSpeaker(), "start_cow", 0);

}
