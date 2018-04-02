//::///////////////////////////////////////////////
//:: FileName duke_recgrdcapbs
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/12/2002 2:39:40 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "guardcaptbastrd_NOD"))
		return FALSE;

	return TRUE;
}
