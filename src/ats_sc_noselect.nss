#include "ats_inc_menu"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    if( ATS_GetMakeableCount(oPlayer) == 0 )
        return TRUE;
    else
        return FALSE;
}
