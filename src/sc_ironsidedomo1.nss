//::///////////////////////////////////////////////
//:: FileName sc_ironsidedomo1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-10-31 12:39:56
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "tokenofvalor"))
		return FALSE;

	return TRUE;
}
