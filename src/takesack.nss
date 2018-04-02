//::///////////////////////////////////////////////
//:: FileName takesack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/30/2002 1:11:39 PM
//:://////////////////////////////////////////////

#include "journal_include"

void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SackofSupplies");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    dhAddJournalQuestEntry("weary_bag", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
}
