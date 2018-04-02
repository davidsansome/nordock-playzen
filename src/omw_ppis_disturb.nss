/*
Persistent Player Item Storage - using Bioware campaign database
by OldManWhistler

See the omw_ppis_start script or documentation that was included with the zip.
*/

// ****************************************************************************
// ** CONFIGURATION (modify)
// ****************************************************************************

// Use this function to create limits to prevent a PC from storing too many items,
// etc.
int PPISUserDefinedInventoryLimit(object oPC, int iCount, object oItem)
{
    // This code is limiting the chest to storing 20 items. Change it if you like.
    // There is probably a fix limit to how many items you can store without having
    // performance hits.
    // You could do something cool with this like have the players buy different
    // levels of storage space. You could also prevent them from storing gold,
    // no drop items, have a limit to the total GP value of the items stored, etc etc.
    if(iCount > 20)
    {
        SendMessageToPC(oPC, "You have reached your storage limit.");
        return FALSE;
    }
    return TRUE;
}

// ****************************************************************************
// ** CONSTANTS (do not modify)
// ****************************************************************************

// Used for keeping track of the number of items stored.
const string PPIS_COUNT = "PPISCount";

// ****************************************************************************
// ** MAIN
// ****************************************************************************

void main()
{
    object oPC = GetLastDisturbed();
    // No point in trying to catch the inventory disturbed event if the source
    // is not a player. It is most likely that the commands are coming in so
    // faster that most of the disturbed events are going to be lost.
    if (!GetIsPC(oPC)) return;
    int iType = GetInventoryDisturbType();
    object oItem = GetInventoryDisturbItem();
    int iCount = GetLocalInt(OBJECT_SELF, PPIS_COUNT);
    if (iType == INVENTORY_DISTURB_TYPE_ADDED)
    {
        if (GetItemStackSize(oItem) > 50000)
        {
            CopyItem(oItem, oPC, TRUE);
            DestroyObject(oItem);
            SendMessageToPC(oPC, "Gold must be broken into separate 50,000 gp stacks.");
            return;
        }
        // Refuse items that have inventories.
        else if (GetHasInventory(oItem))
        {
            SendMessageToPC(oPC, "You cannot store containers.  Remove it or it will be destroyed.");
        }
        else if(!PPISUserDefinedInventoryLimit(oPC, iCount + 1, oItem))
        {
            // Delay is important, it makes sure that the item actually exists before
            // it is transfered.
            CopyItem(oItem, oPC, TRUE);
            DestroyObject(oItem);
            return;
        }
        else
            SendMessageToPC(oPC, "Storage space used: "+IntToString(iCount+1)+" of 20");

        iCount++;
        SetLocalInt(OBJECT_SELF, PPIS_COUNT, iCount);
    }
    else if (iType == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        // The inventory was removed from.
        iCount--;
        SetLocalInt(OBJECT_SELF, PPIS_COUNT, iCount);
        SendMessageToPC(oPC, "Storage space used: "+IntToString(iCount)+" of 20");
    }

}
