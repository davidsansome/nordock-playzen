void main()
{
    object oTrashCan = OBJECT_SELF;
    object oPlayer = GetPCSpeaker();

    object oItemInTrash = GetFirstItemInInventory(oTrashCan);
    while(GetIsObjectValid(oItemInTrash) == TRUE)
    {
        DestroyObject(oItemInTrash);
        oItemInTrash = GetNextItemInInventory(oTrashCan);
    }
}
