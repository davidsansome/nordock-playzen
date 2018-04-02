#include "rr_persist"
#include "journal_include"

void main()
{
    object oBenner = GetNearestObjectByTag("InmateRicky");
    object oBennerDoor = GetNearestObjectByTag("BrosnaCellDoorWest_Benner");
    object oPC = GetPCSpeaker();

    GiveXPToCreature(oPC, 500);
    dhAddJournalQuestEntry("benner", 2, oPC, FALSE, FALSE, FALSE, TRUE);
    AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 10);
    SPI(oPC, "InmateBennerFinished", 1);

    SetLocked(oBennerDoor, FALSE);

    ActionMoveToObject(oBennerDoor, TRUE);
    ActionOpenDoor(oBennerDoor);

    if (GetIsObjectValid(oBenner))
    {
        ActionSpeakString("You're not going to escape this time benner!");
        ActionAttack(oBenner);
    }
    else
    {
        ActionSpeakString("No!  He's gone!");
        ActionCloseDoor(oBennerDoor);
    }
}
