//::///////////////////////////////////////////////
//:: FileName annoy_half_chek
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/3/2002 4:55:43 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "annoyed_north_halfling") == 1))
		return FALSE;

	return TRUE;
}