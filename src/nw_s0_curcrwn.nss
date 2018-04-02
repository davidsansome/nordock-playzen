#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Cure Critical Wounds
//:: NW_S0_CurCrWn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure critical wounds
// cures 4d8 points of damage plus 1 point per
// caster level (up to +20).
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2000
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 26, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    spellsCure(d8(4), 20, 32, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_G, GetSpellId());
}
}
