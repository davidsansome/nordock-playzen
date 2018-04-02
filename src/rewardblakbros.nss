//::///////////////////////////////////////////////
//:: FileName rewardblakbros
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2002 11:28:41 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 1000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 1500);

    // Give the speaker the items
    CreateItemOnObject("stoneofbrosna", GetPCSpeaker(), 1);

    // Set Persistent Token so that Quest is not repeatable
    SetTokenBool(GetPCSpeaker(), "duke_unger", 1);

    dhAddJournalQuestEntry("duke_unger", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
}
