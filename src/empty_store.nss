void main()
{
    object oTrashCan = OBJECT_SELF;

    object oItemInTrash = GetFirstItemInInventory(oTrashCan);
    while(GetIsObjectValid(oItemInTrash) == TRUE)
    {
        DestroyObject(oItemInTrash);
        oItemInTrash = GetNextItemInInventory(oTrashCan);
    }
}

