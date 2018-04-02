int StartingConditional()
{
    object oMod = GetModule();
    SetLocalInt(oMod, "tru_rez_pos", 0);
    int nPC = 1;

    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if (GetTag(GetArea(oPC))=="FuguePlane")
        {
            SetCustomToken(42000 + nPC, GetName(oPC));
            SetLocalObject(oMod, "tru_rez_" + IntToString(nPC), oPC);
            nPC++;
        }
        oPC=GetNextPC();
    }
    while (nPC <= 12)
    {
        SetLocalObject(oMod, "tru_rez_" + IntToString(nPC), OBJECT_INVALID);
        nPC++;
    }

    return TRUE;
}
