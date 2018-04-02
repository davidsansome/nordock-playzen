//::///////////////////////////////////////////////
//:: FileName wearysupgive
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/30/2002 1:05:40 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("sackofsupplies", GetPCSpeaker(), 1);
    SetLocalInt(GetPCSpeaker(),"OnSupplyQuest",1);
    dhAddJournalQuestEntry("weary_bag", 1, GetPCSpeaker(), FALSE);
}
