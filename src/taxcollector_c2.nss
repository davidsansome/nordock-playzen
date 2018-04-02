int StartingConditional()
{
    SetCustomToken(1100, "<cþ  >[Chaotic]</c>");
    SetCustomToken(1101, "<c þ >[Lawful]</c>");
    if (GetLocalInt(GetPCSpeaker(), "TaxCollectorStage") == 1)
        return TRUE;
    return FALSE;
}
