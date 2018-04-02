void main()
{
    if (GetLocalInt(OBJECT_SELF, "SpawnedBottles") != 1)
    {
        CreateItemOnObject("NW_IT_MPOTION023", OBJECT_SELF, d6());
        CreateItemOnObject("house_ale", OBJECT_SELF, d6());
        SetLocalInt(OBJECT_SELF, "SpawnedBottles", 1);
    }

    // Clean any empty bottles from the chest
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "NW_IT_THNMISC001")
            DestroyObject(oItem);
        oItem = GetNextItemInInventory();
    }

    // Create 10 empty bottles
    CreateItemOnObject("NW_IT_THNMISC001", OBJECT_SELF, 10);
}

