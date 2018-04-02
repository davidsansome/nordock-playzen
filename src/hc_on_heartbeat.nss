//Hardcore Heartbeat
//Archaegeo 2002 Jun 24

// Heartbeat Optimization of Player State by Brian Kelly (spilth)
// http://www.spilth.org/
// Inspired by Mitchell M. Evans (gonecamping@cox.net)

// This script goes in OnHeartBeat in the Module Properties Events
// It checks players to see if their PlayerState is other than Alive
// and takes steps as noted below to affect them.

#include "hc_inc"
//#include "hc_inc_wandering"
#include "hc_inc_on_hrtbt"
#include "hc_text_hrtbeat"
//#include "hc_inc_timecheck"
//#include "hc_inc_htf"
#include "rr_drunk_inc"

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

void main()
{
//Removed by Grug in an effort to reduce lag 03/10/2003
//    int iHour = GetTimeHour ();
//    int iMinute = GetTimeMinute ();
//    int iSecond = GetTimeSecond ();
//    int iMillisecond = GetTimeMillisecond();
//    SetTime(iHour, iMinute, iSecond, iMillisecond);


    if(!preEvent()) return;
    int iCurrentHour = GetTimeHour();
    object oPlayer = GetFirstPC();
    // Removed by Robin Apr 05
    //if(SecondsSinceBegin() > GetLocalInt(oMod,"NEXTHTFCHECK"))
    //    SignalEvent(oMod,EventUserDefined(HTFCHKEVENTNUM));
    while(GetIsObjectValid(oPlayer))
    {
        string sCDK=GetPCPublicCDKey(oPlayer);
        if(GetPlotFlag(oPlayer) && !GetIsDM(oPlayer) && !GetLocalInt(oPlayer,"GHOST"))
            SetPlotFlag(oPlayer, FALSE);
        // Removed by Robin Apr 05
        /*if(GetLocalInt(oMod,"RESTSYSTEM"))
        {
            int iLastHour = GetLocalInt(oPlayer,"LastHour");
            if (iLastHour != iCurrentHour)
            {
                ExecuteScript("hc_fb_play_rest", oPlayer);
                SetLocalInt(oPlayer,"LastHour",iCurrentHour);
            }
        }*/
        if(!GetIsDM(oPlayer))
            SetLocalInt(oMod,"LastHP"+GetName(oPlayer)+sCDK,  GetCurrentHitPoints(oPlayer));
//Torches can burn forever if they want to, less work in the heartbeat
// Thanks to RogC for the base for the Torch code, modified by Archaegeo for HCR
// And modified for grenade support of oil flasks
//        if(GetLocalInt(oMod,"BURNTORCH"))
//        {
//            if ( !GetIsDM(oPlayer) )
//            {
//                object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPlayer);
//                string sTag=GetTag(oTorch);
//                if (sTag == "NW_IT_TORCH001" ||
//                    sTag == "hc_torch" ||
//                    sTag == "hc_lantern")
//                {
//                    int nC;
//                    if ( (nC=(GetLocalInt(oTorch,"BURNCOUNT")+1)) >=
//                        GetLocalInt(oMod,"BURNTORCH")*(FloatToInt(HoursToSeconds(1)/6.0)))
//                    {
//                        if(sTag=="NW_IT_TORCH001" ||
//                           sTag=="hc_torch")
//                        {
//                            DestroyObject(oTorch);
//                            SendMessageToPC(oPlayer,TORCHOUT);
//                        }
//                        else
//                        {
//                            AssignCommand(oPlayer, ActionUnequipItem(oTorch));
//                            SendMessageToPC(oPlayer,LANTERNOUT);
//                        }
//                    }
//                    else
//                        SetLocalInt(oTorch,"BURNCOUNT", nC);
//                }
//            }
//        }
        if(GetLocalInt(oMod,"PKTRACKER"))
        {
            if(GetLocalInt(oMod,"PKCOUNT"+sCDK)>GetLocalInt(oMod,"PKTRACKER"))
            {
                SendMessageToAllDMs(sCDK+DMBOOTPK);
                WriteTimestampedLogEntry("** Booted: "+sCDK+" for excessive PK");
                BootPC(oPlayer);
                postEvent();
                return;
            }
        }
        // Removed by Robin Apr 05
        /*if(GetLocalInt(oMod,"WANDERSYSTEM") && GetLocalInt(oPlayer,"RESTING"))
        {
            wander_check(oPlayer);
        }*/

        DrunkCheck(oPlayer);

        oPlayer=GetNextPC();
    }
    postEvent();
}
