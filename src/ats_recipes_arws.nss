//------------------------------------------------------------------------------
//
// ats_inc_update
//
// Include for ATS, fletching recipies
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

void ATS_FletchingRecipies()
{
    // Basic Arrow
    ATS_Recipe_NewRecipe("Basic Crafted Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 01);
    ATS_Recipe_SetSingleType("ATS_C_F001_N_ARR");  // Crafted Basic Arrow
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_AddMaterial("ATS_C_W721_N_IRO", 1, 100);   // Basic Head
    ATS_Recipe_AddMaterial("ATS_R_FBSH_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Hooked Arrow
    ATS_Recipe_NewRecipe("Hooked Crafted Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 02);
    ATS_Recipe_SetSingleType("ATS_C_F002_N_ARR");  // Crafted Hooked Arrow
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_FBHO_N_ARR", 1, 100);   // Hooked Head
    ATS_Recipe_AddMaterial("ATS_R_FBSH_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Bladed Arrow
    ATS_Recipe_NewRecipe("Bladed Crafted Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 03);
    ATS_Recipe_SetSingleType("ATS_C_F003_N_ARR");  // Crafted Hooked Arrow
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_FBBL_N_ARR", 1, 100);   // Bladed Head
    ATS_Recipe_AddMaterial("ATS_R_FBSH_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch
}

//------------------------------------------------------------------------------
