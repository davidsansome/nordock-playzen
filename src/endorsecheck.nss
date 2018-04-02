//::///////////////////////////////////////////////
//:: FileName endorsecheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/6/2002 11:53:38 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "NoteofEndorsement"))
		return FALSE;

	return TRUE;
}
