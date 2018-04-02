// Removed by Grug 18-Apr-2004 - nodrops are now set by item flag
//#include "ats_inc_nodrop"
#include "ats_inc_common"
#include "ats_const_common"

void ATS_OnAcquireItem(object oItemPossessor, object oItemAcquired, object oItemOldPossessor)
{
// Removed by Grug 18-Apr-2004 - nodrops are now set by item flag
//    ATS_AssignPossessorToNoDropItems(oItemPossessor, oItemAcquired);

    string sItemTag = GetTag(oItemAcquired);
    string sItemResRef;
    int OreCount=0;
    object tmp=OBJECT_INVALID;
    object pos=OBJECT_INVALID;
    if(GetLocalInt(oItemAcquired,"Created by ATS acquire")==TRUE)
    {
        // this check is to prevent infinite looping, since the creation of a new
        // ore object inside the user's bag fires the OnAcquireItem event each time
        DeleteLocalInt(oItemAcquired,"Created by ATS acquire");
        return;
    }
    // Check for ore and move into miner's bag
    if((ATS_IsItemResource(oItemAcquired) == TRUE) && (ATS_GetTagBaseType(oItemAcquired) == "ORE1"))
    {
        if(GetHasInventory(oItemPossessor) == FALSE)        //check that inventory exists
            return;

        sItemResRef = GetStringLowerCase(GetTag(oItemAcquired));
        object oBagInInventory = GetFirstItemInInventory(oItemPossessor); //get first item
        while(GetIsObjectValid(oBagInInventory) == TRUE)    //...until end of inventory
        {
            if(ATS_GetTagBaseType(oBagInInventory) == CSTR_MINERBAG)
            { // if miner's bag... check counter
                OreCount = GetLocalInt(oBagInInventory,"Ore count");
                if(OreCount < 6) // if counter is less than 6, it shouldn't be full
                {
        //try to create ore into the bag - if successful, destroy original and return
        //safe to use here just lower case tag as resref, due to ATS naming convention
                    tmp=CreateItemOnObject(sItemResRef,oBagInInventory,1);
                    pos=OBJECT_INVALID; // just in case
                    pos=GetItemPossessor(tmp);
                    if(pos == oItemPossessor)
                    // only way to tell if Create was successful, if the possessor of the new
                    // block of ore is the same as the possessor of the original
                    {
                        SetLocalInt(tmp,"Created by ATS acquire",TRUE); // anti-recursion check
                        SetLocalInt(oBagInInventory,"Ore count",OreCount+1); // increment bag's ore count
                        DestroyObject(oItemAcquired,0.1);
                        return;
                    } else { // if unsuccessful mark the bag full until next smelt
                        SetLocalInt(oBagInInventory,"Ore count",6);
                    }
                }
            }

            oBagInInventory = OBJECT_INVALID; // just in case
            oBagInInventory = GetNextItemInInventory(oItemPossessor);  //get next item
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

