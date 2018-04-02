//::///////////////////////////////////////////////
//:: FileName dorneryllsquest
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/1/2002 8:03:35 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(100, GetPCSpeaker());

    // Give the speaker some XP
    RewardPartyXP(100, GetPCSpeaker());

}
