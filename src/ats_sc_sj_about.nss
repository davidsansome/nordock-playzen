#include "ats_const_common"

int StartingConditional()
{
    SetCustomToken(500, "\n");
    SetCustomToken(49999, FloatToString(CFLOAT_VERSION_NUMBER, 3, 2));
    return TRUE;
}
