/****************************************************
  Mineable Rock OnPhysicalAttacked Script
  ats_mrock_atk

  Last Updated: August 19, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on a Mineable Rock's
  OnPhysicalAttacked trigger.  It is responsible
  for calculating mining success and creating the
  appropriate results.
****************************************************/

#include "ats_inc_skill_mn"


void main()
{
    object oPlayer = GetLastAttacker();
    // Gets the mining tool
    object oWeaponOnPlayer = GetLastWeaponUsed(oPlayer);
    int iMaterialType = GetLocalInt(OBJECT_SELF, "ats_material_type");
    if(iMaterialType == CINT_MATERIAL_UNKNOWN)
    {
        FloatingTextStringOnCreature("You cannot mine this rock.", oPlayer, FALSE);
        return;
    }
    DelayCommand(2.0, AssignCommand(oPlayer, ClearAllActions()));
    if(ATS_GetTagBaseType(oWeaponOnPlayer) != CSTR_MINETOOL1 && ATS_GetTagBaseType(oWeaponOnPlayer) != CSTR_MINETOOL2 && ATS_GetTagBaseType(oWeaponOnPlayer) != CSTR_MINETOOL3)
    {
        FloatingTextStringOnCreature("You failed to find anything since one of your mining tools was unequipped", oPlayer, FALSE);
        return;
    }
    int iHealAmount = GetMaxHitPoints() - GetCurrentHitPoints();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(iHealAmount), OBJECT_SELF);
    if(ATS_GetItemDurability(OBJECT_SELF) > 0)
        ATS_DecreaseItemDurability(OBJECT_SELF, 1);
//     DEBUG_PrintString("Rock Durability: " + IntToString(ATS_GetItemDurability(OBJECT_SELF)));
    ATS_AdjustCraftToolDurability(oWeaponOnPlayer, 1);
    int iMiningResult = CalculateMiningSuccess(oPlayer, iMaterialType);

    if(iMiningResult == CINT_SUCCESS)
        {
            if(ATS_GetIsMaterialTypeGem(iMaterialType) == TRUE)
                DelayCommand(2.75, CreateRoughGemOnPlayer(iMaterialType, oPlayer));
            else
                DelayCommand(2.75, CreateOreOnPlayer(iMaterialType, oPlayer));

            if( ATS_CheckTrivial(oPlayer, iMaterialType) == TRUE)
                DelayCommand(2.0, FloatingTextStringOnCreature("This rock has become trivial to mine.", oPlayer, FALSE));
        }
    else if(iMiningResult == CINT_FAILURE)
       {
            if(d100(1) <= CINT_SKILLGAIN_FAILURE  && ATS_CheckTrivial(oPlayer, iMaterialType) == FALSE)
                DelayCommand(2.0, ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_MINING, 1));
            DelayCommand(2.0, FloatingTextStringOnCreature(CSTR_MINE_FAILURE, oPlayer, FALSE));

       }
    else
    {
        FloatingTextStringOnCreature("You are too unskilled to break free anything from this rock.", oPlayer, FALSE);
    }



//    if(ATS_GetItemDurability(OBJECT_SELF) <= 0)
//        DelayCommand(2.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF));




}
