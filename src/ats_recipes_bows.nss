//------------------------------------------------------------------------------
//
// ats_inc_update
//
// Include for ATS, bowyering recipies
//
//------------------------------------------------------------------------------
//
// Author:          Allen Sun [Mojo]
// Creation Date:   xx-08-2003
//
// Last Altered By: Michael Tuffin [Grug]
// Last Altered:    22-12-2003
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 001 (22-12-2003)
// - Added commenting/code structure
// - Added missing include statement
//
// Version: 000 (Anything previous to 22-12-2003)
// - None
//
//------------------------------------------------------------------------------

#include "ats_inc_recipe_f"

//------------------------------------------------------------------------------

void ATS_BowyeringRecipies()
{
  // Shortbows C0
    // Rough Oak Hemp Shortbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 01);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_OAK");  // Rough Oak Hemp Bow
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Elm Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_ELM");  // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Ash Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_ASH");  // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Smooth Oak Hemp Shortbow
    ATS_Recipe_NewRecipe("Smooth Oak Hemp Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_OAK");  // Smooth Oak Hemp Bow
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Elm Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_ELM");  // Smooth Elm Hemp Bow
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Ash Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_ASH");  // Smooth Ash Hemp Bow
    ATS_Recipe_SetMinSkill(100);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Rough Oak Silk Shortbow
    ATS_Recipe_NewRecipe("Rough Oak Silk Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 03);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_OAK");  // Rough Oak Hemp Bow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Elm Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_ELM");  // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Ash Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_ASH");  // Rough Ash Hemp Bow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Smooth Oak Silk Shortbow
    ATS_Recipe_NewRecipe("Smooth Oak Silk Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 04);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_OAK");  // Smooth Oak Hemp Bow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Elm Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_ELM");  // Smooth Elm Hemp Bow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Ash Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_ASH");  // Smooth Ash Hemp Bow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

  // Longbows  C1
    // Rough Oak Hemp Longbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 01);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_OAK");  // Rough Oak Hemp LongBow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Elm Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_ELM");  // Rough Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Ash Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_ASH");  // Rough Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Smoothed Oak Hemp Longbow
    ATS_Recipe_NewRecipe("Smooth Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_OAK");  // Smooth Oak Hemp LongBow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Elm Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_ELM");  // Smooth Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Ash Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_ASH");  // Smooth Ash Hemp LongBow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Rough Oak Silk Longbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 03);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_OAK");  // Rough Oak Silk LongBow
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Elm Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_ELM");  // Rough Elm Silk LongBow
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Ash Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_ASH");  // Rough Elm Silk LongBow
    ATS_Recipe_SetMinSkill(110);
    ATS_Recipe_SetMaxSkill(130);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Smoothed Oak Silk Longbow
    ATS_Recipe_NewRecipe("Smooth Oak Silk Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 04);
    ATS_Recipe_SetSingleType("ATS_C_C104N_OAK");  // Smooth Oak Silk Longbow
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Elm Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C104_N_ELM");  // Smooth Elm Silk LongBow
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Ash Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C104_N_ASH");  // Smooth Ash Silk LongBow
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(150);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

  // Crossbows  C2

  // Battlebows  C3

  // Specials  C4
    // Ranger Oak Shortbow
    ATS_Recipe_NewRecipe("Ranger Oak Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SPECIALBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_402_N_OAK");  // Ranger Oak ShortBow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_SetClassRestriction(CLASS_TYPE_RANGER);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CBRP_N_POT", 1, 75);   // Bowyer Essence
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Ranger Elm Shortbow
    ATS_Recipe_NewRecipe("Ranger Elm Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SPECIALBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_402_N_ELM");  // Ranger Elm ShortBow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_SetClassRestriction(CLASS_TYPE_RANGER);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CBRP_N_POT", 1, 75);   // Bowyer Essence
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife
}

//------------------------------------------------------------------------------
