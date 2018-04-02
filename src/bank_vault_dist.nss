#include "bank_inc"

void main()
{
    object oPC = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    int iAction = GetInventoryDisturbType();

    if(iAction == INVENTORY_DISTURB_TYPE_ADDED)
        AddPersistentItem(oPC, OBJECT_SELF, oItem);
    else if(iAction == INVENTORY_DISTURB_TYPE_REMOVED)
        RemovePersistentItem(oPC, oItem);
}
