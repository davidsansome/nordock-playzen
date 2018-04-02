#include "ats_config"

int StartingConditional()
{
    SetLocalInt(GetPCSpeaker(), "ats_sj_display_count", 0);
    if(CBOOL_SJ_NUMERIC_DISPLAY == FALSE)
        return TRUE;
    else
        return FALSE;
}
