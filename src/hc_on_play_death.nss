// Hardcore Death - Creates Death Amulet on player to prevent quit and return
//                  Also pops up Death GUI where respawn is now pray
// Archaegeo
// 2002 Jun 24

// This script sets the PlayerState to DEAD once they hit -10 hitpoits and
// displays one GUI if they have a deity, and another if they do not.
// Respawn buttor prays for ressurection on the one, and does nothing on other.

// REZPENALTY code by Jamos and Majoru

#include "hc_inc_on_death"
#include "hc_inc_gods"
#include "hc_inc_rezpen"
#include "hc_inc_transfer"
//#include "hc_inc_timecheck"
#include "nw_i0_tool"
#include "rr_persist"

// Function to take equipped items from players called from the main()
// function(thanks Jhenne)
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

void strip_equiped(object oPlayer, object oDeathCorpse, object oEquip)
{
    if(GetIsObjectValid(oEquip))
        AssignCommand(oDeathCorpse, ActionTakeItem(oEquip, oPlayer));
}

void main()
{
    if(!preEvent()) return;
    object oPlayer = GetLastPlayerDied();
    object oHenchman = GetHenchman(oPlayer);
    if (GetIsObjectValid(oHenchman)) RemoveHenchman(oPlayer, oHenchman);
    string sName=GetName(oPlayer);
    string sCDK=GetPCPublicCDKey(oPlayer);
    string sID=sName+sCDK;
    object oKiller=GetLastAttacker(oPlayer);
    location lDiedHere;

    // sober up a drunken player

    SetLocalInt(GetModule(),"BAC"+GetName(oPlayer)+GetPCPublicCDKey(oPlayer),0);

    // clear prior cohort
    SetLocalInt(oMod,"cohort"+sCDK+sName,FALSE);

    // arena? If so, allow conventional respawn

    if (GetLocalInt(oPlayer,"arena"))
        {
            DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, TRUE, TRUE, 0, "You may exit or respawn"));
            return;
        }

    if (GetStringLowerCase(GetSubRace(oPlayer))=="drow")
    {
       AdjustReputation(oPlayer,GetObjectByTag("FACTION_DROW"),100);
       AdjustReputation(oPlayer,GetObjectByTag("FACTION_UNDERDARK"),100);
       AdjustReputation(oPlayer,GetObjectByTag("Faction_Merchant"),-100);
       AdjustReputation(oPlayer,GetObjectByTag("Faction_Defender"),-100);
       AdjustReputation(oPlayer,GetObjectByTag("good_boy"),-100);
    }
    else if (GetStringLowerCase(GetSubRace(oPlayer))=="duergar")
    {
       AdjustReputation(oPlayer,GetObjectByTag("duergar_faction"),100);
       AdjustReputation(oPlayer,GetObjectByTag("FACTION_UNDERDARK"),100);
       AdjustReputation(oPlayer,GetObjectByTag("Faction_Merchant"),-100);
       AdjustReputation(oPlayer,GetObjectByTag("Faction_Defender"),-100);
       AdjustReputation(oPlayer,GetObjectByTag("good_boy"),-100);
    }
    else
    {
        AdjustReputation(oPlayer,GetObjectByTag("good_boy"),100);
    }

    // Were we doing a follow-me quest?
    object oBenner = GetLocalObject(oPlayer, "InmateBenner");
    if (GetIsObjectValid(oBenner))
    {
        DeleteLocalObject(oPlayer, "InmateBenner");
        DestroyObject(oBenner);
    }

    if(GetLocalInt(oPlayer,"LOGINDEATH"))
    {
        if(GetTag(GetArea(oPlayer)) != "")
            lDiedHere=GetPersistentLocation(oMod,"DIED_HERE"+sID);
        else
        {
            lDiedHere=GetLocation(GetObjectByTag("GraveYard"));
            SetPersistentLocation(oMod,"DIED_HERE"+sID,lDiedHere);
        }

    }
    else
    {
        lDiedHere=GetLocation(oPlayer);
        SetPersistentLocation(oMod,"DIED_HERE"+sID,lDiedHere);
    }
    if((GetLocalInt(oMod,"LASTDIED"+sID) + 60) > SecondsSinceBegin())
        SendMessageToAllDMs("** WARNING **"+GetPCPlayerName(oPlayer)+
            " might be trying to avoid death.");
    else
        SetLocalInt(oMod,"LASTDIED"+sID,SecondsSinceBegin());
// If we are using the loot sytem, strip all items from the dead man
    object oDeathCorpse;
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
    {
        oDeathCorpse=GetLocalObject(oMod,"DeathCorpse"+sID);

// If the player went strait to DEAD without going through DYING then we
// need to make a Death Corpse to put things in
        if(GetIsObjectValid(oDeathCorpse) == FALSE)
        {
            oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse", lDiedHere);
            SetLocalObject(oDeathCorpse,"Owner",oPlayer);
            SetLocalString(oDeathCorpse,"Name",sName);
            SetLocalString(oDeathCorpse,"Key",sCDK);
            SetLocalObject(oMod,"DeathCorpse"+sID,oDeathCorpse);
// I think this bit was hacked out to disable player lootsystem
//   re-enabling it had odd results
            int nAmtGold=GetGold(oPlayer);
            object oBag;
            if(nAmtGold)
            {
                oBag=CreateItemOnObject("bagofgold",oDeathCorpse);
                SetLocalInt(oBag,"AmtGold",nAmtGold);
                AssignCommand(oDeathCorpse,TakeGoldFromCreature(nAmtGold,oPlayer,TRUE));
            }
            //hcTransferObjects(oPlayer, oDeathCorpse, 2);
// this next line should create the object  'A Head' on the corpse.
            object oHead;
            oHead=CreateItemOnObject("pchead", oDeathCorpse,1);
            SetLocalString(oHead, "Name", GetName(oPlayer));

        }
// might re-enable it to test

        else if(GetTag(oDeathCorpse)=="DyingCorpse")
        {
            object oDC=oDeathCorpse;
            oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse", lDiedHere);
            SetLocalObject(oDeathCorpse,"Owner",oPlayer);
            SetLocalString(oDeathCorpse,"Name",sName);
            SetLocalString(oDeathCorpse,"Key",sCDK);
            SetLocalObject(oMod,"DeathCorpse"+sID,oDeathCorpse);
            //hcTransferObjects(oDC, oDeathCorpse, 2);
       }
// Now that they are DEAD, make a Player Corpse Token that others can use
// to drag their carcass to a cleric
        object oDeadMan;
        if(GetIsObjectValid(
            oDeadMan = GetLocalObject(oMod,"PlayerCorpse"+sID))==FALSE)
            oDeadMan=CreateItemOnObject("PlayerCorpse", oDeathCorpse);
        else SetLocalInt(oPlayer,"REDEATH",0);
        SetLocalObject(oDeadMan,"Owner",oPlayer);
        SetLocalObject(oDeadMan,"DeathCorpse",oDeathCorpse);
        SetLocalString(oDeadMan,"Name",sName);
        SetLocalString(oDeadMan,"Key",sCDK);
        SetLocalInt(oDeadMan,"Alignment",GetAlignmentGoodEvil(oPlayer));
        SetLocalString(oDeadMan,"Deity",GetDeity(oPlayer));
        SetLocalObject(oDeathCorpse,"PlayerCorpse",oDeadMan);
        SetLocalObject(oMod,"PlayerCorpse"+sID,oDeadMan);
// this bit seems to be to remove equiped items

//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_ARMS, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_ARROWS, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BELT, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BOLTS, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BOOTS, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BULLETS, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_CHEST, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_CLOAK, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_HEAD, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_NECK, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer));
//        strip_equiped(oPlayer, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPlayer));

// again has been ripped out.. :/ Perhaps re-enable
    }
    if(GetLocalInt(oMod,"BLEEDSYSTEM"))
    {
        SetLocalInt(oMod, "LastRecCheck"+sID, 0);
        if(GPS(oPlayer)==PWS_PLAYER_STATE_ALIVE)
            DelayCommand(6.0,ExecuteScript("hc_bleeding", oPlayer));
        SPS(oPlayer, PWS_PLAYER_STATE_DEAD);
    }

    string sCDKK=GetPCPublicCDKey(oKiller);
    if(GetLocalInt(oMod,"PKTRACKER"))
    {
        int nPartyMember;
        object oPM;
        object oMaster=GetMaster(oKiller);
        while(GetIsObjectValid(oMaster) && sCDKK=="")
        {
            sCDKK=GetPCPublicCDKey(oMaster);
            if(sCDKK !="")
            {
                oKiller=oMaster;
                break;
            }
            oMaster=GetMaster(oMaster);
        }
        oPM=GetFirstFactionMember(oPlayer);
        while(GetIsObjectValid(oPM))
        {
            if(oPM==oKiller)
            {
                nPartyMember=1;
                break;
            }
            oPM=GetNextFactionMember(oPlayer);
        }
        if(sCDKK!="" && !nPartyMember)
            SetLocalInt(oMod,"PKCOUNT"+sCDKK,(GetLocalInt(oMod,"PKCOUNT"+sCDKK)+1));
    }
    if(GetLocalInt(oMod,"TELLONPK") && sCDKK != "")
        SendMessageToAllDMs("**(PK): "+sName+" was PK'd by "+
            GetName(oKiller));

// IF using Deity pray system, check to see if they have a god, and if so, is
// that god listening.  (5% chance by default, can only be done once per character)
    int nRess;
    if((!GetLocalInt(oMod,"GODSYSTEM") || !(nRess=ress_check(oPlayer))) &&
        GetLocalInt(oMod,"LIMBO"))
    {

//        if (!HasItem(oPlayer,"SoulFrag_NOD"))
//            CreateItemOnObject("soulfrag_nod",oPlayer,1);
//        SetLocalInt(oPC,"SOULFRAG"+sID,TRUE);

        SetLocalInt(oPlayer,"MOVING",1);
        object oLimbo = GetObjectByTag("FugueMarker");
        effect eParalyze = EffectParalyze();
        SetPersistentLocation(oMod,"DIED_HERE"+sID,lDiedHere);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(
            GetMaxHitPoints(oPlayer)), oPlayer);
        RemoveEffects(oPlayer);
        SetPlotFlag(oPlayer,TRUE);
        AssignCommand(oPlayer,ClearAllActions());
        SetLocalInt(oPlayer, "GHOST", 1);
        // Altered by Grug 25-May-2004 for death variable
        SPI(oPlayer, "NCP_DEAD", 1); // Set the player as dead
        AssignCommand(oPlayer,ActionJumpToObject(oLimbo));
        SetLocalInt(oPlayer,"LOGINDEATH",0);
        postEvent();
        return;
    }
    else if(!nRess && GetLocalInt(oMod,"DEATHSYSTEM"))
    {
        SendMessageToPC(oPlayer,"You have died. You must wait for help.");
        DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, FALSE, TRUE, 0, "You have no Deity, you must wait for help"));
    }
// If not using Death or Deity, then let them respawn normally.
    else if(!nRess)
    {
// If using the Loss of Level rez penalty, plug it in here if not using
// DEATH or GOD system (otherwise its handled elsewhere
        if( GetLocalInt(oMod,"REZPENALTY") )
            DelayCommand(5.0,hcRezPenalty(oPlayer));
        DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, TRUE, TRUE, 0, "You may exit or respawn"));
    }
    SetLocalInt(oPlayer,"LOGINDEATH",0);


    postEvent();
}
