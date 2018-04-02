#include "ats_config"
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_inc_common"
#include "ats_const_skill"
#include "ats_inc_skill"
#include "ats_inc_stats"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    int iSkillNumber = GetLocalInt(GetPCSpeaker(), "ats_sj_select_skill");
    string sSkillName;

    if(GetLocalInt(GetPCSpeaker(), "ats_sj_display_primaryskills") == TRUE)
    {
        sSkillName = ATS_GetPrimarySkillName(iSkillNumber);
    }
    else
    {
        sSkillName = ATS_GetSecondarySkillName(iSkillNumber);
    }

    int iSkillValue = ATS_GetTradeskill(oPlayer, sSkillName);
    // Skill Name
    SetCustomToken(45000, sSkillName);
    // Skill Description
    SetCustomToken(45001 , ATS_GetSkillDescription(sSkillName));
    // Skill Value
    SetCustomToken(45002, IntToString(iSkillValue));
    // Skill Max Value
    SetCustomToken(45003, IntToString(ATS_GetMaxSkill(sSkillName)));
    // Skill Rank
    SetCustomToken(45004, ATS_GetSkillRankName(iSkillValue));
    if(ATS_IsSkillValueMasterLevel(iSkillValue) == TRUE)
    {
        SetCustomToken(45005, "Apprentice");
        // For now, no apprenticeship
        SetCustomToken(45006, "None");
    }
    else
    {
        SetCustomToken(45005, "Mentor");
        SetCustomToken(45006, "None");
    }
    SetCustomToken(45007, IntToString(ATS_GetSuccessCount(oPlayer, sSkillName)));
    SetCustomToken(45008, FloatToString(ATS_GetSuccessRate(oPlayer, sSkillName)*100, 3, 1));
    SetCustomToken(45009, IntToString(ATS_GetAttemptsCount(oPlayer, sSkillName)));
    SetCustomToken(500, "\n");

    return TRUE;
}
