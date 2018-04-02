#include "rr_persist"

int StartingConditional()
{
    if (GPI(GetPCSpeaker(), "TaxCollectorCompleted") == 1)
        return FALSE;
    if (GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), "DibblesTaxMoney")))
        return FALSE;
    return TRUE;
}
