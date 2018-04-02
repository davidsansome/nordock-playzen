//::///////////////////////////////////////////////
//:: FileName tkanover
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/29/2002 6:28:02 PM
//:://////////////////////////////////////////////
#include "apts_inc_ptok"
#include "journal_include"

void main()
{
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "BookofTKan");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 750);

    // Give the speaker some xo
    GiveXPToCreature(GetPCSpeaker(), 400);

    // Set the persistent token variable so quest cannot be repeated
    SetTokenBool(GetPCSpeaker(), "tkan_book", 1);

    dhAddJournalQuestEntry("bookoftkan", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

}
