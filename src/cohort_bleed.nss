
#include "cohort_inc"
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

object oCohort;
effect eMove=EffectMovementSpeedDecrease(80);
effect eCurse=EffectCurse(5,5,0,5,5,0);
effect eSlow=EffectSlow();

void CheckBleed()
{
    DelayCommand(6.0,ExecuteScript("cohort_bleed", oCohort));
}

void SetCohortHP(string sID)
{
    int CHP = GetCurrentHitPoints(oCohort);
    if (CHP = -11)
        CHP = GetLocalInt(oCohort,"NEGATIVEHP");
    SetLocalInt(oMod,"LastHP" + sID,CHP);
}

void CohortDisabledSetup()
{
    int nPS=GetLocalInt(oMod,"DR_APPLIED" + GetName(oCohort));
    if(nPS==FALSE) {
        SPS(oCohort, PWS_PLAYER_STATE_DISABLED);
        DelayCommand(0.1, RemoveEffects(OBJECT_SELF));
        if (GetCurrentHitPoints() < 1)
            DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), OBJECT_SELF));
        DeleteLocalInt(OBJECT_SELF,"NEGATIVEHP");
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oCohort));
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCurse, oCohort));
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oCohort));
        SetLocalInt(oMod,"DR_APPLIED" + GetName(oCohort),TRUE);
    }
    DeleteLocalInt(oCohort,"BLEEDCOUNTER");
}


void CohortDisabledRemove(object oVictim)
{
    effect eBad=GetFirstEffect(oVictim);
    while (GetIsEffectValid (eBad) ) {
        int nEtype=GetEffectType(eBad);
        if(nEtype == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE ||
           nEtype == EFFECT_TYPE_CURSE ||
          nEtype == EFFECT_TYPE_SLOW)
          RemoveEffect (oVictim, eBad);
         eBad = GetNextEffect (oVictim);
    }
    DeleteLocalInt(oMod,"DR_APPLIED" + GetName(oVictim));
}

int CohortBledToDeath(object realMaster)
{
    int which = d6();
    switch (which) {
        case 1: PlayVoiceChat (VOICE_CHAT_PAIN1, oCohort); break;
        case 2: PlayVoiceChat (VOICE_CHAT_PAIN2, oCohort); break;
        case 3: PlayVoiceChat (VOICE_CHAT_PAIN3, oCohort); break;
        case 4: PlayVoiceChat (VOICE_CHAT_HEALME, oCohort); break;
        case 5: PlayVoiceChat (VOICE_CHAT_NEARDEATH, oCohort); break;
        case 6: PlayVoiceChat (VOICE_CHAT_HELP, oCohort); break;
    }
    int bleedcounter = GetLocalInt(oCohort,"BLEEDCOUNTER");
    SetLocalInt(oCohort,"NEGATIVEHP",GetLocalInt(oCohort,"NEGATIVEHP") - 1);
    if (GetLocalInt(oCohort,"NEGATIVEHP") == -10 || bleedcounter >= 10) {
        DelayCommand(0.1, RemoveEffects(OBJECT_SELF));
        PlayVoiceChat(VOICE_CHAT_DEATH);
        RemoveCohort(realMaster);
        SPS(oCohort, PWS_PLAYER_STATE_DEAD);
        SendDeadCohortToRepository(realMaster);
        return 1;
    }
    else {
        SetCohortHP(GetName(oCohort));
        SetLocalInt(oCohort,"BLEEDCOUNTER",bleedcounter + 1);
    }
    return 0;
}

void StopCohortBleeding()
{
    int iSpellID = GetLastSpell();
    switch(iSpellID) {
        case SPELL_CURE_CRITICAL_WOUNDS:
        case SPELL_CURE_LIGHT_WOUNDS:
        case SPELL_CURE_MINOR_WOUNDS:
        case SPELL_CURE_MODERATE_WOUNDS:
        case SPELL_CURE_SERIOUS_WOUNDS:
        case SPELL_HEAL:
        case SPELL_HEALING_CIRCLE:
        case SPELL_MASS_HEAL:
        case SPELLABILITY_LAY_ON_HANDS:
        case TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT:
        case TALENT_CATEGORY_BENEFICIAL_HEALING_POTION:
        case TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH:
            CohortDisabledSetup();
    }
}

void main()
{
    if(GetIsObjectValid(OBJECT_SELF))
        oCohort=OBJECT_SELF;
    else
        return;

    object realMaster = GetRealMaster();
    int iCohortState = GPS(oCohort);

    int iCHP = GetCurrentHitPoints(oCohort);
    int iCohortMoving=GetLocalInt(oCohort,"MOVING");
    if (iCHP == -11)
        iCHP=GetLocalInt(oCohort,"NEGATIVEHP");
    string sAreaTag=GetTag(GetArea(oCohort));
    string sFT=GetTag(GetArea(GetObjectByTag("COHORT_REPOSITORY")));;

    //Debugging info
    //SendMessageToPC(GetFirstPC(),GetName(oCohort) + ": " + IntToString(iCohortState) + ", " + IntToString(iCHP));

    if (iCohortState==PWS_PLAYER_STATE_DEAD && sAreaTag == sFT) return;

    if (iCohortState==PWS_PLAYER_STATE_DEAD && sAreaTag != sFT) {
        CohortBledToDeath(realMaster);
        return;
    }

    if( iCohortState!=PWS_PLAYER_STATE_ALIVE && iCHP > 1 && sAreaTag != sFT) {
        if(iCohortMoving) {
            CheckBleed();
            return;
        }
        SPS(oCohort, PWS_PLAYER_STATE_ALIVE);
        DelayCommand(0.5,CohortDisabledRemove(oCohort));
    }
    else if(iCohortState == PWS_PLAYER_STATE_ALIVE) return;

    if((iCHP == 1 && iCohortState!=PWS_PLAYER_STATE_DISABLED) ||
        (iCohortState==PWS_PLAYER_STATE_DISABLED &&
        GetLocalInt(oMod,"DR_APPLIED"+GetName(oCohort))==FALSE))
    {
        CohortDisabledSetup();
        CheckBleed();
        return;
    }

    object oLastCaster = GetLastSpellCaster();
    //debugging info
    //SendMessageToPC(GetFirstPC(),GetName(oLastCaster) + " cast: " + IntToString(GetLastSpell()));

    if (oLastCaster!=OBJECT_INVALID &&
        oLastCaster!= OBJECT_SELF &&
        (iCohortState==PWS_PLAYER_STATE_DYING ||
         iCohortState==PWS_PLAYER_STATE_STABLE))
    {
        StopCohortBleeding();
    }

    int nHour=nConv;
    int nDay=24*nConv;
    int nSSB=SecondsSinceBegin();

    // Check for spontaneous healing
    if(((iCohortState == PWS_PLAYER_STATE_STABLE || iCohortState == PWS_PLAYER_STATE_STABLEHEAL) &&
        (GetLocalInt(oMod,"LastRecCheck"+GetName(oCohort))+nHour) < nSSB) ||
       (iCohortState == PWS_PLAYER_STATE_RECOVERY &&
       (GetLocalInt(oMod,"LastRecCheck"+GetName(oCohort))+nDay) < nSSB))
    {
        SetLocalInt(oMod, "LastRecCheck"+GetName(oCohort), nSSB);
        if(d100() <= 10) {
            if(iCohortState==PWS_PLAYER_STATE_STABLE)
                CohortDisabledSetup();
            else
                SPS(oCohort, PWS_PLAYER_STATE_ALIVE);
        }
        else if (CohortBledToDeath(realMaster)) return;
    }
    else if (iCohortState==PWS_PLAYER_STATE_DYING) {
        // Make a stabilization check
        if (d100() <= 10) // They stabilized
            SPS(oCohort, PWS_PLAYER_STATE_STABLE);
        else if (CohortBledToDeath(realMaster)) return;
    }
    CheckBleed();
}
