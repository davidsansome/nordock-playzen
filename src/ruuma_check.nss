//::///////////////////////////////////////////////
//:: FileName ruuma_check
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2003 11:54:57 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "Tickettoruumania"))
		return FALSE;

	return TRUE;
}
