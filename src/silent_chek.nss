//::///////////////////////////////////////////////
//:: FileName silent_chek
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/17/2002 7:16:45 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "silent_first_time") == 0))
		return FALSE;

	return TRUE;
}