int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetIsDM(oPC) || GetIsDM(GetMaster(oPC)))
        return TRUE;
    return FALSE;
}
