//::///////////////////////////////////////////////
//:: FileName reward_scouting
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/26/2002 16:17:32
//:://////////////////////////////////////////////
#include "nw_i0_tool"

#include "journal_include"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(100, GetPCSpeaker());
    dhAddJournalQuestEntry("grack_sewer", 3, GetPCSpeaker(), FALSE);
}
