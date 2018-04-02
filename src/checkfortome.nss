//::///////////////////////////////////////////////
//:: FileName checkfortome
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/5/2002 2:46:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "TomeofDarkGlyphs")||HasItem(GetPCSpeaker(),"rubykey_NOD"))
        return FALSE;

    return TRUE;
}
