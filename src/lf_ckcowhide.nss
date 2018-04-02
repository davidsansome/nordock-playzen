//::///////////////////////////////////////////////
//:: FileName lf_ckcowhide
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/15/2002 12:17:43 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "supercowhide"))
		return FALSE;

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "start_cow") == 1))
		return FALSE;

	return TRUE;
}
