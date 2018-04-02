int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "CanUseNewbieStore") == 1))
        return FALSE;

    return TRUE;
}
