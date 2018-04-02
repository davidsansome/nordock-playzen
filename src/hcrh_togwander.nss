#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "WANDERSYSTEM"))
    {
        SetLocalInt(oMod,"WANDERSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"WANDERSYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"WANDERSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"WANDERSYSTEM system is now on.");
    }
}
