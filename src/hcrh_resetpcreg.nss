#include "hc_inc_helper"

void main()
{
    if(!GetLocalInt(oMod,"SINGLECHARACTER"))
    {
        SendMessageToPC(OBJECT_SELF,"This is not a single player server.");
        return;
    }
    DeletePersistentString(oMod,"SINGLECHARACTER"+GetPCPublicCDKey(oMyTarget));
    BootPC(oMyTarget);
    SendMessageToPC(OBJECT_SELF,"That player is reset.");
}
