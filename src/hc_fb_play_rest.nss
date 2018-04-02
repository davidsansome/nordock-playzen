/*
    hc_fb_play_rest
    by Celedhros, 26 July 2002

    If the Hardcore Resting System is in use, this script will check to see
    when the PC last rested and set the Resting Panel Button in the UI to
    flash if they are eligible to rest again.
*/

#include "hc_inc"
//#include "hc_inc_timecheck"

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
    object oPC=OBJECT_SELF;
    object oBedroll;
    int iMinRest = GetLocalInt(oMod,"RESTBREAK")*nConv;
    int iBedroll;
    string sPCName=GetName(oPC);
    string sCDK=GetPCPublicCDKey(oPC);
    string sID=sPCName+sCDK;
//  Check to see if the bedroll system is being used and whether or not the PC has one
    if(GetLocalInt(oMod,"BEDROLLSYSTEM"))
    {
        if(GetIsObjectValid(oBedroll=GetItemPossessedBy(oPC,"bedroll")))
            iBedroll=1;
    }

//  Get the time last rested and the current time.
    int iLastRest = GetLocalInt(oMod, ("LastRest"+sID));
//  If PC does not have a bedroll, set rest period to 24 hours
    if(GetLocalInt(oMod,"BEDROLLSYSTEM") && !iBedroll)
    {
        iMinRest = 24*nConv;
    }
//  If it has been at least as long as the minimum rest period, set rest panel to flash
    if (GetLocalInt(oMod,"RESTSYSTEM") && iLastRest && (iLastRest+iMinRest >= SecondsSinceBegin()))
    {
        SetPanelButtonFlash(oPC,PANEL_BUTTON_REST,1);
    }
    return;
}
