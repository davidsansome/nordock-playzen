//::///////////////////////////////////////////////
//:: FileName dl_daishiroom
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 06/10/2002 11:48:44 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "daishisring"))
		return FALSE;

	return TRUE;
}
