#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "RESTARMORPEN"))
    {
        SetLocalInt(oMod,"RESTARMORPEN",0);
        SendMessageToPC(OBJECT_SELF,"RESTARMORPEN system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"RESTARMORPEN",1);
        SendMessageToPC(OBJECT_SELF,"RESTARMORPEN system is now on.");
    }
}
