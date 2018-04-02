/****************************************************
  Action Taken Script : Categories Custom Tokens
  ats_at_cr_categ

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the custom conversation tokens
  for the crafting menu for the different
  categories.
***************************************************/

#include "ats_const_recipe"
#include "ats_inc_menu"

void main()
{
    object oPlayer = GetPCSpeaker();

    string sCraftType = ATS_GetCurrentCraftType(oPlayer);

    if(sCraftType == ATS_CRAFT_TYPE_ARMOR)
    {
        SetCustomToken(54000,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_ARMORCRAFTING_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_WEAPON)
    {
        SetCustomToken(54010,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_0);
        SetCustomToken(54011,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_1);
        SetCustomToken(54012,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_2);
        SetCustomToken(54013,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_3);
        SetCustomToken(54014,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_4);
        SetCustomToken(54015,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_5);
        SetCustomToken(54016,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_6);
        SetCustomToken(54017,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_7);
        SetCustomToken(54018,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_8);
        SetCustomToken(54019,  CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_LEATHER)
    {
        SetCustomToken(54000,  CSTR_CRAFT_TANNING_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_TANNING_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_TANNING_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_TANNING_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_TANNING_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_TANNING_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_TANNING_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_TANNING_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_TANNING_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_TANNING_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_GEMCUTTING)
    {
        SetCustomToken(54000,  CSTR_CRAFT_GEMCUTTING_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_GEMCUTTING_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_GEMCUTTING_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_GEMCUTTING_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_GEMCUTTING_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_GEMCUTTING_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_GEMCUTTING_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_GEMCUTTING_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_GEMCUTTING_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_GEMCUTTING_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_JEWELCRAFT)
    {
        SetCustomToken(54000,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_JEWELCRAFTING_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_BOWYERING)
    {
        SetCustomToken(54000,  CSTR_CRAFT_BOWYERING_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_BOWYERING_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_BOWYERING_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_BOWYERING_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_BOWYERING_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_BOWYERING_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_BOWYERING_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_BOWYERING_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_BOWYERING_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_BOWYERING_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_FLETCHING)
    {
        SetCustomToken(54000,  CSTR_CRAFT_FLETCHING_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_FLETCHING_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_FLETCHING_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_FLETCHING_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_FLETCHING_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_FLETCHING_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_FLETCHING_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_FLETCHING_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_FLETCHING_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_FLETCHING_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_TAILOR)
    {
        SetCustomToken(54000,  CSTR_CRAFT_TAILOR_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_TAILOR_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_TAILOR_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_TAILOR_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_TAILOR_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_TAILOR_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_TAILOR_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_TAILOR_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_TAILOR_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_TAILOR_CATEGORY_9);
    }
    else if(sCraftType == ATS_CRAFT_TYPE_TINKER)
    {
        SetCustomToken(54000,  CSTR_CRAFT_TINKER_CATEGORY_0);
        SetCustomToken(54001,  CSTR_CRAFT_TINKER_CATEGORY_1);
        SetCustomToken(54002,  CSTR_CRAFT_TINKER_CATEGORY_2);
        SetCustomToken(54003,  CSTR_CRAFT_TINKER_CATEGORY_3);
        SetCustomToken(54004,  CSTR_CRAFT_TINKER_CATEGORY_4);
        SetCustomToken(54005,  CSTR_CRAFT_TINKER_CATEGORY_5);
        SetCustomToken(54006,  CSTR_CRAFT_TINKER_CATEGORY_6);
        SetCustomToken(54007,  CSTR_CRAFT_TINKER_CATEGORY_7);
        SetCustomToken(54008,  CSTR_CRAFT_TINKER_CATEGORY_8);
        SetCustomToken(54009,  CSTR_CRAFT_TINKER_CATEGORY_9);
    }
    SetLocalInt(oPlayer, "ats_craft_category_count", 0);
}
