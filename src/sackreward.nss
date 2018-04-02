//::///////////////////////////////////////////////
//:: FileName sackreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/30/2002 1:12:20 PM
//:://////////////////////////////////////////////
#include "apts_inc_ptok"
#include "nw_i0_tool"

void main()
{
    // Give the Quest Reward Item
    if (!HasItem(GetPCSpeaker(),"wearybag_NOD"))
        CreateItemOnObject("wearybag_nod",GetPCSpeaker(),1);

    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 250);

    // Give the speaker some XP
    if (GetHitDice(GetPCSpeaker())<10)
        GiveXPToCreature(GetPCSpeaker(), 350);

    // Set the persistent token variable so quest cannot be repeated
    SetTokenBool(GetPCSpeaker(), "weary_bag", 1);

}
