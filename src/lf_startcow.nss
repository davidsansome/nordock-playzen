//::///////////////////////////////////////////////
//:: FileName lf_startcow
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/15/2002 12:15:33 PM
//:://////////////////////////////////////////////
#include "journal_include"

void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "start_cow", 1);
    dhAddJournalQuestEntry("legfarm", 1, GetPCSpeaker(), FALSE);

}
