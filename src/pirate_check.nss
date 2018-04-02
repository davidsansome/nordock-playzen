#include "nw_i0_tool"

int StartingConditional()
{
    if (HasItem(GetPCSpeaker(), "pirateguildring2"))
        return TRUE;
    return FALSE;
}
