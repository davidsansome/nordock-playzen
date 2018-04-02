/****************************************************
  Begin Crafting Script
  ats_inc_cr_begin

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains the bulk of the crafting
  system.  It is responsible for doing skill checks
  and producing the appropriate results.

*****************************************************/
#include "ats_inc_menustub"
#include "ats_inc_math"
#include "ats_inc_tool"
#include "ats_inc_stats"



void PlayCraftingAnimation(string sTradeskillName)
{
    object oPlayer = GetPCSpeaker();
    if(sTradeskillName == CSTR_SKILLNAME_ARMORCRAFTING ||
        sTradeskillName == CSTR_SKILLNAME_WEAPONCRAFTING)
    {
        ActionPauseConversation();
        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));
        DelayCommand(1.0, PlaySound("as_cv_smithhamr1"));

        location locAnvil = GetLocation(OBJECT_SELF);
        vector vEffectPos = GetPositionFromLocation(locAnvil);
        vEffectPos.z += 1.0;
        location locEffect = Location( GetAreaFromLocation(locAnvil), vEffectPos,
                                       GetFacingFromLocation(locAnvil) );

        ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect);
        DelayCommand(1.7, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(2.4, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(3.1, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(3.8, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(6.0, ActionResumeConversation());
    }
    else if(sTradeskillName == CSTR_SKILLNAME_TANNING)
    {

        if(GetLocalInt(oPlayer, "ats_tanning_subskill") == ATS_TANNING_SUBSKILL_CURING)
        {
            ActionPauseConversation();
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0));

            location locOven = GetLocation(OBJECT_SELF);
            vector vEffectPos = GetPositionFromLocation(locOven);

            float fDirection = ATS_CorrectDirection(GetFacing(OBJECT_SELF));
            vEffectPos.z += 0.25;
            vector vRelativeVector = Vector(0.1, -0.4, 0.0);
            vector vTranslate = ATS_Transform2DVector(vRelativeVector, fDirection);
            vEffectPos += vTranslate;


            location locEffect = Location( GetAreaFromLocation(locOven), vEffectPos,
                                           GetFacingFromLocation(locOven) );

            object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE, "ats_flame_small", locEffect, TRUE);
            vEffectPos = GetPositionFromLocation(locOven);

            vEffectPos.z += 4.2;
            vRelativeVector = Vector(0.0, 1.0, 0.0);
            vTranslate = ATS_Transform2DVector(vRelativeVector, fDirection);
            vEffectPos += vTranslate;
            locEffect = Location( GetAreaFromLocation(locOven), vEffectPos,
                                           GetFacingFromLocation(locOven) );

            ApplyEffectAtLocation (DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), locEffect, 3.0);
            DelayCommand(2.0, DestroyObject(oFlame));
            DelayCommand(4.0, ActionResumeConversation());
        }
        else if(GetLocalInt(oPlayer, "ats_tanning_subskill") == ATS_TANNING_SUBSKILL_TANNING)
        {
            ActionPauseConversation();
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.5));
            PlaySound("as_na_waterlap1");
            DelayCommand(5.0, ActionResumeConversation());
        }
        else if(GetLocalInt(oPlayer, "ats_tanning_subskill") == ATS_TANNING_SUBSKILL_HARDENING)
        {
            ActionPauseConversation();
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));

            location locOven = GetLocation(OBJECT_SELF);
            vector vEffectPos = GetPositionFromLocation(locOven);
            vEffectPos.z += 1.0;
            location locEffect = Location( GetAreaFromLocation(locOven), vEffectPos,
                                           GetFacingFromLocation(locOven) );

            ApplyEffectAtLocation (DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), locEffect, 2.0);
            DelayCommand(4.0, ActionResumeConversation());

        }
        else if(GetLocalInt(oPlayer, "ats_tanning_subskill") == ATS_TANNING_SUBSKILL_SEWING)
        {
            AssignCommand(oPlayer, ActionPauseConversation());
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 4.0));

            DelayCommand(3.0, AssignCommand(oPlayer, ActionResumeConversation()));

        }
    }
    else if(sTradeskillName == CSTR_SKILLNAME_GEMCUTTING)
    {
        ActionPauseConversation();
        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 3.0));
        PlaySound("as_cv_chiseling2");
        DelayCommand(3.0, ActionResumeConversation());
    }
    else if(sTradeskillName == CSTR_SKILLNAME_JEWELCRAFTING)
    {
        ActionPauseConversation();
        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));
        PlaySound("as_cv_shopmetal1");
        DelayCommand(2.5, PlaySound("it_bladesmall"));
        DelayCommand(2.75, PlaySound("it_bladesmall"));
        DelayCommand(3.0, PlaySound("it_bladesmall"));
        DelayCommand(3.25, PlaySound("it_bladesmall"));
        DelayCommand(3.5, PlaySound("it_jewelry"));
        DelayCommand(4.0, ActionResumeConversation());
    }
    else if(sTradeskillName == CSTR_SKILLNAME_BOWYERING)
    {
        ActionPauseConversation();
        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));
        PlaySound("as_cv_shopmetal1");
        DelayCommand(2.5, PlaySound("it_bladesmall"));
        DelayCommand(2.75, PlaySound("it_bladesmall"));
        DelayCommand(3.0, PlaySound("it_bladesmall"));
        DelayCommand(3.25, PlaySound("it_bladesmall"));
        DelayCommand(3.5, PlaySound("it_jewelry"));
        DelayCommand(4.0, ActionResumeConversation());
    }
    else if(sTradeskillName == CSTR_SKILLNAME_FLETCHING)
    {
        ActionPauseConversation();
        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));
        PlaySound("as_cv_shopmetal1");
        DelayCommand(2.5, PlaySound("it_bladesmall"));
        DelayCommand(2.75, PlaySound("it_bladesmall"));
        DelayCommand(3.0, PlaySound("it_bladesmall"));
        DelayCommand(3.25, PlaySound("it_bladesmall"));
        DelayCommand(3.5, PlaySound("it_jewelry"));
        DelayCommand(4.0, ActionResumeConversation());
    }
//Tailor Code Starts
    else if(sTradeskillName == CSTR_SKILLNAME_TAILOR)
    {
        ActionPauseConversation();
        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));
        PlaySound("as_cv_shopmetal1");
        DelayCommand(2.5, PlaySound("it_bladesmall"));
        DelayCommand(2.75, PlaySound("it_bladesmall"));
        DelayCommand(3.0, PlaySound("it_bladesmall"));
        DelayCommand(3.25, PlaySound("it_bladesmall"));
        DelayCommand(3.5, PlaySound("it_jewelry"));
        DelayCommand(4.0, ActionResumeConversation());
    }
///Tailor Code Ends
    else if(sTradeskillName == CSTR_SKILLNAME_TINKER)
    {
        ActionPauseConversation();
        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));
        PlaySound("as_cv_shopmetal1");
        DelayCommand(2.5, PlaySound("it_bladesmall"));
        DelayCommand(2.75, PlaySound("it_bladesmall"));
        DelayCommand(3.0, PlaySound("it_bladesmall"));
        DelayCommand(3.25, PlaySound("it_bladesmall"));
        DelayCommand(3.5, PlaySound("it_jewelry"));
        DelayCommand(4.0, ActionResumeConversation());
    }
}

int BeginCrafting(object oPlayer, string sCraftTag, int iMaterialType, float fDelay)
{
    string sTradeskillName = ATS_GetTradeSkillFromCraftTag(sCraftTag);
    string sItemTag;
    string sItemResRef;
    int iTokenOffset = ATS_GetTokenOffset(oPlayer);

    int iPlayersSkillValue = ATS_GetTradeskill(oPlayer, sTradeskillName);

    int iMinSkill = ATS_GetCraftMinSkill(sCraftTag);
    int iMaxSkill = ATS_GetCraftMaxSkill(sCraftTag);

    if(ATS_IsCraftSingleType(sCraftTag) == FALSE)
    {
        iMinSkill += ATS_GetMaterialMinBonus(iMaterialType);
        iMaxSkill += ATS_GetMaterialMaxBonus(iMaterialType);
    }
    int iSkillRange = iMaxSkill - iMinSkill + 1;
    float fMultiplier = 100.0 / IntToFloat(iSkillRange);
    int iFlatFailure = FALSE;
    int iSkillGainAdjustment;
    int iBaseSkillGainChance;

    //Check Tool and adjust durability
    object oCraftTool = ATS_GetToolForCraft(oPlayer, sTradeskillName);
    if(GetLocalInt(oPlayer, "ats_flag_notool_needed") == FALSE)
    {
        if(oCraftTool == OBJECT_INVALID)
        {
            SendMessageToPC(oPlayer, "You must have the proper tool in order to finish.");
            return FALSE;
        }
        ATS_AdjustCraftToolDurability(oCraftTool, 1);
    }


    //FloatingTextStringOnCreature("Attempting to craft...", oPlayer, FALSE);
    AssignCommand(oPlayer, SpeakString("Attempting to craft..."));
    PlayCraftingAnimation(sTradeskillName);

    // Keep track of attempts
    ATS_IncrementAttemptsCount(oPlayer, sTradeskillName);

    DEBUG_PrintString("MinSkill: " + IntToString(iMinSkill) + " MaxSkill: " + IntToString(iMaxSkill));

    int iSuccessValue = FloatToInt(fMultiplier * (iMaxSkill - iPlayersSkillValue));

    int iDiceRoll;

    iDiceRoll = d100(1);
    DEBUG_PrintString("DiceRoll: " + IntToString(iDiceRoll) + " <= " + IntToString(CINT_FLATFAILURE_OVERALL));
    if(iDiceRoll <= CINT_FLATFAILURE_OVERALL)
        iFlatFailure = TRUE;

    iDiceRoll = d100(1);
    DEBUG_PrintString("DiceRoll: " + IntToString(iDiceRoll) + " <= " + IntToString(ATS_GetFlatFailure(sTradeskillName)));
    if(iDiceRoll <= ATS_GetFlatFailure(sTradeskillName))
        iFlatFailure = TRUE;



    iDiceRoll = d100(1);
    DEBUG_PrintString("DiceRoll: " + IntToString(iDiceRoll) + " + " +
                    IntToString(ATS_GetAttributeBonus(oPlayer, sTradeskillName))
                    + "     SuccessValue: " + IntToString(iSuccessValue));


    if((iFlatFailure == FALSE) &&
       (iDiceRoll + ATS_GetAttributeBonus(oPlayer, sTradeskillName) >= iSuccessValue))
    {
        //Remove materials freom player
        if(ATS_RemoveCraftMaterials(oPlayer, sCraftTag, iMaterialType) == FALSE)
        {
            //Could not find all materials
            FloatingTextStringOnCreature("Not all the materials could be found to make this.", oPlayer, FALSE);
            return FALSE;
        }

        // Success
        DelayCommand(fDelay, FloatingTextStringOnCreature("**SUCCESSFUL**", GetPCSpeaker()));
        //Successfully made normal version
        sItemTag = ATS_CraftToItemTag(sCraftTag, CSTR_QUALITY_NORMAL, ATS_GetMaterialTag(iMaterialType));

        //Keep track of successes
        ATS_IncrementSuccessCount(oPlayer, sTradeskillName);

        // Check to see if exceptional version of item exists
        if(ATS_CheckCraftItemExistence(sCraftTag, CINT_QUALITY_EXCEPTIONAL, iMaterialType) == TRUE)
        {
            //Check to see if exceptional version was made
            iDiceRoll = d100(1);
            string sRelatedSkill = ATS_GetRelatedQualitySkill(sTradeskillName);
            int iRelatedSkillValue = ATS_GetTradeskill(oPlayer, sRelatedSkill);
            if(ATS_IsPrimarySkill(sRelatedSkill) == FALSE)
                iRelatedSkillValue = 2 * iRelatedSkillValue;

            /*int iQualitySuccessValue = FloatToInt(fMultiplier * (iMaxSkill - iRelatedSkillValue));
            iQualitySuccessValue = iQualitySuccessValue / 2;
            if(iQualitySuccessValue < 0)
                iQualitySuccessValue = 0;
            iQualitySuccessValue += 50;*/

            int iQualitySuccessValue = 95 - FloatToInt(iPlayersSkillValue/100.0 + iRelatedSkillValue/200.0);

            if(iDiceRoll > iQualitySuccessValue)
            {
                //Successly made exceptional version
                sItemTag = ATS_CraftToItemTag(sCraftTag, CSTR_QUALITY_EXCEPTIONAL, ATS_GetMaterialTag(iMaterialType));
                // Check secondary skill gain
                if(iRelatedSkillValue < iMaxSkill)
                {
                    iDiceRoll = d100(1);
                    iBaseSkillGainChance = 5 + iQualitySuccessValue + GetAbilityModifier(ABILITY_INTELLIGENCE, oPlayer);
                    iSkillGainAdjustment = FloatToInt((CFLOAT_SKILLGAIN_ADJUST_OVERALL * iBaseSkillGainChance) +
                                           (ATS_GetSkillGainAdjustment(sRelatedSkill) * iBaseSkillGainChance));
                    if(iDiceRoll <= (iBaseSkillGainChance + iSkillGainAdjustment) )
                        DelayCommand(fDelay, ATS_RaiseTradeskill(oPlayer, sRelatedSkill, 1));
                }
            }
            else
            {
                // Check secondary skill gain on failure of exceptional item
                if(iRelatedSkillValue < iMaxSkill)
                {
                    iDiceRoll = d100(1);
                    if(iDiceRoll <= CINT_SKILLGAIN_FAILURE )
                        DelayCommand(fDelay, ATS_RaiseTradeskill(oPlayer, sRelatedSkill, 1));
                }
             }
        }


        // Check primary skill gain on success
        if(iPlayersSkillValue < iMaxSkill) //Check trivial
        {
            iDiceRoll = d100(1);

            iBaseSkillGainChance = 5 + iSuccessValue + GetAbilityModifier(ABILITY_INTELLIGENCE, oPlayer);
            iSkillGainAdjustment = FloatToInt((CFLOAT_SKILLGAIN_ADJUST_OVERALL * iBaseSkillGainChance) +
                                             (ATS_GetSkillGainAdjustment(sTradeskillName) * iBaseSkillGainChance));

            DEBUG_PrintString("Skill Gain Chance for" + sTradeskillName);
            DEBUG_PrintString("DiceRoll: " + IntToString(iDiceRoll) +
                             " <=    BaseSuccessValue: " + IntToString(iBaseSkillGainChance) +
                             " + SkillAdjust: " + IntToString(iSkillGainAdjustment));

            if(iDiceRoll <= (iBaseSkillGainChance + iSkillGainAdjustment) )
                DelayCommand(fDelay, ATS_RaiseTradeskill(oPlayer, sTradeskillName, 1));
        }
        sItemResRef = GetStringLowerCase(sItemTag);
        DelayCommand(fDelay + 1.0, ATS_CreateItemOnPlayer(sItemResRef, oPlayer));

        if(GetIsObjectValid(GetObjectByTag(sItemTag)) == FALSE)
            sItemTag = GetLocalString(GetModule(), sItemTag);
         // Sets the custom tag
        SetCustomToken(55090 + iTokenOffset, GetName(GetObjectByTag(sItemTag)));

        return TRUE;
    }

    // Check primary skill gain on failure
    if(iPlayersSkillValue < iMaxSkill) //Check trivial
    {
        if(d100(1) <= CINT_SKILLGAIN_FAILURE)
            DelayCommand(fDelay, ATS_RaiseTradeskill(oPlayer, sTradeskillName, 1));
    }

    return FALSE;

}
