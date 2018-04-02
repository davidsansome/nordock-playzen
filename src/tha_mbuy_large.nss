#include "tha_housing_cost"
#include "rr_persist"

void main()
{
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(oPC,"large_house_key");

    if(oKey != OBJECT_INVALID)
    {
        DestroyObject(oKey);
        GiveGoldToCreature(oPC,((LARGE_HOUSE_COST/4)*3));
        SPI(oPC,"home_owner",FALSE);
    }
    return;
}

