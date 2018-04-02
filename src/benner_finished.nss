#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    SPI(oPC, "InmateBennerFinished", 1);
    SPI(oPC, "InmateBennerReward", 2);
    dhAddJournalQuestEntry("benner", 3, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

    AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 10);
    AdjustReputation(oPC, GetObjectByTag("Faction_Defender"), 50);
    DestroyObject(OBJECT_SELF);
}


