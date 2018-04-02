#include "ats_const_recipe"
#include "ats_inc_menu"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    int bCategoryVisible = TRUE;
    string sCraftType = ATS_GetCurrentCraftType(oPlayer);
    int iCategoryCount = GetLocalInt(oPlayer, "ats_craft_category_count");


    if(sCraftType == ATS_CRAFT_TYPE_ARMOR)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_ARMORCRAFTING_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
    else if(sCraftType == ATS_CRAFT_TYPE_WEAPON)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
    else if(sCraftType == ATS_CRAFT_TYPE_LEATHER)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_TANNING_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_TANNING_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_TANNING_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_TANNING_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_TANNING_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_TANNING_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_TANNING_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_TANNING_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_TANNING_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_TANNING_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
    else if(sCraftType == ATS_CRAFT_TYPE_GEMCUTTING)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_GEMCUTTING_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
    else if(sCraftType == ATS_CRAFT_TYPE_JEWELCRAFT)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_JEWELCRAFTING_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
    else if(sCraftType == ATS_CRAFT_TYPE_BOWYERING)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_BOWYERING_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
    else if(sCraftType == ATS_CRAFT_TYPE_FLETCHING)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_FLETCHING_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
//Tailoring Code Statements
    else if(sCraftType == ATS_CRAFT_TYPE_TAILOR)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_TAILOR_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_TAILOR_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_TAILOR_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_TAILOR_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_TAILOR_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_TAILOR_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_TAILOR_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_TAILOR_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_TAILOR_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_TAILOR_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }
///TAILORING CODE ENDS
    else if(sCraftType == ATS_CRAFT_TYPE_TINKER)
    {
        switch(iCategoryCount)
         {
            case 0:
                if(CSTR_CRAFT_TINKER_CATEGORY_0 == "")
                    bCategoryVisible = FALSE;
                break;
            case 1:
                if(CSTR_CRAFT_TINKER_CATEGORY_1 == "")
                    bCategoryVisible = FALSE;
                break;
            case 2:
                if(CSTR_CRAFT_TINKER_CATEGORY_2 == "")
                    bCategoryVisible = FALSE;
                break;
            case 3:
                if(CSTR_CRAFT_TINKER_CATEGORY_3 == "")
                    bCategoryVisible = FALSE;
                break;
            case 4:
                if(CSTR_CRAFT_TINKER_CATEGORY_4 == "")
                    bCategoryVisible = FALSE;
                break;
            case 5:
                if(CSTR_CRAFT_TINKER_CATEGORY_5 == "")
                    bCategoryVisible = FALSE;
                break;
            case 6:
                if(CSTR_CRAFT_TINKER_CATEGORY_6 == "")
                    bCategoryVisible = FALSE;
                break;
            case 7:
                if(CSTR_CRAFT_TINKER_CATEGORY_7 == "")
                    bCategoryVisible = FALSE;
                break;
            case 8:
                if(CSTR_CRAFT_TINKER_CATEGORY_8 == "")
                    bCategoryVisible = FALSE;
                break;
            case 9:
                if(CSTR_CRAFT_TINKER_CATEGORY_9 == "")
                    bCategoryVisible = FALSE;
                break;
        }
    }



    if(ATS_GetCraftArraySize(sCraftType, iCategoryCount) == 0)
        bCategoryVisible = FALSE;

    iCategoryCount++;
    SetLocalInt(oPlayer, "ats_craft_category_count", iCategoryCount);

    return bCategoryVisible;
}
