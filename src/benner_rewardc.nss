#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GPI(oPC, "InmateBennerReward") != 2)
        return FALSE;

    GiveGoldToCreature(oPC, 200);
    GiveXPToCreature(oPC, 400);
    CreateItemOnObject("house_ale", oPC, 2);
    SPI(oPC, "InmateBennerReward", 1);

    return TRUE;
}
