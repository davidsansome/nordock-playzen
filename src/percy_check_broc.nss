//::///////////////////////////////////////////////
//:: FileName percy_check_broc
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 1:10:37 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "RecipeforBrocksdagger"))
        return FALSE;

    return TRUE;
}
