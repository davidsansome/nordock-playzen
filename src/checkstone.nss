//::///////////////////////////////////////////////
//:: FileName checkstone
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/24/2004 12:50:43 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "portalstone"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "portalstoneii"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "portalstoneiii"))
        return FALSE;

else
   {
    return TRUE;
   }

}

