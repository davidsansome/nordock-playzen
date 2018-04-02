int StartingConditional()
{
    if (GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), "KabuRing")))
        return TRUE;
    return FALSE;
}
