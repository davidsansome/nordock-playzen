//::///////////////////////////////////////////////
//:: FileName duergar_axe_ck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/20/2002 13:24:04
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "AxeofFate"))
		return FALSE;

	return TRUE;
}
