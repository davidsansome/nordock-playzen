int StartingConditional()
{
    int oHD = GetHitDice(GetPCSpeaker());
    int chcost = oHD * 100;
    SetCustomToken(1669,IntToString(chcost));
    return TRUE;
}
