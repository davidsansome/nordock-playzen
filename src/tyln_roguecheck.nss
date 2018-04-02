int StartingConditional()
{
    // Only show store to rogues
    if (GetLevelByClass(CLASS_TYPE_ROGUE, GetPCSpeaker()) > 0)
        return TRUE;
    return FALSE;
}
