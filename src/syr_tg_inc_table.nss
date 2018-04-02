//int StartingConditional () {return FALSE;}
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
///////The include files sy_t_magic.nss contains the actual
////////create item function definitions.
/////////////////////////////////////////////////////////////////////////////////////////
#include "syr_tg_inc_magic"


///Declarations///////////////////////////////////////////////////////////////
struct Treasure SyGenerateTreasure(object oCreateOn, int nCr, int nTmodifier);    //Determines the number and class of items.
string SyGenerateMagicItem (int nTClass);//Determines the type (ring, armor, etc) of items.

//////////////////////////////////////////////////////////////////////////////


//////This script allows the DM to globally adjust the generation scripts.
////If you are using the default exp setting of 10%, it is recommended that you use
////the default settings of poor (2%), standard (5%) and rich (10%) for all cash loots
//////(this value is set in the nw_o_generalxxx scripts).
///////Otherwise, the players will accumulate cash treasure at a significantly faster rate.
int IsArrows (object oNewItem)
{
    if  (   (GetBaseItemType(oNewItem) == BASE_ITEM_ARROW) ||
                (GetBaseItemType(oNewItem) == BASE_ITEM_BOLT) ||
                (GetBaseItemType(oNewItem) == BASE_ITEM_BULLET) ||
                (GetBaseItemType(oNewItem) == BASE_ITEM_DART) ||
                (GetBaseItemType(oNewItem) == BASE_ITEM_THROWINGAXE) ||
                (GetBaseItemType(oNewItem) == BASE_ITEM_SHURIKEN)
                )
                {return TRUE;}
    return FALSE;
}
struct Treasure Itemize(struct Treasure Scroll)
{
    CreateItemOnObject(Scroll.ItemOne,OBJECT_SELF,1); Scroll.ItemOne = "";
    if (MagicLevel == SYR_RICH) {CreateItemOnObject(Scroll.ItemTwo,OBJECT_SELF,1); Scroll.ItemTwo = "";}
    if (MagicLevel != SYR_POOR)
    {
        CreateItemOnObject(Scroll.ItemThree,OBJECT_SELF,1); Scroll.ItemThree = "";
        CreateItemOnObject(Scroll.ItemFour,OBJECT_SELF,1); Scroll.ItemFour = "";
        CreateItemOnObject(Scroll.ItemFive,OBJECT_SELF,1); Scroll.ItemFive = "";
        CreateItemOnObject(Scroll.ItemSix,OBJECT_SELF,1); Scroll.ItemSix = "";
    }
    return Scroll;
}

void TreasureChance (object oCreateOn, int nCr, int nTModifier)
{
    //GeneratedTreasure;
    object oNewItem; struct Treasure Scroll;
    CreateItemOnObject("NW_IT_GOLD001", oCreateOn, SyCreateGold(nCr, nTModifier));
    CreateItemOnObject (SyCreateGem (nCr, nTModifier),oCreateOn, 1);
   //if (Random(100) < 100)
    //{
    struct Treasure GeneratedTreasure = SyGenerateTreasure(oCreateOn, nCr, nTModifier);    // By default the item generation scripts are NOT reduced.
        if (GeneratedTreasure.ItemOne == "arcanescrollshee")
        {
            Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);
        }
        else if (GeneratedTreasure.ItemOne == "divinescrollshee")
        {
            Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);
        }
        else
        {
            oNewItem = CreateItemOnObject(GeneratedTreasure.ItemOne,oCreateOn,1);
            if (IsArrows(oNewItem))
            {
            CreateItemOnObject(GeneratedTreasure.ItemOne,oCreateOn,d10(3));
            }
        }
        if (MagicLevel == SYR_HIGH)
        {
            if  (GeneratedTreasure.ItemTwo == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);     }
            else if (GeneratedTreasure.ItemTwo == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll  = Itemize(Scroll);}
            else {
                    oNewItem = CreateItemOnObject(GeneratedTreasure.ItemTwo,oCreateOn,1);
                    if (IsArrows(oNewItem))
                    {   CreateItemOnObject(GeneratedTreasure.ItemTwo,oCreateOn,d10(3)); }}
                }
        if (MagicLevel != SYR_LOW)
        {
            if (GeneratedTreasure.ItemThree == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr); Scroll = Itemize(Scroll); }
            else if (GeneratedTreasure.ItemThree == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll); }
            else {
                    oNewItem = CreateItemOnObject(GeneratedTreasure.ItemThree,oCreateOn,1);
                    if (IsArrows(oNewItem))
                    {   CreateItemOnObject(GeneratedTreasure.ItemThree,oCreateOn,d10(3));}
                 }
        if (GeneratedTreasure.ItemFour == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr); Scroll = Itemize(Scroll);}
        else if (GeneratedTreasure.ItemFour == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);}
        else {
                oNewItem = CreateItemOnObject(GeneratedTreasure.ItemFour,oCreateOn,1);
                if (IsArrows(oNewItem))
                {   CreateItemOnObject(GeneratedTreasure.ItemFour,oCreateOn,d10(3)); }
             }
    }
    if (MagicLevel = SYR_HIGH)
        {
        if (GeneratedTreasure.ItemFive == "arcanescrollshee")
            {   Scroll = SyCreateArcaneScroll(nCr); Scroll = Itemize(Scroll); }
        else if (GeneratedTreasure.ItemFive == "divinescrollshee")
            {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll); }
        else {  oNewItem = CreateItemOnObject(GeneratedTreasure.ItemFive,oCreateOn,1);
                if (IsArrows(oNewItem))
                {   CreateItemOnObject(GeneratedTreasure.ItemFive,oCreateOn,d10(3)); }
        }
        if (GeneratedTreasure.ItemSix == "arcanescrollshee")
            {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll); }
        else if (GeneratedTreasure.ItemSix == "divinescrollshee")
            {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll); }
        else {
                oNewItem = CreateItemOnObject(GeneratedTreasure.ItemSix,oCreateOn,1);
                if (IsArrows(oNewItem))
                {   CreateItemOnObject(GeneratedTreasure.ItemSix,oCreateOn,d10(3));}
            }
        }
}
///////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////
//////This function will determine how many and what type of items should be created..
////////////////////////////////////////////////////////////////////////////////////////
///////nCR is intended to be the Challenge Rating of the encounter where they chest is taken.
/////By adjusting the percentages in the following scripts, the odds of a magic item being generated
/////randomly given a specified challenge rating can be adjusted.
/////////////////////////////////////////////////////////////////////////////////////////

struct Treasure SyGenerateTreasure(object oCreateOn, int nCr, int nTModifier)
{

    struct Treasure GeneratedTreasure;
    int nRandom; int nQuantity = 0;
    int nTreasureClass = 1;
    int nCR = nCR + MagicLevel/2 - 3;
    if (nCr < 1) {nCr = 1;}
    switch (nCr)
    {
        case 1:
            nRandom = Random(100) + 1;
            if (nRandom > 98) { nTreasureClass = 1; nQuantity = 1;}  // This script will generate one minor magic item.
            else if (nRandom > 60) {    nTreasureClass = 0; nQuantity = d2(3) - 3; }//This script will generate 0 to 3 mundane items.
            break;
        case 2:
            nRandom = Random(100) + 1;
            if (nRandom > 95)
            {nTreasureClass = 1; nQuantity = 1; }  //This script will generate one minor magic item.
            else if (nRandom > 55) {nTreasureClass = 0; nQuantity = d2(3) - 3;}// This script will generate 0 -3 mundane items.
            break;
        case 3:
            nRandom = Random(100) + 1;
            if (nRandom > 95) {nTreasureClass = 1; nQuantity = 1;} // This script will generate one minor item.
            else if (nRandom > 55) {nTreasureClass = 0; nQuantity = d2(3) - 2;}// This script will generate 1 - 4 mundane items.
            break;
        case 4:
            nRandom = Random(100) + 1;
            if (nRandom > 85) {nTreasureClass = 1; nQuantity = 1;} // This script will generate one minor item.
            else if (nRandom > 49)  {nTreasureClass = 0; nQuantity = d2(2);}// This script will generate 1 - 4 mundane items.
            break;
        case 5:
            nRandom = Random(100) + 1;
            if (nRandom > 78) {nTreasureClass = 1; nQuantity = 1;} // This script will generate one minor item.
            else if (nRandom > 49) {nTreasureClass = 0; nQuantity = d2(2); }// This script will generate 2 - 4 mundane items.
            break;
        case 6:
            nRandom = Random(100) + 1;
            if (nRandom > 62) {nTreasureClass = 1;  nQuantity = 1;} // This script will generate 1 minor item.
            else if (nRandom > 42) {nTreasureClass = 0; nQuantity = d2(2);}// This script will generate 2 - 4 mundane items.
            break;
        case 7:
            nRandom = Random(100) + 1;
            if (nRandom > 99) {nTreasureClass = 2;  nQuantity = 1;}// This script will generate 1 medium magic item.
            else if (nRandom > 67) {nTreasureClass = 1; d3(2) - 3;}//This script will generate 0 to 3 minor magic items.
            else if (nRandom > 57) {nTreasureClass = 0; nQuantity = d4();}// This script will generate 1 - 4 Mundane items.
            break;
        case 8:
            nRandom = Random(100) + 1;
            if (nRandom > 97) {nTreasureClass = 2;  nQuantity = 1;}// This script will generate 1 Medium Magic item.
            else if (nRandom > 59)  {nTreasureClass = 1; nQuantity = d3(2) - 3;  //This script will generate 1 to 3 minor magic items
                if (nQuantity < 1) {nQuantity = 1;} }  //(heavily weighted towards 1 item).
            else if (nRandom > 54){nTreasureClass = 0; nQuantity = d3() + 1; } // This script will generate 2 -4 Mundane items.
            break;
        case 9:
            nRandom = Random(100) + 1;
            if (nRandom > 96) {nTreasureClass = 2;  nQuantity = 1;}// This script will generate 1 Medium Magic Item.
            else if (nRandom > 51){{nTreasureClass = 1;  nQuantity = d3(2) - 2;
                if (nQuantity < 1) {nQuantity = 1;} } //This script will generate 1 to 4 minor magic items (weighted towards 1 item).
            break;
        case 10:
            nRandom = Random(100) + 1;
            if (nRandom > 91) {nTreasureClass = 2; nQuantity = 1;} // This script will generate 1 Medium Magic item.
            else if (nRandom > 48) {nTreasureClass = 1;  nQuantity = d3(2) - 2;
                if (nQuantity < 1) {nQuantity = 1;}} //This script will generate 1 to 4 minor magic items (weighted towards 1 item).
           break;
       case 11:
            nRandom = Random(100) + 1;
            if (nRandom > 99) { nTreasureClass = 3;  nQuantity = 1;}// The script will generate one Major magic item.
            else if (nRandom > 84)  {nTreasureClass = 2; nQuantity = 1; }// This script will generate 1 Meduim Magic Item.
            else if (nRandom > 40)  {nTreasureClass = 1; nQuantity = d3();}// This script will generate 1 - 3 Minor Magic items.
            break;
       case 12:
            nRandom = Random(100) + 1;
            if (nRandom > 98) {nTreasureClass = 3; nQuantity = 1; }// This script will generate 1 Major Magic Item.
            else if (nRandom > 87) {nTreasureClass = 2;  nQuantity = 1;}// This script will generate 1 Medium Magic Item.
            else if (nRandom > 31) {nTreasureClass = 1; nQuantity = d4(); }// This script will generate 2 - 4 Minor Magic Items.
            break;
        case 13:
            nRandom = Random(100) + 1;
            if (nRandom > 97) {nTreasureClass = 3; nQuantity = 1; }// This script will generate 1 Major Magic Item.
            else if (nRandom > 73) {nTreasureClass = 2;  nQuantity = 1; }// This script will generate 1 Medium Magic Item.
            else if (nRandom > 27) {nTreasureClass =     1; nQuantity = d4();}// This script will generate 1 -4 Minor Magic Items
            break;
        case 14:
            nRandom = Random(100) + 1;
            if (nRandom > 95) {nTreasureClass = 3;  nQuantity = 1;}// This script will generate 1 major magic item.                 // You can increase the quantity by adjusting nQuantity.
            else if (nRandom > 58) {nTreasureClass = 2; nQuantity = 1;}// This script will generate 1 medium magic item.
            else if (nRandom > 29) {nTreasureClass = 1; nQuantity = d4() + 1;}// This script will generate 2 - 5 minor magic items.
            break;
        case 15:
            nRandom = Random(100) + 1;
            if (nRandom > 99) {nTreasureClass = 4; nQuantity = 1;}// This script will generate one Epic magic item.
            else if (nRandom > 91) {nTreasureClass = 3; nQuantity = 1;}// This script will generate 1 Major magic item.
            else if (nRandom > 45) {nTreasureClass = 2; nQuantity = 1;}// This script will generate one medium magic item.
            else if (nRandom > 17) {nTreasureClass = 1; nQuantity = d4() + 1;}// This script will generate 3 - 6 Minor Magic Items.
            break;
        case 16:
            nRandom = Random(100) + 1;
            if (nRandom > 98) {nTreasureClass = 4;  nQuantity = 1; }// This script will create 1 Epic magic item.
            else if (nRandom > 88) {nTreasureClass = 3;  nQuantity = 1; }// This script will create 1 Major Magic Item.
            else if (nRandom > 34) {nTreasureClass = 2; nQuantity = d3(2) - 4;}
                if (nQuantity < 1) {nQuantity = 1;}} //This script will generate 1 to 2 medium magic items (heavily weighted towards 1 item).
            break;
        case 17:
            nRandom = Random(100) + 1;
            if (nRandom > 97) {nTreasureClass = 4;  nQuantity = 1; }// This will create 1 Epic item.
            else if (nRandom > 87) {nTreasureClass = 3; nQuantity = 1; }// This will create 1 major magic item.
            else if (nRandom > 34) {nTreasureClass = 2; nQuantity = d3(2) - 3;
                if (nQuantity < 1) {nQuantity = 1;}}//This script will generate 1 to 3 medium magic items (heavily weighted towards 1 item).
            break;
        case 18:
            nRandom = Random(100) + 1;
            if (nRandom > 95) {nTreasureClass = 4;  nQuantity = 1;}// This will create 1 Epic magic item
            else if (nRandom > 78) {nTreasureClass = 3; nQuantity = 1;}// This will create 1 Major magic item.
            else if (nRandom > 25) {nTreasureClass = 2; nQuantity = d4() - 1;
                if (nQuantity < 1) {nQuantity = 1;}} //This script will generate 1 to 3 medium magic items weighted towards 1 item).
            break;
        case 19:
            nRandom = Random(100) + 1;
            if (nRandom > 92) { nTreasureClass = 4; nQuantity = 1;} //This will create 1 Epic magic item.
            else if (nRandom > 68) {nTreasureClass = 3; nQuantity = 1;}// This will create 1 Major magic item.
            else if (nRandom > 25) {nTreasureClass = 2; nQuantity = d4();
                if (nQuantity < 1) {nQuantity = 1;}}//This script will generate 1 to 4 medium magic items
            break;
        case 20:
            nRandom = Random(100) + 1;
            if (nRandom > 90) {nTreasureClass = 4; nQuantity = 1; }// This will create 1 Epic magic item.
            else if (nRandom > 58) {nTreasureClass = 3; nQuantity = 1;}// This will create 1 Major magic item.
            else if (nRandom > 20) {nTreasureClass = 2; nQuantity = d3() + 1;}// This will create 2 - 5 Medium magic items.
            break;
        default:
            nRandom = Random(100) + 1;
            if (nRandom > 90) {nTreasureClass = 4; nQuantity = 1;}// This will create 1 Epic magic item.
            else if (nRandom > 58) {nTreasureClass = 3; nQuantity = 1;}// This will create 1 Major magic item.
            else if (nRandom > 20) {nTreasureClass = 2; nQuantity = d4() + 1;}// This will create 2 - 5 Medium magic items.
            break;
         }
         switch (nQuantity)
                   {
                    case 5: GeneratedTreasure.ItemFive = SyGenerateMagicItem (nTreasureClass);
                    case 4: GeneratedTreasure.ItemFour = SyGenerateMagicItem (nTreasureClass);
                    case 3: GeneratedTreasure.ItemThree = SyGenerateMagicItem (nTreasureClass);
                    case 2: GeneratedTreasure.ItemTwo = SyGenerateMagicItem (nTreasureClass);
                    case 1: GeneratedTreasure.ItemOne = SyGenerateMagicItem (nTreasureClass); break;
                   // case 0: CreateItemOnObject("arrow4",OBJECT_SELF,1);

                    }
        return GeneratedTreasure;
}
//////////////////////////////////////////////////////////////////////////////
 /////////////////DETERMINE TYPE OF TREASURE/////////////////////
 ///////////This will determine what kind of item is found//////
 //////////////////////////////////////////////////////////////////
 /////////By adjusting the values for ARCANE, etc you can alter the likelihood
 ////////of a particular item type occuring in a given treasure class.
 /////////The total of all variables should equal 100.

 ///////////////////////////////////////////////////////////////////////////////



string SyGenerateMagicItem (int nTClass)         //
{                                                               //
    string sNewItem;
    int ARCANE = 20; int DIVINE = 10; int AMMO = 8; int POTION = 20; int RING = 3; int WAND = 9;
    int WEAPON = 5; int ARMOR = 5; int AMULET = 2; int MISC = 1; int GARB = 7;
   switch (nTClass)
    {
        case 0: //Mundane item//
                ARCANE = 10; DIVINE = 5; AMMO = 10;  POTION = 10; RING = 0;  AMULET = 0;
                WAND = 10;    WEAPON = 15;  ARMOR = 20; MISC = 20;    GARB = 0;
                break;
        case 1: ///Minor items///
                ARCANE = 20; DIVINE = 10; AMMO = 10;  POTION = 20; RING = 5;  AMULET = 3;
                WAND = 9;    WEAPON = 7;  ARMOR = 7; MISC = 2;    GARB = 7;
                break;
        case 2: ///Medium items////
                ARCANE = 10; DIVINE = 5;  AMMO = 10;  POTION = 10; RING = 10; AMULET = 5;
                WAND = 15;   WEAPON = 10; ARMOR = 10; MISC = 2;    GARB = 13;
                break;
        case 3: ///Major items///
                ARCANE = 8;  DIVINE = 4;  AMMO = 8;    POTION = 5;  RING = 10;  AMULET = 6;
                WAND = 20;   WEAPON = 10; ARMOR = 10;  MISC = 4;    GARB = 15;
                break;
        case 4: ///Epic items/////
                ARCANE = 8;  DIVINE = 4;  AMMO = 5;    POTION = 5;  RING = 10;  AMULET = 6;
                WAND = 20;   WEAPON = 11; ARMOR = 11;  MISC = 5;    GARB = 15;
                break;
     };
    int nItemType = Random(100);
    struct Treasure Spells;
    if (nItemType < ARCANE)
       {sNewItem = "arcanescrollshee" ;} //Arcane Scroll
    else if (nItemType < ARCANE + DIVINE)
       { sNewItem = "divinescrollshee";}//Divine Scroll
    else if (nItemType < ARCANE + DIVINE + AMMO)
        {sNewItem = SyGenerateExhRange(nTClass);} //Ammo and Thrown Weapons
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION)
      { sNewItem = SyCreatePotion(nTClass); }               //Potion
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING)
        {sNewItem = SyCreateRing(nTClass);} //Ring
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET)
        {sNewItem = SyCreateAmulet(nTClass); }    //Amulet                        //Amulet
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC)
        {sNewItem = SyCreateMisc(nTClass); }   //Miscellaneous Items
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC + WAND)
        {sNewItem = SyCreateWand(nTClass); }                  // Rods, Staves and Wands
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC + WAND + GARB)
        {sNewItem = SyCreateGarb (nTClass); }  //Garb
    else if (nItemType < ARCANE + DIVINE + AMMO + POTION + RING + AMULET + MISC + WAND + GARB + WEAPON)
        {sNewItem = SyCreateWeapon (nTClass);}  //Weapon
    else {sNewItem = SyCreateArmor (nTClass);}    //Armor
    return sNewItem;

}
//void main () {}
