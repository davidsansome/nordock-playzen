int StartingConditional()
{
    int iResult;
    int oHD = GetHitDice(GetPCSpeaker());

    iResult = (GetGold(GetPCSpeaker())< oHD * 200);

    return iResult;
}
