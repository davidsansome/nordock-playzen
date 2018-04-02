//::///////////////////////////////////////////////
//:: FileName sangrolu_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/14/2002 12:02:36 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"

void main()
{
    SetTokenBool(GetPCSpeaker(), "gurnal_quest_2", 1);
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "sangroluskull", 1);
    // Give the speaker some gold
    RewardPartyGP(1000, GetPCSpeaker());
    // Give the speaker some XP
    RewardPartyXP(1000, GetPCSpeaker());
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "sangroluskull");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
