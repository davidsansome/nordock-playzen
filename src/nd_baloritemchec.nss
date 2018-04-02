//::///////////////////////////////////////////////
//:: FileName nd_baloritemchec
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/12/2002 11:06:09 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "nd_balorwand"))
		return FALSE;

	return TRUE;
}
