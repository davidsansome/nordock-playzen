#include "bbs_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oNotice = GetItemPossessedBy(oPC, "bbs_notice");
    BBS_NewPost(oPC, oNotice);
}
