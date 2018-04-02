void ClearSlot(int iSlotID)
{
    object oItem = GetItemInSlot(iSlotID);
    if (GetDroppableFlag(oItem) == FALSE)
    {
        DestroyObject(oItem);
    }
}
void main()
{
    SetIsDestroyable(FALSE, FALSE, FALSE);
    // Destroy all non droppable equipped slots
    int iSlotID;
    for (iSlotID = 0; iSlotID < NUM_INVENTORY_SLOTS; iSlotID++)
    {
        ClearSlot(iSlotID);
    }
    // Destroy all non droppable inventory items
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem) == TRUE)
    {
        if (GetDroppableFlag(oItem) == FALSE)
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory();
    }
    // Destroy or kill creature
    DelayCommand(6.0, SetIsDestroyable(TRUE, FALSE, TRUE));
}

