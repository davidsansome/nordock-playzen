//::///////////////////////////////////////////////
//:: FileName test_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/13/2002 12:10:14 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(500, GetPCSpeaker());

    // Give the speaker some XP
    RewardPartyXP(500, GetPCSpeaker());

}
