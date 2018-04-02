#include "ats_config"
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_inc_common"
#include "ats_const_skill"
#include "ats_inc_skill"

int StartingConditional()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName;
    SetLocalInt(oDM, "ats_sw_display_count", 0);
    SetCustomToken(65001, GetName(oTarget));
    //Used same script for Skill Journal to select skill so we need to fetch
    // from this variable
    int iSkillConstant = GetLocalInt(oDM, "ats_sj_select_skill");
    if(GetLocalInt(GetPCSpeaker(), "ats_sw_display_primaryskills") == TRUE)
    {
        sSkillName = ATS_GetPrimarySkillName(iSkillConstant);
    }
    else
    {
        sSkillName = ATS_GetSecondarySkillName(iSkillConstant);
    }
    SetLocalString(oDM, "ats_sw_current_skill", sSkillName);

    SetCustomToken(65002, sSkillName);
    SetCustomToken(65003, IntToString(ATS_GetTradeskill(oTarget, sSkillName)));
    SetCustomToken(65004, IntToString(GetLocalInt(oDM, "ats_sw_adjust_value")));

    return TRUE;

}
