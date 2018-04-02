void main()
{
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        if (GetResRef(oItem) == "bloodstainednote")
            return;
        oItem = GetNextItemInInventory();
    }

    CreateItemOnObject("bloodstainednote");
}
