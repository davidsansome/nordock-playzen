#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "LOCKED"))
    {
        SetLocalInt(oMod,"LOCKED",0);
        SendMessageToPC(OBJECT_SELF,"The server is now Unlocked.");
    }
    else
    {
        SetLocalInt(oMod,"LOCKED",1);
        SendMessageToPC(OBJECT_SELF,"The server is now Locked.");
    }
}
