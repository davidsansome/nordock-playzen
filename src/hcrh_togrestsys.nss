#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "RESTSYSTEM"))
    {
        SetLocalInt(oMod,"RESTSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"RESTSYSTEM system is now turned entirely off.");
    }
    else
    {
        SetLocalInt(oMod,"RESTSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"RESTSYSTEM system is now turned on.");
    }
}
