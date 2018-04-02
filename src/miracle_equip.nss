//::///////////////////////////////////////////////
//:: FileName miracle_equip
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/22/2002 2:27:04 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "miracle_blade"))
		return FALSE;
	if(!CheckPartyForItem(GetPCSpeaker(), "miracle_shield"))
		return FALSE;

	return TRUE;
}
