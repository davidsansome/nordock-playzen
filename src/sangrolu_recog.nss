//::///////////////////////////////////////////////
//:: FileName sangrolu_recog
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/13/2002 11:57:45 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "sangroluskull"))
		return FALSE;

	return TRUE;
}
