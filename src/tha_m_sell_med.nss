#include "tha_housing_cost"
#include "rr_persist"

void main()
{
    object oPC = GetPCSpeaker();

    int iGold = GetGold(oPC);

    if(iGold >= MED_HOUSE_COST)
    {
        TakeGoldFromCreature(MED_HOUSE_COST,oPC,TRUE);
        CreateItemOnObject("med_house_key",oPC);
        SPI(oPC,"home_owner",TRUE);
    }

    else
        FloatingTextStringOnCreature("You do not have enough gold for that!",oPC,FALSE);

    return;
}
