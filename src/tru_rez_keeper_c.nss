int StartingConditional()
{
    if (GetLocalInt(GetPCSpeaker(), "ResurrectionType") == 0)
        return FALSE;
    return TRUE;
}
