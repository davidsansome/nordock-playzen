//::///////////////////////////////////////////////
//:: FileName trond_tick3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/3/2002 10:44:58 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetHitDice(GetPCSpeaker()) >= 3)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
