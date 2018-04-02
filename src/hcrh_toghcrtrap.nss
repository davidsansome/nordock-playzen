#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "HCRTRAPS"))
    {
        SetLocalInt(oMod,"HCRTRAPS",0);
        SendMessageToPC(OBJECT_SELF,"HCRTRAPS system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"HCRTRAPS",1);
        SendMessageToPC(OBJECT_SELF,"HCRTRAPS system is now on.");
    }
}
