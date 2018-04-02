//::///////////////////////////////////////////////
//:: [Ressurection]
//:: [NW_S0_Ressurec.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with full
//:: health.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001

#include "wm_include"
#include "hc_inc_remeff"
#include "hc_inc_pwdb_func"
#include "hc_text_activate"
#include "hc_inc_rezpen"
#include "tru_rez_include"

void main()
{
    if (WildMagicOverride()) { return; }
    //Get the spell target
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    //Check to make sure the target is dead first
    int nAtDC;
    object oDC;
    if(GetLocalInt(oMod,"MATERCOMP") && GetIsPC(oCaster) && GetIsDM(oCaster)==FALSE)
    {
        object oComp;
        if( (oComp=GetItemPossessedBy(oCaster, "ressdiamond"))==OBJECT_INVALID)
        {
            SendMessageToPC(oCaster,"You do not have the required materials to "+
                "cast this spell.  For this spell you need a small diamond.");
            AssignCommand(oCaster, ClearAllActions());
            return;
        }
        else
            DestroyObject(oComp);
    }
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
    {
        if(GetTag(oTarget)=="DeathCorpse")
        {
            oDC=oTarget;
            oTarget=GetLocalObject(oDC,"Owner");
            nAtDC=1;
        }
    }
    if(nAtDC || GetIsDead(oTarget))
    {
        if(nAtDC && GetIsObjectValid(oTarget)==FALSE)
        {
            SendMessageToPC(oCaster,"Player not on line. Invalid ressurection.");
            AssignCommand(oCaster, ClearAllActions());
            return;
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));

        ResurrectPlayer(oTarget, oCaster, RES_SPELL);
    }
}


