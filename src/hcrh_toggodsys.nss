#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "GODSYSTEM"))
    {
        SetLocalInt(oMod,"GODSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"GODSYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"GODSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"GODSYSTEM system is now on.");
    }
}
