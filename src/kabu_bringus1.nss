int StartingConditional()
{
    object oPC = GetPCSpeaker();

    // Search the PC's inventory for the head
    object oObject = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oObject))
    {
        if (GetTag(oObject) == "HeadofBringus")
            return FALSE;
        oObject = GetNextItemInInventory(oPC);
    }

    return TRUE;
}
