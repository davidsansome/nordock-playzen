int StartingConditional()
{
    SetCustomToken(1100, "<c�  >[Chaotic]</c>");
    SetCustomToken(1101, "<c � >[Lawful]</c>");
    if (GetLocalInt(GetPCSpeaker(), "TaxCollectorStage") == 1)
        return TRUE;
    return FALSE;
}
