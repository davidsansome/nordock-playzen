#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Cure Light Wounds
//:: NW_S0_CurLgtW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// When laying your hand upon a living creature,
// you channel positive energy that cures 1d8 points
// of damage plus 1 point per caster level (up to +5).
// Since undead are powered by negative energy, this
// spell inflicts damage on them instead of curing
// their wounds. An undead creature can attempt a
// Will save to take half damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Brennon Holmes
//:: Created On: Oct 12, 2000
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 26, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    spellsCure(d8(), 5, 8, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_S, GetSpellId());
}
}
