// HardCore Ruleset User Define
// Archaegeo 2002 Aug 10

// Much script from the PWDB system by Valerio Santinelli

#include "hc_inc"
#include "hc_inc_on_user"
#include "hc_inc_htf"
//#include "hc_inc_timecheck"
#include "ats_inc_cl_enter"

int nConv=FloatToInt(HoursToSeconds(1));

int SecondsSinceBegin()
{
    object oMod=GetModule();
    float fStartHour=IntToFloat(GetLocalInt(oMod,"HourStart"));
    float fStartDay=IntToFloat(GetLocalInt(oMod,"DayStart"));
    float fStartMonth=IntToFloat(GetLocalInt(oMod,"MonthStart"));
    float fStartYear=IntToFloat(GetLocalInt(oMod,"YearStart"));
    float fCurDay=IntToFloat(GetCalendarDay());
    float fCurMonth=IntToFloat(GetCalendarMonth());
    float fCurYear=IntToFloat(GetCalendarYear());
    float fCurHour=IntToFloat(GetTimeHour());
    float fCurMin=IntToFloat(GetTimeMinute());
    float fCurSec=IntToFloat(GetTimeSecond());


    float fElapsed=0.000;

    if(fCurYear==fStartYear)
    {
        if(fCurMonth==fStartMonth)
        {
            if(fCurDay==fStartDay)
            {
                fElapsed += (fCurHour-fStartHour);
            }
            else
            {
                if(fCurHour>fStartHour)
                {
                    fElapsed += 24.0 * (fCurDay-fStartDay);
                    fElapsed += fCurHour-fStartHour;
                }
                else
                {
                    fElapsed += 24.0 * (fCurDay-fStartDay-1.0);
                    fElapsed += 24.0 - fStartHour + fCurHour;
                }
            }
        }
        else
        {
            if(fCurDay>fStartDay)
            {
                fElapsed += 28.0 * 24.0 * (fCurMonth - fStartMonth);
                fElapsed += 24.0 * (fCurDay-fStartDay);
            }
            else
            {
                fElapsed += 28.0 * 24.0 * (fCurMonth - fStartMonth - 1.0);
                fElapsed += 24.0 * (28.0 - fStartDay + fCurDay);
            }
            if(fCurHour > fStartHour)
                fElapsed += fCurHour-fStartHour+2.0;
            else
                fElapsed += -24.0 + fStartHour + fCurHour;
        }
    }
    else
    {
        if(fCurMonth>fStartMonth)
        {
            fElapsed += 12.0 * 28.0 * 24.0 * (fCurYear - fStartYear);
            fElapsed += 28.0 * 24.0 * (fCurMonth-fStartMonth);
        }
        else
        {
            fElapsed += 12.0 * 28.0 * 24.0 * (fCurYear - fStartYear - 1.0);
            fElapsed += 28.0 * 24.0 * (12.0 - fStartMonth + fCurMonth);
        }
        if(fCurDay> fStartDay)
            fElapsed += 24.0 * (fCurDay-fStartDay);
        else
            fElapsed += 24.0 * (28.0 - fStartDay + fCurDay);
        if(fCurHour > fStartHour)
            fElapsed += fCurHour-fStartHour+2.0;
        else
            fElapsed += -24.0 + fStartHour + fCurHour;
    }

    fElapsed = IntToFloat(nConv)*fElapsed;
    fElapsed+=fCurMin*60.0;
    fElapsed+=fCurSec;
    return FloatToInt(fElapsed);
}

void PWDB_SaveToDatabase()
{
    WriteTimestampedLogEntry("PWDB_SaveToDatabase()");
    // Set some test vars on PCs who haven't had them.
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        if (GetLocalInt(oPC, "PV_TEST_VARS_SET"))
        {
          oPC = GetNextPC();
          continue;
        }
        if(!GetIsDM(oPC))
            SetPersistentLocation(oPC, "PV_START_LOCATION", GetLocation(oPC));
        SetLocalInt(oPC, "PV_TEST_VARS_SET", 1);

        oPC = GetNextPC();
    }

    object oMod = GetModule();
    int iHeartBeat = GetLocalInt(oMod, "TMP_HBMONITOR");
    SetLocalInt(oMod,"CurrentYear",GetCalendarYear());
    SetLocalInt(oMod,"CurrentMonth",GetCalendarMonth());
    SetLocalInt(oMod,"CurrentDay",GetCalendarDay());
    SetLocalInt(oMod,"CurrentHour",GetTimeHour());
    SetLocalInt(oMod,"CurrentMin",GetTimeMinute());
    if (iHeartBeat == 0)
    {
        SetLocalInt(oMod, "TMP_HBMONITOR", 1);
        WriteTimestampedLogEntry("Saving ALL to PWDB");
        PWDBSaveAll();
    }
    else
    {
        SetLocalInt(oMod, "TMP_HBMONITOR", 0);
        WriteTimestampedLogEntry("Saving CHANGED to PWDB");
        PWDBSaveChanged();
    }

    // If all clients have left, save the entire database.
    object oTemp = GetFirstPC();
    int iPlayerCount = 0;
    while (oTemp != OBJECT_INVALID)
    {
        iPlayerCount++;
        oTemp = GetNextPC();
    }

    int iSavedAll = GetLocalInt(oMod, "PWDB_SAVEDALL");
    if (iPlayerCount < 1 && !iSavedAll)
    {
        SetLocalInt(oMod, "PWDB_SAVEDALL", 1);
        PWDBSaveAll();
    }
    else if (iPlayerCount > 0 && iSavedAll)
    {
        SetLocalInt(oMod, "PWDB_SAVEDALL", 0);
    }
}

void main()
{
    int PWDB_HEARTBEAT_EVENT = 502;
    float BEAT_TIME = 60.0f;

    int nUser=GetUserDefinedEventNumber();

    if (nUser == PWDB_HEARTBEAT_EVENT) {
        // Set up the next iteration of the custom heartbeat
        event evEvent = EventUserDefined(PWDB_HEARTBEAT_EVENT);

        // Send the custom heartbeat event to myself in 1 minute
        DelayCommand(BEAT_TIME,SignalEvent(OBJECT_SELF,evEvent));
        if (!(GetLocalInt(GetModule(), "ModLoadEvent")))
            PWDB_SaveToDatabase();
        DeleteLocalInt(GetModule(), "ModLoadEvent");
    }

    if (nUser == HTFCHKEVENTNUM)
    {
        int nCheckTime;
        nCheckTime=SecondsSinceBegin();
        nCheckTime+=(FloatToInt(HoursToSeconds(1))/60)*HTFCHKTIMER;
        SetLocalInt(oMod,"NEXTHTFCHECK",nCheckTime);
        LoopHTFSystemChk();
    }
    if (nUser == 2112)
      {
        ATS_InitializePlayer(GetEnteringObject());
      }

    if(!preEvent()) return;
    postEvent();
}
