//::///////////////////////////////////////////////
//:: FileName checktoken2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/8/2002 8:52:34 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "TokenofPossession"))
		return FALSE;

	return TRUE;
}
