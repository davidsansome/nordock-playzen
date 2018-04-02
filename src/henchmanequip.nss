//::///////////////////////////////////////////////
//:: FileName henchmanequip      v 0.6
//:://////////////////////////////////////////////
//:: This script will store all the objects possessed by the PC
//:: in an object array. It will then delete the Bag of Holding
//:: given the PC by the henchman. All objects in the bag of
//:: holding will be in limbo, useful for identifying them as
//:: having been inside a bag of holding. The script then ends,
//:: waiting for the conversation to call "henchmanfinish" so
//:: that the henchman will actually start putting on the items.
//:://////////////////////////////////////////////
//:: Created By: Pausanias (c) 2002
//::
//:://////////////////////////////////////////////

#include "paus_inc_generic"
#include "PAUS_I0_ARRAY"

void main()
{
    object oBag, oItem, oPC, oSelf, oNew;
    int    i, iIdent;

    oSelf = OBJECT_SELF;
    oPC = GetPCSpeaker();

    DeleteLocalInt(OBJECT_SELF, "HenchmanInv");

    // This is the bag created by the henchmanmanage script.
    oBag = GetLocalObject(OBJECT_SELF,"HenchBag");

    SetAssociateState(NW_ASC_IS_BUSY,TRUE);
    if (oBag != OBJECT_INVALID)
    {
        // Go through all the bag's items

        oItem = GetFirstItemInInventory(oBag);
        while (oItem != OBJECT_INVALID)
        {
            // Copy the item to me
            object oNewItem = CopyItem(oItem, OBJECT_SELF, TRUE);
            DestroyObject(oItem);

            switch (GetBaseItemType(oNewItem))
            {
            case BASE_ITEM_AMULET:
                ActionEquipItem(oNewItem, INVENTORY_SLOT_NECK); break;
            case BASE_ITEM_BELT:
                ActionEquipItem(oNewItem, INVENTORY_SLOT_BELT); break;
            case BASE_ITEM_BOOTS:
                ActionEquipItem(oNewItem, INVENTORY_SLOT_BOOTS); break;
            case BASE_ITEM_BRACER:
            case BASE_ITEM_GLOVES:
                ActionEquipItem(oNewItem, INVENTORY_SLOT_ARMS); break;
            case BASE_ITEM_CLOAK:
                ActionEquipItem(oNewItem, INVENTORY_SLOT_CLOAK); break;
            case BASE_ITEM_HELMET:
                ActionEquipItem(oNewItem, INVENTORY_SLOT_HEAD); break;
            case BASE_ITEM_RING:
                if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTRING)))
                    ActionEquipItem(oNewItem, INVENTORY_SLOT_LEFTRING);
                else if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTRING)))
                    ActionEquipItem(oNewItem, INVENTORY_SLOT_RIGHTRING);
                break;
            case BASE_ITEM_SMALLSHIELD:
            case BASE_ITEM_LARGESHIELD:
            case BASE_ITEM_TOWERSHIELD:
                ActionEquipItem(oNewItem, INVENTORY_SLOT_RIGHTHAND); break;
            }

            oItem = GetNextItemInInventory(oBag);
        }

        // Equip best armor and weapon
        ActionEquipMostDamagingRanged();
        ActionEquipMostEffectiveArmor();

        // Destroy robe if it exists
        object oDecency = GetLocalObject(OBJECT_SELF,"Decency");
        if (GetIsObjectValid(oDecency))
            DestroyObject(oDecency);

        // Destroy the bag
        DestroyObject(oBag);
    }
    SetAssociateState(NW_ASC_IS_BUSY,FALSE);
}
