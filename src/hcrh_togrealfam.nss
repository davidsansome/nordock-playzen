#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "REALFAM"))
    {
        SetLocalInt(oMod,"REALFAM",0);
        SendMessageToPC(OBJECT_SELF,"REALFAM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"REALFAM",1);
        SendMessageToPC(OBJECT_SELF,"REALFAM system is now on.");
    }
}
