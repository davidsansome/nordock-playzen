//::///////////////////////////////////////////////
//:: FileName goblin_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/21/2002 16:40:38
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"
#include "journal_include"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(500, GetPCSpeaker());
    // Give the speaker some xp
    RewardPartyXP(150, GetPCSpeaker());


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "KlandsHead");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // Set the variables
    SPI(GetPCSpeaker(), "goblin_dead", 1);
    dhAddJournalQuestEntry("goblin_nest", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

}
