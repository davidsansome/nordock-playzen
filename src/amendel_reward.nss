//::///////////////////////////////////////////////
//:: FileName amendel_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/3/2002 1:32:35 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP and GP
    RewardPartyXP(2500, GetPCSpeaker());
    RewardPartyGP(2500, GetPCSpeaker());

    // Give the speaker the items
    CreateItemOnObject("miracleshield", GetPCSpeaker(), 1);
    CreateItemOnObject("miracleblade", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "sangroluskull");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
