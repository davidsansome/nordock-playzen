//::///////////////////////////////////////////////
//:: FileName xp_recognize
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/7/2002 10:03:35 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "iTalkToGuide") == 1))
		return FALSE;

	return TRUE;
}
