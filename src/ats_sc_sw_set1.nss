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
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");

    int iAdjustValue = GetLocalInt(oDM, "ats_sw_adjust_value");
    int iMaxValue = ATS_GetMaxSkill(sSkillName);

    if(iAdjustValue > iMaxValue)
    {
        SetLocalInt(oDM, "ats_sw_adjust_value", iMaxValue);
        SetCustomToken(65001, GetName(oTarget));
        SetCustomToken(65002, sSkillName);
        SetCustomToken(65004, IntToString(iMaxValue));
        return FALSE;
    }
    SetCustomToken(65001, GetName(oTarget));
    SetCustomToken(65002, sSkillName);
    SetCustomToken(65004, IntToString(iAdjustValue));

    return TRUE;

}
