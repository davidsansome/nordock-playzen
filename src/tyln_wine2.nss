int StartingConditional()
{
    object oPC = GetPCSpeaker();

    // Search the PC's inventory for the wine
    object oObject = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oObject))
    {
        if (GetTag(oObject) == "VintageTylnWine")
            return TRUE;
        oObject = GetNextItemInInventory(oPC);
    }

    return FALSE;
}
