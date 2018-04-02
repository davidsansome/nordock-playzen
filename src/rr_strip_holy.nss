#include "nw_i0_tool"

void main()
{
    object oPC=OBJECT_SELF;
    object oItemToTake;
    if (HasItem(oPC,"SHighPri_NOD"))
    {
        oItemToTake = GetItemPossessedBy(oPC, "SHighPri_NOD");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        CreateItemOnObject("shighpri_nod",oPC);
    }
}
