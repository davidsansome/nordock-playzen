int StartingConditional()
{
    int iResult;

    iResult = GetGold(GetPCSpeaker())>=GetLocalInt(GetModule(),"TRUEREZCOST");
    return iResult;
}
