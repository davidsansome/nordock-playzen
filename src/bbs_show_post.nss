#include "bbs_include"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    BBS_LoadMessage(oPC);

    return TRUE;
}
