#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Cure Minor Wounds
//:: NW_S0_CurMinW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure minor wounds
// cures only 1 point of damage
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: Feb 22, 2001
//:: Last Updated By: Preston Watamaniuk, On: April 6, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    spellsCure(4, 0, 4, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, GetSpellId());
}}
