// Checks for available gold to complete transaction.
int StartingConditional()
{

    // Inspect local variables
    if(!(GetGold(GetPCSpeaker()) > 1000))
        return FALSE;

    return TRUE;
}
