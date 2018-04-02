//::///////////////////////////////////////////////
//:: FileName lf_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/15/2002 12:37:09 PM
//:://////////////////////////////////////////////
#include "apts_inc_ptok"
#include "journal_include"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 5000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 2500);

    // Set the persistent token variable so quest cannot be repeated
    SetTokenBool(GetPCSpeaker(), "legendfarm", 1);
    dhAddJournalQuestEntry("legfarm", 3, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

}
