//::///////////////////////////////////////////////
//:: FileName jark_givetome
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/21/2002 1:39:54 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("tome_vhaerun", GetPCSpeaker(), 1);
    dhAddJournalQuestEntry("drowquest", 2, GetPCSpeaker(), FALSE);
}
