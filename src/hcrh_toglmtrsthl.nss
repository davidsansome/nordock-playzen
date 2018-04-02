#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "LIMITEDRESTHEAL"))
    {
        SetLocalInt(oMod,"LIMITEDRESTHEAL",0);
        SendMessageToPC(OBJECT_SELF,"LIMITEDRESTHEAL system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"LIMITEDRESTHEAL",1);
        SendMessageToPC(OBJECT_SELF,"LIMITEDRESTHEAL system is now on.");
    }
}
