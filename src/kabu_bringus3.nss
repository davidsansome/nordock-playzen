#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    dhAddJournalQuestEntry("kabu_bringus", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
    GiveXPToCreature(oPC, 200);

    SPI(oPC, "KabuBringusCompleted", 1);
}
