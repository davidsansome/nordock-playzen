// hc_bleeding - HardCore Bleeding/Death system
// Archaegeo 2002 July 2

#include "hc_inc"
//#include "hc_inc_timecheck"
#include "hc_text_bleed"
#include "hc_inc_death"
#include "hc_inc_remeff"

object oPlayer;

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

void CheckBleed()
{
    DelayCommand(6.0,ExecuteScript("hc_bleeding", oPlayer));
}

void SetHP(string sID, object oPlayer)
{
    SetLocalInt(oMod,"LastHP"+sID,GetCurrentHitPoints(oPlayer));
}

void main()
{
    if(GetIsObjectValid(OBJECT_SELF)) oPlayer=OBJECT_SELF;
    else return;
    int iPlayerState = GPS(oPlayer);
    int iPlayerMoving=GetLocalInt(oPlayer,"MOVING");
    int iCHP=GetCurrentHitPoints(oPlayer);
    string sName=GetName(oPlayer);
    string sCDK=GetPCPublicCDKey(oPlayer);
    string sID=sName+sCDK;
    string sAreaTag=GetTag(GetArea(oPlayer));
    string sFT="FuguePlane";

    if(GetIsDM(oPlayer)) return;

    int iLHP=GetLocalInt(oMod,"LastHP"+sID);

    if(GetLocalInt(oMod,"LIMBO") && iPlayerMoving && sAreaTag != sFT)
    {
        object oLimbo = GetObjectByTag("FugueMarker");
        // Altered by Grug 25-May-2004 for death variable
        SetLocalInt(oPlayer, "NCP_DEAD", 1); // Set the player as dead
        AssignCommand(oPlayer, ActionJumpToObject(oLimbo));
        CheckBleed();
        return;
    }
    if( iPlayerState==PWS_PLAYER_STATE_DEAD &&
        sAreaTag == sFT)
        return;
    if( iPlayerState!=PWS_PLAYER_STATE_ALIVE &&
        iCHP >= 1 &&
        sAreaTag != sFT &&
        !GetLocalInt(oPlayer,"GHOST"))
    {
        if(iPlayerMoving)
        {
            CheckBleed();
            return;
        }
        SetPlotFlag(oPlayer,FALSE);
        RemoveEffects(oPlayer);
        SPS(oPlayer, PWS_PLAYER_STATE_ALIVE);
        SetHP(sID, oPlayer);
        // Removed by Grug 25-May-2004 to replace with death variable
        DeleteLocalInt(oMod, "NCP_DEAD_" + GetPCPublicCDKey(oPlayer)); // Set the player as alive
        //object oFR;
        //if((oFR=GetItemPossessedBy(oPlayer, "fugue_NOD"))!=OBJECT_INVALID)
        //    DestroyObject(oFR);
        DelayCommand(0.5,hcDisabledRemove(oPlayer));
    }
    else if(iPlayerState == PWS_PLAYER_STATE_ALIVE) return;
    if( (iCHP == 0 && iPlayerState!=PWS_PLAYER_STATE_DISABLED) ||
        (iPlayerState==PWS_PLAYER_STATE_DISABLED &&
        GetLocalInt(oMod,"DR_APPLIED"+sID)==FALSE))
    {
        hcDisabledSetup(oPlayer);
        CheckBleed();
        return;
    }
    int nHour=nConv;
    int nDay=24*nConv;
    int nSSB=SecondsSinceBegin();

// Check for spontaneous healing
    if(
       ((iPlayerState == PWS_PLAYER_STATE_STABLE ||
         iPlayerState == PWS_PLAYER_STATE_STABLEHEAL) &&
        (GetLocalInt(oMod,"LastRecCheck"+sID)+nHour) < nSSB) ||
       (iPlayerState == PWS_PLAYER_STATE_RECOVERY &&
        (GetLocalInt(oMod,"LastRecCheck"+sID)+nDay) < nSSB)
      )
    {
        if( (iCHP > iLHP) &&
             iPlayerState != PWS_PLAYER_STATE_RECOVERY &&
             iPlayerState != PWS_PLAYER_STATE_STABLEHEAL
          )
        {
            SendMessageToPC(oPlayer, STABLERECMESSAGE);
            SPS(oPlayer, PWS_PLAYER_STATE_STABLEHEAL);
            CheckBleed();
            return;
        }
        SetLocalInt(oMod, "LastRecCheck"+sID, nSSB);
        if(d100() <= 10)
        {
            if(iPlayerState==PWS_PLAYER_STATE_STABLE)
            {
                SPS(oPlayer, PWS_PLAYER_STATE_RECOVERY);
                hcDisabledSetup(oPlayer);
                SendMessageToPC(oPlayer, RECOVERMESSAGE);
                SetHP(sID, oPlayer);
            }
            else if(iPlayerState==PWS_PLAYER_STATE_STABLEHEAL)
            {
                SPS(oPlayer, PWS_PLAYER_STATE_DISABLED);
                hcDisabledSetup(oPlayer);
                SendMessageToPC(oPlayer, DISABLEMESSAGE);
                SetHP(sID, oPlayer);
            }
            else
            {
                SendMessageToPC(oPlayer, HEALNATURAL);
                SPS(oPlayer, PWS_PLAYER_STATE_ALIVE);
            }
        }
        else
        {
            effect eDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
            ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPlayer);
            SendMessageToPC(oPlayer,SLIPDEATH);
            SetHP(sID, oPlayer);

        }
    }
    else if (iPlayerState==PWS_PLAYER_STATE_DYING)
    {
// Make a stabilization check
        if(iCHP > iLHP)
        {
            SendMessageToPC(oPlayer, STABLERECMESSAGE);
            SPS(oPlayer, PWS_PLAYER_STATE_STABLEHEAL);
            CheckBleed();
            return;
        }
        if (d100() <= 10)
        {
// They stabilized
            SendMessageToPC(oPlayer, STABLEMESSAGE);
            SPS(oPlayer, PWS_PLAYER_STATE_STABLE);
        }
        else
        {
// They bleed!
            SendMessageToPC(oPlayer,SLIPDEATH);
            effect eDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
            ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPlayer);
            int which = d6();
            switch (which)
            {
                case 1:
                    PlayVoiceChat (VOICE_CHAT_PAIN1, oPlayer);
                break;
                case 2:
                    PlayVoiceChat (VOICE_CHAT_PAIN2, oPlayer);
                break;
                case 3:
                    PlayVoiceChat (VOICE_CHAT_PAIN3, oPlayer);
                break;
                case 4:
                    PlayVoiceChat (VOICE_CHAT_HEALME, oPlayer);
                break;
                case 5:
                    PlayVoiceChat (VOICE_CHAT_NEARDEATH, oPlayer);
                break;
                case 6:
                    PlayVoiceChat (VOICE_CHAT_HELP, oPlayer);
                break;
            }
            SetHP(sID, oPlayer);
        }
    }
    CheckBleed();
}
