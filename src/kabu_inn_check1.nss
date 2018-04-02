int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "KabuNecklace")))
        return TRUE;
    return FALSE;
}
