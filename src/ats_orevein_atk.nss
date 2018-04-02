/****************************************************
  Orevein OnPhysicalAttacked Script
  ats_orevein_atk

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on an Orevein's
  OnPhysicalAttacked trigger.  It is responsible
  for calculating mining success and creating the
  appropriate results.
****************************************************/

#include "ats_inc_skill_mn"
#include "ats_inc_stats"


void main()
{
    object oPlayer = GetLastAttacker();
    // Gets the mining tool
    object oWeaponOnPlayer = GetLastWeaponUsed(oPlayer);
    int iOreType = ATS_GetMaterialType(OBJECT_SELF);
//Commenting out as suggested by Death 09/08/2003
//Hopefully wont lead to too many AFK players
//Undoing - wont work, but if did would lead to a single attack allowing attacks even after pick breaks
    DelayCommand(2.0, AssignCommand(oPlayer, ClearAllActions()));
    if(ATS_GetTagBaseType(oWeaponOnPlayer) != CSTR_MINETOOL1 && ATS_GetTagBaseType(oWeaponOnPlayer) != CSTR_MINETOOL2 && ATS_GetTagBaseType(oWeaponOnPlayer) != CSTR_MINETOOL3)
    {
        FloatingTextStringOnCreature("You failed to find any ore since one of your mining tools was unequipped", oPlayer, FALSE);
        return;
    }

    ATS_AdjustCraftToolDurability(oWeaponOnPlayer, 1);
    int iMiningResult = CalculateMiningSuccess(oPlayer, iOreType);
    ATS_IncrementAttemptsCount(oPlayer, CSTR_SKILLNAME_MINING);

    if(iMiningResult == CINT_SUCCESS)
        {
            ATS_IncrementSuccessCount(oPlayer, CSTR_SKILLNAME_MINING);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1), OBJECT_SELF);
            DelayCommand(2.75, CreateOreOnPlayer(iOreType, oPlayer));
            if(d100(1) <= 3 * GetAbilityModifier(ABILITY_STRENGTH, oPlayer))
                DelayCommand(3.50, CreateOreOnPlayer(iOreType, oPlayer));
            if( ATS_CheckTrivial(oPlayer, iOreType) == TRUE)
                DelayCommand(2.0, FloatingTextStringOnCreature("This ore vein has become trivial to mine.", oPlayer, FALSE));

        }
    else if(iMiningResult == CINT_FAILURE)
       {
            if(d100(1) <= CINT_SKILLGAIN_FAILURE  && ATS_CheckTrivial(oPlayer, iOreType) == FALSE)
                DelayCommand(2.0, ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_MINING, 1));
            DelayCommand(2.0, FloatingTextStringOnCreature(CSTR_MINE_FAILURE, oPlayer, FALSE));

       }
    else
    {
        FloatingTextStringOnCreature("You are too unskilled to break free any of this ore.", oPlayer, FALSE);
    }




}
