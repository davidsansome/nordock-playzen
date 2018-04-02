/****************************************************
  Recipes Script
  ats_recipes

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains all recipes designed for the
  system.  Do not add recipes to this script!
  Instead, add custom recipes to the ats_recipes_cust
  script.
***************************************************/
#include "ats_const_recipe"
#include "ats_inc_recipe_f"
//#include "ats_recipes_tink"
#include "ats_recipes_tail"
//#include "ats_recipes_cust"

void ATS_FletchingRecipies()
{
    // Shaft
    ATS_Recipe_NewRecipe("Basic Shaft", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 07);
    ATS_Recipe_SetSingleType("ATS_C_F007_N_ARR");
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Staff

    // Basic Arrow
    ATS_Recipe_NewRecipe("Basic Crafted Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 01);
    ATS_Recipe_SetSingleType("ATS_C_F001_N_ARR");         // Crafted Basic Arrow
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_AddMaterial("ATS_C_W721_N_IRO", 1, 100);   // Basic Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Basic Bolt
    ATS_Recipe_NewRecipe("Basic Crafted Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 04);
    ATS_Recipe_SetSingleType("ATS_C_F004_N_ARR");         // Crafted Basic Bolt
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_AddMaterial("ATS_C_W721_N_IRO", 1, 100);   // Basic Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch


    // Hooked Arrow
    ATS_Recipe_NewRecipe("Crafted Hooked Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 02);
    ATS_Recipe_SetSingleType("ATS_C_F002_N_ARR");         // Crafted Hooked Arrow
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(45);
    ATS_Recipe_AddMaterial("ATS_C_W722_N_IRO", 1, 100);   // Hooked Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Hooked Bolt
    ATS_Recipe_NewRecipe("Crafted Hooked Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 05);
    ATS_Recipe_SetSingleType("ATS_C_F005_N_ARR");         // Crafted Hooked Bolt
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(45);
    ATS_Recipe_AddMaterial("ATS_C_W722_N_IRO", 1, 100);   // Hooked Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Bladed Arrow
    ATS_Recipe_NewRecipe("Crafted Bladed Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 03);
    ATS_Recipe_SetSingleType("ATS_C_F003_N_ARR");         // Crafted Bladed Arrow
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_AddMaterial("ATS_C_W723_N_IRO", 1, 100);   // Bladed Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Bladed Bolt
    ATS_Recipe_NewRecipe("Crafted Bladed Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 06);
    ATS_Recipe_SetSingleType("ATS_C_F006_N_ARR");         // Crafted Bladed Bolt
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_AddMaterial("ATS_C_W723_N_IRO", 1, 100);   // Bladed Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Piercing Arrow
    ATS_Recipe_NewRecipe("Crafted Piercing Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 08);
    ATS_Recipe_SetSingleType("ATS_C_F008_N_ARR");         // Crafted Piercing Arrow
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_C_W723_N_IRO", 1, 100);   // Bladed Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Piercing Bolt
    ATS_Recipe_NewRecipe("Crafted Piercing Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 09);
    ATS_Recipe_SetSingleType("ATS_C_F009_N_ARR");         // Crafted Piercing Bolt
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_C_W723_N_IRO", 1, 100);   // Bladed Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Flaming Arrow
    ATS_Recipe_NewRecipe("Crafted Flaming Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 10);
    ATS_Recipe_SetSingleType("ATS_C_F010_N_ARR");         // Crafted Flaming Arrow
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFF_N_POT", 1, 50);    // Essence of Fire

    // Flaming Bolt
    ATS_Recipe_NewRecipe("Crafted Flaming Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 11);
    ATS_Recipe_SetSingleType("ATS_C_F011_N_ARR");         // Crafted Flaming Bolt
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFF_N_POT", 1, 50);    // Essence of Fire

    // Electrical Arrow
    ATS_Recipe_NewRecipe("Crafted Electrical Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 12);
    ATS_Recipe_SetSingleType("ATS_C_F012_N_ARR");         // Crafted Electrical Arrow
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFE_N_POT", 1, 50);    // Essence of Electricity

    // Electrical Bolt
    ATS_Recipe_NewRecipe("Crafted Electrical Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 13);
    ATS_Recipe_SetSingleType("ATS_C_F013_N_ARR");         // Crafted Electrical Bolt
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFE_N_POT", 1, 50);    // Essence of Electricity

    // Acid Arrow
    ATS_Recipe_NewRecipe("Crafted Acid Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 14);
    ATS_Recipe_SetSingleType("ATS_C_F014_N_ARR");         // Crafted Acid Arrow
    ATS_Recipe_SetMinSkill(110);
    ATS_Recipe_SetMaxSkill(140);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 1, 50);    // Essence of Acid

    // Acid Bolt
    ATS_Recipe_NewRecipe("Crafted Acid Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 15);
    ATS_Recipe_SetSingleType("ATS_C_F015_N_ARR");         // Crafted Acid Bolt
    ATS_Recipe_SetMinSkill(110);
    ATS_Recipe_SetMaxSkill(140);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 1, 50);    // Essence of Acid

    // Frozen Arrow
    ATS_Recipe_NewRecipe("Crafted Frozen Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 16);
    ATS_Recipe_SetSingleType("ATS_C_F016_N_ARR");         // Crafted Frozen Arrow
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFC_N_POT", 1, 50);    // Essence of Cold

    // Frozen Bolt
    ATS_Recipe_NewRecipe("Crafted Frozen Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 17);
    ATS_Recipe_SetSingleType("ATS_C_F017_N_ARR");         // Crafted Frozen Bolt
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F007_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFC_N_POT", 1, 50);    // Essence of Cold


}


void ATS_BowyeringRecipies()
{

// Shortbows C0 ************************************

    // Rough Oak Hemp Shortbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 01);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_OAK");         // Rough Oak Hemp Bow
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Elm Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_ELM");         // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Ash Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_ASH");         // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Smooth Oak Hemp Shortbow
    ATS_Recipe_NewRecipe("Smooth Oak Hemp Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_OAK");         // Smooth Oak Hemp Bow
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smooth Elm Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_ELM");         // Smooth Elm Hemp Bow
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smooth Ash Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_ASH");         // Smooth Ash Hemp Bow
    ATS_Recipe_SetMinSkill(100);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Rough Oak Silk Shortbow
    ATS_Recipe_NewRecipe("Rough Oak Silk Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 03);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_OAK");         // Rough Oak Hemp Bow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Elm Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_ELM");         // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Ash Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_ASH");         // Rough Ash Hemp Bow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Smooth Oak Silk Shortbow
    ATS_Recipe_NewRecipe("Smooth Oak Silk Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 04);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_OAK");         // Smooth Oak Hemp Bow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smooth Elm Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_ELM");         // Smooth Elm Hemp Bow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smooth Ash Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_ASH");         // Smooth Ash Hemp Bow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

////////////Compound Shortbows////////////

// Rough Oak Compound Shortbow
    ATS_Recipe_NewRecipe("Rough Oak Compound Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 05);
    ATS_Recipe_SetSingleType("ATS_C_C005_N_OAK");         // Rough Oak Compound ShortBow
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(150);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Rough Elm Compound Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Compound Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C005_N_ELM");         // Rough Elm Compound ShortBow
    ATS_Recipe_SetMinSkill(150);
    ATS_Recipe_SetMaxSkill(170);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Rough Ash Compound Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Compound Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C005_N_ASH");         // Rough Elm Compound ShortBow
    ATS_Recipe_SetMinSkill(170);
    ATS_Recipe_SetMaxSkill(190);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Smooth Oak Compound Shortbow
    ATS_Recipe_NewRecipe("Smooth Oak Compound Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 06);
    ATS_Recipe_SetSingleType("ATS_C_C006_N_OAK");         // Smooth Oak Compound ShortBow
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Smooth Elm Compound Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Compound Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C006_N_ELM");         // Smooth Elm Compound ShortBow
    ATS_Recipe_SetMinSkill(160);
    ATS_Recipe_SetMaxSkill(180);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Smooth Ash Compound Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Compound Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C006_N_ASH");         // Smooth Ash Compound ShortBow
    ATS_Recipe_SetMinSkill(180);
    ATS_Recipe_SetMaxSkill(200);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley



// Longbows  C1 ************************************

    // Rough Oak Hemp Longbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 01);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_OAK");         // Rough Oak Hemp LongBow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Elm Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_ELM");         // Rough Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Ash Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_ASH");         // Rough Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Smoothed Oak Hemp Longbow
    ATS_Recipe_NewRecipe("Smooth Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_OAK");         // Smooth Oak Hemp LongBow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smoothed Elm Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_ELM");         // Smooth Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smoothed Ash Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_ASH");         // Smooth Ash Hemp LongBow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);    // Pumice Stone

    // Rough Oak Silk Longbow
    ATS_Recipe_NewRecipe("Rough Oak Silk Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 03);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_OAK");         // Rough Oak Silk LongBow
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Elm Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_ELM");         // Rough Elm Silk LongBow
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Ash Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_ASH");         // Rough Elm Silk LongBow
    ATS_Recipe_SetMinSkill(110);
    ATS_Recipe_SetMaxSkill(130);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Smoothed Oak Silk Longbow
    ATS_Recipe_NewRecipe("Smooth Oak Silk Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 04);
    ATS_Recipe_SetSingleType("ATS_C_C104_N_OAK");          // Smooth Oak Silk Longbow
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smoothed Elm Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C104_N_ELM");         // Smooth Elm Silk LongBow
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Smoothed Ash Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C104_N_ASH");         // Smooth Ash Silk LongBow
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(150);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

/////////////Compound Longbows///////////////

    // Rough Oak Compound Longbow
    ATS_Recipe_NewRecipe("Rough Oak Compound Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 05);
    ATS_Recipe_SetSingleType("ATS_C_C105_N_OAK");         // Rough Oak Compound LongBow
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Rough Elm Compound Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Compound Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C105_N_ELM");         // Rough Elm Compound LongBow
    ATS_Recipe_SetMinSkill(160);
    ATS_Recipe_SetMaxSkill(180);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Rough Ash Compound Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Compound Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C105_N_ASH");         // Rough Elm Compound LongBow
    ATS_Recipe_SetMinSkill(180);
    ATS_Recipe_SetMaxSkill(200);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Smoothed Oak Compound Longbow
    ATS_Recipe_NewRecipe("Smooth Oak Compound Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 06);
    ATS_Recipe_SetSingleType("ATS_C_C106_N_OAK");         // Smooth Oak Compound LongBow
    ATS_Recipe_SetMinSkill(150);
    ATS_Recipe_SetMaxSkill(170);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Smoothed Elm Compound Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Compound Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C106_N_ELM");         // Smooth Elm Compound LongBow
    ATS_Recipe_SetMinSkill(170);
    ATS_Recipe_SetMaxSkill(190);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley

    // Smoothed Ash Compound Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Compound Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C106_N_ASH");         // Smooth Ash Compound LongBow
    ATS_Recipe_SetMinSkill(190);
    ATS_Recipe_SetMaxSkill(210);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_C_L903_N_SLH", 1, 100);   // Waxed Leather Cord
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone
    ATS_Recipe_AddMaterial("ATS_R_BCBP_N_PUL", 2, 100);   // Compound Bow Pulley


// Crossbows  C2 ************************************


// CrossCrossbows  C2 ************************************

  //// Light Crossbows

    // Light Rough Oak Hemp Crossbow
    ATS_Recipe_NewRecipe("Light Rough Oak Hemp Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 01);
    ATS_Recipe_SetSingleType("ATS_C_C201_N_OAK");         // Light Rough Oak Hemp Crossbow
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Light Rough Elm Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Rough Elm Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C201_N_ELM");         // Light Rough Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Light Rough Ash Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Rough Ash Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C201_N_ASH");         // Light Rough Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Light Smooth Oak Hemp Crossbow
    ATS_Recipe_NewRecipe("Light Smooth Oak Hemp Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C202_N_OAK");         // Light Smooth Oak Hemp Crossbow
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Light Smooth Elm Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Smooth Elm Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C202_N_ELM");         // Light Smooth Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Light Smooth Ash Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Smooth Ash Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C202_N_ASH");         // Light Smooth Ash Hemp Crossbow
    ATS_Recipe_SetMinSkill(100);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Light Rough Oak Silk Crossbow
    ATS_Recipe_NewRecipe("Light Rough Oak Silk Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 03);
    ATS_Recipe_SetSingleType("ATS_C_C203_N_OAK");         // Light Rough Oak Hemp Crossbow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Light Rough Elm Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Rough Elm Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C203_N_ELM");         // Light Rough Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Light Rough Ash Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Rough Ash Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C203_N_ASH");         // Light Rough Ash Hemp Crossbow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Light Smooth Oak Silk Crossbow
    ATS_Recipe_NewRecipe("Light Smooth Oak Silk Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 04);
    ATS_Recipe_SetSingleType("ATS_C_C204_N_OAK");         // Light Smooth Oak Hemp Crossbow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Light Smooth Elm Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Smooth Elm Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C204_N_ELM");         // Light Smooth Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Light Smooth Ash Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Light Smooth Ash Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C204_N_ASH");         // Light Smooth Ash Hemp Crossbow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

  //// Heavy CrossCrossbows

    // Heavy Rough Oak Hemp Crossbow
    ATS_Recipe_NewRecipe("Heavy Rough Oak Hemp Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 05);
    ATS_Recipe_SetSingleType("ATS_C_C205_N_OAK");         // Heavy Rough Oak Hemp Crossbow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Heavy Rough Elm Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Rough Elm Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C205_N_ELM");         // Heavy Rough Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Heavy Rough Ash Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Rough Ash Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C205_N_ASH");         // Heavy Rough Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Heavy Smoothed Oak Hemp Crossbow
    ATS_Recipe_NewRecipe("Heavy Smooth Oak Hemp Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 06);
    ATS_Recipe_SetSingleType("ATS_C_C206_N_OAK");         // Heavy Smooth Oak Hemp Crossbow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Heavy Smoothed Elm Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Smooth Elm Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C206_N_ELM");         // Heavy Smooth Elm Hemp Crossbow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Heavy Smoothed Ash Hemp Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Smooth Ash Hemp Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C206_N_ASH");         // Heavy Smooth Ash Hemp Crossbow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);    // Pumice Stone

    // Heavy Rough Oak Silk Crossbow
    ATS_Recipe_NewRecipe("Heavy Rough Oak Silk Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 07);
    ATS_Recipe_SetSingleType("ATS_C_C207_N_OAK");         // Heavy Rough Oak Silk Crossbow
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Heavy Rough Elm Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Rough Elm Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C207_N_ELM");         // Heavy Rough Elm Silk Crossbow
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Heavy Rough Ash Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Rough Ash Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C207_N_ASH");         // Heavy Rough Elm Silk Crossbow
    ATS_Recipe_SetMinSkill(110);
    ATS_Recipe_SetMaxSkill(130);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Heavy Smoothed Oak Silk Crossbow
    ATS_Recipe_NewRecipe("Heavy Smooth Oak Silk Crossbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 08);
    ATS_Recipe_SetSingleType("ATS_C_C208_N_OAK");         // Heavy Smooth Oak Silk Crossbow
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Heavy Smoothed Elm Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Smooth Elm Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C208_N_ELM");         // Heavy Smooth Elm Silk Crossbow
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone

    // Heavy Smoothed Ash Silk Crossbow
    ATS_Recipe_AddAlternateRecipe("Heavy Smooth Ash Silk Crossbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C208_N_ASH");         // Heavy Smooth Ash Silk Crossbow
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(150);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CSTO_N_PUM", 1, 100);   // Pumice Stone


// Battlebows  C3 ************************************

// Specials  C4 ************************************

    // Ranger Oak Shortbow
    ATS_Recipe_NewRecipe("Ranger Oak Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SPECIALBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C402_N_OAK");  // Ranger Oak ShortBow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_SetClassRestriction(CLASS_TYPE_RANGER);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);       // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);       // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CBRP_N_POT", 1, 75);        // Bowyer Essence
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);  // Smoothing Knife


    // Ranger Elm Shortbow
    ATS_Recipe_NewRecipe("Ranger Elm Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SPECIALBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C402_N_ELM");  // Ranger Elm ShortBow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_SetClassRestriction(CLASS_TYPE_RANGER);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);       // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);       // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CBRP_N_POT", 1, 75);        // Bowyer Essence
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);  // Smoothing Knife


}


void ATS_TanningRecipes()
{

// Curing //

    // Curing(Badger Pelt -> Small Cured Leather Hide)
    ATS_Recipe_NewRecipe("Badger Pelt", ATS_CRAFT_TYPE_LEATHER, 0, 01);
    ATS_Recipe_SetSingleType("ATS_C_L001_N_SLH");           // Small Cured Leather Hide
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_R_BADG_N_PEL", 1, 100);     // Badger Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 1, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_SLH", 95);   // Failure: Small Ruined Pelt

    // Curing(Deer Pelt -> Medium Cured Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Deer Pelt", TRUE);       // Creates another cured leather recipe
    ATS_Recipe_SetSingleType("ATS_C_L001_N_MLH");           // Medium Cured Leather Hide
    ATS_Recipe_SetMinSkill(5);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_AddMaterial("ATS_R_DEER_N_PEL", 1, 100);     // Deer Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 2, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 1, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_MLH", 95);   // Failure: Medium Ruined Pelt

    // Curing(Cougar Pelt -> Medium Cured Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Cougar Pelt", TRUE);     // Creates another cured leather recipe
    ATS_Recipe_SetSingleType("ATS_C_L001_N_MLH");           // Medium Cured Leather Hide
    ATS_Recipe_SetMinSkill(5);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_AddMaterial("ATS_R_COUG_N_PEL", 1, 100);     // Deer Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 1, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_MLH", 95);   // Failure: Medium Ruined Pelt

    // Curing(Bear Pelt -> Large Cured Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Bear Pelt", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L001_N_LLH");           // Large Cured Leather Hide
    ATS_Recipe_SetMinSkill(5);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_BEAR_N_PEL", 1, 100);     // Bear Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 3, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 2, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_LLH", 95);   // Failure: Large Ruined Hide

    // Curing(Black Bat Pelt -> Small Cured Black Leather Hide)
    ATS_Recipe_NewRecipe("Black Bat Pelt", ATS_CRAFT_TYPE_LEATHER, 0, 02);
    ATS_Recipe_SetSingleType("ATS_C_L002_N_SLH");           // Small Cured Black Leather Hide
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_AddMaterial("ATS_R_BBAT_N_PEL", 1, 100);     // Black Bat Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 2, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 1, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L302_N_SLH", 95);   // Failure: Small Ruined Black Hide

    // Curing(Panther Pelt -> Medium Cured Black Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Panther Pelt", TRUE);    // Creates another cured leather recipe
    ATS_Recipe_SetSingleType("ATS_C_L002_N_MLH");           // Medium Cured Black Leather Hide
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(45);
    ATS_Recipe_AddMaterial("ATS_R_BCAT_N_PEL", 1, 100);     // Panther Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 3, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 1, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L302_N_MLH", 95);   // Failure: Medium Ruined Black Hide

    // Curing(Black Bear Pelt -> Large Cured Black Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Black Bear Pelt", TRUE); // Creates another cured leather recipe
    ATS_Recipe_SetSingleType("ATS_C_L002_N_LLH");           // Medium Cured Black Leather Hide
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_BLAB_N_PEL", 1, 100);     // Black Bear Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 3, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 2, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L302_N_LLH", 95);   // Failure: Medium Ruined Black Hide

    // Curing(White Stag Pelt -> Small Cured White Leather Hide)
    ATS_Recipe_NewRecipe("White Stag Pelt", ATS_CRAFT_TYPE_LEATHER, 0, 03);
    ATS_Recipe_SetSingleType("ATS_C_L003_N_SLH");           // Small Cured White Leather Hide
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_WSTA_N_PEL", 1, 100);     // White Stag Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 2, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 2, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_SLH", 95);   // Failure: Small Ruined White Hide

    // Curing(Crag Cat Pelt -> Medium Cured White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Crag Cat Pelt", TRUE);   // Creates another cured leather recipe
    ATS_Recipe_SetSingleType("ATS_C_L003_N_MLH");           // Medium Cured White Leather Hide
    ATS_Recipe_SetMinSkill(45);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_R_CCAT_N_PEL", 1, 100);     // Panther Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 3, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 2, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_MLH", 95);   // Failure: Medium Ruined White Hide

    // Curing(Winter Wolf Pelt -> Medium Cured White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Winter Wolf Pelt", TRUE);// Creates another cured leather recipe
    ATS_Recipe_SetSingleType("ATS_C_L003_N_MLH");           // Medium Cured White Leather Hide
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_AddMaterial("ATS_R_WWOL_N_PEL", 1, 100);     // Winter Wolf Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 2, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_MLH", 95);   // Failure: Medium Ruined White Hide

    // Curing(Polar Bear Pelt -> Large Cured White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Polar Bear Pelt", TRUE); // Creates another cured leather recipe
    ATS_Recipe_SetSingleType("ATS_C_L003_N_LLH");           // Large Cured White Leather Hide
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(105);
    ATS_Recipe_AddMaterial("ATS_R_POLB_N_PEL", 1, 100);     // Polar Bear Pelt
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 3, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_R_WOOD_N_OAK", 3, 100);     // Log of Wood(Oak)
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_LLH", 95);   // Failure: Large Ruined White Hide

// Tanning //

    // Tanning(Small Cured Leather Hide -> Small Tanned Leather Hide)
    ATS_Recipe_NewRecipe("Small Cured Hide", ATS_CRAFT_TYPE_LEATHER, 1, 01);
    ATS_Recipe_SetSingleType("ATS_C_L101_N_SLH");           // Small Tanned Leather Hide
    ATS_Recipe_SetMinSkill(5);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_SLH", 1, 100);     // Small Cured Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_SLH", 95);   // Failure: Small Ruined Pelt

    // Tanning(Medium Cured Leather Hide -> Medium Tanned Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Cured Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L101_N_MLH");           // Medium Tanned Leather Hide
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(65);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_MLH", 1, 100);     // Medium Cured Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 2, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_MLH", 95);   // Failure: Medium Ruined Pelt

    // Tanning(Large Cured Leather Hide -> Large Tanned Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Cured Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L101_N_LLH");           // Large Tanned Leather Hide
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_LLH", 1, 100);     // Large Cured Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 2, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 2, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_LLH", 95);   // Failure: Large Ruined Pelt

    // Tanning(Small Ruined Leather Hide -> Small Tanned Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Small Ruined Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L101_N_SLH");           // Small Tanned Leather Hide
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_C_L301_N_SLH", 1, 100);     // Small Ruined Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Medium Ruined Leather Hide -> Medium Tanned Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Ruined Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L101_N_MLH");           // Medium Tanned Leather Hide
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_C_L301_N_MLH", 1, 100);     // Medium Ruined Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Large Ruined Leather Hide -> Large Tanned Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Ruined Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L101_N_LLH");           // Large Tanned Leather Hide
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(140);
    ATS_Recipe_AddMaterial("ATS_C_L301_N_LLH", 1, 100);     // Large Ruined Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Small Cured Black Leather Hide -> Small Tanned Black Leather Hide)
    ATS_Recipe_NewRecipe("Small Cured Black Hide", ATS_CRAFT_TYPE_LEATHER, 1, 02);
    ATS_Recipe_SetSingleType("ATS_C_L102_N_SLH");           // Small Tanned Black Leather Hide
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_AddMaterial("ATS_C_L002_N_SLH", 1, 100);     // Small Cured Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L302_N_SLH", 95);   // Failure: Small Ruined Pelt

    // Tanning(Medium Cured Black Leather Hide -> Medium Tanned Black Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Cured Black Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L102_N_MLH");           // Medium Tanned Leather Hide
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_C_L002_N_MLH", 1, 100);     // Medium Cured Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 2, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L302_N_MLH", 95);   // Failure: Small Ruined Pelt

    // Tanning(Large Cured Black Leather Hide -> Large Tanned BlackLeather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Cured Black Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L102_N_LLH");           // Large Tanned Leather Hide
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_AddMaterial("ATS_C_L002_N_LLH", 1, 100);     // Large Cured Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 2, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 2, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L302_N_LLH", 95);   // Failure: Small Ruined Pelt

    // Tanning(Small Ruined Black Leather Hide -> Small Tanned BlackLeather Hide)
    ATS_Recipe_AddAlternateRecipe("Small Ruined Black Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L102_N_SLH");           // Small Tanned Black Leather Hide
    ATS_Recipe_SetMinSkill(65);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_C_L302_N_SLH", 1, 100);     // Small Ruined Black Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Medium Ruined Black Leather Hide -> Medium Tanned Black Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Ruined Black Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L102_N_MLH");           // Medium Tanned Black Leather Hide
    ATS_Recipe_SetMinSkill(85);
    ATS_Recipe_SetMaxSkill(132);
    ATS_Recipe_AddMaterial("ATS_C_L302_N_MLH", 1, 100);     // Medium Ruined Black Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Large Ruined Black Leather Hide -> Large Tanned Black Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Ruined Black Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L102_N_LLH");           // Large Tanned Black Leather Hide
    ATS_Recipe_SetMinSkill(92);
    ATS_Recipe_SetMaxSkill(148);
    ATS_Recipe_AddMaterial("ATS_C_L302_N_LLH", 1, 100);     // Large Ruined Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Small Cured White Leather Hide -> Small Tanned White Leather Hide)
    ATS_Recipe_NewRecipe("Small Cured White Hide", ATS_CRAFT_TYPE_LEATHER, 1, 03);
    ATS_Recipe_SetSingleType("ATS_C_L103_N_SLH");           // Small Tanned White Leather Hide
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(65);
    ATS_Recipe_AddMaterial("ATS_C_L003_N_SLH", 1, 100);     // Small Cured White Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 2, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_SLH", 95);   // Failure: Small Ruined White Hide

    // Tanning(Medium Cured White Leather Hide -> Medium Tanned White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Cured White Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L103_N_MLH");           // Medium Tanned White Leather Hide
    ATS_Recipe_SetMinSkill(45);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_C_L003_N_MLH", 1, 100);     // Medium Cured White Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 3, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 2, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_MLH", 95);   // Failure: Medium Ruined White Hide

    // Tanning(Large Cured White Leather Hide -> Large Tanned White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Cured White Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L103_N_LLH"); // Large Tanned Leather White Hide
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_C_L003_N_LLH", 1, 100);     // Large Cured White Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 3, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 3, 100);     // Tannic Acid
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_LLH", 95);   // Failure: Large Ruined White Hide

    // Tanning(Small Ruined White Leather Hide -> Small Tanned White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Small Ruined White Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L103_N_SLH");           // Small Tanned White Leather Hide
    ATS_Recipe_SetMinSkill(92);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_C_L303_N_SLH", 1, 100);     // Small Ruined White Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Medium Ruined White Leather Hide -> Medium Tanned White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Ruined White Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L103_N_MLH");           // Medium Tanned White Leather Hide
    ATS_Recipe_SetMinSkill(108);
    ATS_Recipe_SetMaxSkill(145);
    ATS_Recipe_AddMaterial("ATS_C_L303_N_MLH", 1, 100);     // Medium Ruined White Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

    // Tanning(Large Ruined White Leather Hide -> Large Tanned White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Ruined White Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L103_N_LLH");           // Large Tanned White Leather Hide
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(170);
    ATS_Recipe_AddMaterial("ATS_C_L303_N_LLH", 1, 100);     // Large Ruined White Leather
    ATS_Recipe_AddMaterial("ATS_S_SALT_N_NON", 1, 50);      // Bowl of Salt
    ATS_Recipe_AddMaterial("ATS_S_Y902_N_ACD", 1, 100);     // Tannic Acid

// Hardening //

    // Hardening(Small Tanned Leather Hide -> Small Hardened Leather Hide)
    ATS_Recipe_NewRecipe("Small Tanned Hide", ATS_CRAFT_TYPE_LEATHER, 2, 01);
    ATS_Recipe_SetSingleType("ATS_C_L201_N_SLH");           // Small Hardened Leather Hide
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(65);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_SLH", 1, 100);     // Small Tanned Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 1, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 1, 100);     // Tanning Oil
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_SLH", 95);   // Failure: Small Ruined Pelt

    // Hardening(Medium Tanned Leather Hide -> Medium Hardened Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Tanned Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L201_N_MLH");           // Medium Tanned Leather Hide
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_MLH", 1, 100);     // Medium Tanned Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 2, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 1, 100);     // Tanning Oil
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_MLH", 95);   // Failure: Medium Ruined Pelt

    // Hardening(Large Tanned Leather Hide -> Large Hardened Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Tanned Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L201_N_LLH");           // Large Hardened Leather Hide
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_LLH", 1, 100);     // Large Tanned Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 3, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 1, 100);     // Tanning Oil

    // Hardening(Small Tanned Black Leather Hide -> Small Hardened Black Leather Hide)
    ATS_Recipe_NewRecipe("Small Tanned Black Hide", ATS_CRAFT_TYPE_LEATHER, 2, 02);
    ATS_Recipe_SetSingleType("ATS_C_L202_N_SLH");           // Small Hardened Black Leather Hide
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_C_L102_N_SLH", 1, 100);     // Small Tanned Black Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 2, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 1, 100);     // Tanning Oil

    // Hardening(Medium Tanned Black Leather Hide -> Medium Hardened Black Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Tanned Black Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L202_N_MLH");           // Medium Tanned Black Leather Hide
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(88);
    ATS_Recipe_AddMaterial("ATS_C_L102_N_MLH", 1, 100);     // Medium Tanned Black Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 3, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 1, 100);     // Tanning Oil

    // Hardening(Large Tanned Black Leather Hide -> Large Hardened Black Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Tanned Black Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L202_N_LLH");           // Large Hardened Black Leather Hide
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_C_L102_N_LLH", 1, 100);     // Large Tanned Black Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 3, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 2, 100);     // Tanning Oil
    ATS_Recipe_AddFailureProduct("ATS_C_L301_N_LLH", 95);   // Failure: Large Ruined Pelt

    // Hardening(Small Tanned White Leather Hide -> Small Hardened White Leather Hide)
    ATS_Recipe_NewRecipe("Small Tanned White Hide", ATS_CRAFT_TYPE_LEATHER, 2, 03);
    ATS_Recipe_SetSingleType("ATS_C_L203_N_SLH");           // Small Hardened White Leather Hide
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(91);
    ATS_Recipe_AddMaterial("ATS_C_L103_N_SLH", 1, 100);     // Small Tanned White Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 2, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 1, 100);     // Tanning Oil
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_SLH", 95);   // Failure: Small Ruined White Hide

    // Hardening(Medium Tanned White Leather Hide -> Medium Hardened White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Medium Tanned White Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L203_N_MLH");           // Medium Tanned Black Leather White
    ATS_Recipe_SetMinSkill(88);
    ATS_Recipe_SetMaxSkill(130);
    ATS_Recipe_AddMaterial("ATS_C_L103_N_MLH", 1, 100);     // Medium Tanned White Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 3, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 1, 100);     // Tanning Oil
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_MLH", 95);   // Failure: Medium Ruined White Hide

    // Hardening(Large Tanned White Leather Hide -> Large Hardened White Leather Hide)
    ATS_Recipe_AddAlternateRecipe("Large Tanned White Hide", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L203_N_LLH");           // Large Hardened White Leather Hide
    ATS_Recipe_SetMinSkill(125);
    ATS_Recipe_SetMaxSkill(175);
    ATS_Recipe_AddMaterial("ATS_C_L103_N_LLH", 1, 100);     // Large Tanned White Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 3, 50);      // Beeswax
    ATS_Recipe_AddMaterial("ATS_S_Y901_N_OIL", 2, 100);     // Tanning Oil
    ATS_Recipe_AddFailureProduct("ATS_C_L303_N_LLH", 95);   // Failure: Large Ruined White Hide

// Sewing Items //

// Miner's Bags //

    // Small Miner's Bag
    ATS_Recipe_NewRecipe("Small Miner's Bag", ATS_CRAFT_TYPE_LEATHER, 9, 01);
    ATS_Recipe_SetSingleType("ATS_C_L901_N_SLH");
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_SLH", 2, 80);     // Small Tanned Leather
    ATS_Recipe_AddMaterial("ATS_S_SBAG_N_PAT", 1, 100);    // Small Bag Pattern

    // Medium Miner's Bag
    ATS_Recipe_AddAlternateRecipe("Medium Miner's Bag", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L901_N_MLH");
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(105);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_MLH", 2, 80);     // Medium Tanned Leather
    ATS_Recipe_AddMaterial("ATS_S_MBAG_N_PAT", 1, 100);    // Medium Bag Pattern

    // Large Miner's Bag
    ATS_Recipe_AddAlternateRecipe("Large Miner's Bag", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L901_N_LLH");
    ATS_Recipe_SetMinSkill(100);
    ATS_Recipe_SetMaxSkill(130);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_LLH", 2, 80);     // Large Tanned Leather
    ATS_Recipe_AddMaterial("ATS_S_LBAG_N_PAT", 1, 100);    // Large Bag Pattern

// Leather Bags //

    // Small Leather Bag
    ATS_Recipe_NewRecipe("Small Leather Bag", ATS_CRAFT_TYPE_LEATHER, 9, 02);
    ATS_Recipe_SetSingleType("ATS_C_L902_N_SLH");
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(105);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_SLH", 2, 80);     // Small Hardened Leather
    ATS_Recipe_AddMaterial("ATS_S_SBAG_N_PAT", 1, 100);    // Small Bag Pattern

    // Medium Leather Bag
    ATS_Recipe_AddAlternateRecipe("Medium Leather Bag", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L902_N_MLH");
    ATS_Recipe_SetMinSkill(100);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_MLH", 2, 80);     // Medium Hardened Leather
    ATS_Recipe_AddMaterial("ATS_S_MBAG_N_PAT", 1, 100);    // Medium Bag Pattern

    // Large Leather Bag
    ATS_Recipe_AddAlternateRecipe("Large Leather Bag", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_L902_N_LLH");
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_LLH", 2, 80);     // Large Hardened Leather
    ATS_Recipe_AddMaterial("ATS_S_LBAG_N_PAT", 1, 100);    // Large Bag Pattern

// Leather Compound Bow String //

    // Waxed Leather Cord
    ATS_Recipe_NewRecipe("Waxed Leather Cord", ATS_CRAFT_TYPE_LEATHER, 9, 03);
    ATS_Recipe_SetSingleType("ATS_C_L903_N_SLH");          // Waxed Leather Cord
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_SLH", 1, 10);     // Small Tanned Leather
    ATS_Recipe_AddMaterial("ATS_R_BEE1_N_WAX", 1, 50);     // Beeswax

// Boots //

    // Soft Leather Boots
    // Dexterity +1
    ATS_Recipe_NewRecipe("Soft Leather Boots", ATS_CRAFT_TYPE_LEATHER, 9, 04);
    ATS_Recipe_SetSingleType("ATS_C_L904_N_SLH");
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_SLH", 1, 100);    // Small Tanned Leather
    ATS_Recipe_AddMaterial("ATS_S_SBOT_N_PAT", 1, 100);    // Small Boot Pattern

    // Hard Leather Boots
    // Constitution +1
    ATS_Recipe_NewRecipe("Hard Leather Boots", ATS_CRAFT_TYPE_LEATHER, 9, 05);
    ATS_Recipe_SetSingleType("ATS_C_L905_N_SLH");
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(125);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_SLH", 2, 80);     // Small Hardened Leather
    ATS_Recipe_AddMaterial("ATS_S_SBOT_N_PAT", 1, 100);    // Small Boot Pattern

    // Soft White Leather Boots
    // Reduced Cold Damage
    ATS_Recipe_NewRecipe("Soft White Leather Boots", ATS_CRAFT_TYPE_LEATHER, 9, 06);
    ATS_Recipe_SetSingleType("ATS_C_L906_N_SLH");
    ATS_Recipe_SetMinSkill(110);
    ATS_Recipe_SetMaxSkill(140);
    ATS_Recipe_AddMaterial("ATS_C_L103_N_SLH", 1, 100);    // Small Tanned White Leather
    ATS_Recipe_AddMaterial("ATS_S_SBOT_N_PAT", 1, 100);    // Small Boot Pattern

    // Soft Black Leather Boots
    // Reduced Fire Damage
    ATS_Recipe_NewRecipe("Soft Black Leather Boots", ATS_CRAFT_TYPE_LEATHER, 9, 07);
    ATS_Recipe_SetSingleType("ATS_C_L907_N_SLH");
    ATS_Recipe_SetMinSkill(125);
    ATS_Recipe_SetMaxSkill(155);
    ATS_Recipe_AddMaterial("ATS_C_L102_N_SLH", 1, 100);    // Small Tanned Black Leather
    ATS_Recipe_AddMaterial("ATS_S_SBOT_N_PAT", 1, 100);    // Small Boot Pattern

    // Hard White Leather Boots
    // Reduced Cold Damage
    // Saving Throw Bonus: Cold +1
    ATS_Recipe_NewRecipe("Hard White Leather Boots", ATS_CRAFT_TYPE_LEATHER, 9, 08);
    ATS_Recipe_SetSingleType("ATS_C_L908_N_SLH");
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(170);
    ATS_Recipe_AddMaterial("ATS_C_L203_N_SLH", 1, 100);    // Small Hardened White Leather
    ATS_Recipe_AddMaterial("ATS_S_SBOT_N_PAT", 1, 100);    // Small Boot Pattern

    // Hard Black Leather Boots
    // Reduced Fire Damage
    // Saving Throw Bonus: Fire +1
    ATS_Recipe_NewRecipe("Hard Black Leather Boots", ATS_CRAFT_TYPE_LEATHER, 9, 09);
    ATS_Recipe_SetSingleType("ATS_C_L909_N_SLH");
    ATS_Recipe_SetMinSkill(155);
    ATS_Recipe_SetMaxSkill(180);
    ATS_Recipe_AddMaterial("ATS_C_L202_N_SLH", 1, 100);    // Small Hardened Black Leather
    ATS_Recipe_AddMaterial("ATS_S_SBOT_N_PAT", 1, 100);    // Small Boot Pattern



}
void ATS_ArmorcraftingRecipes()
{
    // Scale Mail
    ATS_Recipe_NewRecipe("Scale Mail", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 02);
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(22);
    ATS_Recipe_Ingots(6);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_MLH", 1, 10);  // Cured Medium Leather Hide

    // Chain Shirt
    ATS_Recipe_NewRecipe("Chain Shirt", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 01);
    ATS_Recipe_SetMinSkill(14);
    ATS_Recipe_SetMaxSkill(28);
    ATS_Recipe_Ingots(8, 75);
    ATS_Recipe_AddMaterial("ATS_C_T902_N_CLO", 1, 25);  // Cloth Padding

    // Chainmail
    ATS_Recipe_NewRecipe("Chainmail", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 03);
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(37);
    ATS_Recipe_Ingots(16, 75);
    ATS_Recipe_AddMaterial("ATS_C_T902_N_CLO", 2, 25);  // Cloth Padding

    // Breastplate
    ATS_Recipe_NewRecipe("Breastplate", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 04);
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_Ingots(22);
    ATS_Recipe_AddMaterial("ATS_C_L003_N_CNL", 1, 15);  // Crafted Studded Leather

    // Splint Mail
    ATS_Recipe_NewRecipe("Splint Mail", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 05);
    ATS_Recipe_SetMinSkill(43);
    ATS_Recipe_SetMaxSkill(65);
    ATS_Recipe_Ingots(16);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_LLH", 2, 10);  // Cured Large Leather Hide
    ATS_Recipe_AddMaterial("ATS_C_T902_N_CLO", 3, 25);  // Cloth Padding

    // Banded Mail
    ATS_Recipe_NewRecipe("Banded Mail", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 06);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(77);
    ATS_Recipe_Ingots(20);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_LLH", 2, 10);  // Tanned Large Leather Hide
    ATS_Recipe_AddMaterial("ATS_C_T902_N_CLO", 3, 25);  // Cloth Padding

    // Half-Plate
    ATS_Recipe_NewRecipe("Half-Plate", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 07);
    ATS_Recipe_SetMinSkill(61);
    ATS_Recipe_SetMaxSkill(91);
    ATS_Recipe_Ingots(28);

    // Full-Plate
    ATS_Recipe_NewRecipe("Full-Plate", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 08);
    ATS_Recipe_SetMinSkill(72);
    ATS_Recipe_SetMaxSkill(105);
    ATS_Recipe_Ingots(40);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_LLH", 2, 10);  // Hardened Large Leather Hide

    // Open Helm
    ATS_Recipe_NewRecipe("Open Helm", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 01);
    ATS_Recipe_SetMinSkill(18);
    ATS_Recipe_SetMaxSkill(26);
    ATS_Recipe_Ingots(7);

    // Chain Coif
    ATS_Recipe_NewRecipe("Chainmail Coif", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 02);
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_Ingots(10);

    // Copper Studs
    ATS_Recipe_NewRecipe("Copper Studs", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 01);
    ATS_Recipe_SetSingleType("ATS_C_A901_N_COP");
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(12);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_COP", 1, 100);   // Copper Ingot
}

void ATS_WeaponcraftingRecipes()
{
    // Dagger
    ATS_Recipe_NewRecipe("Dagger", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(15);
    ATS_Recipe_Ingots(2);

    // Kama
    ATS_Recipe_NewRecipe("Kama", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 02);
    ATS_Recipe_SetMinSkill(7);
    ATS_Recipe_SetMaxSkill(21);
    ATS_Recipe_Ingots(2);

    // Mace
    ATS_Recipe_NewRecipe("Mace", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 01);
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_Ingots(3);

    // Handaxe
    ATS_Recipe_NewRecipe("Handaxe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 01);
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_Ingots(4);

    // Longsword
    ATS_Recipe_NewRecipe("Longsword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 03);
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_Ingots(6);

    // Scimitar
    ATS_Recipe_NewRecipe("Scimitar", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 04);
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_Ingots(8);

    // Smithing Hammer
    ATS_Recipe_NewRecipe("Smithing Hammer", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_TOOLS, 11);
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_Ingots(4);

    // Pickaxe
    ATS_Recipe_NewRecipe("Pickaxe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_TOOLS, 01);
    ATS_Recipe_SetMinSkill(27);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_Ingots(5);

    // Skinning Knife
    ATS_Recipe_NewRecipe("Skinning Knife", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_TOOLS, 02);
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_Ingots(3);

    // Paring Knife
    ATS_Recipe_NewRecipe("Paring Knife", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_TOOLS, 03);
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_Ingots(3);

    // Fletching Knife
    ATS_Recipe_NewRecipe("Fletching Knife", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_TOOLS, 04);
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_Ingots(3);

    // Tinkering Tool
    ATS_Recipe_NewRecipe("Tinkering Tool", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_TOOLS, 06);
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_Ingots(3);

}

void ATS_GemcuttingRecipes()
{
    // Gemcutting(Rough Malachite -> Cut Malachite)
    ATS_Recipe_NewRecipe("Cut Rough Malachite", ATS_CRAFT_TYPE_GEMCUTTING,
                            ATS_CRAFT_PART_GEM, 01);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_MAL"); // Cut Malachite
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_MAL", 1, 100);     // Rough Malachite
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_MAL", 10);  // Failure: Broken Malachite

    // Gemcutting(Malachite -> Cut Malachite)
    ATS_Recipe_AddAlternateRecipe("Cut Malachite", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_MAL"); // Cut Malachite
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(15);
    ATS_Recipe_AddMaterial("NW_IT_GEM007", 1, 100);     // Malachite
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_MAL", 10);  // Failure: Broken Malachite

    // Gemcutting(Rough Amethyst -> Cut Amethyst)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Amethyst", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_AMY"); // Cut Amethyst
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(45);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_AMY", 1, 100);     // Rough Amethyst
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_AMY", 10);  // Failure: Broken Amethyst

    // Gemcutting(Amethyst -> Cut Amethyst)
    ATS_Recipe_AddAlternateRecipe("Cut Amethyst", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_AMY"); // Cut Amethyst
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_AddMaterial("NW_IT_GEM003", 1, 100);     // Amethyst
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_AMY", 10);  // Failure: Broken Amethyst

    // Gemcutting(Rough Lapis Lazuli -> Cut Lapis Lazuli)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Lapis Lazuli", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_LAZ"); // Cut Lapis Lazuli
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(65);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_LAZ", 1, 100);     // Rough Lapis Lazuli
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_LAZ", 10);  // Failure: Broken Lapis Lazuli

    // Gemcutting(Lapis Lazuli -> Cut Lapis Lazuli)
    ATS_Recipe_AddAlternateRecipe("Cut Lapis Lazuli", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_LAZ"); // Cut Lapis Lazuli
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_AddMaterial("ATS_R_GEM1_N_LAZ", 1, 100);     // Lapis Lazuli
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_LAZ", 10);  // Failure: Broken Lapis Lazuli

    // Gemcutting(Rough Turquoise -> Cut Turquoise)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Turquoise", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_TRQ"); // Cut Turquoise
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(85);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_TRQ", 1, 100);     // Rough Turquoise
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_TRQ", 10);  // Failure: Broken Turquoise

    // Gemcutting(Turquoise -> Cut Turquoise)
    ATS_Recipe_AddAlternateRecipe("Cut Turquoise", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_TRQ"); // Cut Turquoise
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_GEM1_N_TRQ", 1, 100);     // Turquoise
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_TRQ", 10);  // Failure: Broken Turquoise

    // Gemcutting(Rough Opal -> Cut Opal)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Opal", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_OPL"); // Cut Opal
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(105);
//    ATS_Recipe_SetAlignmentRestriction(ALIGNMENT_GOOD);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_OPL", 1, 100);     // Rough Opal
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_OPL", 10);  // Failure: Broken Opal

    // Gemcutting(Rough Onyx -> Cut Onyx)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Onyx", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_OYX"); // Cut Onyx
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(105);
//    ATS_Recipe_SetAlignmentRestriction(ALIGNMENT_EVIL);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_OYX", 1, 100);     // Rough Onyx
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_OYX", 10);  // Failure: Broken Onyx

    // Gemcutting(Rough Jade -> Cut Jade)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Jade", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_JDE"); // Cut Jade
    ATS_Recipe_SetMinSkill(100);
    ATS_Recipe_SetMaxSkill(125);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_JDE", 1, 100);     // Rough Jade
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_JDE", 10);  // Failure: Broken Jade

    // Gemcutting(Rough Pearl -> Cut Pearl)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Pearl", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_PRL"); // Cut Pearl
    ATS_Recipe_SetMinSkill(120);
    ATS_Recipe_SetMaxSkill(145);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_PRL", 1, 100);     // Rough Pearl
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_PRL", 10);  // Failure: Broken Pearl

    // Gemcutting(Rough Sapphire -> Cut Sapphire)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Sapphire", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_SAP"); // Cut Sapphire
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(165);
//    ATS_Recipe_SetAlignmentRestriction(ALIGNMENT_GOOD);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_SAP", 1, 100);     // Rough Sapphire
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_SAP", 10);  // Failure: Broken Sapphire

    // Gemcutting(Rough Shadow Sapphire -> Cut Shadow Sapphire)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Black Sapphire", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_BSP"); // Cut Black Sapphire
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(165);
//    ATS_Recipe_SetAlignmentRestriction(ALIGNMENT_EVIL);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_BSP", 1, 100);     // Rough Black Sapphire
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_BSP", 10);  // Failure: Broken Black Sapphire

    // Gemcutting(Rough Fire Opal -> Cut Fire Opal)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Fire Opal", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_FOP"); // Cut Fire Opal
    ATS_Recipe_SetMinSkill(160);
    ATS_Recipe_SetMaxSkill(180);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_FOP", 1, 100);     // Rough Fire Opal
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_FOP", 10);  // Failure: Broken Fire Opal

    // Gemcutting(Rough Ruby -> Cut Ruby)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Ruby", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_RBY"); // Cut Ruby
    ATS_Recipe_SetMinSkill(175);
    ATS_Recipe_SetMaxSkill(225);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_RBY", 1, 100);     // Rough Ruby
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_RBY", 10);  // Failure: Broken Ruby

    // Gemcutting(Rough Emerald -> Cut Emerald)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Emerald", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_EME"); // Cut Emerald
    ATS_Recipe_SetMinSkill(185);
    ATS_Recipe_SetMaxSkill(225);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_EME", 1, 100);     // Rough Emerald
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_EME", 10);  // Failure: Broken Emerald

    // Gemcutting(Rough Diamond -> Cut Diamond)
    ATS_Recipe_AddAlternateRecipe("Cut Rough Diamond", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_G001_N_DIA"); // Cut Diamond
    ATS_Recipe_SetMinSkill(195);
    ATS_Recipe_SetMaxSkill(225);
    ATS_Recipe_AddMaterial("ATS_R_GEM0_N_DIA", 1, 100);     // Rough Diamond
    ATS_Recipe_AddFailureProduct("ATS_C_G001_R_DIA", 10);  // Failure: Broken Diamond

}


void ATS_JewelcraftingRecipes()
{
//******************************************************************************
//******************************** Smooth Rings *********************************
//******************************************************************************
// Copper Smooth Ring
    ATS_Recipe_NewRecipe("Smooth Copper Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 00); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(6);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_COP", 2, 25);  // Copper ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Copper Smooth Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Copper Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 12); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(15);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_COP", 2, 25);  // Copper ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Bronze Ring
    ATS_Recipe_NewRecipe("Smooth Bronze Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 02); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(4);
    ATS_Recipe_SetMaxSkill(10);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BRO", 2, 25);  // Bronze ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Bronze Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Bronze Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 13); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(14);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BRO", 2, 25);  // Bronze ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Iron Ring
    ATS_Recipe_NewRecipe("Smooth Iron Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 01); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(7);
    ATS_Recipe_SetMaxSkill(14);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_IRO", 2, 25);  // Iron ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100); // Smooth Ring Mold

// Smooth Iron Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Iron Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 14); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(17);
    ATS_Recipe_SetMaxSkill(24);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_IRO", 2, 25);  // Iron ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100); // Smooth Ring Mold

// Smooth Silver Ring
    ATS_Recipe_NewRecipe("Smooth Silver Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 03); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(13);
    ATS_Recipe_SetMaxSkill(21);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SIL", 2, 50);  // Silver ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Silver Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Silver Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 15); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(23);
    ATS_Recipe_SetMaxSkill(31);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SIL", 2, 25);  // Silver ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Gold Ring
    ATS_Recipe_NewRecipe("Smooth Gold Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 04); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(17);
    ATS_Recipe_SetMaxSkill(26);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_GOL", 2, 50);  // Gold ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Gold Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Gold Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 16); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(27);
    ATS_Recipe_SetMaxSkill(36);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_GOL", 2, 25);  // Gold ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

//  Smooth Shadow Ring
    ATS_Recipe_NewRecipe("Smooth Shadow Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 05); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(22);
    ATS_Recipe_SetMaxSkill(32);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BLA", 2, 50);  // Shadow ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Shadow Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Shadow Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 17); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(32);
    ATS_Recipe_SetMaxSkill(42);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BLA", 2, 25);  // Shadow ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Rubicite Ring
    ATS_Recipe_NewRecipe("Smooth Rubicite Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 06); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(27);
    ATS_Recipe_SetMaxSkill(38);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB", 2, 70);  // Rubicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Rubicite Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Rubicite Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 18); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(37);
    ATS_Recipe_SetMaxSkill(48);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB", 2, 25);  // Rubicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Verdicite Ring
    ATS_Recipe_NewRecipe("Smooth Verdicite Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 07); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(27);
    ATS_Recipe_SetMaxSkill(38);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_VER", 2, 70);  // Verdicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Verdicite Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Verdicite Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 19); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(37);
    ATS_Recipe_SetMaxSkill(48);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_VER", 2, 25);  // Verdicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Syenite Ring
    ATS_Recipe_NewRecipe("Smooth Syenite Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 08); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(27);
    ATS_Recipe_SetMaxSkill(38);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SYE", 2, 70);  // Syenite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Syenite Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Syenite Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 20); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(37);
    ATS_Recipe_SetMaxSkill(48);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SYE", 2, 25);  // Syenite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Mithral Ring
    ATS_Recipe_NewRecipe("Smooth Mithral Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 09); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(32);
    ATS_Recipe_SetMaxSkill(44);
    ATS_Recipe_Gems(1, 100);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 2, 75);  // Mithral ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Mithral Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Mithral Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 21); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(42);
    ATS_Recipe_SetMaxSkill(54);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 2, 25);  // Mithral ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Adamantine Ring
    ATS_Recipe_NewRecipe("Smooth Adamantine Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 10); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(36);
    ATS_Recipe_SetMaxSkill(49);
    ATS_Recipe_Gems(1, 100);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 2, 80);  // Adamantine ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Adamantine Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Adamantine Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 22); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(46);
    ATS_Recipe_SetMaxSkill(59);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 2, 25);  // Adamantine ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Myrkandite Ring
    ATS_Recipe_NewRecipe("Smooth Myrkandite Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 11); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(42);
    ATS_Recipe_SetMaxSkill(56);
    ATS_Recipe_Gems(1, 100);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MYR", 2, 100);  // Myrkandite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

// Smooth Myrkandite Ideal Ring
    ATS_Recipe_NewRecipe("Smooth Myrkandite Ideal Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 23); // 0 is the category for the smooth band
    ATS_Recipe_SetMinSkill(52);
    ATS_Recipe_SetMaxSkill(66);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MYR", 2, 25);  // Myrkandite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);

//******************************************************************************
//******************************* Smooth Amulet ********************************
//******************************************************************************

// Copper Smooth Amulet
    ATS_Recipe_NewRecipe("Smooth Copper Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 00); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(3);
    ATS_Recipe_SetMaxSkill(8);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_COP", 3, 25);  // Copper ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Bronze Amulet
    ATS_Recipe_NewRecipe("Smooth Bronze Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 02); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(7);
    ATS_Recipe_SetMaxSkill(13);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BRO", 3, 25);  // Bronze ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Iron Amulet
    ATS_Recipe_NewRecipe("Smooth Iron Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 01); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(17);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_IRO", 3, 25);  // Iron ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100); // Smooth Amulet Mold

// Smooth Silver Amulet
    ATS_Recipe_NewRecipe("Smooth Silver Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 03); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(16);
    ATS_Recipe_SetMaxSkill(24);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SIL", 3, 25);  // Silver ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Gold  Amulet
    ATS_Recipe_NewRecipe("Smooth Gold Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 04); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(29);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_GOL", 3, 25);  // Gold ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Shadow Smooth Amulet
    ATS_Recipe_NewRecipe("Smooth Shadow Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 05); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BLA", 3, 25);  // Shadow ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Rubicite Amulet
    ATS_Recipe_NewRecipe("Smooth Rubicite Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 06); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(41);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB", 3, 25);  // Rubicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Verdicite Amulet
    ATS_Recipe_NewRecipe("Smooth Verdicite Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 07); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(41);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_VER", 3, 25);  // Verdicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Syenite Amulet
    ATS_Recipe_NewRecipe("Smooth Syenite Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 08); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(41);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SYE", 3, 25);    // Syenite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Mithral Amulet
    ATS_Recipe_NewRecipe("Smooth Mithral Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 09); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(47);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 3, 25);  // Mithral ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Adamantine Amulet
    ATS_Recipe_NewRecipe("Smooth Adamantine Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 10); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(39);
    ATS_Recipe_SetMaxSkill(52);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 3, 25);  // Adamantine ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Myrkandite Amulet
    ATS_Recipe_NewRecipe("Smooth Myrkandite Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 11); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(45);
    ATS_Recipe_SetMaxSkill(59);
    ATS_Recipe_Gems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MYR", 3, 25);  // Myrkandite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

//******************************************************************************
//******************************* Smooth Ideal Amulet **************************
//******************************************************************************

// Smooth Copper Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Copper Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 12); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(13);
    ATS_Recipe_SetMaxSkill(18);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_COP", 3, 25);  // Copper ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Bronze Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Bronze Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 13); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(17);
    ATS_Recipe_SetMaxSkill(23);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BRO", 3, 25);  // Bronze ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Iron Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Iron Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 14); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(27);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_IRO", 3, 25);  // Iron ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100); // Smooth Amulet Mold

// Smooth Silver Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Silver Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 15); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(26);
    ATS_Recipe_SetMaxSkill(34);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SIL", 3, 25);  // Silver ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Gold  Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Gold Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 16); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(39);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_GOL", 3, 25);  // Gold ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Shadow Smooth Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Shadow Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 17); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(45);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BLA", 3, 25);  // Shadow ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Rubicite Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Rubicite Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 18); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(51);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB", 3, 25);  // Rubicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Verdicite Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Verdicite Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 19); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(51);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_VER", 3, 25);  // Verdicite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Syenite Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Syenite Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 20); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(51);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SYE", 3, 25);  // Syenite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Mithral Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Mithral Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 21); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(45);
    ATS_Recipe_SetMaxSkill(57);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 3, 25);  // Mithral ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Adamantine Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Adamantine Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 22); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(49);
    ATS_Recipe_SetMaxSkill(62);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 3, 25);  // Adamantine ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);

// Smooth Myrkandite Ideal Amulet
    ATS_Recipe_NewRecipe("Smooth Myrkandite Ideal Amulet", ATS_CRAFT_TYPE_JEWELCRAFT, 1, 23); // 1 is the category for the smooth amulet
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(69);
    ATS_Recipe_IdealGems(1);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MYR", 3, 25);  // Myrkandite ingots
    ATS_Recipe_AddMaterial("ATS_S_SM01_N_MOL", 1, 100);
}

void main()
{
    ATS_ArmorcraftingRecipes();
    DelayCommand(5.0f, ATS_WeaponcraftingRecipes());
    DelayCommand(10.0f, ATS_TanningRecipes());
    DelayCommand(15.0f, ATS_GemcuttingRecipes());
    DelayCommand(20.0f, ATS_JewelcraftingRecipes());
    DelayCommand(25.0f, ATS_BowyeringRecipies());
    DelayCommand(30.0f, ATS_FletchingRecipies());
    DelayCommand(35.0f, ATS_TailorRecipes());
//    ATS_TinkerRecipes();
//    ATS_CustomRecipes();
}
