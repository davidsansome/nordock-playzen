//------------------------------------------------------------------------------
//
// ats_inc_update
//
// Include for ATS, tayloring recipies
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

void ATS_TailorRecipes()
{
    // CLOTHES
    ATS_Recipe_NewRecipe("Normal Clothes", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOTHES, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(10);
    ATS_Recipe_ClothsL(1, 100);

    // BELTS
    ATS_Recipe_NewRecipe("Lesser Belts", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_ClothsM(1, 100);

    ATS_Recipe_NewRecipe("Normal Belts", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 02);
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_ClothsM(1, 100);

    ATS_Recipe_NewRecipe("Greater Belts", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 03);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_ClothsM(1, 100);

    ATS_Recipe_NewRecipe("Ultimate Belts", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 04);
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_ClothsM(1, 100);


    // ARMORS
    ATS_Recipe_NewRecipe("Leather Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Padded Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 02);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Studded Leather Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 03);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Hide Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 04);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Monk's Outfits", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 05);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Mage's Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 06);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    // DYES
    ATS_Recipe_NewRecipe("Make Dyes", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_Flowers(1, 100);

    // CLOTHS
    ATS_Recipe_NewRecipe("Make Small Cloths", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 97);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_SLH", 1); // Small Harden Hide
    ATS_Recipe_Dyes(1, 100);

    ATS_Recipe_NewRecipe("Make Medium Cloths", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 98);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_MLH", 1); // Medium Harden Hide
    ATS_Recipe_Dyes(1, 100);

    ATS_Recipe_NewRecipe("Make Large Cloths", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 99);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_LLH", 1); // Large Harden Hide
    ATS_Recipe_Dyes(1, 100);

    // BAGS
    ATS_Recipe_NewRecipe("Normal Bags", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BAGS, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsM(1, 100);

    ATS_Recipe_NewRecipe("Miner's Bags", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BAGS, 02);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(1, 100);


    // GLOVES
    ATS_Recipe_NewRecipe("Lesser Gloves", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_ClothsS(2, 100);

    ATS_Recipe_NewRecipe("Normal Gloves", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 02);
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_ClothsS(2, 100);

    ATS_Recipe_NewRecipe("Greater Gloves", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 03);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_ClothsS(2, 100);

    ATS_Recipe_NewRecipe("Ultimate Gloves", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 04);
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_ClothsS(2, 100);


    // CLOAKS
    ATS_Recipe_NewRecipe("Lesser Cloaks", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOAKS, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Normal Cloaks", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOAKS, 02);
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Greater Cloaks", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOAKS, 03);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Ultimate Cloaks", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOAKS, 04);
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_ClothsL(2, 100);


    // BOOTS
    ATS_Recipe_NewRecipe("Lesser Boots", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BOOTS, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_ClothsS(2, 100);

    ATS_Recipe_NewRecipe("Normal Boots", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BOOTS, 02);
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_ClothsS(2, 100);

    ATS_Recipe_NewRecipe("Greater Boots", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BOOTS, 03);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_ClothsS(2, 100);

    ATS_Recipe_NewRecipe("Ultimate Boots", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BOOTS, 04);
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(125);
    ATS_Recipe_ClothsS(2, 100);

    // CLOTH PADDING SOLD WITH BLACKSMITH
    // Need to modify Item's Blueprint ResRef and Tag to match... as well as to
    // modify the ats_recipes where it is needed in armor creation
    // (Done -- Robin May 05)
    ATS_Recipe_NewRecipe("Make Cloth Padding", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 02);
    ATS_Recipe_SetSingleType("ATS_C_T902_N_CLO");
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_MLH", 2); // Medium Harden Hide
}

//------------------------------------------------------------------------------

