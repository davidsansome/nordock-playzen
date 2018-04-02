#include "ats_inc_common"
#include "ats_inc_constant"
#include "ats_config"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_msp"

void ATS_InitializeMineSpawnPoint(object oCurrentSpawnPoint)
{
    ATS_InitMiningSpawnConfig(oCurrentSpawnPoint);
    if(ATS_AssignMiningSpawnConfig(oCurrentSpawnPoint, GetName(oCurrentSpawnPoint)) == TRUE)
        ATS_TriggerMiningSpawn(oCurrentSpawnPoint);
}
void main()
{
    object oCurrentSpawnPoint = GetObjectByTag("ATS_MSP_WP");
    int i = 0;
    while(oCurrentSpawnPoint != OBJECT_INVALID)
    {
        if(GetLocalInt(oCurrentSpawnPoint, "ats_msp_initialized") == FALSE)
            DelayCommand(0.0, ATS_InitializeMineSpawnPoint(oCurrentSpawnPoint));
        oCurrentSpawnPoint = GetObjectByTag("ATS_MSP_WP", ++i);
    }
}
