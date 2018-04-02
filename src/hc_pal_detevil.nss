//::///////////////////////////////////////////////
//:: Detect_Evil
//:: NW_S2_DetecEvil.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////

// Modified to work per PHB by Archaegeo, Wraithdrit, and Velmar

#include "hc_inc"
//#include "hc_inc_timecheck"
#include "hc_text_detevil"

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
    //Declare major variables
    object oTarget;
    object oUser=OBJECT_SELF;
    int nEvil;
    effect eVis = EffectVisualEffect(VFX_COM_SPECIAL_RED_WHITE);
    location lHere=GetLocation(oUser);
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, lHere, TRUE, OBJECT_TYPE_CREATURE|OBJECT_TYPE_DOOR|OBJECT_TYPE_PLACEABLE);
    int nLastDet=GetLocalInt(oUser,"DETECTEVILTIME");

  if(!GetLocalInt(oUser,"DETECTEVILROUNDS") ||
     !nLastDet || SecondsSinceBegin() > (nLastDet+12))
  {
    int nCtEvil;
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
        if(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
        {
            nEvil = GetAlignmentGoodEvil(oTarget);
            if(nEvil == ALIGNMENT_EVIL)
                nCtEvil++;
        }
        else if(GetLocalInt(oTarget,"EVILPOWER"))
            nCtEvil++;
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lHere, TRUE,
            OBJECT_TYPE_CREATURE|OBJECT_TYPE_DOOR|OBJECT_TYPE_PLACEABLE);
    }
    if(nCtEvil>0)
        SendMessageToPC(oUser,DETEVIL);
    SetLocalInt(oUser,"DETECTEVILROUNDS",1);
  }
  else if(GetLocalInt(oUser,"DETECTEVILROUNDS")==1)
  {
    SetLocalInt(oUser,"DETECTEVILROUNDS",2);
    int nCtEvil;
    int nMxEvil;
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
        if(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
        {
            nEvil = GetAlignmentGoodEvil(oTarget);
            if(nEvil == ALIGNMENT_EVIL)
            {
                nCtEvil++;
                int iPow = abs(GetHitDice(oTarget)/5);
                if ( (GetLevelByClass(CLASS_TYPE_UNDEAD,oTarget)>0) ||
                     (GetLevelByClass(CLASS_TYPE_ELEMENTAL,oTarget)>0))
                   iPow = abs(GetHitDice(oTarget)/2);
                if((GetLevelByClass(CLASS_TYPE_OUTSIDER,oTarget)>0) ||
                   (GetLevelByClass(CLASS_TYPE_CLERIC,oTarget)>0))
                   iPow = GetHitDice(oTarget);
                if(iPow > nMxEvil) nMxEvil=iPow;
            }
        }
        else
        {
            int iPow=GetLocalInt(oTarget,"EVILPOWER");
            if(iPow)
            {
                nCtEvil++;
                if(iPow > nMxEvil) nMxEvil=iPow;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lHere, TRUE,
            OBJECT_TYPE_CREATURE|OBJECT_TYPE_DOOR|OBJECT_TYPE_PLACEABLE);
    }
    if(nCtEvil>0)
    {
        string sEvilMsg=IntToString(nCtEvil)+SENSE;
        if(nMxEvil < 2) sEvilMsg+=FAINT;
        else if(nMxEvil < 5) sEvilMsg+=MOD;
        else if(nMxEvil < 11) sEvilMsg+=STRONG;
        else sEvilMsg+=OVERPWR;
        if(nMxEvil>(GetHitDice(oUser)*2) && (nMxEvil>10))
        {
            SendMessageToPC(oUser,STUNNED);
            DeleteLocalInt(oUser,"DETECTEVILROUNDS");
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oUser,6.0);
        }
        SendMessageToPC(oUser, sEvilMsg);
    }
  }
  else if(GetLocalInt(oUser,"DETECTEVILROUNDS")==2)
  {
    int nCtEvil;
    int nMxEvil;
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
        if(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
        {
            nEvil = GetAlignmentGoodEvil(oTarget);
            if(nEvil == ALIGNMENT_EVIL)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 3.0);
                int iPow = abs(GetHitDice(oTarget)/5);
                if ( (GetLevelByClass(CLASS_TYPE_UNDEAD,oTarget)>0) ||
                     (GetLevelByClass(CLASS_TYPE_ELEMENTAL,oTarget)>0))
                   iPow = abs(GetHitDice(oTarget)/2);
                if((GetLevelByClass(CLASS_TYPE_OUTSIDER,oTarget)>0) ||
                   (GetLevelByClass(CLASS_TYPE_CLERIC,oTarget)>0))
                   iPow = GetHitDice(oTarget);
                string sEvilMsg;
                if(iPow < 2) sEvilMsg+=FAINTLY;
                else if(iPow < 5) sEvilMsg+=MODLY;
                else if(iPow < 11) sEvilMsg+=STRONGLY;
                else sEvilMsg+=OVERPWRLY;
                SendMessageToPC(oUser, GetName(oTarget)+IS+sEvilMsg+EVIL);
            }
        }
        else
        {
            int iPow=GetLocalInt(oTarget,"EVILPOWER");
            if(iPow)
            {
                string sEvilMsg;
                if(iPow < 2) sEvilMsg+=FAINTLY;
                else if(iPow < 5) sEvilMsg+=MODLY;
                else if(iPow < 11) sEvilMsg+=STRONGLY;
                else sEvilMsg+=OVERPWRLY;
                SendMessageToPC(oUser, GetName(oTarget)+IS+sEvilMsg+EVIL);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lHere, TRUE,
            OBJECT_TYPE_CREATURE|OBJECT_TYPE_DOOR|OBJECT_TYPE_PLACEABLE);
    }
  }
  SetLocalInt(oUser,"DETECTEVILTIME",SecondsSinceBegin());
}

