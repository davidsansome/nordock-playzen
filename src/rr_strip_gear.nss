#include "nw_i0_tool"

void main()
{
    object oPC=OBJECT_SELF;
    object oItemToTake;

    // white crafted armor
    if (HasItem(oPC,"ATS_C_T401_N_C17"))
    {
        oItemToTake = GetItemPossessedBy(oPC, "ATS_C_T401_N_C17");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        CreateItemOnObject("ats_c_t401_n_c17",oPC);
    }
    // white boots
    if (HasItem(oPC,"ATS_C_T001_N_C17"))
    {
        oItemToTake = GetItemPossessedBy(oPC, "ATS_C_T001_N_C17");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        CreateItemOnObject("ats_c_t001_n_c17",oPC);
    }
}
