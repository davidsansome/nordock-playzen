//::///////////////////////////////////////////////
//:: FileName beetleover
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/28/2002 9:00:29 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

void main()
{
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "BeetleVial");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 300);

    // Give the speaker the items
    CreateItemOnObject("nw_it_medkit002", GetPCSpeaker(), 3);

    // Set the Persistent Token to Prevent Repitition
    SetTokenBool(GetPCSpeaker(), "farmer_beetle", 1);

    dhAddJournalQuestEntry("redbeetle", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
}
