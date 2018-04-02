#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Lesser Spell Breach
//:: NW_S0_LsSpBrch.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes 2 spell protection from an enemy mage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 10, 2002
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    if(SpellSuccess()){
    DoSpellBreach(GetSpellTargetObject(), 2, 3);
}}
