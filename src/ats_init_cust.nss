#include "ats_inc_init"

void ats_init_cust()
{
    if (!GetLocalInt(GetModule(),"ats_cust"))
    {
        ExecuteScript("ats_recipes_cust", GetModule());
        PrintString("Initializing Custom Recipes");
        SetLocalInt(GetModule(),"ats_cust",TRUE);
    }
}
