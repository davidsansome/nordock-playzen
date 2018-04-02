//::///////////////////////////////////////////////
//:: FileName duke_recgrdcapgs
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/12/2002 2:40:04 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "guardcaptgrtswrd_NOD"))
		return FALSE;

	return TRUE;
}
