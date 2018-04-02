
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
// Make sure the PC is online
    if(GetIsPC(oCleric)==TRUE)
    {
        SendMessageToPC(oUser,NPCONLY);
        return;
    }
// Make sure the cleric is a NPC and at least level 10 (raise dead is a level
// 5 spell, requires level 10 to cast)
    if(iLevel < 9)
    {
        SendMessageToPC(oUser,NOTPOWERFUL);
        return;
    }
//    int nAlign=GetLocalInt(oItem, "Alignment");
//    if (nAlign != ALIGNMENT_NEUTRAL &&
//        GetAlignmentGoodEvil(oCleric) != ALIGNMENT_NEUTRAL)
//    {
//        if (GetAlignmentGoodEvil(oCleric) != nAlign)
//        {
//            SendMessageToPC(oUser,NOTALIGN);
//            return;
//        }
//    }
    int nGold=GetGold(oUser);
    int nGODSYSTEM;
    int nBaseCost=1;
    string sDeity=GetLocalString(oItem, "Deity");
    // Find out how much, and see if they have that much gold.
    nGODSYSTEM=GetLocalInt(oMod,"GODSYSTEM");
//    if(nGODSYSTEM && GetDeity(oCleric)==sDeity)
//        nBaseCost=0;
    int iRezAmount = 90*iLevel+5500*nBaseCost;
//    if (iLevel >= 17 && nGold >=iRezAmount)
//        casttype = TRUE_RESS;
    if (iLevel >= 13 && nGold >= (iRezAmount=70*iLevel+500*nBaseCost))
        casttype = RESS;
    else if (iLevel >= 9 && nGold >= (iRezAmount=50*iLevel+500*nBaseCost))
        casttype = RAISE;
    if (casttype == NONE)
    {
        SendMessageToPC(oUser,NOTENOUGH+IntToString(iRezAmount)+" gps.");
        return;
    }
    // Charge em and raise the dead man
    AssignCommand(oCleric,TakeGoldFromCreature(iRezAmount, oUser, TRUE));
    SendMessageToPC(oUser, CLERICACCEPT);
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
            if( !GetLocalInt(oMod,"REZPENALTY") && GetIsPC(oRespawner))
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
        SendMessageToPC(oUser,"Player not on-line. Invalid attempt to raise from dead.");
//        SetPersistentLocation(oMod,"RESLOC"+
//            GetLocalString(oItem,"Name")+
//            GetLocalString(oItem,"Key"), GetLocation(oCleric));
//        if(casttype==TRUE_RESS)
//            SetLocalInt(oMod,"PlayerState"+
//            GetLocalString(oItem,"Name")+
//            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RESTRUE);
//        else if(casttype==RESS)
//            SetLocalInt(oMod,"PlayerState"+
//            GetLocalString(oItem,"Name")+
//            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RESURRECTED);
//        else
//            SetLocalInt(oMod,"PlayerState"+
//            GetLocalString(oItem,"Name")+
//            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RAISEDEAD);
    }
// Get rid of the Player Corpse item
    DestroyObject(oItem);
}
