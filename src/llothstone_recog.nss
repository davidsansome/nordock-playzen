//::///////////////////////////////////////////////
//:: FileName llothstone_recog
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/26/2002 11:10:41 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "llothstone"))
		return FALSE;

	return TRUE;
}
