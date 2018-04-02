#include "ats_inc_constant"
#include "ats_config"
#include "ats_inc_common"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_tool"


/////////////////////////////////////////////////////
// ATS_GetMiningLevel                              //
//      Gets the minimum skill level for mining    //
//      the specified ore material                 //
// Returns: int - minimum skill value              //
/////////////////////////////////////////////////////
int ATS_GetMiningLevel
(
int iOreType    // Material constant for an ore
)
{
    // Metals
    if(iOreType == CINT_MATERIAL_COPPER)
        return CINT_MINELEVEL_COPPER;
    else if(iOreType == CINT_MATERIAL_BRONZE)
        return CINT_MINELEVEL_BRONZE;
    else if(iOreType == CINT_MATERIAL_IRON)
        return CINT_MINELEVEL_IRON;
    else if(iOreType == CINT_MATERIAL_SILVER)
        return CINT_MINELEVEL_SILVER;
    else if(iOreType == CINT_MATERIAL_GOLD)
        return CINT_MINELEVEL_GOLD;
    else if(iOreType == CINT_MATERIAL_SHADOW)
        return CINT_MINELEVEL_SHADOW;
    else if(iOreType == CINT_MATERIAL_VERDICITE)
        return CINT_MINELEVEL_VERDICITE;
    else if(iOreType == CINT_MATERIAL_RUBICITE)
        return CINT_MINELEVEL_RUBICITE;
    else if(iOreType == CINT_MATERIAL_SYENITE)
        return CINT_MINELEVEL_SYENITE;
    else if(iOreType == CINT_MATERIAL_MITHRAL)
        return CINT_MINELEVEL_MITHRAL;
    else if(iOreType == CINT_MATERIAL_ADAMANTINE)
        return CINT_MINELEVEL_ADAMANTINE;
    else if(iOreType == CINT_MATERIAL_MYRKANDITE)
        return CINT_MINELEVEL_MYRKANDITE;

    // Gems
    else if(iOreType == CINT_MATERIAL_MALACHITE)
        return CINT_MINELEVEL_MALACHITE;
    else if(iOreType == CINT_MATERIAL_AMETHYST)
        return CINT_MINELEVEL_AMETHYST;
    else if(iOreType == CINT_MATERIAL_LAPIS_LAZULI)
        return CINT_MINELEVEL_LAPIS_LAZULI;
    else if(iOreType == CINT_MATERIAL_TURQUOISE)
        return CINT_MINELEVEL_TURQUOISE;
    else if(iOreType == CINT_MATERIAL_OPAL)
        return CINT_MINELEVEL_OPAL;
    else if(iOreType == CINT_MATERIAL_ONYX)
        return CINT_MINELEVEL_ONYX;
    else if(iOreType == CINT_MATERIAL_JADE)
        return CINT_MINELEVEL_JADE;
    else if(iOreType == CINT_MATERIAL_PEARL)
        return CINT_MINELEVEL_PEARL;
    else if(iOreType == CINT_MATERIAL_SAPPHIRE)
        return CINT_MINELEVEL_SAPPHIRE;
    else if(iOreType == CINT_MATERIAL_BLACK_SAPPHIRE)
        return CINT_MINELEVEL_BLACK_SAPPHIRE;
    else if(iOreType == CINT_MATERIAL_FIRE_OPAL)
        return CINT_MINELEVEL_FIRE_OPAL;
    else if(iOreType == CINT_MATERIAL_RUBY)
        return CINT_MINELEVEL_RUBY;
    else if(iOreType == CINT_MATERIAL_EMERALD)
        return CINT_MINELEVEL_EMERALD;
    else if(iOreType == CINT_MATERIAL_DIAMOND)
        return CINT_MINELEVEL_DIAMOND;
    else
        return 0;
}

void CreateOreOnPlayer(int iOreType, object oPlayer)
{
    string sMaterialName = ATS_GetMaterialName(iOreType);
    FloatingTextStringOnCreature("You have found some " + sMaterialName + " ore!", oPlayer, FALSE);
    string sOreTag = "ATS_R_" + CSTR_ORE_BASETAG + "_N_" + ATS_GetMaterialTag(iOreType);
    //ATS_CreateItemOnPlayer(sOreTag, oPlayer);
    object oCreatedItem = CreateObject(OBJECT_TYPE_ITEM, ATS_GetResRefFromTag(sOreTag), GetLocation(oPlayer));
    AssignCommand(oPlayer, ActionPickUpItem(oCreatedItem));
}

void CreateRoughGemOnPlayer(int iGemType, object oPlayer)
{
    string sMaterialName = ATS_GetMaterialName(iGemType);
    FloatingTextStringOnCreature("You have found a rough " + sMaterialName + "!", oPlayer, FALSE);
    string sGemTag = "ATS_R_" + CSTR_GEM_BASETAG + "_N_" + ATS_GetMaterialTag(iGemType);
    //ATS_CreateItemOnPlayer(sOreTag, oPlayer);
    object oCreatedItem = CreateObject(OBJECT_TYPE_ITEM, ATS_GetResRefFromTag(sGemTag), GetLocation(oPlayer));
    AssignCommand(oPlayer, ActionPickUpItem(oCreatedItem));
}

int CalculateMiningSuccess(object oPlayer, int iMaterialType)
{
    int iDiceRoll = d100(1) / 2;
    int iMaterialDifficulty = ATS_GetMiningLevel(iMaterialType);
    int iFlatFailure = FALSE;

    if(d100(1) <= CINT_FLATFAILURE_OVERALL)
        iFlatFailure = TRUE;
    if(d100(1) <= ATS_GetFlatFailure(CSTR_SKILLNAME_MINING))
        iFlatFailure = TRUE;


    int iSuccessLevel = iMaterialDifficulty - ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_MINING);
    if((iSuccessLevel - GetAbilityModifier(ABILITY_STRENGTH, oPlayer)) > 50)
    {
        return CINT_UNSKILLED;
    }
    else if(iFlatFailure == TRUE)
        return CINT_FAILURE;

    if( (iDiceRoll + GetAbilityModifier(ABILITY_STRENGTH, oPlayer) > iSuccessLevel) && (iDiceRoll != 0) )
    {
        if(iSuccessLevel <= 0)
            return CINT_SUCCESS;

        int iBaseSkillGainChance = 5 + iSuccessLevel + GetAbilityModifier(ABILITY_INTELLIGENCE, oPlayer);
        int iSkillGainAdjustment = FloatToInt((CFLOAT_SKILLGAIN_ADJUST_OVERALL * iBaseSkillGainChance) +
                                           (ATS_GetSkillGainAdjustment(CSTR_SKILLNAME_MINING) * iBaseSkillGainChance));

        iDiceRoll = d100(1);
        if(iDiceRoll <= (iBaseSkillGainChance + iSkillGainAdjustment) )
            DelayCommand(2.0, ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_MINING, 1));
        return CINT_SUCCESS;
    }
    else
        return CINT_FAILURE;
}
int ATS_CheckTrivial(object oPlayer,int iMaterialType)
{
    return (ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_MINING) >= ATS_GetMiningLevel(iMaterialType));
}
