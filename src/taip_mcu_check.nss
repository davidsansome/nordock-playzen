int StartingConditional()
{
    int iResult,iGold;

    iGold = GetGold(GetPCSpeaker());
    if (iGold >= 500000) iResult = 1;
    else iResult = 0;
    return iResult;
}
