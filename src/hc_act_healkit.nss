#include "hc_inc"
#include "hc_text_activate"

void main()
{

    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
    string sName=GetName(oOther);
    string sCDK=GetPCPublicCDKey(oOther);
    //If target is bleeding, attempt to stop the bleeding.
    if(GPS(oOther) == PWS_PLAYER_STATE_STABLE ||
     GPS(oOther) == PWS_PLAYER_STATE_DYING ||
     GPS(oOther) == PWS_PLAYER_STATE_RECOVERY ||
     GPS(oOther) == PWS_PLAYER_STATE_STABLEHEAL)
    {
        AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
        DelayCommand(1.0,AssignCommand(oUser,
ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW)));
        int nHeal = GetSkillRank(SKILL_HEAL, oUser);
        int nRandom = d20(1);
        int nResult = nRandom + nHeal;

        if(nResult > 15)
        {
            SPS( oOther, PWS_PLAYER_STATE_DISABLED);
            int nToHeal = abs(GetCurrentHitPoints(oOther)) +1;

            effect eHeal = EffectHeal(nToHeal);
            effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oOther);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oOther);

            SendMessageToPC(oOther, DISABLEDSAY);
            SendMessageToPC(oUser, STOPBLEEDING);
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectParalyze(), oOther, 6.0);
        }

        else SendMessageToPC(oUser,NOSTOPBLEED);
        DestroyObject(oItem);
        return;
    }

        //Check for poison or disease, and attempt to remove the effect.
    effect eBad= GetFirstEffect(oOther);
    while(GetIsEffectValid(eBad))
    {
    //Check to see if the effect is poison or disease
        if (GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE)
        {
            AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
            DelayCommand(1.0,AssignCommand(oUser,
                ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW)));
            int nHeal = GetSkillRank(SKILL_HEAL, oUser);
            int nRandom = d20(1);
            int nResult = nRandom + nHeal;
             //TEMPORARY: Generate random DC from 12-22.  This will be replaced
            //by poison/disease specific DCs once I figure out how to determine
           //what type of poison or disease is afflicting the PC.
            int nDC = d6(2) + 10;

            if(nResult > nDC)
            {
                effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
                RemoveEffect(oOther, eBad);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oOther);
            }
            else SendMessageToPC(oUser, TREATMENTFAIL);

                //Destroy kit and end treatment attempt after first poison/disease effect.
            DestroyObject(oItem);
            return;
        }
        eBad=GetNextEffect(oOther);
    }

        //If target is alive and wounded, attempt to provide long term care.
    if(GPS(oOther) == PWS_PLAYER_STATE_ALIVE &&
        GetCurrentHitPoints(oOther) < GetMaxHitPoints(oOther))
    {
        //Healers cannot give themselves long term care.
        if(oOther == oUser)
        {
            SendMessageToPC(oUser, NOTSELF);
            return;
        }

            //Check if target has already received long term care since last resting
            //successful or not.
        if(GetLocalInt(oMod, "LONGTERMCARE"+sName+sCDK) != 0)
        {
            SendMessageToPC(oUser, sName+ALREADYCARE);
            return;
        }

        AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
        DelayCommand(1.0,AssignCommand(oUser,
ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW)));
        int nHeal = GetSkillRank(SKILL_HEAL, oUser);
        int nRandom = d20(1);
        int nResult = nRandom + nHeal;

        if(nResult > 15)
        {
            effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oOther);
            SetLocalInt(oMod, "LONGTERMCARE"+sName+sCDK, 2);
            SendMessageToPC(oUser, sName+TREATSUC);
            SendMessageToPC(oOther, GetName(oUser)+TENDWOUND);
        }
        else
        {
            SetLocalInt(oMod,"LONGTERMCARE"+sName+sCDK, 1);
            SendMessageToPC(oUser, sName+TREATFAIL2);
            SendMessageToPC(oOther, GetName(oUser)+TREATFAILO);
        }
        DestroyObject(oItem);
    }
}
