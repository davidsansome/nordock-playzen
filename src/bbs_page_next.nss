#include "bbs_include"

void main()
{
    object oPC = GetPCSpeaker();
    int iPage = GetLocalInt(oPC, "BBS_Page");
    SetLocalInt(oPC, "BBS_Page", iPage+1);
    BBS_LoadMessageList(oPC);
}
