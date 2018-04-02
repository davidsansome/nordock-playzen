#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "DEATHSYSTEM"))
    {
        SetLocalInt(oMod,"DEATHSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"DEATHSYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"DEATHSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"DEATHSYSTEM system is now on.");
    }
}
