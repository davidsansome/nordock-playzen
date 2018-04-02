//::///////////////////////////////////////////////
//:: FileName checkbook
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/29/2002 6:22:11 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "BookofTKan") || GetLocalInt(GetPCSpeaker(),"OnTkanQuest"))
        return FALSE;

    return TRUE;
}
