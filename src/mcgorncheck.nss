//::///////////////////////////////////////////////
//:: FileName mcgorncheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/4/2002 9:50:23 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "NotetoSgtMcGorn"))
		return FALSE;

	return TRUE;
}
