//::///////////////////////////////////////////////
//:: FileName henchmanmng_eqip
//:://////////////////////////////////////////////
//:: This script will cause the henchman to give the PC all their equipped
//:: possessions within a bag of holding. The PC will arrange the
//:: possessions, and then use dialog to give the bag back to the
//:: henchman.
//:://////////////////////////////////////////////
//:: Created By: Pausanias/ Modified By: der_drakken
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
    object oItem, oBag;
    int    i;

    // Set the variables
    // This variable is checked for in dialogue. HenchmanInv = 1
    // means that the PC has the Henchman's inventory.
    SetLocalInt(OBJECT_SELF, "HenchmanInv", 1);
    SetAssociateState(NW_ASC_IS_BUSY,TRUE);

    // Give the PC a bag of holding.
    oBag = CreateItemOnObject("henchman_pack001",GetPCSpeaker(),1);

    // If PC is low-level, the bag sometimes wont' identify for some reason.
    SetIdentified(oBag,TRUE);

    // The script henchmanequip will have to refer to this bag, so create
    // a pointer to it.
    SetLocalObject(OBJECT_SELF,"HenchBag",oBag);
////////////////////////////////////////////////////////////////
    // First go through the backpack.

    //oItem = GetFirstItemInInventory(OBJECT_SELF);

    //while (oItem != OBJECT_INVALID) {
           //switch (GetBaseItemType(oItem)) {
            //case BASE_ITEM_ARMOR:
            //case BASE_ITEM_CLOAK:
            //case BASE_ITEM_BOOTS:
            //case BASE_ITEM_HELMET:
            //case BASE_ITEM_SMALLSHIELD:
            //case BASE_ITEM_LARGESHIELD:
            //case BASE_ITEM_TOWERSHIELD:
                //break;

            //default:
                //DelayCommand(0.2,ActionGiveItem(oItem,oBag));
                //break;
          //}

        //oItem = GetNextItemInInventory(OBJECT_SELF);
   //}
///////////////////////////////////////////////////////////////////////
    // Next go through all the equipped items. DO NOT transfer creature
    // items to the PC!
    ClearAllActions();

    for(i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oItem = GetItemInSlot(i,OBJECT_SELF);
        if (oItem != OBJECT_INVALID)
           switch (GetBaseItemType(oItem)) {
            //case BASE_ITEM_ARMOR:
            //case BASE_ITEM_CLOAK:
            //case BASE_ITEM_BOOTS:
            case BASE_ITEM_CREATUREITEM:
            case BASE_ITEM_CBLUDGWEAPON:
            case BASE_ITEM_CSLASHWEAPON:
            case BASE_ITEM_CSLSHPRCWEAP:
            case BASE_ITEM_CPIERCWEAPON:
            //case BASE_ITEM_HELMET:
            //case BASE_ITEM_SMALLSHIELD:
            //case BASE_ITEM_LARGESHIELD:
            //case BASE_ITEM_TOWERSHIELD:
                break;

            default:
                DelayCommand(0.2,ActionGiveItem(oItem,oBag));
                break;
          }
    }
    // Now for some decency: we don't want the henchman to stand there
    // all naked (do we????), so we create a nice monk's outfit.
    oItem = CreateItemOnObject("NW_CLOTH016",OBJECT_SELF,1);
    DelayCommand(0.2,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));

    // This will later be destroyed by the script henchmanequip, so
    // create a pointer to it.
    SetLocalObject(OBJECT_SELF,"Decency",oItem);
    SetAssociateState(NW_ASC_IS_BUSY,FALSE);
}
