//::///////////////////////////////////////////////
//:: sy_t_tclass.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By:  Syrsuro
//:: Created On:  November - May
//:://////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////This script will generate a treasure appropriate for its given CR rating.
///////The include files sy_t_magic.nss and sy_t_mundane contain the actual
////////create item function definitions.
/////////////////////////////////////////////////////////////////////////////////////////
#include "sy_t_magic"
//#include "sy_t_mundane"
////////////////////////////////////////////////////////////////////////////////////////

///Declarations///////////////////////////////////////////////////////////////
void GenerateTreasure(object oCreateOn, int nCr, int nTmodifier);    //Determines the number and class of items.
void GenerateMagicItem (object oTarget, int nTClass);//Determines the type (ring, armor, etc) of items.
void GenerateMundane(object oCreateOn, int nCr);
//////////////////////////////////////////////////////////////////////////////


//////This script allows the DM to globally adjust the generation scripts.
////If you are using the default exp setting of 10%, it is recommended that you use
////the default settings of poor (2%), standard (5%) and rich (10%) for all cash loots
//////(this value is set in the nw_o_generalxxx scripts).
///////Otherwise, the players will accumulate cash treasure at a significantly faster rate.
void TreasureChance (object oCreateOn, int nCr, int nTModifier)
{
    CreateGold(oCreateOn, nCr, nTModifier); //The CreateGold script is also (by default) modified by this value.
    if (Random(100) < nTModifier)  {CreateGem (oCreateOn, nCr); }
    if (Random(100) < 100) {GenerateTreasure(oCreateOn, nCr, nTModifier); }   // By default the item generation scripts are NOT reduced.
}
///////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////
//////This function will determine how many and what type of items should be created..
////////////////////////////////////////////////////////////////////////////////////////
///////nCR is intended to be the Challenge Rating of the encounter where they chest is taken.
/////By adjusting the percentages in the following scripts, the odds of a magic item being generated
/////randomly given a specified challenge rating can be adjusted.
/////////////////////////////////////////////////////////////////////////////////////////

void GenerateTreasure(object oCreateOn, int nCr, int nTModifier)
{

    int nRandom; int nQuantity = 1;
    int nTreasureClass = 1;  int x = 0;
    int nCR = nCR + nTModifier/2 - 3;  //Default values of nTModifier are 2 (poor), 6 (standard) and 10 (rich).
                                        //This reduces the CR of the chest by 2 if it
                                        //is a poor chest or increases it by 2 if it is a rich chest.
    if (nCr < 1) {nCr = 1;}
    switch (nCr)
    {
        case 1:
            nRandom = Random(100) + 1;
            if (nRandom > 98)
            {
                nTreasureClass = 1; nQuantity = 1;
                // This script will generate one minor magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 60)
            {
                nQuantity = d2(3) - 3;
                //This script will generate 0 to 3 mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 2:
            nRandom = Random(100) + 1;
            if (nRandom > 95)
            {
                nTreasureClass = 1; nQuantity = 1;
                //This script will generate one minor magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 55)
            {
                nQuantity = d2(3) - 3;
                // This script will generate 0 -3 mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 3:
            nRandom = Random(100) + 1;
            if (nRandom > 95)
            {
                nTreasureClass = 1; nQuantity = 1;
                // This script will generate one minor item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 55)
            {
                nQuantity = d2(3) - 2;
                // This script will generate 1 - 4 mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 4:
            nRandom = Random(100) + 1;
            if (nRandom > 85)
            {
                nTreasureClass = 1; nQuantity = 1;
                // This script will generate one minor item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 49)
            {
                nQuantity = d2(2);
                // This script will generate 1 - 4 mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 5:
            nRandom = Random(100) + 1;
            if (nRandom > 78)
            {
                nTreasureClass = 1; nQuantity = 1;
                // This script will generate one minor item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 49)
            {
                nQuantity = d2(2);
                // This script will generate 2 - 4 mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 6:
            nRandom = Random(100) + 1;
            if (nRandom > 62)
            {
                nTreasureClass = 1;  nQuantity = 1;
                // This script will generate 1 minor item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 42)
            {
                nQuantity = d2(2);
                // This script will generate 2 - 4 mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 7:
            nRandom = Random(100) + 1;
            if (nRandom > 99)
            {
                nTreasureClass = 2;  nQuantity = 1;
                // This script will generate 1 medium magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 67)
            {
                nTreasureClass = 1; nQuantity = d3();
                // This script will generate 1 -3 minor magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 57)
            {
                nQuantity = d4();
                // This script will generate 1 - 4 Mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 8:
            nRandom = Random(100) + 1;
            if (nRandom > 97)
            {
                nTreasureClass = 2;  nQuantity = 1;
                // This script will generate 1 Medium Magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 59)
            {
                nTreasureClass = 1; nQuantity = d3();
                // This script will generate 1 - 3 minor magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);    //ONLY ONE
                }       //1d3
            }
            else if (nRandom > 54)
            {
                nQuantity = d3() + 1;
                // This script will generate 2 -4 Mundane items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMundane(oCreateOn, nCr);
                }
            }
            break;
        case 9:
            nRandom = Random(100) + 1;
            if (nRandom > 96)
            {
                nTreasureClass = 2;  nQuantity = 1;
                // This script will generate 1 Medium Magic Item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 51)
            {
                nTreasureClass = 1;  nQuantity = d3();
                // This script will generate 1 - 3 Minor Magic Items
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 10:
            nRandom = Random(100) + 1;
            if (nRandom > 91)
            {
                nTreasureClass = 2; nQuantity = 1;
                // This script will generate 1 Medium Magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 48)
            {
                nTreasureClass = 1; nQuantity = d3() + 1;
                // This script will generate 2 - 4 Minor magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
       case 11:
            nRandom = Random(100) + 1;
            if (nRandom > 99)
            {
                nTreasureClass = 3;  nQuantity = 1;
                // The script will generate one Major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 84)
            {
                nTreasureClass = 2; nQuantity = 1;
                // This script will generate 1 Meduim Magic Item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 40)
            {
                nTreasureClass = 1; nQuantity = d3()+1;
                // This script will generate 2 - 4 Minor Magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
       case 12:
            nRandom = Random(100) + 1;
            if (nRandom > 98)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This script will generate 1 Major Magic Item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 87)
            {
                nTreasureClass = 2;  nQuantity = 1;
                // This script will generate 1 Medium Magic Item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 31)
            {
                nTreasureClass = 1; nQuantity = d3() + 1;
                // This script will generate 2 - 4 Minor Magic Items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 13:
            nRandom = Random(100) + 1;
            if (nRandom > 97)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This script will generate 1 Major Magic Item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 73)
            {
                nTreasureClass = 2;  nQuantity = 1;
                // This script will generate 1 Medium Magic Item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 27)
            {
                nTreasureClass =     1; nQuantity = d3() + 1;
                // This script will generate 2 -4 Minor Magic Items
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 14:
            nRandom = Random(100) + 1;
            if (nRandom > 95)
            {
                nTreasureClass = 3;  nQuantity = 1;
                // This script will generate 1 major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 58)
            {
                nTreasureClass = 2; nQuantity = 1;
                // This script will generate 1 medium magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 29)
            {
                nTreasureClass = 1; nQuantity = d3() + 2;
                // This script will generate 3 - 5 minor magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 15:
            nRandom = Random(100) + 1;
            if (nRandom > 99)
            {
                nTreasureClass = 4; nQuantity = 1;
                // This script will generate one Epic magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 91)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This script will generate 1 Major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 45)
            {
                nTreasureClass = 2; nQuantity = 1;
                // This script will generate one medium magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 17)
            {
                nTreasureClass = 1; nQuantity = d4() + 2;
                // This script will generate 3 - 6 Minor Magic Items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            } break;
        case 16:
            nRandom = Random(100) + 1;
            if (nRandom > 98)
            {
                nTreasureClass = 4;  nQuantity = 1;
                // This script will create 1 Epic magic item.
                // You can increase the quantity by adjusting nQuantity.
               for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 88)
            {
                nTreasureClass = 3;  nQuantity = 1;
                // This script will create 1 Major Magic Item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 34)
            {
                nTreasureClass = 2; nQuantity = d2();
                // This will create 1 -2 medium magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 17:
            nRandom = Random(100) + 1;
            if (nRandom > 97)
            {
                nTreasureClass = 4;  nQuantity = 1;
                // This will create 1 Epic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 87)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This will create 1 major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 34)
            {
                nTreasureClass = 2; nQuantity = d2();
                // This will create 1 -2 Medium magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 18:
            nRandom = Random(100) + 1;
            if (nRandom > 95)
            {
                nTreasureClass = 4;  nQuantity = 1;
                // This will create 1 Epic magic item
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 78)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This will create 1 Major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 25)
            {
                nTreasureClass = 2; nQuantity = d2();
                // This will create 1 -2 Medium magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 19:
            nRandom = Random(100) + 1;
            if (nRandom > 92)
            {
                nTreasureClass = 4; nQuantity = 1;
                //This will create 1 Epic magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 68)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This will create 1 Major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 25)
            {
                nTreasureClass = 2; nQuantity = d3();
                // This will create 1 - 4 Medium magic items.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            break;
        case 20:
            nRandom = Random(100) + 1;
            if (nRandom > 90)
            {
                nTreasureClass = 4; nQuantity = 1;
                // This will create 1 Epic magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 58)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This will create 1 Major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 20)
            {
                nTreasureClass = 2; nQuantity = d4() + 1;
                // This will create 2 - 5 Medium magic items.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
             }
            break;
        default:
            nRandom = Random(100) + 1;
            if (nRandom > 90)
            {
                nTreasureClass = 4; nQuantity = 1;
                // This will create 1 Epic magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 58)
            {
                nTreasureClass = 3; nQuantity = 1;
                // This will create 1 Major magic item.
                // You can increase the quantity by adjusting nQuantity.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
            }
            else if (nRandom > 20)
            {
                nTreasureClass = 2; nQuantity = d4() + 1;
                // This will create 2 - 5 Medium magic items.
                for (x = 0; x < nQuantity; x++)
                {
                    GenerateMagicItem (oCreateOn, nTreasureClass);
                }
             }
            break;
}}
//////////////////////////////////////////////////////////////////////////////
   /////////////////DETERMINE TYPE OF TREASURE/////////////////////
 ///////////This will determine what kind of item is found//////
 //////////////////////////////////////////////////////////////////
 /////////By adjusting the values for ARCANE, etc you can alter the likelihood
 ////////of a particular item type occuring in a given treasure class.
 /////////The total of all variables should equal 100.
 ///////////////////////////////////////////////////////////////////////////////
void GenerateMagicItem (object oTarget, int nTClass)         //
{                                                               //
    object oCreateOn = oTarget;
    int ARCANE = 20; int DIVINE = 10; int AMMO = 8; int POTION = 20; int RING = 3; int WAND = 9;
     int WEAPON = 5; int ARMOR = 5; int AMULET = 2; int MISC = 1; int GARB = 7;
    switch (nTClass)
    {
        case 1: {///Minor items///
                int ARCANE = 20; int DIVINE = 10; int AMMO = 10;    int POTION = 20;
                int RING = 5;    int WAND = 9;   int WEAPON = 7;    int ARMOR = 7;
                int AMULET = 3;  int MISC = 2;   int GARB = 7;
                } break;
        case 2: {///Medium items////
                int ARCANE = 10; int DIVINE = 5; int AMMO = 10;    int POTION = 10;
                int RING = 10;   int WAND = 15;  int WEAPON = 10; int ARMOR = 10;
                int AMULET = 5;  int MISC = 2;   int GARB = 13;
                } break;
        case 3: {///Major items///
                int ARCANE = 8;  int DIVINE = 4; int AMMO = 8;    int POTION = 5;
                int RING = 10;   int WAND = 20;  int WEAPON = 10; int ARMOR = 10;
                int AMULET = 6;  int MISC = 4;   int GARB = 15;
                } break;
        case 4: {///Epic items/////
                int ARCANE = 8;  int DIVINE = 4; int AMMO = 5;    int POTION = 5;
                int RING = 10;   int WAND = 20;  int WEAPON = 11; int ARMOR = 11;
                int AMULET = 6;  int MISC = 5;   int GARB = 15;
                } break;
     };
    int nItemType = Random(100);
    if (nItemType < ARCANE)
        {CreateArcaneScroll(oCreateOn, nTClass);}           //Arcane Scroll
    else if (nItemType < ARCANE + DIVINE)
        {CreateDivineScroll(oCreateOn, nTClass);}           //Divine Scroll
    else if (nItemType < ARCANE + DIVINE + AMMO)
        {GenerateExhRange(oCreateOn, nTClass);}            //Ammo and Thrown Weapons
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION)
        {CreatePotion(oCreateOn, nTClass);}                 //Potion
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING)
        {CreateRing (oCreateOn,  nTClass);}                 //Ring
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET)
        {CreateAmulet (oCreateOn, nTClass);}                //Amulet
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC)
        {CreateMisc (oCreateOn, nTClass);}                  //Miscellaneous Items
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC + WAND)
        {CreateWand (oCreateOn,nTClass);}                   // Rods, Staves and Wands
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC + WAND + GARB)
        {CreateGarb (oCreateOn, nTClass);}                 //Garb
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC + WAND + GARB + WEAPON)
        {CreateWeapon (oCreateOn, nTClass);}                //Weapon
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC + WAND + GARB + WEAPON + ARMOR)
        {CreateArmor (oCreateOn, nTClass);}                //Armor
}


///////////////////////////////////////////////////////////////////////////
void GenerateMundane(object oCreateOn, int nCr)
{
    int nGMRandom = Random(12) + 1;
    switch (nGMRandom)
    {
        case 1:  CreateNMClothing (oCreateOn);  break;
        case 2:  case 3: CreateNMArmor (oCreateOn); break;
        case 4:  case 5: CreateNMWeapon (oCreateOn); break;
        case 6:  case 7: CreateNMAmmo (oCreateOn); break;
        case 8:  CreateJunk (oCreateOn); break;
        case 9:  CreateBook (oCreateOn); break;
        case 10: case 11: case 12: GenerateKit(oCreateOn, nCr);  break;
        //case 12: CreateArt (oCreateOn, nCr); break;
     }
}

/////////////////////////////////////////////////////////////////////////////////
//void main () {}
