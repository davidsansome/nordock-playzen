#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "SINGLECHARACTER"))
    {
        SetLocalInt(oMod,"SINGLECHARACTER",0);
        SendMessageToPC(OBJECT_SELF,"SINGLECHARACTER system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"SINGLECHARACTER",1);
        SendMessageToPC(OBJECT_SELF,"SINGLECHARACTER system is now on.");
    }
}
