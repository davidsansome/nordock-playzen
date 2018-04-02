int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "TylnTargetType") != 1)
        return FALSE;

    object oTarget = GetLocalObject(GetPCSpeaker(), "TylnTarget");
    SetCustomToken(1000, GetName(oTarget));
    return TRUE;
}
