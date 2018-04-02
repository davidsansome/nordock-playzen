/****************************************************
  Orevein OnDeath Script
  ats_orevein_die

  Last Updated: July 16, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on an Orevein's
  OnDeath trigger.  This is responsible for
  spawning a new orevein when one gets destroyed.
  This only happens if the autospawn flag is set
  to true in the ats_config script.
****************************************************/

#include "ats_config"
#include "ats_inc_common"

void main()
{
    if(CBOOL_AUTOSPAWN_ORE == TRUE)
    {
        string sTemplate = GetStringLowerCase(GetTag(OBJECT_SELF));
        location lCurrentLoc = GetLocation(OBJECT_SELF);

        int iTimeRange = CINT_AUTOSPAWN_ORE_MAXTIME - CINT_AUTOSPAWN_ORE_MINTIME
                        + 1;
        int iRespawnMinutes = Random(iTimeRange) + CINT_AUTOSPAWN_ORE_MINTIME;
        AssignCommand( GetArea(OBJECT_SELF),
                        DelayCommand(iRespawnMinutes*60.0, ATS_CreateObject(OBJECT_TYPE_PLACEABLE,
                                    sTemplate, lCurrentLoc, TRUE)));

    }
}
