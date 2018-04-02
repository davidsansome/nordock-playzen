int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "TylnTargetType") != 3)
        return FALSE;

    return TRUE;
}
