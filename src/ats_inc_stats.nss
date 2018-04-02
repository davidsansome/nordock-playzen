// Dependencies: ats_inc_common
#include "ats_inc_common"

// Trade skill stats

int ATS_GetSuccessCount(object oPlayer, string sTradeskillName)
{
    return ATS_GetPersistentInt(oPlayer, "ats_stat_success_count_" + sTradeskillName);
}

void ATS_IncrementSuccessCount(object oPlayer, string sTradeskillName)
{
    int iSuccesses = ATS_GetSuccessCount(oPlayer, sTradeskillName);
    ATS_SetPersistentInt(oPlayer, "ats_stat_success_count_" + sTradeskillName, ++iSuccesses);
}

int ATS_GetAttemptsCount(object oPlayer, string sTradeskillName)
{
    return ATS_GetPersistentInt(oPlayer, "ats_stat_attempts_count_" + sTradeskillName);
}

void ATS_IncrementAttemptsCount(object oPlayer, string sTradeskillName)
{
    int iAttempts = ATS_GetAttemptsCount(oPlayer, sTradeskillName);
    ATS_SetPersistentInt(oPlayer, "ats_stat_attempts_count_" + sTradeskillName, ++iAttempts);
}

float ATS_GetSuccessRate(object oPlayer, string sTradeskillName)
{
    int iSuccessCount = ATS_GetSuccessCount(oPlayer, sTradeskillName);
    int iTotalAttempts = ATS_GetAttemptsCount(oPlayer, sTradeskillName);
    if(iTotalAttempts == 0)
        return 0.0f;
    else
        return (IntToFloat(iSuccessCount) / IntToFloat(iTotalAttempts));
}



