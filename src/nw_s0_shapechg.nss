// creates the sBluePrint item on the object oTarget
void CreatePolyItem(string sBlueprint, object oTarget)
{
CreateItemOnObject(sBlueprint, oTarget);
}


#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Shapechange
//:: NW_S0_ShapeChg.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 22, 2002
//:://////////////////////////////////////////////

void main()
{
    if(SpellSuccess()){
    // Clear Action Queue to prevent chain casting exploit
    AssignCommand(GetSpellTargetObject(),ClearAllActions());
    //Declare major variables
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect ePoly;
    int nPoly;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    //Determine Polymorph subradial type
    if(nSpell == 392)
    {
        nPoly = POLYMORPH_TYPE_RED_DRAGON;
    }
    else if (nSpell == 393)
    {
        nPoly = POLYMORPH_TYPE_FIRE_GIANT;
    }
    else if (nSpell == 394)
    {
        nPoly = POLYMORPH_TYPE_BALOR;
    }
    else if (nSpell == 395)
    {
        nPoly = POLYMORPH_TYPE_DEATH_SLAAD;
    }
    else if (nSpell == 396)
    {
        nPoly = POLYMORPH_TYPE_IRON_GOLEM;
    }
    ePoly = EffectPolymorph(nPoly);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHAPECHANGE, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration)));

}}
