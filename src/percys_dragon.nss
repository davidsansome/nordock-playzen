//::///////////////////////////////////////////////
//:: FileName percys_dragon
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/10/2002 11:14:10 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC17"))
        return FALSE;

    return TRUE;
}

void main()
{
    // script modified by Paradox_42
    // this script now sells all items at once
    object oPC = GetPCSpeaker();
    object oItem;

    if (StartingConditional())
    {
        oItem = GetFirstItemInInventory(oPC);
        // check inventory for item
        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == "NW_IT_MSMLMISC17")
            {
                DestroyObject(oItem);
                GiveGoldToCreature(oPC, 400);
            }
            oItem = GetNextItemInInventory(oPC);
        }
    }

}
