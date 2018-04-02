/****************************************************
  Custom Recipes Script
  ats_recipes_cust

  Last Updated: August25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is for custom recipes. Nothing will
  ever be added to this script as default so never
  overwrite this file when updating.

  Please read the ats_about_recipe script for
  detailed explanations about the recipe functions.
*****************************************************/
#include "ats_const_recipe"
#include "ats_inc_recipe_f"
#include "ats_recipes_tink"

void ATS_CustomRecipes()
{

/*
 EXAMPLE to make a chain shirt as found in the ats_recipes script:
    // Chain Shirt
    ATS_Recipe_NewRecipe("Chain Shirt", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 01);
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_Ingots(8, 75);
    ATS_Recipe_AddMaterial("ATS_C_T902_N_CLO", 1, 25);  // Cloth Padding, # of items, percentage of consumption
*/

// PLACE ALL CUSTOM RECIPES HERE

/////////////////////////////////////////////////////////
// Additional "Standard" Weapons not included with ATS //
/////////////////////////////////////////////////////////

// Standard Greatsword
// ATS_C_W122_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Greatsword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 22);
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_Ingots(8);


// Standard Bastardsword
// ATS_C_W123_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Bastardsword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 23);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(85);
    ATS_Recipe_Ingots(8);


// Standard Shortsword
// ATS_C_W124_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Shortsword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 24);
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(65);
    ATS_Recipe_Ingots(4);


// Standard Battleaxe
// ATS_C_W021_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Battleaxe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 21);
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_Ingots(6);


// Standard Greateaxe
// ATS_C_W022_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Greataxe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 22);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_Ingots(8);

// Standard Light Hammer
// ATS_C_W221_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Light Hammer", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 21);
    ATS_Recipe_SetMinSkill(45);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_Ingots(4);


// Standard Warhammer
// ATS_C_W222_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Warhammer", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 22);
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_Ingots(8);

// -----------------------------------------------------------------------------

// Standard Small Shield
// ATS_C_A222_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Small Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 22);
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_Ingots(4);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_SLH", 1, 20); // 1 Small tanned hide


// Standard Large Shield
// ATS_C_A223_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Large Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 23);
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_Ingots(6);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_MLH", 1, 20); // 1 Medium tanned hide


// Standard Tower Shield
// ATS_C_A224_N_XXX   XXX=Metal
    ATS_Recipe_NewRecipe("Tower Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 24);
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_Ingots(8);
    ATS_Recipe_AddMaterial("ATS_C_L101_N_LLH", 1, 20); // 1 Large tanned hide

// -----------------------------------------------------------------------------

/////////////////////////
// Pure Custom Recipes //
/////////////////////////

// -----------------------------------------------------------------------------

// ========================
//    Armour Crafting
// ========================

// Windwalker Breastplate
// Ability Bonus: Dexterity +2
// AC Bonus vs. Racial Group: Undead +1
// Base Item Weight Reduction 40% of Weight
// Cast Spell: Call Lightning (10) 1 Use/Day
// Cast Spell: Color Spray (2) 3 Uses/Day
// Cast Spell: Lightning Bolt (5) 3 Uses/Day
// Decreased Saving Throws: Electrical -1
// Immunity: Damage Type: Slashing 5% Immunity Bonus
// Saving Throw Bonus: Fear +2
    ATS_Recipe_NewRecipe("Windwalker Breastplate", ATS_CRAFT_TYPE_ARMOR,ATS_CRAFT_PART_BODY, 21);
    ATS_Recipe_SetSingleType("ATS_C_A021_N_SIL");
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_Ingots(22,50);                                // 22 Silver Ingots
    ATS_Recipe_AddMaterial("ATS_C_L003_N_CNL", 1, 15);       // Crafted Studded Leather
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 2, 15);  // Blue dragon breath glands

// Drow Chain
// AC Bonus vs. Alignment Group: Good +2
// AC Bonus vs. Alignment Group: Lawful +2
// Base Item Weight Reduction 20% of Weight
// Damage Resistance: Cold Resist 5 / -
// Damage Resistance: Fire Resist 5 / -
// Damage Resistance: Slashing Resist 5 / -
// Use Limitation: Alignment Group: Evil
// Use Limitation: Racial Type: Elf
    ATS_Recipe_NewRecipe("Drow Chainmail", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 22);
    ATS_Recipe_SetSingleType("ATS_C_A022_N_BLA");
    ATS_Recipe_SetMinSkill(200);
    ATS_Recipe_SetMaxSkill(240);
    ATS_Recipe_Ingots(16, 75);                          // 16 Shadow Ingots
    ATS_Recipe_AddMaterial("ATS_C_T902_N_CLO", 8, 25);  // Cloth Padding
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR609", 1, 50);  // 1 Scroll of "Shades"

// Braveheart
// Damage Resistance: Fire Resist 30 / -
// Light Normal (15m) Red
// Saving Throw Bonus: Fire +5
    ATS_Recipe_NewRecipe("Braveheart", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 23);
    ATS_Recipe_SetSingleType("ATS_C_A023_N_RUB");
    ATS_Recipe_SetMinSkill(190);
    ATS_Recipe_SetMaxSkill(210);
    ATS_Recipe_Ingots(24,50);                           // 24 rubicite ingots
    ATS_Recipe_AddMaterial("ATS_C_L003_N_CNL", 1, 15);  // Crafted Studded Leather
    ATS_Recipe_AddMaterial("reddragonheart", 2, 50);    // 2 Ancient Red Dragon hearts

// Fire-Blasted Red Plate
// AC Bonus +4
// AC Bonus vs. Racial Group: Dragon +5
// Base Item Weight Reduction 10% of Weight
// Damage Resistance: Fire Resist 30 / -
// Damage Vulnerability: Cold 25% Damage Vulnerability
// Light Bright (20m) Red
    ATS_Recipe_NewRecipe("Fire-Blasted Red Plate", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 30);
    ATS_Recipe_SetSingleType("ATS_C_A030_N_MIT");
    ATS_Recipe_SetMinSkill(390);
    ATS_Recipe_SetMaxSkill(405);
    ATS_Recipe_Ingots(30,50);                             // 30 Mithral ingots
    ATS_Recipe_AddMaterial("ATS_C_L003_N_CNL", 1, 15);    // Crafted Studded Leather
    ATS_Recipe_AddMaterial("reddragonheart", 10, 100);    // 10 Ancient Red Dragon hearts
    ATS_Recipe_AddMaterial("reddragonscale", 20, 100);    // 20 Red Dragon Scales
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 20, 100);  // Dragon's Blood, 20 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB", 30, 100);  // 30 Rubicite ingots, 100% consumption risk

// -----------------------------------------------------------------------------

// Helm of the Gargoyle
// 2/day Stoneskin
    ATS_Recipe_NewRecipe("Helm of the Gargoyle", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 35);
    ATS_Recipe_SetSingleType("ATS_C_A135_N_ADA");
    ATS_Recipe_SetMinSkill(360);
    ATS_Recipe_SetMaxSkill(380);
    ATS_Recipe_Ingots(8,50);                             // 8 adamantine ingots, 50% chance of ingot loss
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC14", 4, 100);  // Gargoyle Skulls, 4 pcs, 100% consumption risk

// The Voice - Undeath the Rocks Helmet Recipe
    ATS_Recipe_NewRecipe("The Voice", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 36);
    ATS_Recipe_SetSingleType("ATS_C_A136_N_BLA");
    ATS_Recipe_SetMinSkill(300);
    ATS_Recipe_SetMaxSkill(330);
    ATS_Recipe_Ingots(10,50);                             // 10 ingots, 50% chance of ingot loss
    ATS_Recipe_AddMaterial("WillOWispessence", 5, 100);   // Wisps
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR909", 1, 100);   // Scroll of Wail of the Bashee
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR107", 1, 100);   // Scroll of Charm Person
    ATS_Recipe_AddMaterial("thevoicerecipe", 1, 100);     // 1 recipie

// -----------------------------------------------------------------------------

// Trebor's Barricade (large shield)
// Ability Bonus: Intelligence +2
// AC Bonus vs. Alignment Group: Chaotic +1
// AC Bonus vs. Alignment Group: Evil +1
// Damage Reduction: +2 Soak 5 Damage
// Darkvision
// Regeneration +1
    ATS_Recipe_NewRecipe("Trebor's Barricade", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 21);
    ATS_Recipe_SetSingleType("ATS_C_A221_N_RUB");
    ATS_Recipe_SetMinSkill(250);
    ATS_Recipe_SetMaxSkill(290);
    ATS_Recipe_Ingots(16,50);                          // 16 Rubucite Ingots
    ATS_Recipe_AddMaterial("LichSkull", 1, 25);        // Lich's Skull
    ATS_Recipe_AddMaterial("ATS_C_L101_N_MLH", 2, 20); // Medium tanned hides

// Dwarven Fortress (Tower Shield) - Undeath
// Craftable by Dwarf only
// AC Bonus +5
// Damage Resistance: Negative Energy: 10/-
// Immunity: Knockdown
// Improved Evasion
// Regen +2
// Use Limitation: Class: Paladin
    ATS_Recipe_NewRecipe("Dwarven Fortress", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 25);
    ATS_Recipe_SetSingleType("ATS_C_A225_N_MYR");
    ATS_Recipe_SetRacialRestriction(RACIAL_TYPE_DWARF);
    ATS_Recipe_SetMinSkill(380);
    ATS_Recipe_SetMaxSkill(410);
    ATS_Recipe_Ingots(16,50);
    ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 10, 100);  // 10 Adamantine Ingots
    ATS_Recipe_AddMaterial("ATS_C_G001_N_DIA", 10, 100);  // 10 Cut Diamonds
    ATS_Recipe_AddMaterial("reddragonscale", 10, 100);    // 10 Red dragon Scales
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 10, 100);  // 10 Dragon's Blood
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC18", 2, 100);   // 2 Ironwood
    ATS_Recipe_AddMaterial("ATS_C_L003_N_LLH", 2, 100);   // 2 Large Cured White Leathers Hides
    ATS_Recipe_AddMaterial("reddragonheart", 1, 100);     // 1 Ancient Red Dragon hearts
    ATS_Recipe_AddMaterial("recipeforfortress", 1, 100);  // 1 recipie

// -----------------------------------------------------------------------------

// Drake Charm of Passage
    ATS_Recipe_NewRecipe("Drake Charm of Passage", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 21);
    ATS_Recipe_SetSingleType("ATS_C_A921_N_GOL");
    ATS_Recipe_SetMinSkill(230);
    ATS_Recipe_SetMaxSkill(250);
    ATS_Recipe_Ingots(4,50);                          // 4 gold ingots
    ATS_Recipe_AddMaterial("ATS_C_G001_N_EME",2,50);  // 2 cut emeralds
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR216",1,50);  // 1 scroll of "Knock"

// -----------------------------------------------------------------------------

// The Rock's Pride (Undeath)
// +5
// +2 Regen
// Freedom
// +5 Discipline
// 80% Weight
    ATS_Recipe_NewRecipe("The Rock's Pride", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 24);
    ATS_Recipe_SetSingleType("ATS_C_A024_N_MIT");
    ATS_Recipe_SetMinSkill(380);
    ATS_Recipe_SetMaxSkill(410);
    ATS_Recipe_Ingots(30);
    ATS_Recipe_SetRacialRestriction(RACIAL_TYPE_DWARF);
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13", 10, 100);      // 10 Skeleton's Knuckles
    ATS_Recipe_AddMaterial("reddragonscale", 20, 100);        // 20 red dragons scales
    ATS_Recipe_AddMaterial("ATS_C_G001_N_RBY", 20, 100);      // 20 cut rubies
    ATS_Recipe_AddMaterial("ATS_C_G001_E_SAP", 1, 100);       // 1 ideal cut sapphire
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 20, 100);      // 20 dragon's blood
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 10, 100); // 10 Blue dragon breath glands
    ATS_Recipe_AddMaterial("reddragonheart", 1, 100);         // 1 red dragon heart
    ATS_Recipe_AddMaterial("ATS_C_L003_N_LLH", 1, 100);       // 1 large cured white leather
    ATS_Recipe_AddMaterial("ATS_C_L002_N_LLH", 1, 100);       // 1 large cured black leather
    ATS_Recipe_AddMaterial("ATS_C_L001_N_LLH", 1, 100);       // 1 large cured leather
    ATS_Recipe_AddMaterial("rage_spid_spin", 10, 100);        // 10 rage spider web spinners
    ATS_Recipe_AddMaterial("RecipeforTheRocksPride", 1, 100); // 1 recipie

// Zanfus' Armour of the Swordsman
    ATS_Recipe_NewRecipe("Zanfus' Armour of the Swordsman", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_BODY, 25);
    ATS_Recipe_SetSingleType("ATS_C_A025_N_RUB");
    ATS_Recipe_SetMinSkill(380);
    ATS_Recipe_SetMaxSkill(410);
    ATS_Recipe_Ingots(20);
    ATS_Recipe_AddMaterial("reddragonheart", 2, 100); // 2 red dragon hearts
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 2, 100); // 2 blue dragon breath glands
    ATS_Recipe_AddMaterial("Blackdragonliver", 10, 100); // 10 black dragon livers
    ATS_Recipe_AddMaterial("ATS_C_L003_N_CNL", 1, 100); // 1 set of crafted studded leather
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 30, 100); // 30 vials of dragon’s blood
    ATS_Recipe_AddMaterial("Blackdragonscales", 2, 100); // 2 black dragon scales
    ATS_Recipe_AddMaterial("reddragonscale", 10, 100); // 10 red dragon scales
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR212", 1, 100); // 1 scroll of Bulls Strength
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR215", 1, 100); // 1 scroll of Endurance
    ATS_Recipe_AddMaterial("BM_IT_SCROLL004", 1, 100); // 1 scroll of Energy Buffer
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SIL", 20, 100); // 20 Silver ingots
    ATS_Recipe_AddMaterial("ATS_C_B001_N_GOL", 20, 100); // 20 Gold ingots
    ATS_Recipe_AddMaterial("RecipeforZanfusArmouroftheSwords", 1, 100);     // 1 recipie



// -----------------------------------------------------------------------------

// Zanfus Mage's Shield
    ATS_Recipe_NewRecipe("Zanfus Mage's Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 26);
    ATS_Recipe_SetSingleType("ATS_C_A226_N_SIL");
    ATS_Recipe_Ingots(20);
    ATS_Recipe_SetMinSkill(350);
    ATS_Recipe_SetMaxSkill(380);
    ATS_Recipe_AddMaterial("lichskull", 1, 100); // 1 Lich Skull
    ATS_Recipe_AddMaterial("sangroluskull", 1, 100); // 1 Sangrolu Skull
    ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB", 16, 100); // 16 Rubucite ingots
    ATS_Recipe_AddMaterial("WillOWispessence", 5, 100); // 5 Will O Wisp essence
    ATS_Recipe_AddMaterial("ATS_C_L101_N_MLH", 5, 100); // 5 Tanned Medium Hide
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 10, 100); // 10 Dragon Blood
    ATS_Recipe_AddMaterial("RecipeforZanfusMagesShield", 1, 100);     // 1 recipie

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

// ========================
//     Weapon Smithing
// ========================

// W021 Battleaxe
// W022 Greataxe

// Blade of the Gargoyle (Battle Axe)
// +2 Enhancement
// +1d6 Additional Slashing Damage
// 1/day Stoneskin
    ATS_Recipe_NewRecipe("Blade of the Gargoyle", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 34);
    ATS_Recipe_SetSingleType("ATS_C_W034_N_ADA");
    ATS_Recipe_SetMinSkill(360);
    ATS_Recipe_SetMaxSkill(380);
    ATS_Recipe_Ingots(15,50);                            // 15 adamantine ingots, 50% chance of ingot loss
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC14", 4, 100);  // Gargoyle Skulls, 4 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("Blackdragonscales", 2, 100); // Black Dragon Scales, 2 pcs, 100% consumption risk
// Dwarven Waraxe
// Damage Bonus: Slashing (1 Damage)
// Use Limitation: Racial Type: Dwarf
    ATS_Recipe_NewRecipe("Dwarven Waraxe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 35);
    ATS_Recipe_SetSingleType("ATS_C_W035_N_IRO");
    ATS_Recipe_SetMinSkill(230);
    ATS_Recipe_SetMaxSkill(270);
    ATS_Recipe_Ingots(6,100);                             // 6 Iron Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 6, 100);   // 6 Mithral Ingots, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC18", 1, 100);   // Ironwood, 1 pc, 100% consumption risk
    ATS_Recipe_SetRacialRestriction(RACIAL_TYPE_DWARF);

// Mage Hunter Axes (Throwing Axes)
// Enhancement Bonus +2
// On hit DC14 Silence (Duration 5% / 5 rounds)
    ATS_Recipe_NewRecipe("Mage Hunter Axes", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 36);
    ATS_Recipe_SetSingleType("ATS_C_W036_N_SIL");
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(170);
    ATS_Recipe_Ingots(10,100);                            // 10 Silver Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 5, 100);   // 5 Short Oak Staves
    ATS_Recipe_AddMaterial("WillOWispessence", 2, 100);   // Will O Wisp essences, 2 pcs, 100% consumption risk


// Golden Axes of Holding
// Enhancement Bonus +2
// On hit DC14 Hold (Duration 5% / 5 rounds)
    ATS_Recipe_NewRecipe("Golden Axes of Holding", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 37);
    ATS_Recipe_SetSingleType("ATS_C_W037_N_GOL");
    ATS_Recipe_SetMinSkill(170);
    ATS_Recipe_SetMaxSkill(200);
    ATS_Recipe_Ingots(10,100);                            // 10 Gold Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 5, 100);   // 5 Short Oak Staves, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC07", 2, 100);   // Ettercap's Silk Gland, 2 pcs, 100% consumption risk


// Verdicite Throwing Axes
// Enhancement Bonus +2
// 1d6 Acid Damage
    ATS_Recipe_NewRecipe("Verdicite Throwing Axes", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 38);
    ATS_Recipe_SetSingleType("ATS_C_W038_N_VER");
    ATS_Recipe_SetMinSkill(200);
    ATS_Recipe_SetMaxSkill(230);
    ATS_Recipe_Ingots(10,100);                            // 10 Verdicite Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 5, 100);   // 5 Short Oak Staves, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC11", 1, 100);   // Quartz Crystal, 1 pcs, 100% consumption risk


// Skeleton Axes
// Enhancement Bonus +2
// Enhancement vs. racial group undead +4
// Extra Ranged damage type Bludgeoning
    ATS_Recipe_NewRecipe("Skeleton Axes", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 39);
    ATS_Recipe_SetSingleType("ATS_C_W039_N_MIT");
    ATS_Recipe_SetMinSkill(230);
    ATS_Recipe_SetMaxSkill(260);
    ATS_Recipe_Ingots(10,100);                            // 10 Mithral Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 5, 100);   // 5 Short Oak Staves, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13", 5, 100);   // Skeleton's Knuckle, 5 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_WTHMAX002", 1, 100);       // Stack of Throwing Axes +1, 100% consumption risk

// -----------------------------------------------------------------------------

// Swifttooth
// Ability Bonus: Dexterity +1
// Attack Bonus vs. Alignment Group: Evil +2
// Cast Spell: Summon Creature V (9) 1 Use/Day
// On Hit: Wounding DC=14
    ATS_Recipe_NewRecipe("Swift Tooth", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 21);
    ATS_Recipe_SetSingleType("ATS_C_W121_N_BLA");
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_Ingots(8,50);                           // 8 Shadow Ingots
    ATS_Recipe_AddMaterial("WillOWispessence", 4, 15); // Will O Wisp essence

// W122 Greatsword
// W123 Bastardsword
// W124 Shortsword

// Brock's Dagger of Mithril
// Attack Bonus +3
// Damage Bonus: Piercing 3 Damage
// On Hit: Daze DC=14 25% / 3 Rounds
    ATS_Recipe_NewRecipe("Brock's Dagger of Mithril", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES,30);
    ATS_Recipe_SetSingleType("ATS_C_W130_N_MIT");
    ATS_Recipe_SetMinSkill(210);
    ATS_Recipe_SetMaxSkill(230);
    ATS_Recipe_Ingots(6,50);                           // 6 Mithril Ingots
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR003",1);      // 1 scroll of Daze
    ATS_Recipe_AddMaterial("WillOWispessence", 1, 15); // 1 essence of Wisp
    ATS_Recipe_AddMaterial("OilofVukas",1,30);         // Oil of Vukas

// Flame Dagger
// Fire Damage +1
    ATS_Recipe_NewRecipe("Flame Dagger", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 31);
    ATS_Recipe_SetSingleType("ATS_C_W131_N_IRO");
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_Ingots(2,50);                             // 2 iron ingots
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC08", 2, 100);  // Fire Beetle Belly, 2 pcs, 100% consumption risk

// Glimmering Shortsword of Crimson
// Enhancement +1
// Light, Red, Bright
// On Hit: Wounding +1
    ATS_Recipe_NewRecipe("Glimmering Shortsword of Crimson", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 32);
    ATS_Recipe_SetSingleType("ATS_C_W132_N_RUB");
    ATS_Recipe_SetMinSkill(180);
    ATS_Recipe_SetMaxSkill(210);
    ATS_Recipe_Ingots(8,50);                             // 8 rubicite ingots, 50% chance of ingot loss
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR004", 2, 100);  // "Light" Scrolls, 2 pcs, 100% consumption risk

// Golden Rapier of the Cortier
// +1 Enhancement Bonus
// +1 Charisma Bonus
// +1 Persuade Bonus
// 50% of casting 'Hold Person' DC 14
    ATS_Recipe_NewRecipe("Golden Rapier of the Cortier", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 33);
    ATS_Recipe_SetSingleType("ATS_C_W133_N_GOL");
    ATS_Recipe_SetMinSkill(280);
    ATS_Recipe_SetMaxSkill(310);
    ATS_Recipe_Ingots(10,50);                            // 10 gold ingots, 50% chance of ingot loss
    ATS_Recipe_AddMaterial("WillOWispessence", 4, 100);  // Will O Wisp essences, 4 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 2, 100);  // Dragon's Blood, 2 pcs, 100% consumption risk

// Vampire's Bane
// Damage Bonus vs. Racial Type: Undead [2d8 damage][Type: Positive Energy]
// Holy Avenger
// On hit: Slay racial group[DC =20][Monster Type: Undead]
    ATS_Recipe_NewRecipe("Vampire's Bane", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 34);
    ATS_Recipe_SetSingleType("ATS_C_W134_N_BLA");
    ATS_Recipe_SetMinSkill(370);
    ATS_Recipe_SetMaxSkill(400);
    ATS_Recipe_Ingots(30,70);                               // 30 Shadow Iron Ingots
    ATS_Recipe_AddMaterial("LichSkull", 10, 100);           // 10 Lich skulls
    ATS_Recipe_AddMaterial("PCHEAD", 3, 100);               // 3 Heads of suspected vampires.
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC24", 20, 100);    // 20 Garlic
    ATS_Recipe_AddMaterial("PlanarGem", 30, 70);            // 30 Planar Gems
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MYR", 30, 70);     // 30 Myrkandite
    ATS_Recipe_AddMaterial("recipeforvampiresbane", 1, 0);  // The Recipe Book


// Biting Bastard Blade
// Bastard Sword
// +3 enhancement
// Keen
// Wounding, DC 14
    ATS_Recipe_NewRecipe("Biting Bastard Blade", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 38);
    ATS_Recipe_SetSingleType("ATS_C_W138_N_GOL");
    ATS_Recipe_SetMinSkill(360);
    ATS_Recipe_SetMaxSkill(390);
    ATS_Recipe_Ingots(10,50);                             // 10 gold ingots, 50% chance of ingot loss
    ATS_Recipe_AddMaterial("ATS_C_B001_N_IRO", 10, 100);  // Iron Ingots, 10 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 3, 100);   // Dragon's Blood, 3 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC06", 3, 100);   // Bodak's Teeth, 3 pcs, 100% consumption risk

// Katana of the Dragons
// Enhancement Bonus +4
// 2d6 fire damage
// Keen
// Skill Bonus Discipline +5
    ATS_Recipe_NewRecipe("Katana of the Dragons", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 39);
    ATS_Recipe_SetSingleType("ATS_C_W139_N_ADA");
    ATS_Recipe_SetMinSkill(390);
    ATS_Recipe_SetMaxSkill(400);
    ATS_Recipe_Ingots(20,100);                            // 20 Adamantine Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 20, 100);  // Dragon's Blood, 20 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("reddragonheart", 10, 100);    // Ancient Red Dragon Hearts, 10 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 10, 100);   // Blue Dragon Breath Glands, 10 pcs, 100% consumption risk

// Scimitar of the Dragons
// Enhancement Bonus +4
// 2d6 fire damage
// Keen
// Skill Bonus Discipline +5
    ATS_Recipe_NewRecipe("Scimitar of the Dragons", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 40);
    ATS_Recipe_SetSingleType("ATS_C_W140_N_ADA");
    ATS_Recipe_SetMinSkill(390);
    ATS_Recipe_SetMaxSkill(400);
    ATS_Recipe_Ingots(20,100);                            // 20 Adamantine Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 20, 100);  // Dragon's Blood, 20 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("reddragonheart", 10, 100);    // Ancient Red Dragon Hearts, 10 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 10, 100);   // Blue Dragon Breath Glands, 10 pcs, 100% consumption risk

// Edge of Oblivion
// Bastard Sword
// +5 enhancement
// Keen
// Vampiric +2
// Effect: Holy
    ATS_Recipe_NewRecipe("Edge of Oblivion", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 41);
    ATS_Recipe_SetSingleType("ATS_C_W141_N_ADA");
    ATS_Recipe_SetMinSkill(360);
    ATS_Recipe_SetMaxSkill(390);
    ATS_Recipe_Ingots(30,100);                                  // 30 Adamantine ingots, 75% chance of ingot loss
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MYR", 30, 100);        // Myrkandite Ingots,
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC09", 10, 100);        // 10 rakhasha eyes
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10", 20, 100);        // 20 Slaad Tongues
    ATS_Recipe_AddMaterial("reddragonheart", 3, 100);           // Ancient Red Dragon Hearts,
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 1, 100);    // Blue Dragon Breath Glands, 10 pcs, 100% consumption risk

// Boggard Holder (Scimitar)
// Damage Bonus : Divine [1d8 Damage]
// Damage Bonus : Positive Energy [1d6 Damage]
// Keen
// Bonus Feat : Knockdown
// Visual Effect : Holy
    ATS_Recipe_NewRecipe("Boggard Holder", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 42);
    ATS_Recipe_SetSingleType("ATS_C_W142_N_ADA");
    ATS_Recipe_SetMinSkill(365);
    ATS_Recipe_SetMaxSkill(395);
    ATS_Recipe_Ingots(20,100);                            // 20 Adamantine Ingots, 100% chance of ingot loss
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 10, 100);   // 10 Blue Dragon Breath Glands, 10 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("reddragonheart", 10, 100);   // 10 Ancient red dragon hearts
    ATS_Recipe_AddMaterial("rage_spid_spin", 5, 100);   // 5 Rage Spider Web Spinner
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13", 5, 100);   // 5 Skeleton Knuckles
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC24", 1, 100);   // 1 Garlic
    ATS_Recipe_AddMaterial("RecipeForBoggardHolder", 1, 100);   // The Recipe

// -----------------------------------------------------------------------------

// W221 LightHammer

// W222 WarHammer

// Golden Mace of Confinement
// 3/day Web
// Ehancement +1
// Massive Criticals 1d4
    ATS_Recipe_NewRecipe("Golden Mace of Confinement", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 36);
    ATS_Recipe_SetSingleType("ATS_C_W236_N_GOL");
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(170);
    ATS_Recipe_Ingots(3,50);                             // 3 gold ingots
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC07", 2, 100);  // Ettercap's Silk Gland, 2 pcs, 100% consumption risk

// -----------------------------------------------------------------------------

// Quarterstaff of Fear
// +2 Enhancement
// 1d6 Acid Damage
// On Hit: Fear DC14
    ATS_Recipe_NewRecipe("Quarterstaff of Fear", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 21);
    ATS_Recipe_SetSingleType("ATS_C_W321_N_MIT");
    ATS_Recipe_SetMinSkill(280);
    ATS_Recipe_SetMaxSkill(320);
    ATS_Recipe_Ingots(5,50);                              // 5 Mithral ingots
    ATS_Recipe_AddMaterial("WillOWispessence", 4, 100);   // Will O Wisp essences, 4 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("Blackdragonliver", 2, 100);   // Black Dragon's Liver, 2 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_WDBMQS002", 1, 100);       // Quarterstaff +1, 100% consumption risk


// Quarterstaff of Wounding
// +3 Enhancement
// On Hit: Wounding DC14
    ATS_Recipe_NewRecipe("Quarterstaff of Wounding", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 22);
    ATS_Recipe_SetSingleType("ATS_C_W322_N_ADA");
    ATS_Recipe_SetMinSkill(320);
    ATS_Recipe_SetMaxSkill(360);
    ATS_Recipe_Ingots(5,50);                             // 5 Adamantine ingots
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 2, 100);  // Dragon's Blood, 2 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC06", 2, 100);  // Bodak's Teeth, 2 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("NW_WDBMQS002", 1, 100);      // Quarterstaff +1, 100% consumption risk
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 5, 100);  // Mithral Ingots, 5 pcs, 100% consumption risk

// Dark Omen
    ATS_Recipe_NewRecipe("Dark Omen", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 23);
    ATS_Recipe_SetSingleType("ATS_C_W323_N_MIT");
    ATS_Recipe_SetMinSkill(370);
    ATS_Recipe_SetMaxSkill(400);
    ATS_Recipe_Ingots(20,100);                               // 6 Mithril ingots
    ATS_Recipe_AddMaterial("reddragonheart", 8, 100);        // 8 red dragon hearts
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 8, 100); // 8 blue dragon breath glands
    ATS_Recipe_AddMaterial("Blackdragonliver", 8, 100);      // 8 black dragon livers
    ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 20, 100);     // 20 admantine ingots
    ATS_Recipe_AddMaterial("ATS_C_G001_N_DIA", 5, 100);      // 5 diamonds (cut)
    ATS_Recipe_AddMaterial("ATS_C_G001_N_RBY", 5, 100);      // 5 rubie (cut)
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC18", 3, 100);      // 3 pieces of Ironwood
    ATS_Recipe_AddMaterial("RecipieoftheDarkOmen", 1, 100);     // 1 recipie

// -----------------------------------------------------------------------------

// Composite Longbow of Distant Death
// Attack Bonus +4
// Mighty +4
// Ability Bonus: Dexterity +3
    ATS_Recipe_NewRecipe("Composite Longbow of Distant Death", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_EXOTIC, 37);
    ATS_Recipe_SetSingleType("ATS_C_W437_N_MIT");
    ATS_Recipe_SetMinSkill(370);
    ATS_Recipe_SetMaxSkill(395);
    ATS_Recipe_Ingots(10,50);                            // 10 Mithral ingots
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC18", 4, 100);  // Ironwood, 4 pcs, 100% consumption risk
    ATS_Recipe_AddMaterial("WillOWispessence", 4, 100);  // Will O Wisp essences, 4 pcs, 100% consumption risk

// Kama of Delor
// Attack Bonus +1, weight reductions, d6 cold, d6 divine, keen
// vampiric +1, Vis. Eff: Holy
    ATS_Recipe_NewRecipe("Kama of Delor", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_EXOTIC, 38);
    ATS_Recipe_SetSingleType("ATS_C_W438_N_BLA");
    ATS_Recipe_SetMinSkill(330);
    ATS_Recipe_SetMaxSkill(360);
    ATS_Recipe_Ingots(6,100);                               // 6 Shadow ingots
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC11", 1, 100);     // Quartz Crystal,
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC18", 1, 100);     // Ironwood,
    ATS_Recipe_AddMaterial("ATS_C_G001_N_SAP", 3, 100);     // saphire 3
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC09", 2, 100);     // Rakshasa Eyes
    ATS_Recipe_AddMaterial("KamaofDelorRecipe", 1, 100);     // 1 recipie

// -----------------------------------------------------------------------------

// Basic Arrowhead
    ATS_Recipe_NewRecipe("Basic Arrowhead", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AMMO, 21);
    ATS_Recipe_SetSingleType("ATS_C_W721_N_IRO");
    ATS_Recipe_SetMinSkill(120);
    ATS_Recipe_SetMaxSkill(140);
    ATS_Recipe_Ingots(1,50);

// Hooked ArrowHead
    ATS_Recipe_NewRecipe("Hooked Arrowhead", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AMMO, 22);
    ATS_Recipe_SetSingleType("ATS_C_W722_N_IRO");
    ATS_Recipe_SetMinSkill(135);
    ATS_Recipe_SetMaxSkill(155);
    ATS_Recipe_Ingots(1,50);

// Bladed ArrowHead
    ATS_Recipe_NewRecipe("Bladed Arrowhead", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AMMO, 23);
    ATS_Recipe_SetSingleType("ATS_C_W723_N_IRO");
    ATS_Recipe_SetMinSkill(150);
    ATS_Recipe_SetMaxSkill(170);
    ATS_Recipe_Ingots(1,50);

// Advanced ArrowHead
    ATS_Recipe_NewRecipe("Advanced Arrowhead", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AMMO, 24);
    ATS_Recipe_SetSingleType("ATS_C_W724_N_IRO");
    ATS_Recipe_SetMinSkill(165);
    ATS_Recipe_SetMaxSkill(185);
    ATS_Recipe_Ingots(1,50);

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

// ========================
//        Tanning
// ========================

    // Blackened treated leather pouch
    ATS_Recipe_NewRecipe("Blackened Treated Leather Pouch", ATS_CRAFT_TYPE_LEATHER, ATS_CRAFT_PART_MISC, 42);
    ATS_Recipe_SetSingleType("ATS_C_L942_N_SLH");
    ATS_Recipe_SetMinSkill(160);
    ATS_Recipe_SetMaxSkill(190);
    ATS_Recipe_AddMaterial("ATS_C_L102_N_SLH", 2, 80);    // Small tanned black leather hide
    ATS_Recipe_AddMaterial("Blackdragonliver", 1, 100);   // Black Dragon's Liver

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

// ========================
//      JewelCrafting
// ========================

// Mortikie's Ring
// +3 Constitution
// +2 Save vs. Mind Spells
// Darkvision
// Light; Red 15m
// Soak Damage +1 (5)
    ATS_Recipe_NewRecipe("Mortikie's Ring", ATS_CRAFT_TYPE_JEWELCRAFT, 0, 30); // 0 is the category for the smooth band
    ATS_Recipe_SetSingleType("ATS_C_J030_N_RBY");
    ATS_Recipe_SetMinSkill(200);
    ATS_Recipe_SetMaxSkill(250);
    ATS_Recipe_Gems(1);                                  // 1 Cut Ruby
    ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB", 2, 25);   // 2 Rubicite ingots, 25% consumption risk
    ATS_Recipe_AddMaterial("ATS_S_SM00_N_MOL", 1, 100);  // Smooth Ring Mold
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR004", 1, 100);  // Scroll of "Light", 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR208", 1, 100);  // Scroll of "Ghostly Visage", 100% consumption risk
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC12", 1, 100);  // 1 Fenberry, 100% consumption risk

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

// ========================
//        Tailoring
// ========================

// Belt of the Dragon
// Immunity - fear
// Immunity - knockdown
// Immunity - death magic
    ATS_Recipe_NewRecipe("Belt of The Dragons", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 21);
    ATS_Recipe_SetSingleType("ATS_C_T021_N_C14");
    ATS_Recipe_SetMinSkill(390);
    ATS_Recipe_SetMaxSkill(405);
    ATS_Recipe_AddMaterial("ATS_C_T999_N_C14", 1, 100);    // Large Red Cloth
    ATS_Recipe_AddMaterial("reddragonheart", 1, 100);      // 1 Ancient Red Dragon hearts
    ATS_Recipe_AddMaterial("reddragonscale", 5, 100);      // 5 Red Dragon Scales
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 20, 100);   // 20 Dragon's Blood

// -----------------------------------------------------------------------------

// Cloak - Cruiss's Cowl - BeAst
// ATS_C_T121_N_C01
    ATS_Recipe_NewRecipe("Cruiss' Cowl", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOAKS, 21);
    ATS_Recipe_SetSingleType("ATS_C_T121_N_C01");
    ATS_Recipe_SetMinSkill(270);
    ATS_Recipe_SetMaxSkill(310);
    ATS_Recipe_AddMaterial("ATS_C_T999_N_C01", 1, 100);         // 1 Large Aqua Cloths
    ATS_Recipe_AddMaterial("ScimitaroftheEarthDruid", 1, 100);  // 1 Earth Druid Scimitar
    ATS_Recipe_AddMaterial("nw_it_mbelt015", 1, 100);           // 1 Lesser Belt of guiding light
    ATS_Recipe_AddMaterial("nw_it_mbelt016", 1, 100);           // 1 belt of guilding light
    ATS_Recipe_AddMaterial("LichSkull", 15, 100);               // 15 lich skulls
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC09", 25, 100);        // 25 rakhasha eyes
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC17", 20, 100);        // 20 Dragons Blood
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR701", 5, 100);         // 5 scrolls of spell mantle

// -----------------------------------------------------------------------------

// The Whistling Fists, (Taleon)
// +5
// 4d4 extra damage
// on hit stun
    ATS_Recipe_NewRecipe("The Whistling Fists", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 21);
    ATS_Recipe_SetSingleType("ATS_C_T221_N_C02");
    ATS_Recipe_SetMinSkill(270);
    ATS_Recipe_SetMaxSkill(310);
    ATS_Recipe_AddMaterial("ATS_C_T997_N_C02", 2, 100);       // 2 Small Black Cloths
    ATS_Recipe_AddMaterial("reddragonheart", 1, 100);         // 1 Ancient Red Dragon hearts
    ATS_Recipe_AddMaterial("reddragonscale", 10, 100);        // 10 red dragons scales
    ATS_Recipe_AddMaterial("Blackdragonliver", 2, 100);       // 2 Black Dragon Livers
    ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 10, 100);      // 10 Adamantine
    ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 10, 100);      // 10 Mithril
    ATS_Recipe_AddMaterial("ATS_C_G001_N_DIA", 2, 100);       // 2 cut diamond
    ATS_Recipe_AddMaterial("WillOWispessence", 10, 100);      // 20 Wisp Essenses

// Gloves of Strong Force
    ATS_Recipe_NewRecipe("Gloves of Strong Force", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 22);
    ATS_Recipe_SetSingleType("ATS_C_T222_N_C06");
    ATS_Recipe_SetMinSkill(350);
    ATS_Recipe_SetMaxSkill(380);
    ATS_Recipe_AddMaterial("ATS_C_T997_N_C06", 2, 100); // 2 Small Gold Cloths
    ATS_Recipe_AddMaterial("NW_IT_SPARSCR109", 1, 100); // 1 scroll of magic missile
    ATS_Recipe_AddMaterial("reddragonheart", 6, 100); // 6 ancient red dragon hearts
    ATS_Recipe_AddMaterial("ATS_C_G001_N_SAP", 3, 100); // 3 cut sapphire
    ATS_Recipe_AddMaterial("WillOWispessence", 5, 100); // 5 will o wisp essence
    ATS_Recipe_AddMaterial("Blackdragonliver", 5, 100); // 5 black dragon livers
    ATS_Recipe_AddMaterial("RecipeforGlovesofStrongForce", 1, 100);     // 1 recipie

// Artisan's Gloves
    ATS_Recipe_NewRecipe("Artisan's Gloves", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 23);
    ATS_Recipe_SetSingleType("ATS_C_T223_N_C17");
    ATS_Recipe_SetMinSkill(250);
    ATS_Recipe_SetMaxSkill(280);
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13", 5, 100); // 5 Skeleton Knuckles
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC06", 5, 100); // 5 Bodak's Teeth
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC07", 2, 100); // 2 Ettercap silk Glands
    ATS_Recipe_AddMaterial("ATS_C_T997_N_C17", 2, 100); // 2 Small White Cloths
    ATS_Recipe_AddMaterial("WillOWispessence", 1, 100); // 1 will o wisp essence
    ATS_Recipe_AddMaterial("RecipeforArtisansGloves", 1, 100); // 1 recipe

// Gloves Of Retribution
    ATS_Recipe_NewRecipe("Gloves Of Retribution", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 24);
    ATS_Recipe_SetSingleType("ATS_C_T224_N_C17");
    ATS_Recipe_SetMinSkill(320);
    ATS_Recipe_SetMaxSkill(350);
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13", 20, 100); // 20 Skeleton Knuckles
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 20, 100); // 20 essence of acid
    ATS_Recipe_AddMaterial("ATS_R_CFFF_N_POT", 20, 100); // 20 essence of fire
    ATS_Recipe_AddMaterial("ATS_R_CFFC_N_POT", 20, 100); // 20 essence of cold
    ATS_Recipe_AddMaterial("ATS_R_CFFE_N_POT", 20, 100); // 20 essence of electricity
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 20, 100); // 20 advanced arrow fletch
    ATS_Recipe_AddMaterial("supercowhide", 2, 100); // 2 super cow hides
    ATS_Recipe_AddMaterial("glovesofretrecipe", 1, 100); // 1 recipe

// -----------------------------------------------------------------------------
// FLETCHING
// -----------------------------------------------------------------------------

// Regular Arrow Shaft
    ATS_Recipe_NewRecipe("Regular Shaft", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 20);
    ATS_Recipe_SetSingleType("ATS_C_F020_N_ARR");
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Staff

// Advanced Arrow Shaft
    ATS_Recipe_NewRecipe("Advanced Shaft", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 21);
    ATS_Recipe_SetSingleType("ATS_C_F021_N_ARR");
    ATS_Recipe_SetMinSkill(170);
    ATS_Recipe_SetMaxSkill(200);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Staff

// Frostreaver Arrow
    ATS_Recipe_NewRecipe("Frostreaver Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 18);
    ATS_Recipe_SetSingleType("ATS_C_F018_N_ARR");         // Frostreaver Arrow
    ATS_Recipe_SetMinSkill(150);
    ATS_Recipe_SetMaxSkill(195);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F020_N_ARR", 1, 100);   // Regular Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFC_N_POT", 1, 50);    // Essence of Cold
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 1, 50);    // Essence of Acid

// Frostreaver Bolt
    ATS_Recipe_NewRecipe("Frostreaver Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 19);
    ATS_Recipe_SetSingleType("ATS_C_F019_N_ARR");         // Frostreaver Bolt
    ATS_Recipe_SetMinSkill(150);
    ATS_Recipe_SetMaxSkill(195);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F020_N_ARR", 1, 100);   // Regular Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFC_N_POT", 1, 50);    // Essence of Cold
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 1, 50);    // Essence of Acid

// Searer Arrow
    ATS_Recipe_NewRecipe("Searer Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 22);
    ATS_Recipe_SetSingleType("ATS_C_F022_N_ARR");         // Searer Arrow
    ATS_Recipe_SetMinSkill(160);
    ATS_Recipe_SetMaxSkill(205);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F020_N_ARR", 1, 100);   // Regular Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFF_N_POT", 1, 50);    // Essence of Fire
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 1, 50);    // Essence of Acid

// Searer Bolt
    ATS_Recipe_NewRecipe("Searer Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 23);
    ATS_Recipe_SetSingleType("ATS_C_F023_N_ARR");         // Searer Bolt
    ATS_Recipe_SetMinSkill(160);
    ATS_Recipe_SetMaxSkill(205);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F020_N_ARR", 1, 100);   // Regular Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("ATS_R_CFFF_N_POT", 1, 50);    // Essence of Fire
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 1, 50);    // Essence of Acid

// Winter's Grip Arrow
    ATS_Recipe_NewRecipe("Winter's Grip Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 24);
    ATS_Recipe_SetSingleType("ATS_C_F024_N_ARR");         // Winter's Grip Arrow
    ATS_Recipe_SetMinSkill(190);
    ATS_Recipe_SetMaxSkill(240);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F021_N_ARR", 1, 100);   // Advanced Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("FletchersEssence", 1, 50);    // Fletcher's Essence
    ATS_Recipe_AddMaterial("WhiteDragonLung", 1, 100);    // White Dragon Lung

// Winters's Grip Bolt
    ATS_Recipe_NewRecipe("Winter's Grip Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 25);
    ATS_Recipe_SetSingleType("ATS_C_F025_N_ARR");         // Winter's Grip Bolt
    ATS_Recipe_SetMinSkill(190);
    ATS_Recipe_SetMaxSkill(240);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F021_N_ARR", 1, 100);   // Advanced Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("FletchersEssence", 1, 50);    // Fletcher's Essence
    ATS_Recipe_AddMaterial("WhiteDragonLung", 1, 100);    // White Dragon Lung

// Thunderclap Arrow
    ATS_Recipe_NewRecipe("Thunderclap Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 26);
    ATS_Recipe_SetSingleType("ATS_C_F026_N_ARR");         // Thunderclap Arrow
    ATS_Recipe_SetMinSkill(230);
    ATS_Recipe_SetMaxSkill(280);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F021_N_ARR", 1, 100);   // Advanced Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("FletchersEssence", 1, 50);    // Fletcher's Essence
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 1, 100);    // Blue Dragon Breath Gland

// Thunderclap Bolt
    ATS_Recipe_NewRecipe("Thunderclap Bolt", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 27);
    ATS_Recipe_SetSingleType("ATS_C_F027_N_ARR");         // Thunderclap Bolt
    ATS_Recipe_SetMinSkill(230);
    ATS_Recipe_SetMaxSkill(280);
    ATS_Recipe_AddMaterial("ATS_C_W724_N_IRO", 1, 100);   // Advanced Arrow Head
    ATS_Recipe_AddMaterial("ATS_C_F021_N_ARR", 1, 100);   // Advanced Shaft
    ATS_Recipe_AddMaterial("ATS_R_FAFL_N_ARR", 1, 100);   // Advanced Arrow Fletch
    ATS_Recipe_AddMaterial("FletchersEssence", 1, 50);    // Fletcher's Essence
    ATS_Recipe_AddMaterial("Bluedragonbreathgland", 1, 100);    // Blue Dragon Breath Gland


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

}



void main()
{
    ATS_CustomRecipes();
    ATS_TinkerRecipes();
}
