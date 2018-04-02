/****************************************************
  Recipe Functions Script
  ats_inc_recipe_f

  Last Updated: August 7, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains all related recipe functions
  that are used in the creation of new recipes.
  For details on how to create a recipe, look at
  the ats_about_recipe script.
****************************************************/

void ATS_Recipe_Initialize(string sRecipeTag)
{
    SetLocalInt(GetModule(), sRecipeTag, TRUE);
    SetLocalInt(GetModule(), sRecipeTag + "_custom_material", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_ingots", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_dyes", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_clothss", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_clothsm", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_clothsl", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_flowers", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_gems", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_idealgems", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_singletype", FALSE);
    SetLocalInt(GetModule(), sRecipeTag + "_race_restrict", RACIAL_TYPE_ALL);
    SetLocalInt(GetModule(), sRecipeTag + "_race_restrict_count", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_class_restrict", CLASS_TYPE_INVALID);
    SetLocalInt(GetModule(), sRecipeTag + "_class_restrict_count", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_alternate_count", 0);
    SetLocalInt(GetModule(), sRecipeTag + "_display", TRUE);
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_good", TRUE);
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_evil", TRUE);
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_lawful", TRUE);
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_neutral", TRUE);
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_chaotic", TRUE);
    SetLocalInt(GetModule(), sRecipeTag + "_failureproduct_count", 0);
    SetLocalString(GetModule(), sRecipeTag + "_next_recipetag", "");
}

int ATS_Recipe_NewRecipe(string sItemName, string sCraftType, int iCraftCategory, int iItemID)
{
    if(iItemID > 99 || iItemID < 0)
        return FALSE;

    string sRecipeTag = "ATS_C_" + sCraftType + IntToString(iCraftCategory);
    if(iItemID < 10)
        sRecipeTag += "0";

    sRecipeTag += IntToString(iItemID);

    SetLocalString(GetModule(), "ats_current_recipe", sRecipeTag);

    // Sets up the array of recipes based on type and category
    string sRecipeArrayName = "ATS_RA_" + sCraftType + IntToString(iCraftCategory) + "_";
    int iArrayCount = GetLocalInt(GetModule(), sRecipeArrayName + "Count");
    int i = 1;
    while(i <= iArrayCount)
    {
        if(GetLocalString(GetModule(), sRecipeArrayName + IntToString(i))
           == sRecipeTag)
           break;
        ++i;
    }
    iArrayCount = i;

    SetLocalInt(GetModule(), sRecipeArrayName + "Count", iArrayCount);
    SetLocalString(GetModule(), sRecipeArrayName + IntToString(iArrayCount), sRecipeTag);

    // Initialize the recipe
    ATS_Recipe_Initialize(sRecipeTag);

    SetLocalString(GetModule(), sRecipeTag + "_name", sItemName);
    SetLocalString(GetModule(), "ats_prev_linked_recipe", sRecipeTag);

    return TRUE;

}

// This function creates another recipe for the same item base tag(meaning same category and ID)
// You can use this to create alternate components needed to make the same item OR
// to make items of the same type but different material and require different components.
// You must call this function after a new recipe has been created or after another alternate
// recipe has been added.
//
// Parameters: sRecipeName - Name to display in menu
//             bDisplay - TRUE if you want to Display this recipe separate in the menu
//                        FALSE if you just want to use the display of the original recipe
void ATS_Recipe_AddAlternateRecipe(string sRecipeName, int bDisplay = FALSE)
{
    string sRecipeTag = GetStringLeft(GetLocalString(GetModule(), "ats_current_recipe"), 10);
    string sTypeAndCategory =  GetStringLeft(GetStringRight(sRecipeTag, 4), 2);

    int iAlternateCount = GetLocalInt(GetModule(), sRecipeTag + "_alternate_count");

    ++iAlternateCount;
    SetLocalInt(GetModule(), sRecipeTag + "_alternate_count", iAlternateCount);

    sRecipeTag += ("_alternate_" + IntToString(iAlternateCount));

    if(bDisplay == TRUE)
    {
        //Adds to the array of recipes based on type and category
        string sRecipeArrayName = "ATS_RA_" + sTypeAndCategory + "_";
        int iArrayCount = GetLocalInt(GetModule(), sRecipeArrayName + "Count");
        ++iArrayCount;

        SetLocalInt(GetModule(), sRecipeArrayName + "Count", iArrayCount);
        SetLocalString(GetModule(), sRecipeArrayName + IntToString(iArrayCount), sRecipeTag);
    }
    else
    {
        string sPrevLinkedRecipe = GetLocalString(GetModule(), "ats_prev_linked_recipe");

        SetLocalString(GetModule(), sPrevLinkedRecipe + "_next_recipetag", sRecipeTag);
        SetLocalString(GetModule(), "ats_prev_linked_recipe", sRecipeTag);
    }

    SetLocalString(GetModule(), "ats_current_recipe", sRecipeTag);

    // Initialize the recipe
    ATS_Recipe_Initialize(sRecipeTag);

    SetLocalString(GetModule(), sRecipeTag + "_name", sRecipeName);
    SetLocalInt(GetModule(), sRecipeTag + "_display", bDisplay);

}


void ATS_Recipe_SetMinSkill(int iMinSkill)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_minskill", iMinSkill);

}

void ATS_Recipe_SetMaxSkill(int iMaxSkill)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_maxskill", iMaxSkill);

}
void ATS_Recipe_SetSingleType(string sItemTag)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_singletype", TRUE);
    SetLocalString(GetModule(), sRecipeTag + "_singletype_itemresref", sItemTag);
}

void ATS_Recipe_Ingots(int iIngotAmount, int iConsumptionRisk = 50, int iSalvageableRate = 80)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_ingots", iIngotAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_ingots_consumption", iConsumptionRisk);
    SetLocalInt(GetModule(), sRecipeTag + "_ingots_salvageable", iSalvageableRate);
}

void ATS_Recipe_Dyes(int iDyeAmount, int iConsumptionRisk = 50)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_dyes", iDyeAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_dyes_consumption", iConsumptionRisk);
}

void ATS_Recipe_ClothsS(int iClothAmount, int iConsumptionRisk = 50)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_clothss", iClothAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_clothss_consumption", iConsumptionRisk);
}

void ATS_Recipe_ClothsM(int iClothAmount, int iConsumptionRisk = 50)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_clothsl", iClothAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_clothsl_consumption", iConsumptionRisk);
}

void ATS_Recipe_ClothsL(int iClothAmount, int iConsumptionRisk = 50)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_clothsl", iClothAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_clothsl_consumption", iConsumptionRisk);
}

void ATS_Recipe_Flowers(int iFlowerAmount, int iConsumptionRisk = 50)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_flowers", iFlowerAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_flowers_consumption", iConsumptionRisk);
}

void ATS_Recipe_Gems(int iGemAmount, int iConsumptionRisk = 75)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_gems", iGemAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_gems_consumption", iConsumptionRisk);
}

void ATS_Recipe_IdealGems(int iGemAmount, int iConsumptionRisk = 75)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_idealgems", iGemAmount);
    SetLocalInt(GetModule(), sRecipeTag + "_idealgems_consumption", iConsumptionRisk);
}
void ATS_Recipe_AddMaterial(string sMaterialTag, int iMaterialAmount, int iConsumptionRisk = 0)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    // Gets the current number of custom materials
    int iCustomMaterialCount = GetLocalInt(GetModule(), sRecipeTag + "_custom_material");
    ++iCustomMaterialCount;
    // Sets the new number of custom materials
    SetLocalInt(GetModule(), sRecipeTag + "_custom_material", iCustomMaterialCount);

    string sCustomMaterialTag = "_custom" + IntToString(iCustomMaterialCount);
    SetLocalString(GetModule(), sRecipeTag + sCustomMaterialTag + "_tag", sMaterialTag);
    SetLocalInt(GetModule(), sRecipeTag + sCustomMaterialTag + "_amount", iMaterialAmount);
    SetLocalInt(GetModule(), sRecipeTag + sCustomMaterialTag + "_consumption", iConsumptionRisk);

}

void ATS_Recipe_SetRacialRestriction(int iRacialType = RACIAL_TYPE_ALL)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");
    int iRacialCount = GetLocalInt(GetModule(), sRecipeTag + "_race_restrict_count");

    if(iRacialType == RACIAL_TYPE_ALL)
       iRacialCount = 0;
    else
       ++iRacialCount;

    SetLocalInt(GetModule(), sRecipeTag + "_race_restrict_count", iRacialCount);
    SetLocalInt(GetModule(), sRecipeTag + "_race_restrict_" + IntToString(iRacialCount),
                iRacialType);
}

void ATS_Recipe_SetAlignmentGood(int bFlag = TRUE)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");

    SetLocalInt(GetModule(), sRecipeTag + "_alignment_good", bFlag);
}
void ATS_Recipe_SetAlignmentEvil(int bFlag = TRUE)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_evil", bFlag);
}
void ATS_Recipe_SetAlignmentLawful(int bFlag = TRUE)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_lawful", bFlag);
}
void ATS_Recipe_SetAlignmentNeutral(int bFlag = TRUE)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_neutral", bFlag);
}
void ATS_Recipe_SetAlignmentChaotic(int bFlag = TRUE)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");
    SetLocalInt(GetModule(), sRecipeTag + "_alignment_chaotic", bFlag);
}

void ATS_Recipe_SetClassRestriction(int iClassType = CLASS_TYPE_INVALID)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");
    int iClassCount = GetLocalInt(GetModule(), sRecipeTag + "_class_restrict_count");

    if(iClassType == CLASS_TYPE_INVALID)
       iClassCount = 0;
    else
       ++iClassCount;

    SetLocalInt(GetModule(), sRecipeTag + "_class_restrict_count", iClassCount);
    SetLocalInt(GetModule(), sRecipeTag + "_class_restrict_" + IntToString(iClassCount),
                iClassType);
}
// This function creates an item when someone fails at a recipe
// This can be called more than once to create multiple failure products
//
// Parameters: sProductTag - the tag of the item you wish to be created on failure
//                           (The RESREF *must* be the same as the first 16 letters of this tag)
//             iChangePercent - The percent that this product will be created on a failure
void ATS_Recipe_AddFailureProduct(string sProductTag, int iChancePercent)
{
    string sRecipeTag = GetLocalString(GetModule(), "ats_current_recipe");
    int iFailureProductCount = GetLocalInt(GetModule(), sRecipeTag + "_failureproduct_count");
    ++iFailureProductCount;
    SetLocalInt(GetModule(), sRecipeTag + "_failureproduct_count", iFailureProductCount);

    string sCurrentTag = sRecipeTag + "_failureproduct" + IntToString(iFailureProductCount);
    SetLocalString(GetModule(), sCurrentTag, sProductTag);
    SetLocalInt(GetModule(), sCurrentTag + "_chancepercent", iChancePercent);
}

