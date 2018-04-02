//::///////////////////////////////////////////////
//:: FileName vhaerun_award
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/6/2002 11:28:48 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(10000, GetPCSpeaker());

    // Give the speaker some XP
    RewardPartyXP(2500, GetPCSpeaker());

    // Give the speaker the items
    CreateItemOnObject("drowtalisman", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "vhaerunsamuletof");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
