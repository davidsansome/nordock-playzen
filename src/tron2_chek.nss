//::///////////////////////////////////////////////
//:: FileName tron2_chek
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/3/2002 6:59:08 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetHitDice(GetPCSpeaker()) >= 2)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
