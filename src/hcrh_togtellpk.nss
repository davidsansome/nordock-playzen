#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "TELLONPK"))
    {
        SetLocalInt(oMod,"TELLONPK",0);
        SendMessageToPC(OBJECT_SELF,"TELLONPK system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"TELLONPK",1);
        SendMessageToPC(OBJECT_SELF,"TELLONPK system is now on.");
    }
}
