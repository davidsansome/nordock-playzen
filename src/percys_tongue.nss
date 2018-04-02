//::///////////////////////////////////////////////
//:: FileName percys_tongue
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/10/2002 11:12:56 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC10"))
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
            if (GetTag(oItem) == "NW_IT_MSMLMISC10")
            {
                DestroyObject(oItem);
                GiveGoldToCreature(oPC, 110);
            }
            oItem = GetNextItemInInventory(oPC);
        }
    }

}
