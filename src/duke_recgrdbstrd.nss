//::///////////////////////////////////////////////
//:: FileName duke_recgrdbstrd
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/12/2002 2:39:15 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "guardbastardswrd_NOD"))
		return FALSE;

	return TRUE;
}
