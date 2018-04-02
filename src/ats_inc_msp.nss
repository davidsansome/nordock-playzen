// Dependencies: ats_inc_common, ats_inc_material, ats_const_mat, ats_config

#include "ats_inc_common"
#include "ats_inc_material"
#include "ats_const_mat"
#include "ats_config"

// Function Declarations
void ATS_InitMiningSpawnConfig(object oMiningSpawnWP);
int ATS_AssignMiningSpawnConfig(object oMiningSpawnWP, string sConfigString);
void ATS_SpawnMineableRock(object oSpawnPoint, location lSpawnLocation);
void ATS_TriggerMiningSpawn(object oSpawnPoint);
void ATS_RefreshMiningSpawn(object oSpawnPoint);

void ATS_InitMiningSpawnConfig(object oMiningSpawnWP)
{
    SetLocalInt(oMiningSpawnWP, "ats_msp_MST", CINT_MSP_DEFAULT_MST);
    SetLocalInt(oMiningSpawnWP, "ats_msp_XST", CINT_MSP_DEFAULT_XST);
    SetLocalInt(oMiningSpawnWP, "ats_msp_FRS", CINT_MSP_DEFAULT_FRS);
    SetLocalInt(oMiningSpawnWP, "ats_msp_CLU", 0);
    SetLocalInt(oMiningSpawnWP, "ats_msp_CRS", FALSE);
    SetLocalInt(oMiningSpawnWP, "ats_msp_DST", CINT_MSP_DEFAULT_DST);
    SetLocalInt(oMiningSpawnWP, "ats_msp_DUR", CINT_MSP_DEFAULT_DUR);
    SetLocalInt(oMiningSpawnWP, "ats_msp_material_count", 0);

}


int ATS_AssignMiningSpawnConfig(object oMiningSpawnWP, string sConfigString)
{
    string sToken;
    string sSwitch;
    int iValue = 0;
    int iMaterialCount = 0;
    int iMaterialDurability;


    sToken = ATS_StrTok(sConfigString, "_");
    if(sToken != "MSP")
    {
        DEBUG_PrintString("Error: Invalid Mining Spawn Point Tag");
        return FALSE;
    }
    while(sToken != "")
    {
        sSwitch = GetStringLeft(sToken, 3);
        iValue = StringToInt(GetStringRight(sToken, GetStringLength(sToken) - 3));
        iMaterialCount = GetLocalInt(oMiningSpawnWP, "ats_msp_material_count");

        if(sSwitch == "MST" || sSwitch == "XST" || sSwitch == "CLU" ||
           sSwitch == "DST" || sSwitch == "FRS")
        {
            DEBUG_PrintString(sSwitch + ": " + IntToString(iValue));
            SetLocalInt(oMiningSpawnWP, "ats_msp_" + sSwitch, iValue);
        }
        else if(sSwitch == "CRS")
        {
                DEBUG_PrintString(sSwitch + ": TRUE");
                SetLocalInt(oMiningSpawnWP, "ats_msp_" + sSwitch, TRUE);
        }
        else if(sSwitch == "DUR")
        {
            DEBUG_PrintString(sSwitch + ": " + IntToString(iValue));

            if(iMaterialCount > 0)
                SetLocalInt(oMiningSpawnWP, "ats_msp_material_" + IntToString(iMaterialCount) + "_" + sSwitch, iValue);
            else
                SetLocalInt(oMiningSpawnWP, "ats_msp_" + sSwitch, iValue);
        }
        else if(ATS_GetMaterialTypeFromTag(sSwitch) != CINT_MATERIAL_UNKNOWN)
        {
            DEBUG_PrintString(sSwitch + ": " + IntToString(iValue));

            SetLocalInt(oMiningSpawnWP, "ats_msp_material_count", ++iMaterialCount);
            SetLocalString(oMiningSpawnWP, "ats_msp_material_" + IntToString(iMaterialCount), sSwitch);
            SetLocalInt(oMiningSpawnWP, "ats_msp_material_" + IntToString(iMaterialCount) + "_chance", iValue);
            iMaterialDurability = GetLocalInt(oMiningSpawnWP, "ats_msp_DUR");
            SetLocalInt(oMiningSpawnWP, "ats_msp_material_" + IntToString(iMaterialCount) + "_DUR", iMaterialDurability);

        }
        sToken = ATS_StrTok("", "_");
    }

    return TRUE;

}

void ATS_TriggerMiningSpawn(object oSpawnPoint)
{
    int iMaxClusterSize = GetLocalInt(oSpawnPoint, "ats_msp_CLU");
    int iNumRocks = GetLocalInt(oSpawnPoint, "ats_msp_totalrocks");
    int iMaxDistance = GetLocalInt(oSpawnPoint, "ats_msp_DST");

    SetLocalInt(oSpawnPoint, "ats_msp_initialized", TRUE);
    SetLocalInt(oSpawnPoint, "ats_msp_refreshdone", TRUE);

    if(iMaxClusterSize == 0 && iNumRocks == 0)
    {
        ATS_SpawnMineableRock(oSpawnPoint, GetLocation(oSpawnPoint));
    }
    else
    {
        while(iNumRocks < iMaxClusterSize)
        {
            ++iNumRocks;
            ATS_SpawnMineableRock(oSpawnPoint,
                                 ATS_GetRandomLocationNearObject(oSpawnPoint, iMaxDistance));
            while(GetLocalInt(oSpawnPoint, "ats_msp_spawn_invalid") == TRUE &&
                  GetLocalInt(oSpawnPoint, "ats_msp_spawn_attempt") < 5)
            {
                 ATS_SpawnMineableRock(oSpawnPoint,
                                     ATS_GetRandomLocationNearObject(oSpawnPoint, iMaxDistance));
            }

        }
    }
    int iForcedRespawnTime = GetLocalInt(oSpawnPoint, "ats_msp_FRS");
    if( iForcedRespawnTime > 0)
    {
        AssignCommand(GetArea(oSpawnPoint), DelayCommand(IntToFloat(iForcedRespawnTime),
                                   ATS_RefreshMiningSpawn(oSpawnPoint)));

    }
}

void ATS_RefreshMiningSpawn(object oSpawnPoint)
{
    int iNumRocks = GetLocalInt(oSpawnPoint, "ats_msp_totalrocks");
    object oCurrentRock;

    SetLocalInt(oSpawnPoint, "ats_msp_refreshdone", FALSE);

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),
                           GetLocation(oSpawnPoint), 1.0);
    while(iNumRocks > 0)
    {
        oCurrentRock = GetLocalObject(oSpawnPoint, "ats_msp_rock_" + IntToString(iNumRocks));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oCurrentRock);
        --iNumRocks;
    }

    AssignCommand(GetArea(oSpawnPoint), DelayCommand(1.0,ATS_TriggerMiningSpawn(oSpawnPoint)));

}

void ATS_SpawnMineableRock(object oSpawnPoint, location lSpawnLocation)
{
    int iChanceTotal = 0;
    int iChanceToSpawn;
    int iMaterialCount = GetLocalInt(oSpawnPoint, "ats_msp_material_count");
    int iMaterialType = 0;
    int iMaterialDurability = GetLocalInt(oSpawnPoint, "ats_msp_DUR");
    int iMaxClusterSize = GetLocalInt(oSpawnPoint, "ats_msp_CLU");
    int iTotalRocks = GetLocalInt(oSpawnPoint, "ats_msp_totalrocks");
    int iSpawnAttempt;
    int iDiceRoll = d100(1);


    SetLocalInt(oSpawnPoint, "ats_msp_spawn_invalid", FALSE);
    if(iMaxClusterSize > 0 && iTotalRocks >= iMaxClusterSize)
        return;

    DEBUG_PrintString("Attempting to Spawn Rock...");
    object oNearestObject = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lSpawnLocation);

    if(oNearestObject != OBJECT_INVALID && GetDistanceBetweenLocations(GetLocation(oNearestObject), lSpawnLocation) < 0.1f)
    {
        iSpawnAttempt = GetLocalInt(oSpawnPoint, "ats_msp_spawn_attempt") + 1;
        SetLocalInt(oSpawnPoint, "ats_msp_spawn_attempt", iSpawnAttempt);
        SetLocalInt(oSpawnPoint, "ats_msp_spawn_invalid", TRUE);
        return;
    }
    object oMineableRock = CreateObject(OBJECT_TYPE_PLACEABLE, "ats_mrock_basic", lSpawnLocation, TRUE);

    if(GetIsObjectValid(oMineableRock) == FALSE)
    {
        iSpawnAttempt = GetLocalInt(oSpawnPoint, "ats_msp_spawn_attempt") + 1;
        SetLocalInt(oSpawnPoint, "ats_msp_spawn_attempt", iSpawnAttempt);
        if(iSpawnAttempt < 6)
            AssignCommand(GetArea(oSpawnPoint),
                        DelayCommand(10.0, ATS_SpawnMineableRock(oSpawnPoint, lSpawnLocation)));
        return;
    }

    SetLocalInt(oSpawnPoint, "ats_msp_spawn_attempt", 0);
    ++iTotalRocks;
    SetLocalInt(oSpawnPoint, "ats_msp_totalrocks", iTotalRocks );
    // Assigns the rock to the list of rocks on spawn point
    SetLocalObject(oSpawnPoint, "ats_msp_rock_" + IntToString(iTotalRocks), oMineableRock);
    // Assigns the spawn point to the rock
    SetLocalObject(oMineableRock, "ats_msp_object", oSpawnPoint);
    ATS_SetItemDurability(oMineableRock, iMaterialDurability);
    SetLocalInt(oMineableRock, "ats_material_type",  CINT_MATERIAL_UNKNOWN);

    int i;
    for(i = 1; i <= iMaterialCount; ++i)
    {

        iChanceToSpawn = GetLocalInt(oSpawnPoint, "ats_msp_material_" + IntToString(i) + "_chance");
        DEBUG_PrintString(GetLocalString(oSpawnPoint, "ats_msp_material_" + IntToString(i) +
                          ": " + IntToString(iChanceToSpawn)));

        if(iChanceToSpawn == 0)
            continue;
        iChanceTotal += iChanceToSpawn;
        if(iDiceRoll <= iChanceTotal)
        {
            iMaterialType = ATS_GetMaterialTypeFromTag(GetLocalString(oSpawnPoint, "ats_msp_material_" + IntToString(i)));
            SetLocalInt(oMineableRock, "ats_material_type",  iMaterialType);
            iMaterialDurability = GetLocalInt(oSpawnPoint, "ats_msp_material_" + IntToString(iMaterialCount) + "_DUR");
            ATS_SetItemDurability(oMineableRock, iMaterialDurability);
            break;
        }
    }

}
