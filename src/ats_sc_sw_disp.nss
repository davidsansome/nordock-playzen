#include "ats_config"
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_inc_common"
#include "ats_inc_textform"
#include "ats_const_skill"
#include "ats_inc_skill"

int StartingConditional()
{
    object oDM = GetPCSpeaker();
    object oPlayer = GetLocalObject(oDM, "ats_item_target");
    int iDisplayCount = GetLocalInt(oDM, "ats_sw_display_count");
    string sSkillName;
    SetLocalInt(GetPCSpeaker(), "ats_sw_display_count", ++iDisplayCount);

    if(GetLocalInt(GetPCSpeaker(), "ats_sw_display_primaryskills") == TRUE)
    {
        sSkillName = ATS_GetPrimarySkillName(iDisplayCount);
    }
    else
    {
        sSkillName = ATS_GetSecondarySkillName(iDisplayCount);
    }
    if(sSkillName == "")
        return FALSE;
    int iStringLength = GetLocalInt(GetModule(), "ats_skillname_width_" + sSkillName);

    int iSkillValue = ATS_GetTradeskill(oPlayer, sSkillName);
    SetCustomToken(49000 + iDisplayCount, sSkillName + ATS_GetPeriodString(100 - iStringLength));
    SetCustomToken(49200 + iDisplayCount, IntToString(iSkillValue));
    SetCustomToken(49300 + iDisplayCount, IntToString(ATS_GetMaxSkill(sSkillName)));

    return TRUE;
}
