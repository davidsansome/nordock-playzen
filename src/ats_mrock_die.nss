/****************************************************
  Mineable Rock OnDeath Script
  ats_mrock_die

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on an Mineable Rock's
  OnDeath trigger.  This is responsible for
  spawning a new Mineable Rock when one gets destroyed.

****************************************************/

#include "ats_config"
#include "ats_const_mat"
#include "ats_inc_common"
#include "ats_inc_material"
#include "ats_inc_msp"

void main()
{
    DEBUG_PrintString("Mineable Rock has been destroyed!");
    string sTemplate = GetStringLowerCase(GetTag(OBJECT_SELF));
    location lCurrentLoc = GetLocation(OBJECT_SELF);
    object oMSP = GetLocalObject(OBJECT_SELF, "ats_msp_object");
    int iTotalRocks = GetLocalInt(oMSP, "ats_msp_totalrocks");

    SetLocalInt(oMSP, "ats_msp_totalrocks",  --iTotalRocks);


    if(GetLocalInt(oMSP, "ats_msp_refreshdone") == FALSE)
        return;

    int iTimeRange = GetLocalInt(oMSP, "ats_msp_XST") - GetLocalInt(oMSP, "ats_msp_MST") + 1;
    if(iTimeRange < 0)
        return;
    float fRespawnSeconds = IntToFloat(Random(iTimeRange) + GetLocalInt(oMSP, "ats_msp_MST"));
    DEBUG_PrintString("Respawn Time: " + FloatToString(fRespawnSeconds));
    if(GetLocalInt(oMSP, "ats_msp_CRS") == FALSE)
    {
            AssignCommand( GetArea(oMSP),
                           DelayCommand(fRespawnSeconds, ATS_SpawnMineableRock(oMSP, lCurrentLoc)));
    }
    else if(iTotalRocks == 0)
    {
        AssignCommand(GetArea(oMSP),
                      DelayCommand(fRespawnSeconds, ATS_TriggerMiningSpawn(oMSP)));
    }

}
