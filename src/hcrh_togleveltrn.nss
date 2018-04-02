#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "LEVELTRAINER"))
    {
        SetLocalInt(oMod,"LEVELTRAINER",0);
        SendMessageToPC(OBJECT_SELF,"LEVELTRAINER system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"LEVELTRAINER",1);
        SendMessageToPC(OBJECT_SELF,"LEVELTRAINER system is now on.");
    }
}
