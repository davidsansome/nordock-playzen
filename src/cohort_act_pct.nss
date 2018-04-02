//::///////////////////////////////////////////////
//:: Resurrecting Cohort Activate PCT Script.
//:: cohort_act_pct
//:://////////////////////////////////////////////
/*
    v1.0.5  Added text references from cohort_text.
            Players will now receive more helpful feedback
            from the cohort regarding the NPC cleric.
            (yibble)

*/
//:://////////////////////////////////////////////
//:: Created By: Nathan 'yibble' Reynolds <yibble@yibble.org>
//:: Created On: 09/02/2002
//:://////////////////////////////////////////////
#include "cohort_inc_vars"
#include "cohort_text"
#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_inc_transfer"
#include "hc_text_activate"


int TRUE_RESS=3;
int RESS=2;
int RAISE=1;
int NONE=0;

void MoveDC(object oDropped, object oUser)
{
            object oDC=GetLocalObject(oDropped,"DeathCorpse");
            object oOwner=GetLocalObject(oDropped,"Owner");
            string sName=GetLocalString(oDropped,"Name");
            string sCDK=GetLocalString(oDropped,"Key");

// If a Death Corpse exits, move all the stuff from the old one to the new one
// at the new location
            object oDeadMan;
            object oDeathCorpse;
            oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                                    GetLocation(oUser));

            SetLocalObject(oMod,"DeathCorpse"+sName+sCDK,oDeathCorpse);
            SetLocalObject(oMod,"PlayerCorpse"+sName+sCDK,oDeadMan);
            SetLocalObject(oDeathCorpse,"Owner",oOwner);
            SetLocalString(oDeathCorpse,"Name",sName);
            SetLocalString(oDeathCorpse,"Key",sCDK);
            hcTransferObjects(oDC, oDeathCorpse);
}

void main()
{
// If the item is a player corpse token, then see if they can get the poor
// slob resurrected.
    int casttype=NONE;
    object oUser=OBJECT_SELF;
    object oCleric=GetLocalObject(oUser,"CLERIC");
    object oRespawner=GetLocalObject(oUser,"DEADMAN");
    object oItem=GetLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"CLERIC");
    DeleteLocalObject(oUser,"DEADMAN");
    int iLevel=GetLevelByClass(CLASS_TYPE_CLERIC, oCleric);

    /* added by yibble for cohort support */
    object oRealMaster = GetLocalObject(oUser, "RealMaster");
// Make sure the PC is online
    if(GetIsPC(oCleric)==TRUE)
    {
    /* added by yibble for cohort support */
        if(REZFEEDBACK)
            SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACKNPCONLY);
        return;
    }
// Make sure the cleric is a NPC and at least level 10 (raise dead is a level
// 5 spell, requires level 10 to cast)
    if(iLevel < 9)
    {
    /* added by yibble for cohort support */
        if(REZFEEDBACK)
            SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + GetName(oCleric) + REZFEEDBACKNOTPOWERFUL);
        SetLocalInt(OBJECT_SELF, "NPCNoRez", TRUE);
        return;
    }
    int nAlign=GetLocalInt(oItem, "Alignment");
    if (nAlign != ALIGNMENT_NEUTRAL &&
        GetAlignmentGoodEvil(oCleric) != ALIGNMENT_NEUTRAL)
    {
        if (GetAlignmentGoodEvil(oCleric) != nAlign)
        {
    /* added by yibble for cohort support */
            if(REZFEEDBACK)
                SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + GetName(oCleric) + REZFEEDBACKNOTALIGN);
            SetLocalInt(OBJECT_SELF, "NPCNoRez", TRUE);
            return;
        }
    }
    int nGold=GetGold(oUser);
    int nGODSYSTEM;
    int nBaseCost=1;
    string sDeity=GetLocalString(oItem, "Deity");
// Find out how much, and see if they have that much gold.
    nGODSYSTEM=GetLocalInt(oMod,"GODSYSTEM");
    if(nGODSYSTEM && GetDeity(oCleric)==sDeity)
        nBaseCost=0;
    int iRezAmount = 90*iLevel+5000*nBaseCost;
    if (iLevel >= 17 && nGold >=iRezAmount)
        casttype = TRUE_RESS;
    else if (iLevel >= 13 && nGold >= (iRezAmount=70*iLevel+500*nBaseCost))
        casttype = RESS;
    else if (iLevel >= 9 && nGold >= (iRezAmount=50*iLevel+500*nBaseCost))
        casttype = RAISE;
    if (casttype == NONE)
    {
    /* added by yibble for cohort support */
        if(REZFEEDBACK)
            SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + GetName(oCleric) + REZFEEDBACKNOTENOUGH + IntToString(iRezAmount) + " gps.");
        SetLocalInt(OBJECT_SELF, "NPCNoRez", iRezAmount);
        return;
    }

// Charge em and raise the dead man
    AssignCommand(oCleric,TakeGoldFromCreature(iRezAmount, oUser, TRUE));
    /* added by yibble for cohort support */
    if(REZFEEDBACK)
        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + GetName(oCleric) + REZFEEDBACKCLERICACCEPT + IntToString(iRezAmount) + " gps.");
    if(GetIsObjectValid(oRespawner))
    {
        MoveDC(oItem, oUser);
        SetPlotFlag(oRespawner, FALSE);
        RemoveEffects(oRespawner);
        if(GetLocalInt(oMod,"GHOSTSYSTEM"))
            DeleteLocalInt(oRespawner, "GHOST");
        AssignCommand(oRespawner, ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectResurrection(),oRespawner));
        if(GetLocalInt(oMod,"BLEEDSYSTEM") && GetIsPC(oRespawner))
        {
                DelayCommand(6.0,ExecuteScript("hc_bleeding", oRespawner));
        }
        if (casttype >= RESS)
            AssignCommand(oRespawner,ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner));
        else
        {
            effect eDam=EffectDamage(GetCurrentHitPoints(oRespawner)-1);
            if( !GetLocalInt(oMod,"REZPENALTY"))
                AssignCommand(oRespawner,ApplyEffectToObject(DURATION_TYPE_INSTANT,
                    eDam,oRespawner));
        }
        AssignCommand(oRespawner, JumpToObject(oCleric));
        // If playing with REZPENALTY on (default) then take the level per the phb
        // Only take XP if not using a true ressurection
        if( GetLocalInt(oMod,"REZPENALTY") && casttype != TRUE_RESS && GetIsPC(oRespawner))
            DelayCommand(5.0,hcRezPenalty(oRespawner));

        // SEI_NOTE: Re-init the subrace traits
        Subraces_RespawnSubrace( oRespawner );
    }
    else
    {
        //SendMessageToPC(oRealMaster,NOTONLINE);
        SetPersistentLocation(oMod,"RESLOC"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), GetLocation(oCleric));
        if(casttype==TRUE_RESS)
            SetLocalInt(oMod,"PlayerState"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RESTRUE);
        else if(casttype==RESS)
            SetLocalInt(oMod,"PlayerState"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RESURRECTED);
        else
            SetLocalInt(oMod,"PlayerState"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RAISEDEAD);
    }
    /* added by yibble for cohort support */
    SetLocalInt(OBJECT_SELF, "SeekingRez", FALSE);
    AssignCommand(OBJECT_SELF, DelayCommand(10.0, ActionStartConversation(oRealMaster)));

// Get rid of the Player Corpse item
    DestroyObject(oItem);
}

