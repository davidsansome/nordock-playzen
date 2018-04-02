#include "ats_config"
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_inc_common"
#include "ats_const_skill"
#include "ats_inc_skill"

int StartingConditional()
{
    SetLocalInt(GetPCSpeaker(), "ats_sj_display_count", 0);
    int iSkillTotal;
    int bPrimarySkillDisp = GetLocalInt(GetPCSpeaker(), "ats_sj_display_primaryskills");
    if(bPrimarySkillDisp == TRUE)
        iSkillTotal = ATS_GetPrimarySkillTotal(GetPCSpeaker());
    else
        iSkillTotal = ATS_GetSecondarySkillTotal(GetPCSpeaker());
    SetCustomToken(49990, IntToString(iSkillTotal));
    return TRUE;
}
