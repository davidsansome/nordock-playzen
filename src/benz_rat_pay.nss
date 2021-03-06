//::///////////////////////////////////////////////
//:: FileName benz_rat_pay
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/2/2002 8:14:15 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "Ratwhisker"))
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
            if (GetTag(oItem) == "Ratwhisker")
            {
                DestroyObject(oItem);
                GiveGoldToCreature(oPC, 2);
            }
            oItem = GetNextItemInInventory(oPC);
        }
    }

}
