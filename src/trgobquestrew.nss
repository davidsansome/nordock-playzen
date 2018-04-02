//::///////////////////////////////////////////////
//:: FileName trgobquestrew
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/19/2002 6:59:37 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 250);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 300);

    dhAddJournalQuestEntry("trondor", 6, GetPCSpeaker());

}
