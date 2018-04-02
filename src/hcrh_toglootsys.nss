#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "LOOTSYSTEM"))
    {
        SetLocalInt(oMod,"LOOTSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"LOOTSYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"LOOTSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"LOOTSYSTEM system is now on.");
    }
}
