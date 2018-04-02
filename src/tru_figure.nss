int StartingConditional()
{
    object oMod=GetModule();
    int rezcost=GetLocalInt(oMod,"TRUEREZCOST");
    SetCustomToken(6666,IntToString(rezcost));

    return TRUE;
}
