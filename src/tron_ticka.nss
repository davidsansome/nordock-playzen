//::///////////////////////////////////////////////
//:: FileName tron_ticka
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/4/2002 12:04:36 AM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();

    GiveGoldToCreature(oPC, 1);
    SetLocalInt(oPC, "ReceivedTrondorCoin", 1);

    dhAddJournalQuestEntry("trondor", 1, oPC);

}
