int StartingConditional()
{
    int iResult;
// if they are not level 15 then this results in FALSE
    iResult = (GetHitDice(GetPCSpeaker())>14);
    return iResult;
}
