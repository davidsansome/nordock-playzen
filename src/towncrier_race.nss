int StartingConditional()
{
    string sSubrace = GetStringLowerCase(GetSubRace(GetPCSpeaker()));

    if ((sSubrace == "drow") || (sSubrace == "duergar"))
        return TRUE;

    return FALSE;
}
