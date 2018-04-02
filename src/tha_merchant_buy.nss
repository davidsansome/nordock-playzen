#include "tha_housing_cost"

object GetKey(object oPC, string tag);

void main()
{
    object oPC = GetPCSpeaker();

    object oKey = GetKey(oPC,"small");
    if(oKey != OBJECT_INVALID)
    {
        DestroyObject(oKey);
        GiveGoldToCreature(oPC,(SMALL_HOUSE_COST/3)*2);

        return;
    }

    oKey = GetKey(oPC,"med");
    if(oKey != OBJECT_INVALID)
    {
        DestroyObject(oKey);
        GiveGoldToCreature(oPC,(MED_HOUSE_COST/3)*2);

        return;
    }

    oKey = GetKey(oPC,"large");
    if(oKey != OBJECT_INVALID)
    {
        DestroyObject(oKey);
        GiveGoldToCreature(oPC,(LARGE_HOUSE_COST/3)*2);

        return;
    }



}

object GetKey(object oPC, string tag)
{
    return GetItemPossessedBy(oPC,tag+"_house_key");
}
