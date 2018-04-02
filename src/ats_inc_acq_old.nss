// Removed by Grug 18-Apr-2004 - nodrops are now set by item flag
//#include "ats_inc_nodrop"
#include "ats_inc_common"
#include "ats_const_common"



void ATS_OnAcquireItem(object oItemPossessor, object oItemAcquired, object oItemOldPossessor)
{

//    ATS_AssignPossessorToNoDropItems(oItemPossessor, oItemAcquired);

    // Check for ore and move into miner's bag
    string sItemTag = GetTag(oItemAcquired);
    if(ATS_IsItemResource(oItemAcquired) == TRUE &&
       ATS_GetTagBaseType(oItemAcquired) == "ORE1")
    {
       int i = 0;
       object oMineBag = ATS_FindItemInInventoryByBaseTag(oItemPossessor, CSTR_MINERBAG);
       while(GetIsObjectValid(oMineBag) == TRUE)
       {
            AssignCommand(oItemPossessor, ActionGiveItem(oItemAcquired, oMineBag));
            ++i;
            oMineBag = ATS_FindItemInInventoryByBaseTag(oItemPossessor, CSTR_MINERBAG, i);
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
            DelayCommand(0.4, ATS_CreateItemOnPlayer(sItemTag, oItemPossessor, iNumberInStack, FALSE));
        }
        else
        {
            SetLocalInt(oItemAcquired, "ats_charges_fix", TRUE);
        }
    }

}


