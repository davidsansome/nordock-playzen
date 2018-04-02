int StartingConditional()
{
    string sSubrace = GetStringLowerCase(GetSubRace(GetPCSpeaker()));

    if ((sSubrace == "drow") || (sSubrace == "duergar") || GetIsDM(GetPCSpeaker()))
        return FALSE;

    return TRUE;
}
