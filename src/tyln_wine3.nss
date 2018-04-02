#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    // Search the PC's inventory for the wine
    object oObject = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oObject))
    {
        if (GetTag(oObject) == "VintageTylnWine")
        {
            DestroyObject(oObject);
            break;
        }
        oObject = GetNextItemInInventory(oPC);
    }

    dhAddJournalQuestEntry("tyln_wine", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

    GiveXPToCreature(oPC, 400);
    GiveGoldToCreature(oPC, 1000);

    SPI(oPC, "TylnWineCompleted", 1);
}
