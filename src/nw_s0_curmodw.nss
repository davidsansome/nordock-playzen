#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Cure Moderate Wounds
//:: NW_S0_CurModW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure moderate wounds
// cures 2d8 points of damage plus 1 point per
// caster level (up to +10).
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 25, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    spellsCure(d8(2), 10, 16, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_M, GetSpellId());
}
}
