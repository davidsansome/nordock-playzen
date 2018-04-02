#include "bbs_include"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "BBS_Pos", 0);
}
