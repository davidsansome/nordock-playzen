//::///////////////////////////////////////////////
//:: FileName goisur_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/30/2002 13:41:38
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"
#include "journal_include"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(1000, GetPCSpeaker());

    // Set the variables
    SPI(GetPCSpeaker(), "jobs_done", 1);
    dhAddJournalQuestEntry("grack_sewer", 4, GetPCSpeaker(), FALSE);

}
