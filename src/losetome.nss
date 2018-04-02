//::///////////////////////////////////////////////
//:: FileName losetome
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/5/2002 3:05:48 PM
//:://////////////////////////////////////////////
#include "journal_include"

void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "TomeofDarkGlyphs");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    dhAddJournalQuestEntry("mainquest", 2, GetPCSpeaker(), FALSE);
}
