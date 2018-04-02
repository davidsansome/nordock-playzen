#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    // Search the PC's inventory for the silverware
    object oObject = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oObject))
    {
        if (GetTag(oObject) == "TylnSilverware")
        {
            DestroyObject(oObject);
            break;
        }
        oObject = GetNextItemInInventory(oPC);
    }

    dhAddJournalQuestEntry("tyln_silverware", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

    GiveXPToCreature(oPC, 750);
    GiveGoldToCreature(oPC, 2000);

    SPI(oPC, "TylnSilverwareCompleted", 1);
}
