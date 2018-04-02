//------------------------------------------------------------------------------
//
// ats_inc_update
//
// Include for ATS, tinkering recipies
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

void ATS_TinkerRecipes()
{
    // Wire
    // Wires go from Copper through Gold
    ATS_Recipe_NewRecipe("Wire", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_WIRES, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(10);
    ATS_Recipe_Ingots(2);

    // Gears
    // Gears require base metal ingots. Copper through Gold
    ATS_Recipe_NewRecipe("Gearset", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_WIRES, 02);
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_Ingots(3);

    // Widgets
    // Widgets require wires and a gear of the proper metal and some ingots
    ATS_Recipe_NewRecipe("Copper Housed Widget", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_WIDGET, 01);
    ATS_Recipe_SetSingleType("ATS_C_Z001_N_COP");         // Copper housed widget
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_C_Z102_N_COP", 1, 100);   // Gearset
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 2, 100);   // Wires
    ATS_Recipe_Ingots(4);   // Ingots

    ATS_Recipe_NewRecipe("Bronze Housed Widget", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_WIDGET, 02);
    ATS_Recipe_SetSingleType("ATS_C_Z002_N_BRO");         // Bronze housed widget
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_C_Z102_N_BRO", 1, 100);   // Gearset
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 2, 100);   // Wires
    ATS_Recipe_Ingots(4);   // Ingots

    ATS_Recipe_NewRecipe("Iron Housed Widget", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_WIDGET, 03);
    ATS_Recipe_SetSingleType("ATS_C_Z003_N_IRO");         // Iron housed widget
    ATS_Recipe_SetMinSkill(120);
    ATS_Recipe_SetMaxSkill(175);
    ATS_Recipe_AddMaterial("ATS_C_Z102_N_IRO", 1, 100);   // Gearset
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 2, 100);   // Wires
    ATS_Recipe_Ingots(4);   // Ingots

    ATS_Recipe_NewRecipe("Silver Housed Widget", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_WIDGET, 04);
    ATS_Recipe_SetSingleType("ATS_C_Z004_N_SIL");         // Silver housed widget
    ATS_Recipe_SetMinSkill(175);
    ATS_Recipe_SetMaxSkill(235);
    ATS_Recipe_AddMaterial("ATS_C_Z102_N_SIL", 1, 100);   // Gearset
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_SIL", 2, 100);   // Wires
    ATS_Recipe_Ingots(4);   // Ingots

    ATS_Recipe_NewRecipe("Gold Housed Widget", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_WIDGET, 05);
    ATS_Recipe_SetSingleType("ATS_C_Z005_N_GOL");         // Gold housed widget
    ATS_Recipe_SetMinSkill(235);
    ATS_Recipe_SetMaxSkill(270);
    ATS_Recipe_AddMaterial("ATS_C_Z102_N_GOL", 1, 100);   // Gearset
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_GOL", 2, 100);   // Wires
    ATS_Recipe_Ingots(4);   // Ingots

    // Alchemy Packs
    // Flaming
    ATS_Recipe_NewRecipe("Flaming Alchemy Pack", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_CHEMPAKS, 01);
    ATS_Recipe_SetSingleType("ATS_C_Z201_N_ALK");         // Crafted Flaming Arrow
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_SLH", 1, 100);   // Small Cured Leather Hide
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 1, 100);   // Copper Wire
    ATS_Recipe_AddMaterial("ATS_R_CFFF_N_POT", 1, 100);   // Essence of Fire

    // Electrical
    ATS_Recipe_NewRecipe("Electrical Alchemy Pack", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_CHEMPAKS, 02);
    ATS_Recipe_SetSingleType("ATS_C_Z202_N_ALK");         // Crafted Electrical Arrow
    ATS_Recipe_SetMinSkill(45);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_SLH", 1, 100);   // Small Cured Leather Hide
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 1, 100);   // Copper Wire
    ATS_Recipe_AddMaterial("ATS_R_CFFE_N_POT", 1, 50);    // Essence of Electricity

    // Acid
    ATS_Recipe_NewRecipe("Acid Alchemy Pack", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_CHEMPAKS, 03);
    ATS_Recipe_SetSingleType("ATS_C_Z203_N_ALK");         // Crafted Acid Arrow
    ATS_Recipe_SetMinSkill(65);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_SLH", 1, 100);   // Small Cured Leather Hide
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 1, 100);   // Copper Wire
    ATS_Recipe_AddMaterial("ATS_R_CFFA_N_POT", 1, 50);    // Essence of Acid

    // Frozen
    ATS_Recipe_NewRecipe("Frozen Alchemy Pack", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_CHEMPAKS, 04);
    ATS_Recipe_SetSingleType("ATS_C_Z204_N_ALK");         // Crafted Frozen Arrow
    ATS_Recipe_SetMinSkill(85);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_C_L001_N_SLH", 1, 100);   // Small Cured Leather Hide
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 1, 100);   // Copper Wire
    ATS_Recipe_AddMaterial("ATS_R_CFFC_N_POT", 1, 50);    // Essence of Cold

    // Traps - all traps require a widget, a wire and some require an alchemy pack
    // Weak spike - ATS_C_Z401_COP
    ATS_Recipe_NewRecipe("Weak Spike Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 01);
    ATS_Recipe_SetSingleType("ATS_C_Z401_N_COP");
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_C_Z001_N_COP", 2, 100);   // Copper Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 1, 100);   // Wire

    // weak tangle - ATS_C_Z402_COP
    ATS_Recipe_NewRecipe("Weak Tangle Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 02);
    ATS_Recipe_SetSingleType("ATS_C_Z402_N_COP");
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(85);
    ATS_Recipe_AddMaterial("ATS_C_Z001_N_COP", 2, 100);   // Copper Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 1, 100);   // Wire

    // weak fire - ATS_C_Z403_BRO
    ATS_Recipe_NewRecipe("Weak Fire Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 03);
    ATS_Recipe_SetSingleType("ATS_C_Z403_N_BRO");
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(105);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 1, 100);   // Alchemy Pack

    // weak shocking - ATS_C_Z404_BRO
    ATS_Recipe_NewRecipe("Weak Shocking Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 04);
    ATS_Recipe_SetSingleType("ATS_C_Z404_N_BRO");
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 1, 100);   // Alchemy Pack

    // weak acid - ATS_C_Z405_BRO
    ATS_Recipe_NewRecipe("Weak Acid Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 05);
    ATS_Recipe_SetSingleType("ATS_C_Z405_N_BRO");
    ATS_Recipe_SetMinSkill(105);
    ATS_Recipe_SetMaxSkill(130);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z203_N_ALK", 1, 100);   // Alchemy Pack

    // weak frost - ATS_C_Z406_BRO
    ATS_Recipe_NewRecipe("Weak Shocking Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 06);
    ATS_Recipe_SetSingleType("ATS_C_Z406_N_BRO");
    ATS_Recipe_SetMinSkill(120);
    ATS_Recipe_SetMaxSkill(145);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z204_N_ALK", 1, 100);   // Alchemy Pack

    // medium spike ATS_C_Z407_IRO
    ATS_Recipe_NewRecipe("Medium Spike Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 07);
    ATS_Recipe_SetSingleType("ATS_C_Z407_N_IRO");
    ATS_Recipe_SetMinSkill(135);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 1, 100);   // Wire

    // medium tangle ATS_C_Z408_IRO
    ATS_Recipe_NewRecipe("Medium Tangle Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 08);
    ATS_Recipe_SetSingleType("ATS_C_Z408_N_IRO");
    ATS_Recipe_SetMinSkill(150);
    ATS_Recipe_SetMaxSkill(175);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 1, 100);   // Wire

    // medium fire - ATS_C_Z409_IRO
    ATS_Recipe_NewRecipe("Medium Fire Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 09);
    ATS_Recipe_SetSingleType("ATS_C_Z409_N_IRO");
    ATS_Recipe_SetMinSkill(165);
    ATS_Recipe_SetMaxSkill(190);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 1, 100);   // Alchemy Pack

    // medium shocking ATS_C_Z410_IRO
    ATS_Recipe_NewRecipe("Medium Shocking Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 10);
    ATS_Recipe_SetSingleType("ATS_C_Z410_N_IRO");
    ATS_Recipe_SetMinSkill(180);
    ATS_Recipe_SetMaxSkill(200);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 1, 100);   // Alchemy Pack

    // medium acid ATS_C_Z411_IRO
    ATS_Recipe_NewRecipe("Medium Acid Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 11);
    ATS_Recipe_SetSingleType("ATS_C_Z411_N_IRO");
    ATS_Recipe_SetMinSkill(195);
    ATS_Recipe_SetMaxSkill(220);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z203_N_ALK", 1, 100);   // Alchemy Pack

    // medium frost ATS_C_Z412_IRO
    ATS_Recipe_NewRecipe("Medium Frost Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 12);
    ATS_Recipe_SetSingleType("ATS_C_Z412_N_IRO");
    ATS_Recipe_SetMinSkill(215);
    ATS_Recipe_SetMaxSkill(240);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z204_N_ALK", 1, 100);   // Alchemy Pack

    // strong spike ATS_C_Z413_SIL
    ATS_Recipe_NewRecipe("Strong Spike Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 13);
    ATS_Recipe_SetSingleType("ATS_C_Z413_N_SIL");
    ATS_Recipe_SetMinSkill(235);
    ATS_Recipe_SetMaxSkill(260);
    ATS_Recipe_AddMaterial("ATS_C_Z004_N_SIL", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_SIL", 1, 100);   // Wire

    // strong tangle ATS_C_Z414_SIL
    ATS_Recipe_NewRecipe("Strong Tangle Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 14);
    ATS_Recipe_SetSingleType("ATS_C_Z414_N_SIL");
    ATS_Recipe_SetMinSkill(255);
    ATS_Recipe_SetMaxSkill(280);
    ATS_Recipe_AddMaterial("ATS_C_Z004_N_SIL", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_SIL", 1, 100);   // Wire

    // strong fire ATS_C_Z415_GOL
    ATS_Recipe_NewRecipe("Strong Fire Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 15);
    ATS_Recipe_SetSingleType("ATS_C_Z415_N_GOL");
    ATS_Recipe_SetMinSkill(275);
    ATS_Recipe_SetMaxSkill(300);
    ATS_Recipe_AddMaterial("ATS_C_Z005_N_GOL", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_GOL", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 1, 100);   // Alchemy Pack

    // strong shocking ATS_C_Z416_GOL
    ATS_Recipe_NewRecipe("Strong Shocking Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 16);
    ATS_Recipe_SetSingleType("ATS_C_Z416_N_GOL");
    ATS_Recipe_SetMinSkill(295);
    ATS_Recipe_SetMaxSkill(320);
    ATS_Recipe_AddMaterial("ATS_C_Z005_N_GOL", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_GOL", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 1, 100);   // Alchemy Pack

    // strong acid ATS_C_Z417_GOL
    ATS_Recipe_NewRecipe("Strong Acid Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 17);
    ATS_Recipe_SetSingleType("ATS_C_Z417_N_GOL");
    ATS_Recipe_SetMinSkill(315);
    ATS_Recipe_SetMaxSkill(340);
    ATS_Recipe_AddMaterial("ATS_C_Z005_N_GOL", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_GOL", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z203_N_ALK", 1, 100);   // Alchemy Pack

    // strong frost ATS_C_Z418_GOL
    ATS_Recipe_NewRecipe("Strong Frost Trap", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRAPS, 18);
    ATS_Recipe_SetSingleType("ATS_C_Z418_N_GOL");
    ATS_Recipe_SetMinSkill(335);
    ATS_Recipe_SetMaxSkill(360);
    ATS_Recipe_AddMaterial("ATS_C_Z005_N_GOL", 2, 100);   // Widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_GOL", 1, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z204_N_ALK", 1, 100);   // Alchemy Pack

    // devices
    // Devices are the random and cool things to craft. Some are useless, some rock
    // Fire Stick - Throws Burning Hands
    ATS_Recipe_NewRecipe("Gnomish Fire Stick", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 01);
    ATS_Recipe_SetSingleType("ATS_C_Z301_N_COP");
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 2, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 1, 100);   // Alchemy Pack

    // Tinkered Mining Helm - Casts Light (5)
    ATS_Recipe_NewRecipe("Tinkered Mining Helmet", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 02);
    ATS_Recipe_SetSingleType("ATS_C_Z302_N_COP");
    ATS_Recipe_SetMinSkill(45);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_C_A101_N_COP", 1, 100); // crafted copper open helm
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 2, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 1, 100);   // Alchemy Pack

    // Gnomish Stun Rod
    ATS_Recipe_NewRecipe("Gnomish Stun Rod", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 03);
    ATS_Recipe_SetSingleType("ATS_C_Z303_N_COP");
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_C_Z001_N_COP", 1, 100); // copper widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_COP", 2, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 1, 100);   // Alchemy Pack

    // Tinkered Cloaking Device
    ATS_Recipe_NewRecipe("Tinkered Cloaking Device", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 04);
    ATS_Recipe_SetSingleType("ATS_C_Z304_N_BRO");
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(145);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 2, 100); // bronze widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 2, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 1, 100);   // Alchemy Pack
    ATS_Recipe_AddMaterial("ATS_R_ORE1_N_BLA", 1, 100); // shadow ore

    // Rocket Boots
    ATS_Recipe_NewRecipe("Gnomish Rocket Boots", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 05);
    ATS_Recipe_SetSingleType("ATS_C_Z305_N_BRO");
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(180);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 2, 100); // bronze widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 2, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 2, 100);   // Alchemy Pack
    ATS_Recipe_AddMaterial("ATS_C_L905_N_SLH", 1, 100);  // Hard Leather Boots

    // Acid Blaster
    ATS_Recipe_NewRecipe("Gnomish Acid Blaster", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 06);
    ATS_Recipe_SetSingleType("ATS_C_Z306_N_IRO");
    ATS_Recipe_SetMinSkill(175);
    ATS_Recipe_SetMaxSkill(210);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 4, 100); // bronze widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 4, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z203_N_ALK", 4, 100);   // Alchemy Pack
    ATS_Recipe_AddMaterial("NW_WBWXL001", 1, 100);  // Light Crossbow

    // Gnomish Crafted Automaton
    ATS_Recipe_NewRecipe("Gnomish Crafted Automaton", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 07);
    ATS_Recipe_SetSingleType("ATS_C_Z307_N_GOL");
    ATS_Recipe_SetMinSkill(325);
    ATS_Recipe_SetMaxSkill(385);
    ATS_Recipe_AddMaterial("ATS_C_Z005_N_GOL", 8, 100); // Gold widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_GOL", 20, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 8, 100);   // Alchemy Pack (electrical)
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 6, 100);   // Alchemy Pack (fire)

    // Clock of Ages
    ATS_Recipe_NewRecipe("Clock of Ages", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 08);
    ATS_Recipe_SetSingleType("ATS_C_Z308_N_GOL");
    ATS_Recipe_SetMinSkill(360);
    ATS_Recipe_SetMaxSkill(425);    // That's right, it never goes green
    ATS_Recipe_AddMaterial("ATS_C_Z005_N_GOL", 8, 100);   // Gold widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_GOL", 8, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 4, 100);   // Alchemy Pack (electrical)
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 4, 100);   // Alchemy Pack (fire)
    ATS_Recipe_AddMaterial("ATS_C_Z203_N_ALK", 4, 100);   // Alchemy Pack (acid)
    ATS_Recipe_AddMaterial("ATS_C_Z204_N_ALK", 4, 100);   // Alchemy Pack (cold)
    ATS_Recipe_AddMaterial("rage_spid_spin", 2, 100);     // Rage spider web spinner

    // Gnomish Crafted Helper
    ATS_Recipe_NewRecipe("Gnomish Crafted Helper", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 09);
    ATS_Recipe_SetSingleType("ATS_C_Z309_N_BRO");
    ATS_Recipe_SetMinSkill(135);
    ATS_Recipe_SetMaxSkill(185);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 6, 100); // Bronze widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 10, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 6, 100);   // Alchemy Pack (electrical)

    // Fire Pipe
    ATS_Recipe_NewRecipe("Gnomish Fire Pipe", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 10);
    ATS_Recipe_SetSingleType("ATS_C_Z310_N_BRO");
    ATS_Recipe_SetMinSkill(140);
    ATS_Recipe_SetMaxSkill(190);
    ATS_Recipe_AddMaterial("ATS_C_Z002_N_BRO", 3, 100); // Bronze widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_BRO", 3, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z201_N_ALK", 3, 100);   // Alchemy Pack (fire)

    // Ice Net
    ATS_Recipe_NewRecipe("Gnomish Ice Net", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 11);
    ATS_Recipe_SetSingleType("ATS_C_Z311_N_IRO");
    ATS_Recipe_SetMinSkill(175);
    ATS_Recipe_SetMaxSkill(220);
    ATS_Recipe_AddMaterial("ATS_C_Z003_N_IRO", 4, 100); // Iron widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_IRO", 3, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z204_N_ALK", 4, 100);   // Alchemy Pack (frozen)

    // Lightning Gun
    ATS_Recipe_NewRecipe("Gnomish Lightning Gun", ATS_CRAFT_TYPE_TINKER, ATS_CRAFT_PART_TRINKETS, 12);
    ATS_Recipe_SetSingleType("ATS_C_Z312_N_SIL");
    ATS_Recipe_SetMinSkill(325);
    ATS_Recipe_SetMaxSkill(370);
    ATS_Recipe_AddMaterial("ATS_C_Z004_N_SIL", 4, 100); // silver widget
    ATS_Recipe_AddMaterial("ATS_C_Z101_N_SIL", 4, 100);   // Wire
    ATS_Recipe_AddMaterial("ATS_C_Z202_N_ALK", 8, 100);   // Alchemy Pack
    ATS_Recipe_AddMaterial("NW_WBWXL001", 1, 100);  // Light Crossbow
}

//------------------------------------------------------------------------------
