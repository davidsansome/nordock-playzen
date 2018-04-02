//::///////////////////////////////////////////////
//:: Dying Script
//:: NW_O0_DEATH.NSS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Hacked and modded to do bleeding to death, thank you very much
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: November 6, 2001
//:://////////////////////////////////////////////

void main()
{
    object oPlayer;
    effect eDamage = EffectDamage(11,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE) ;
    oPlayer = GetLastPlayerDying();
    ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPlayer );


}

