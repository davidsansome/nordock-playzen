//::///////////////////////////////////////////////
//:: FileName checkrenal
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 12:11:21 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "renalmad") == 0))
		return FALSE;

	return TRUE;
}
