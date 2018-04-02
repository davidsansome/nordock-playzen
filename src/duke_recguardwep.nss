//::///////////////////////////////////////////////
//:: FileName duke_recguardwep
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/12/2002 2:35:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "guardbastardswrd_NOD"))
        return FALSE;
        else
    if(!CheckPartyForItem(GetPCSpeaker(), "guardcaptbastrd_NOD"))
        return FALSE;
        else
    if(!CheckPartyForItem(GetPCSpeaker(), "guardcaptgrtswrd_NOD"))
        return FALSE;
        else
    return TRUE;
}
