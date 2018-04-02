//::///////////////////////////////////////////////
//:: FileName dornquestrew
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/19/2002 6:58:58 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 100);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 150);

    dhAddJournalQuestEntry("trondor", 4, GetPCSpeaker());

}
