//::///////////////////////////////////////////////
//:: FileName trondgobquest
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/1/2002 10:25:41 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
	// Give the speaker some gold
	RewardPartyGP(500, GetPCSpeaker());

	// Give the speaker some XP
	RewardPartyXP(250, GetPCSpeaker());

}