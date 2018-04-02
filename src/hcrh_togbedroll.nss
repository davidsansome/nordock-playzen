#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "BEDROLLSYSTEM"))
    {
        SetLocalInt(oMod,"BEDROLLSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"BEDROLLSYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"RESTSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"BEDROLLSYSTEM system is now on.");
    }
}
