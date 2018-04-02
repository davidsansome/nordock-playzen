#include "rr_persist"

void main()
{
    object oPC = GetPCSpeaker();
    object oNecklace = GetItemPossessedBy(oPC, "KabuNecklace");
    if (GetIsObjectValid(oNecklace))
    {
        GiveXPToCreature(oPC, 400);
        DestroyObject(oNecklace);
        SPI(oPC, "KabuInnStage", 2);
    }
}
