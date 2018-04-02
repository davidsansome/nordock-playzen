int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "BBSCurrentSelection_" + GetTag(OBJECT_SELF)) == 0)
        return FALSE;

    if (GetIsDM(oPC))
        return TRUE;

    if (GetIsDM(GetMaster(oPC)))
        return TRUE;

    return FALSE;
}
