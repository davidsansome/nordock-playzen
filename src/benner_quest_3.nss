#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iStage = GetLocalInt(oPC, "InmateBennerQuest");
    int iFinishedQuest = GPI(oPC, "InmateBennerFinished");
    if ((iStage == 1) && (iFinishedQuest != 1))
    {
        // Is the door unlocked?
        object oDoor = GetNearestObjectByTag("BrosnaCellDoorWest_Benner");
        if (GetLocked(oDoor) == FALSE)
            return FALSE;

        // Does the player have the key?
        if (GetIsObjectValid(GetItemPossessedBy(oPC, "BrosnaCellKeyWest")))
            return TRUE;
    }
    return FALSE;
}
