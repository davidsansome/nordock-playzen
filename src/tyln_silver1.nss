#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int iAlreadyDone = GPI(oPC, "TylnSilverwareCompleted");
    if (iAlreadyDone == 1)
        return FALSE;

    // Search the PC's inventory for the silverware
    object oObject = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oObject))
    {
        if (GetTag(oObject) == "TylnSilverware")
            return FALSE;
        oObject = GetNextItemInInventory(oPC);
    }

    return TRUE;
}
