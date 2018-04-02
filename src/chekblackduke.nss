//::///////////////////////////////////////////////
//:: FileName chekblackduke
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2002 11:19:37 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "Blackdragonscales") || GetLocalInt(GetPCSpeaker(),"gavescales")==1)
        return FALSE;

    return TRUE;
}
