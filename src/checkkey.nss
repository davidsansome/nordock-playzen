//::///////////////////////////////////////////////
//:: FileName checkkey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/24/2004 12:50:43 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "kat_DiamondKey"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "kat_EmeraldKey"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "kat_ObsidianKey"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "kat_RubyKey"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "kat_SapphireKey"))
        return FALSE;

    return TRUE;
}
