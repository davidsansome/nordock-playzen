#include "ats_const_recipe"

void ATS_DeleteRecipe(string sRecipeTag)
{
    DeleteLocalString(GetModule(), sRecipeTag + "_name");
    DeleteLocalInt(GetModule(), sRecipeTag);
    DeleteLocalInt(GetModule(), sRecipeTag + "_custom_material");
    DeleteLocalInt(GetModule(), sRecipeTag + "_ingots");
    DeleteLocalInt(GetModule(), sRecipeTag + "_gems");
    DeleteLocalInt(GetModule(), sRecipeTag + "_idealgems");
    DeleteLocalInt(GetModule(), sRecipeTag + "_singletype");
    DeleteLocalInt(GetModule(), sRecipeTag + "_race_restrict");
    DeleteLocalInt(GetModule(), sRecipeTag + "_race_restrict_count");
    DeleteLocalInt(GetModule(), sRecipeTag + "_class_restrict");
    DeleteLocalInt(GetModule(), sRecipeTag + "_class_restrict_count");
    DeleteLocalInt(GetModule(), sRecipeTag + "_alternate_count");
    DeleteLocalInt(GetModule(), sRecipeTag + "_display");
    DeleteLocalInt(GetModule(), sRecipeTag + "_alignment_good");
    DeleteLocalInt(GetModule(), sRecipeTag + "_alignment_evil");
    DeleteLocalInt(GetModule(), sRecipeTag + "_alignment_lawful");
    DeleteLocalInt(GetModule(), sRecipeTag + "_alignment_neutral");
    DeleteLocalInt(GetModule(), sRecipeTag + "_alignment_chaotic");
    DeleteLocalInt(GetModule(), sRecipeTag + "_failureproduct_count");
    DeleteLocalString(GetModule(), sRecipeTag + "_next_recipetag");
    DeleteLocalInt(GetModule(), sRecipeTag + "_alternate_count");

}

void ATS_ClearRecipeArray(string sCraftType)
{
    string sRecipeArrayPrefix =  "ATS_RA_" + ATS_CRAFT_TYPE_ARMOR;
    string sRecipeArrayName;
    string sRecipeTag;
    string sAlternateRecipeTag;

    int i, j, k;
    int iTotal;
    int iAlternateCount;
    // Interate through each category
    for(i = 0; i < 10; ++i)
    {
        sRecipeArrayName = sRecipeArrayPrefix + IntToString(i) + "_";
        iTotal = GetLocalInt(GetModule(), sRecipeArrayName + "Count");
        for(j = 0; j < iTotal; ++j)
        {
            sRecipeTag = GetLocalString(GetModule(), sRecipeArrayName + IntToString(j));
            if(sRecipeTag != "")
            {
                DeleteLocalString(GetModule(), sRecipeArrayName + IntToString(j));
                iAlternateCount = GetLocalInt(GetModule(), sRecipeTag + "_alternate_count");
                ATS_DeleteRecipe(sRecipeTag);

                for(k = 0; k < iAlternateCount; ++k)
                {
                    sAlternateRecipeTag = sRecipeTag + "_alternate_" + IntToString(k);
                    ATS_DeleteRecipe(sRecipeTag);
                }
            }

        }


    }

}

void main()
{
    ATS_ClearRecipeArray(ATS_CRAFT_TYPE_ARMOR);
    ATS_ClearRecipeArray(ATS_CRAFT_TYPE_WEAPON);
    ATS_ClearRecipeArray(ATS_CRAFT_TYPE_LEATHER);
    ATS_ClearRecipeArray(ATS_CRAFT_TYPE_BLACKSMITH);
    ATS_ClearRecipeArray(ATS_CRAFT_TYPE_JEWELCRAFT);
    ATS_ClearRecipeArray(ATS_CRAFT_TYPE_GEMCUTTING);
}
