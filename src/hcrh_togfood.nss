#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "FOODSYSTEM"))
    {
        SetLocalInt(oMod,"FOODSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"FOODSYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"FOODSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"FOODSYSTEM system is now on.");
    }
}
