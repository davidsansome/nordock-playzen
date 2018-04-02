//::///////////////////////////////////////////////
//:: FileName dl_sirpat
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 07/10/2002 12:39:41 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "LilthsToken"))
		return FALSE;

	return TRUE;
}
