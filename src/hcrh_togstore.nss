#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "STORESYSTEM"))
    {
        SetLocalInt(oMod,"STORESYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"STORESYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"STORESYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"STORESYSTEM system is now on.");
    }
}
