/****************************************************
  Action Taken Script: Forge - Smelting
  ats_forge_smelt

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for smelting ore into
  ingots.  Skill calculations are based on
  blacksmithing skill and the difficulty of the ore.
****************************************************/
#include "ats_inc_common"
#include "ats_inc_constant"
#include "ats_config"
#include "ats_inc_skill_bs"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_stats"

int CINT_SMALL_FLAME    = 1;
int CINT_MEDIUM_FLAME   = 2;
int CINT_LARGE_FLAME    = 3;

int GetFlameType()
{
    object oForgeFlame = GetNearestObjectByTag("ATS_FORGE_FLAME");
    string sFlameName = GetName(oForgeFlame);

    if(sFlameName == "Small Flame")
        return CINT_SMALL_FLAME;
    else if(sFlameName == "Medium Flame")
        return CINT_MEDIUM_FLAME;
    else if(sFlameName == "Large Flame")
        return CINT_LARGE_FLAME;
    else
        return 0;
}

void CheckTrivial(int iOreType, object oPlayer)
{
    int iMaterialDifficulty = ATS_GetSmeltingLevel(iOreType);
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING) >= iMaterialDifficulty)
        SendMessageToPC(oPlayer, "The " + ATS_GetMaterialName(iOreType) + " ore has become trivial to smelt.");
}

int ATS_CalculateSmeltingSuccess(int iOreType, object oPlayer, int iBonusSuccess)
{
    int iDiceRoll = d100(1) / 2;
    int iMaterialDifficulty = ATS_GetSmeltingLevel(iOreType);

    int iSuccessLevel = iMaterialDifficulty - ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING);
    int iFlatFailure = FALSE;

    if(d100(1) <= CINT_FLATFAILURE_OVERALL)
        iFlatFailure = TRUE;
    if(d100(1) <= ATS_GetFlatFailure(CSTR_SKILLNAME_BLACKSMITHING))
        iFlatFailure = TRUE;

    if(iSuccessLevel > 50)
    {
        return CINT_UNSKILLED;
    }
    if( (iFlatFailure == FALSE) && (iDiceRoll + iBonusSuccess > iSuccessLevel) && (iDiceRoll != 0) )
    {
        if(iSuccessLevel <= 0)
            return CINT_SUCCESS;

        int iBaseSkillGainChance = 5 + iSuccessLevel + GetAbilityModifier(ABILITY_INTELLIGENCE, oPlayer);
        int iSkillGainAdjustment = FloatToInt((CFLOAT_SKILLGAIN_ADJUST_OVERALL * iBaseSkillGainChance) +
                                           (ATS_GetSkillGainAdjustment(CSTR_SKILLNAME_BLACKSMITHING) * iBaseSkillGainChance));


        iDiceRoll = d100(1);
        if(iDiceRoll <= (iBaseSkillGainChance + iSkillGainAdjustment) )
            ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING, 1);
        return CINT_SUCCESS;
    }
    else
    {
        if(d100(1) <= CINT_SKILLGAIN_FAILURE )
            ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING, 1);
        return CINT_FAILURE;
    }
}

void ATS_SmeltOre(object oPlayer, object oCurrentItem, int iBonusIngots, int iBonusSuccess)
{
    int iOreType = ATS_GetMaterialType(oCurrentItem);
    int iSmeltingSuccess = ATS_CalculateSmeltingSuccess(iOreType, oPlayer, iBonusSuccess);

    ATS_IncrementAttemptsCount(oPlayer, CSTR_SKILLNAME_BLACKSMITHING);

    if(iSmeltingSuccess == CINT_SUCCESS)
    {
        ATS_IncrementSuccessCount(oPlayer, CSTR_SKILLNAME_BLACKSMITHING);

        string sMaterialName = ATS_GetMaterialName(iOreType);
        int iIngotsProduced = d3(1) + iBonusIngots;
        string sSuccessString = "You have successfully produced " +
                                IntToString(iIngotsProduced) + " " +
                                sMaterialName + " ingot";
        if(iIngotsProduced == 1)
            sSuccessString = sSuccessString + "!";
        else
            sSuccessString = sSuccessString + "s!";

        //SendMessageToPC(oPlayer, sSuccessString);
        FloatingTextStringOnCreature(sSuccessString, oPlayer, FALSE);

        string sIngotResRef = "ats_c_" + GetStringLowerCase(CSTR_INGOT_BASETAG)
                            + "_n_" + GetStringLowerCase(ATS_GetMaterialTag(iOreType));
        CreateItemOnObject(sIngotResRef, oPlayer, iIngotsProduced);
        DestroyObject(oCurrentItem);
   }
    else if(iSmeltingSuccess == CINT_UNSKILLED)
    {
        string sFailureString = "The " + ATS_GetMaterialName(iOreType) +
                        " ore is beyond your ability to smelt.";
        //SendMessageToPC(oPlayer, sFailureString);
        FloatingTextStringOnCreature(sFailureString, oPlayer, FALSE);
    }
    else
    {
        DestroyObject(oCurrentItem);
        string sFailureString = "You have failed to produce any ingots.";
        //SendMessageToPC(oPlayer, sFailureString);
        FloatingTextStringOnCreature(sFailureString, oPlayer, FALSE);
    }
}

void main()
{
    object oCurrentItem = GetFirstItemInInventory();
    if(oCurrentItem == OBJECT_INVALID)
        {
        FloatingTextStringOnCreature("No Ore to Smelt.", GetLastUsedBy(), FALSE);
        return;
        }
    int iFlameType = GetFlameType();
    int iBonusIngots;
    int iBonusSuccess;
    object oPlayer = GetPCSpeaker();

    if(iFlameType == CINT_SMALL_FLAME)
    {
        iBonusIngots = 2;
        iBonusSuccess = 0;
    }
    else if(iFlameType == CINT_MEDIUM_FLAME)
    {
        iBonusIngots = 1;
        iBonusSuccess = 5;
    }
    else if(iFlameType == CINT_LARGE_FLAME)
    {
        iBonusIngots = 0;
        iBonusSuccess = 10;
    }
    else
        return;


    do
    {
        if(ATS_GetTagBaseType(oCurrentItem) != CSTR_ORE_BASETAG)
        {
            oCurrentItem = GetNextItemInInventory();
            continue;
        }
        AssignCommand(oPlayer, ActionDoCommand(ATS_SmeltOre(oPlayer, oCurrentItem, iBonusIngots, iBonusSuccess)));
        AssignCommand(oPlayer, ActionWait(1.0));

        oCurrentItem = GetNextItemInInventory();
    }
    while(GetIsObjectValid(oCurrentItem) == TRUE);


    // Move miner's bags back
    oCurrentItem = GetFirstItemInInventory();
    object oForge = OBJECT_SELF;
    while(GetIsObjectValid(oCurrentItem) == TRUE)
    {
        if(ATS_GetTagBaseType(oCurrentItem) == CSTR_MINERBAG)
        {
            SetLocalInt(oCurrentItem,"Bag count",0);
            AssignCommand(oPlayer, ActionTakeItem(oCurrentItem, oForge));
        }
        oCurrentItem = GetNextItemInInventory();
    }
}

