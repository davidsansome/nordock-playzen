// This script was rewritten by GilronS to address the "Too Many Instructions"
// errors caused by mining with multiple Miner's Bags in your inventory.
// This script caused compilation errors in the hc_on_acq_item script, so it
// is not being used.
// -Jarketh Thavin 12/20/2002

// Removed by Grug 18-Apr-2004 - nodrops are now set by item flag
//#include "ats_inc_nodrop"
#include "ats_inc_common"
#include "ats_const_common"

void ATS_OnAcquireItem(object oItemPossessor, object oItemAcquired, object
oItemOldPossessor)
{

//    ATS_AssignPossessorToNoDropItems(oItemPossessor, oItemAcquired);

    // Check for ore and move into miner's bag
    string sItemTag = GetTag(oItemAcquired);
    string sItemResRef;
    if(ATS_IsItemResource(oItemAcquired) == TRUE &&
       ATS_GetTagBaseType(oItemAcquired) == "ORE1")
    {

        if(GetHasInventory(oItemPossessor) == FALSE)        //check that inventory exists
            return OBJECT_INVALID;

    object oBagInInventory = GetFirstItemInInventory(oItemPossessor); //get first item
    while(GetIsObjectValid(oBagInInventory) == TRUE)    //...until end of inventory
    {
        if(ATS_GetTagBaseType(oBagInInventory) == CSTR_MINERBAG)    //if miner's bag
        {

            sItemResRef = GetStringLowerCase(GetTag(oItemAcquired));
        //try to create ore into the bag - if successful, destroy original and return
        //safe to use here just lower case tag as resref, due to ATS naming convention
            if(CreateItemOnObject(sItemResRef,oBagInInventory,1) != OBJECT_INVALID)
            {
                DestroyObject(oItemAcquired);
                return;
            }
        }
        GetNextItemInInventory(oItemPossessor);             //get next item
    }
    }
    else if(sItemTag == CSTR_TRADESKILL_JOURNAL)
        return;
    else if(GetStringLeft(sItemTag, 3) == "ATS" &&
            GetItemHasItemProperty(oItemAcquired, ITEM_PROPERTY_CAST_SPELL) == TRUE)
    {
        // Workaround for stores selling items with zero charges
        if(GetLocalInt(GetModule(), "ats_refresh_useable_items_" + GetName(oItemPossessor)) == TRUE &&
           GetLocalInt(oItemAcquired, "ats_charges_fix") == FALSE)
        {
            int iNumberInStack = GetNumStackedItems(oItemAcquired);
            DestroyObject(oItemAcquired);
            DelayCommand(0.4, ATS_CreateItemOnPlayer(sItemTag, oItemPossessor,iNumberInStack, FALSE));
        }
        else
        {
            SetLocalInt(oItemAcquired, "ats_charges_fix", TRUE);
        }
    }

}
