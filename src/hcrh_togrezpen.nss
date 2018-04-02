#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "REZPENALTY"))
    {
        SetLocalInt(oMod,"REZPENALTY",0);
        SendMessageToPC(OBJECT_SELF,"REZPENALTY system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"REZPENALTY",1);
        SendMessageToPC(OBJECT_SELF,"REZPENALTY system is now on.");
    }
}
