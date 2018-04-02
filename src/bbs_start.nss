#include "bbs_include"

void main()
{
    object oPC = GetLastUsedBy();
    SetLocalInt(oPC, "BBS_Page", 0);
    BBS_LoadMessageList(oPC);

    ActionStartConversation(oPC, "", TRUE);
}
