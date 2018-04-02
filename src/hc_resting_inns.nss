//:://///
//:: Hard Core 3E Resting
//:: hc_player_rest
//:://///
/*
*/
//:://///
//:: Created By: Archaegeo
//:: Created On: June 2002
//:: Modified By: Maelfactor
//:: Modified On: June 2002 to add PC messages.
//:://///

// Only allows PC's to use the rest command once ever 8 hours.
// (thats 16 minutes normal time with a 2 min per day timer)
// This prevents casters from spam casting rest 30 seconds spam
// casting.

// added Inn Check on 7/19/2002 (Marc Richter)

// Added blindness to resting on 12/13/2002 (Jarketh Thavin)

// moduleonrest.nss
// 6/2/02 Jesse Fox
// modified rest to allow bedrolls.

#include "hc_inc"
#include "nw_i0_tool"
#include "hc_inc_remeff"

// Apply the rest effect to oPC
void effectRest(object oPC, int iInn=FALSE);


void effectRest(object oPC, int iInn=FALSE)
{
    object oMod=GetModule();
    string sPCName=GetName(oPC);
    string sCDK=GetPCPublicCDKey(oPC);
    effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
    effect eBlind =  EffectBlindness();

    if (iInn)
        SetLocalInt(oPC, "INNREST",1);
    else
        SetLocalInt(oPC,"RESTING",1);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0);
    SetLocalInt(oMod, ("LastHourRest"+sPCName+sCDK), GetTimeHour());
    SetLocalInt(oMod, ("LastDayRest"+sPCName+sCDK), GetCalendarDay());
    SetLocalInt(oMod, ("LastMonthRest"+sPCName+sCDK), GetCalendarMonth());
    SetLocalInt(oMod, ("LastYearRest"+sPCName+sCDK), GetCalendarYear());

    //insert special effects here. I tried EffectSleep along with different
    //animations. They either get overrode by the rest anim or cancel the rest.
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 10.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 20.0);
    DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 10.0));
}


void main()
{
    int iMinRest = GetLocalInt(oMod,"RESTBREAK");
    object oMod=GetModule();
    object oPC = GetLastPCRested();
    int nRestHP = GetCurrentHitPoints(oPC);
    object oBedroll;
    int iBedroll;
    string sPCName=GetName(oPC);
    string sCDK=GetPCPublicCDKey(oPC);

    // save the resting character
    if (GetLocalInt(oPC, "RestExportDelay") != 1)
    {
        ExportSingleCharacter(oPC);
        SetLocalInt(oPC, "RestExportDelay", 1);
        DelayCommand(30.0f, SetLocalInt(oPC, "RestExportDelay", 0));
    }

    effect eBlind =  EffectBlindness();

//    Subraces_RespawnSubrace( oPC );

    if(GetLocalInt(oPC,"arena"))
        return;

    if(GetIsObjectValid(oBedroll=GetItemPossessedBy(oPC,"bedroll")))
       iBedroll=1;
    else if(GetIsObjectValid(oBedroll=GetLocalObject(oMod,"inbedroll" + sPCName + sCDK)))
       iBedroll=1;


    if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
        SetLocalInt(oMod,"HPStartRest"+sPCName+sCDK,nRestHP);
        string sRestedText = GetName(oPC)+" is not tired enough.";

        //First get the time last rested and the current time.
        int iLastHourRest = GetLocalInt(oMod, ("LastHourRest"+sPCName+sCDK));
        int iLastDayRest = GetLocalInt(oMod, ("LastDayRest"+sPCName+sCDK));
        int iLastYearRest = GetLocalInt(oMod,("LastYearRest"+sPCName+sCDK));
        int iLastMonthRest = GetLocalInt(oMod,("LastMonthRest"+sPCName+sCDK));
        int iHour = GetTimeHour();
        int iDay  = GetCalendarDay();
        int iYear = GetCalendarYear();
        int iMonth = GetCalendarMonth();
        int iHowLong = 0;
        int nHasFood;
        object oFood;

        //make sure to modify the time for rollover of day, month and year.
        // in NWN there are 28 days to a month, 12 months to a year.
        if (!iBedroll && GetLocalInt(oMod, "RESTSYSTEM")==1)
            iMinRest = 8;  // altered to remove the bedroll requirement
        if (iLastYearRest != iYear)
            iMonth = iMonth + 12;
        if (iLastMonthRest != iMonth)
            iDay = iDay + 28;
        if (iDay != iLastDayRest)
            iHour = iHour + 24 * (iDay - iLastDayRest);

        //figure out how long it has been since last rested
        iHowLong = iHour - iLastHourRest;
        object oEquip=GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oEquip))
        {
            if(!FindSubString(GetTag(oEquip),"Food"))
            {
                nHasFood=1;
                oFood=oEquip;
                break;
            }
            oEquip=GetNextItemInInventory(oPC);
        }

        if ((HasItem(oPC,"InnKeyWeary")) && (GetTag(GetArea(oPC))=="WearyRestInn"))
        {
            object oKey;
            object oEquip=GetFirstItemInInventory(oPC);
            while(GetIsObjectValid(oEquip))
            {
                if(!FindSubString(GetTag(oEquip),"InnKeyWeary"))
                {
                    oKey=oEquip;
                    break;
                }
                oEquip=GetNextItemInInventory(oPC);
            }
            DestroyObject(oKey);

            effectRest(oPC, TRUE);
        }
        else if ((HasItem(oPC,"bednboozeInnKey")) && (GetTag(GetArea(oPC))=="BedandBooze"))
        {

            object oKey;
            object oEquip=GetFirstItemInInventory(oPC);
            while(GetIsObjectValid(oEquip))
            {
                if(!FindSubString(GetTag(oEquip),"bednboozeInnKey"))
                {
                    oKey=oEquip;
                    break;
                }
                oEquip=GetNextItemInInventory(oPC);
            }
            DestroyObject(oKey);

            effectRest(oPC, TRUE);
        }
        else if ((HasItem(oPC,"InnKeyTrond")) && (GetTag(GetArea(oPC))=="TrondorInn"))
        {

            object oKey;
            object oEquip=GetFirstItemInInventory(oPC);
            while(GetIsObjectValid(oEquip))
            {
                if(!FindSubString(GetTag(oEquip),"InnKeyTrond"))
                {
                    oKey=oEquip;
                    break;
                }
                oEquip=GetNextItemInInventory(oPC);
            }
            DestroyObject(oKey);

            effectRest(oPC, TRUE);
        }
        else if ((GetTag(GetArea(oPC))=="DraeloksKeep"))
        {
            effectRest(oPC, TRUE);
        }
        else if (GetTag(GetArea(oPC)) == "GatewayToNordock")
        {
            effectRest(oPC, TRUE);
        }
        else if (GetTag(GetArea(oPC)) == "TylnCastleInn")
        {
            effectRest(oPC, TRUE);
        }
        else if (GetTag(GetArea(oPC)) == "TESTINGAREA")
        {
            effectRest(oPC, TRUE);
        }
        else if ((iHowLong < iMinRest))
        {
            AssignCommand(oPC, ClearAllActions());
            FloatingTextStringOnCreature(sRestedText + " Try again in " + IntToString(iMinRest - iHowLong) + " hours.",oPC,FALSE);
        }
        else if(GPS(oPC)==PWS_PLAYER_STATE_RECOVERY)
        {
            SendMessageToPC(oPC,"You are not yet well enough to rest.");
            AssignCommand( oPC, ClearAllActions());
        }
        else if(!nHasFood)
        {
            SendMessageToPC(oPC, "You cannot rest on an empty stomach.");
            AssignCommand( oPC, ClearAllActions());
        }
        else
        {
            //set the variables for the current time to mark the pc as resting

                DestroyObject(oFood);
                SendMessageToPC(oPC, "You eat some food.");

            effectRest(oPC);
        }

        if (iBedroll || GetLocalInt(oPC, "INNREST"))
        {
            object oNewBedroll=CreateObject(OBJECT_TYPE_PLACEABLE,"bedroll",GetLocation(oPC));
            if (iBedroll)
                DestroyObject(oBedroll);
            SetLocalObject(oMod,"inbedroll"+GetName(oPC)+sCDK,oNewBedroll);
        }
    }

    int nLastRestType=GetLastRestEventType();
    if (nLastRestType == REST_EVENTTYPE_REST_FINISHED || nLastRestType == REST_EVENTTYPE_REST_CANCELLED)
    {
        SetLocalInt(oPC,"RESTING",0);

        //if they tried to use a bedroll, put it back in their inventory.
        if(!GetLocalInt(oPC,"INNREST"))
        {
            int nHD=GetHitDice(oPC);
            int nSHP=GetLocalInt(oMod,("HPStartRest"+sPCName+sCDK));
            int nDam;
            if(nRestHP > (nSHP+nHD))
            {
                nDam=(nRestHP - (nSHP+nHD));
                nDam=nDam/2;
                effect eDamage = EffectDamage(nDam,
                    DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
                ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPC);
            }
        }

        if (iBedroll)
        {
            oBedroll=GetLocalObject(oMod, "inbedroll" + GetName(oPC) + sCDK);
            CreateItemOnObject("bedroll", oPC);
            DestroyObject(oBedroll);
            DeleteLocalObject(oMod, "inbedroll" + GetName(oPC) + sCDK);
        }
        SetLocalInt(oPC, "INNREST",0);
    }
}
