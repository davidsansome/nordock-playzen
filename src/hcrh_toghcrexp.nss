#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "HCREXP"))
    {
        SetLocalInt(oMod,"HCREXP",0);
        SendMessageToPC(OBJECT_SELF,"HCREXP system is now turned off.");
    }
    else
    {
        SetLocalInt(oMod,"HCREXP",1);
        SendMessageToPC(OBJECT_SELF,"HCREXP system is now turned on.");
    }
}
