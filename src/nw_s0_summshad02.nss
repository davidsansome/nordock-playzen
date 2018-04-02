//::///////////////////////////////////////////////
//:: Summon Shadow
//:: NW_S0_SummShad02.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spell powerful ally from the shadow plane to
    battle for the wizard
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////
#include "hc_inc"

void check_strength()
{
    object oMaster=OBJECT_SELF;
    object oAC=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oMaster);
    int nMHD=GetHitDice(oMaster);
    int nAHD=GetHitDice(oAC);
    if(nAHD>nMHD)
    {
        effect eDisap=EffectDisappear();
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisap, oAC);
        SendMessageToPC(oMaster,"The shadow returns to its home plane, it is "+
            "powerful for you to control.");
    }
}

void main()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_CLERIC);
    effect eSummon;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

    //Set the summoned undead to the appropriate template based on the caster level
    if (nCasterLevel <= 7)
    {
        eSummon = EffectSummonCreature("NW_S_SHADOW",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 8) && (nCasterLevel <= 10))
    {
        eSummon = EffectSummonCreature("NW_S_SHADMASTIF",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 11) && (nCasterLevel <= 14))
    {
        eSummon = EffectSummonCreature("NW_S_SHFIEND",VFX_FNF_SUMMON_UNDEAD); // change later
    }
    else if ((nCasterLevel >= 15))
    {
        eSummon = EffectSummonCreature("NW_S_SHADLORD",VFX_FNF_SUMMON_UNDEAD);
    }

    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(24));
    if(GetLocalInt(oMod,"REALFAM"))
            DelayCommand(1.0,check_strength());
}

