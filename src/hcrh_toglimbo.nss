#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "LIMBO"))
    {
        SetLocalInt(oMod,"LIMBO",0);
        SendMessageToPC(OBJECT_SELF,"LIMBO system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"LIMBO",1);
        SendMessageToPC(OBJECT_SELF,"LIMBO system is now on.");
    }
}
