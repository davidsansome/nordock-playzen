int StartingConditional()
{
    object oMod = GetModule();

    int iPos = GetLocalInt(oMod, "tru_rez_pos");
    iPos++;
    SetLocalInt(oMod, "tru_rez_pos", iPos);

    return GetIsObjectValid(GetLocalObject(oMod, "tru_rez_" + IntToString(iPos)));
}
