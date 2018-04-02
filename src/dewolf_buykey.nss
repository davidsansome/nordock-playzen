#include "rr_persist"

void main()
{
    object oPC = GetPCSpeaker();

    int iGold = GetGold(oPC);
    if (iGold < 150)
    {
        FloatingTextStringOnCreature("*Not enough gold*", oPC);
        return;
    }

    TakeGoldFromCreature(150, oPC, TRUE);
    int iFunds = GPI(GetModule(), "DeWolfBrothelGold");
    SPI(GetModule(), "DeWolfBrothelGold", iFunds+150);

    CreateItemOnObject("dewolf_memberkey", oPC);
}
