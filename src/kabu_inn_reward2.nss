#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oRing = GetItemPossessedBy(oPC, "KabuRing");
    if (GetIsObjectValid(oRing))
    {
        GiveXPToCreature(oPC, 900);
        GiveGoldToCreature(oPC, 1000);
        DestroyObject(oRing);
        CreateItemOnObject("kabu_ring_reward", oPC);
        SPI(oPC, "KabuInnStage", 4);
    }
    dhAddJournalQuestEntry("kabu_inn", 3, oPC, FALSE, FALSE, FALSE, TRUE);
}
