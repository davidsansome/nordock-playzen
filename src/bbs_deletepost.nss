#include "bbs_include"

void main()
{
    object oPC = GetPCSpeaker();
    BBS_DeletePost(oPC);
}
