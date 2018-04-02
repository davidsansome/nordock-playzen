  //::///////////////////////////////////////////////
//:: SY_3E_TREASURE
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  This include file generates random items in any of the categories listed in the
  declarations.

*/
//:://////////////////////////////////////////////
//:: Created By:  Syrsuro
//:: Created On:  July 2002
//:://////////////////////////////////////////////
// * ---------
// * CONSTANTS
// * ---------


///////Declarations/////////////////////////////////////////////////////////////
//// /*  Any of these can be called by another script (that includes this     //
//        script if you wish to create a specific type of item.               //
//                                                                            //
//        oCreateOn is the object in whose inventory the items wll be created///
//        nTClass is the Treasure Class (Minor, Medium, Major or Epic)      *///
////////////////////////////////////////////////////////////////////////////////
void CreateArcaneScroll(object oCreateOn, int nTClass);      //Arcane Scroll//
void CreateDivineScroll(object oCreateOn, int nTClass);      //Divine Scroll//
void GenerateExhRange(object oCreateOn, int nTClass); //Ammo and Thrown Weapons
    void CreateAmmo (object oCreateOn, int nTClass);            //Ammunition//
    void CreateThrown (object oCreateOn, int nTClass);//Throwing Hammers, Darts and Shuriken//
    void CreatePotion(object oCreateOn, int nTClass);              //Potions//
void CreateRing (object oCreateOn,  int nTClass);                    //Rings//
void CreateAmulet (object oCreateOn, int nTClass);                 //Amulets//
void CreateMisc (object oCreateOn, int nTClass);       //Miscellaneous Items//
void CreateWand (object oCreateOn,int nTClass);     //Rods, Staves and Wands//
void CreateGarb (object oCreateOn, int nTClass);                      //Garb//
    void CreateBelt  (object oCreateOn, int nTClass);
    void CreateBoots (object oCreateOn, int nTClass);
    void CreateCloak (object oCreateOn, int nTClass);
    void CreateHands (object oCreateOn, int nTClass);
    void CreateHelm (object oCreateOn, int nTClass);
void CreateWeapon (object oCreateOn, int nTClass);                  //Weapon//
    void CreateBasicMeleeWeapon(object oCreateOn, int nTClass);   //+x Weapons//
    void CreateSpecialMeleeWeapon(object oCreateOn, int nTClass);//w/abilities//
    void CreateBasicRangeWeapon(object oCreateOn,  int nTClass);  //+x Weapons//
    void CreateSpecialRangeWeapon(object oCreateOn, int nTClass);//w/abilities//
void CreateArmor (object oCreateOn, int nTClass);                    //Armor//
    void CreateLightArmor(object oCreateOn, int nTClass);                   //
    void CreateMediumArmor(object oCreateOn, int nTClass);                  //
    void CreateHeavyArmor(object oCreateOn, int nTClass);                   //
    void CreateRobes(object oCreateOn, int nTClass);                        //
    void CreateShield(object oCreateOn, int nTClass);                       //
void CreateGold(object oCreateOn, int nCR, int nTModifier);             //Gold//
void CreateGem(object oCreateOn, int nCR);                              //Gems//
void CreateNMClothing (object oCreateOn);                 //Non-magic clothing//
void CreateNMArmor (object oCreateOn);                     //Non-magical armor//
void CreateNMWeapon (object oCreateOn);                  //Non-magical weapons//
void CreateNMAmmo (object oCreateOn);  //Non-magical ammo and throwing weapons//
void CreateJunk (object oCreateOn);          //Miscellaneous non-magical stuff//
void CreateBook (object oCreateOn);                          //BioWare's Books//
void GenerateKit(object oCreateOn, int nTClass);                              //
    void CreateTrapKit(object oCreateOn, int nCR);                     //Traps//
    void CreateHealingKit(object oCreateOn, int nCR);   //BioWare Healing Kits//
    void CreateLockPick(object oCreateOn, int nCR);        //BioWare Lockpicks//
//////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////
/////////ITEM GENERATION DEFINITIONS///////////
/////////////////////////////////////////////////
void CreateGold(object oCreateOn, int nCR, int nGoldPerc)
{                         //The values in this table approximate those of the DMG in Table 7-4.
                      // As such, they are very high and must be reduced.
    int nAmount = 0;      //They are divided by GoldDiv so as to give out between 1/50th (Poor) to 1/10th (Rich)
    if (nCR < 1) {nCR = 1;}//of the 'book' rates.
    switch (nCR)          //This multiplier can be used to set the relative gold awarded as desired.
    {                    //                   //Averages:   Base(100%); Poor (2%);  Standard (6%);  Rich (10%)
    case  1: nAmount = d6() * d10(); break;   // averages:      19;     1gp;        1gp             2gp
    case  2: nAmount = d8() * d10(); break;    // average:      25;     1gp;        2gp;            3gp
    case  3: nAmount = d8(2) * d10(); break;    // average:     50;     1gp;        3gp;            5gp
    case  4: nAmount = d10(4) * d10(); break;    // average:    121;    2gp;        7gp;            12gp;
    case  5: nAmount = d4() * d100(); break;    // average:     126;    3gp;        8gp;            13gp;
    case  6: nAmount = d6() * d100(); break;    // average:     177;    4gp;        11gp;           18gp;
    case  7: nAmount = d8() * d100(); break;    // average:     227;    5gp;        14gp;           23gp;
    case  8: nAmount = d10() * d100(); break;    // average:    278;    6gp;        17gp;           28gp;
    case  9: nAmount = d6(2) * d100(); break;   // average:     354;    7gp;        21gp;           35gp;
    case 10: nAmount = d8(2) * d100(); break;   // average:     455;    9gp;        27gp;           46gp;
    case 11: nAmount = d4(5) * d100(); break;   // average:     631;    13gp;       38gp;           63gp;
    case 12: nAmount = d4(6) * d100(); break;   // average:     758;    15gp;       45gp;           76gp;
    case 13: nAmount = d8(4) * d100(); break;  // average:      909;    18gp;       55gp;           91gp;
    case 14: nAmount = d4() * d100(8);  break;  // average:     1010;    20gp;       60gp;           101gp;
    case 15: nAmount = d4() * d100(10); break;  // average:    1263;    25gp;       76gp;           126gp;
    case 16: nAmount = d6() * d100(10); break;  // average:    1768;    35gp;       106gp;          177gp;
    case 17: nAmount = d8() * d100(10); break;  // average:    2273;    45gp;       136gp;          227gp;
    case 18: nAmount = d12() * d100(10); break;  // average:   3283;    66gp;       197gp;          328gp;
    case 19: nAmount = d4(3) * d100(10); break;  // average:   3788;    76gp;       227gp;          379gp;
    case 20: nAmount = d6(3) * d100(10); break;  // average:   5302;    106gp;      318gp;          530gp;
    default : nAmount = d8(3) * d100(10); break; // average:   6818;    136gp;      409gp;          682gp;
    }
    nAmount = nAmount * nGoldPerc / 100;
    if (nAmount <= 0)
        {
            nAmount = d4();
        }
    CreateItemOnObject("NW_IT_GOLD001", oCreateOn, nAmount);
}




///////////CREATE AN ARCANE SCROLL////////////////////////////////////
    int WhatLevel (int nTC)
    {
        int nLev = 0;
        switch (nTC)
        {
            case 1 : nLev = Random(4); break;
            case 2 : nLev = Random(3) + 3; break;
            case 3 : nLev = Random(3) + 5; break;
            case 4 : nLev = Random(3) + 7; break;
        }
    return nLev;
    }
    int nMaxs = 21;
///////////////////////////////////////////////////////////////////////////////////
    int WhatArcMax (int nLev)
    {
    int ArcMax = 4;
    switch (nLev)                                                                   //
        {                                                                            //
            case 0: ArcMax = 4; break;                                              //
            case 1: ArcMax = 13; break;                                             //
            case 2: ArcMax = 21; break;                                             //
            case 3: ArcMax = 15; break;                                             //
            case 4: ArcMax = 17; break;                                             //
            case 5: ArcMax = 13; break;                                             //
            case 6: ArcMax = 14; break;                                             //
            case 7: ArcMax = 8; break;                                              //
            case 8: ArcMax = 9; break;                                              //
            case 9: ArcMax = 12; break;
            default: ArcMax = 4;

        }
    return ArcMax;
    }

 //////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////
    int WhatDivMax (int nLev)//This determines how many spells there are of each level.
    {
    int DivMax = 4;
    switch (nLev)                                                           //
        {                                                                         //
            case 0: DivMax = 4; break;                                              //
            case 1: DivMax = 11; break;                                             //
            case 2: DivMax = 23; break;                                             //
            case 3: DivMax = 19; break;                                             //
            case 4: DivMax = 13; break;                                             //
            case 5: DivMax = 11; break;                                             //
            case 6: DivMax = 9; break;                                             //
            case 7: DivMax = 8; break;                                              //
            case 8: DivMax = 10; break;                                              //
            case 9: DivMax = 7; break;
            default: DivMax = 4;

        }
    return DivMax;
    }

 //////////////////////////
void CreateArcaneScroll(object oCreateOn, int nTClass)     //
    {                                                               //
        int x = 0;
        int nSpells = 1;                                    //
        int nLevel = 1;                         // What level is each spell
        int nMax = 21;
        int nScroll = 1;                        // Which spell from the list
        string sRes = "nw_it_sparscr216";
        switch (nTClass)
            {
            case 1 : nSpells = d3();break;      //How many spell scrolls to create?
            case 2 : nSpells = d4(); break;
            case 3 : nSpells = d6(); break;
            case 4 : nSpells = d6(); break;
            }                                                           //
        for (x = 0; x < nSpells; x++)
            {
                nLevel = WhatLevel(nTClass);    //Based on the TClass, a spell level range is returned
                nMax = WhatArcMax(nLevel);      //Given the level, how many spells are there to choose from?
                nScroll = Random(nMax) + 1;     //Picking randomly from all the spells at that level//
                if (nScroll < 10)                                                         //
                {                                                                         //
                    sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + "0" + IntToString(nScroll);//
                }                                                                         //
                else                                                                      //
                {                                                                         //
                    sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + IntToString(nScroll);  //
                }                                                                         //
                CreateItemOnObject(sRes, oCreateOn, 1);
            }
        }
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
void CreateDivineScroll(object oCreateOn, int nTClass)     //
    {                                                               //
        int x = 0;
        int nSpells = 1;                        // How many spells to creates               //
        int nLevel = 1;                         // What level is each spell
        int nMax = 21;                          // How many spells are there of each level
        int nScroll = 1;                        // Which spell from the list
        string sRes = "NW_IT_SPDVSCR401";

        //
        switch (nTClass)
            {
            case 1 : nSpells = d3();break;      //How many scrolls to create?
            case 2 : nSpells = d4(); break;     //How many scrolls to create?
            case 3 : nSpells = d6(); break;     //How many scrolls to create?
            case 4 : nSpells = d6(); break;     //How many scrolls to create?
            }                                                           //
        for (x = 0; x < nSpells; x++)
            {
                nLevel = WhatLevel(nTClass);
                nMax = WhatDivMax(nLevel);
                nScroll = Random(nMax) + 1;                                               //
                if (nScroll < 10)                                                         //
                {                                                                         //
                    sRes = "SY_IT_SPDVSCR" + IntToString(nLevel) + "0" + IntToString(nScroll);//
                }                                                                         //
                else                                                                      //
                {                                                                         //
                sRes = "SY_IT_SPDVSCR" + IntToString(nLevel) + IntToString(nScroll);  //
                }                                                                         //
                CreateItemOnObject(sRes, oCreateOn, 1);
            }
        }
    //
    ////////////////////////////////////////////////////////////////////////////////

//////////////////////CREATE AMMO or THROWN WEAPON/////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
void GenerateExhRange (object oCreateOn, int nTClass)
{                                                       //Determines whether an ammo
    int nRandom = d2();                                 //(arrow, bolt or bullet) or a
    switch (nRandom)                                    //thrown item (handaxe, dart or
    {                                                   //shuriken) is found.
        case 1: CreateAmmo (oCreateOn, nTClass); break;
        case 2: CreateThrown (oCreateOn, nTClass); break;
    }
}
////////////////////////////////////////////////////////////////////////////////////////
///////////This will create magical exhaustible weapons (thrown or ammo)////////
    void CreateAmmo(object oCreateOn, int nTClass)
    {
        string sAmmo = ""; int nRandom = 1;
        switch (nTClass)
        {
            case 1:
                nRandom = Random(16);
                switch (nRandom)
                {
                    case  1 : sAmmo = "arrow1"; break;              // Arrow +1
                    case  2 : sAmmo = "arrow2"; break;              // Arrow +2
                    case  3 : sAmmo = "arrowanimalbane"; break;     //  Arrow of AnimalBane
                    case  4 : sAmmo = "arrowdragonbane"; break;     //   Arrow of DragonBane
                    case  5 : sAmmo = "arroworcbane"; break;        //   Arrow of OrcBane
                    case  6 : sAmmo = "NW_WAMMAR001"; break;        // Arrow ofthe Vampire
                    case  7 : sAmmo = "arrowofeternalre"; break;    //    Arrow of Eternal Rest
                    case  8 : sAmmo = "bolt1"; break;               //  Bolt +1
                    case  9 : sAmmo = "bolt2"; break;               //  Bolt +2
                    case 10 : sAmmo = "NW_WAMMBO001"; break;        //   Bolt of Frostbite
                    case 11 : sAmmo = "NW_WAMMBO002"; break;        // Bolt of Lightning
                    case 12 : sAmmo = "bullet1"; break;             //  Bullet +1
                    case 13 : sAmmo = "bullet2"; break;             //  Bullet +2
                    case 14 : sAmmo = "NW_WAMMBO003"; break;        //  Paralytic Bolt
                    case 15 : sAmmo = "raidarrow"; break;           //  RaidArrow
                    case 16 : sAmmo = "arrowofthebeasts"; break;    // Arrow of the Beastslayer;
                }
                break;
            case 2:
                nRandom = Random(19);
                switch (nRandom)
                {
                    case  1 : sAmmo = "NW_WAMMAR003"; break;        // Acid Arrow
                    case  2 : sAmmo = "NW_WAMMBO005"; break;        //  Bolt of Fire
                    case  3 : sAmmo = "NW_WAMMBO004"; break;        // Bolt of Piercing
                    case  4 : sAmmo = "NW_WAMMBU004"; break;        //  Bullets of Smiting
                    case  5 : sAmmo = "NW_WAMMAR002"; break;        //  Fire Arrow
                    case  6 : sAmmo = "NW_WAMMBU005"; break;        // Fire Bullet
                    case  7 : sAmmo = "NW_WAMMAR005"; break;        //   Ice Arrow
                    case  8 : sAmmo = "NW_WAMMBU006"; break;        //  Ice Bullet
                    case  9 : sAmmo = "NW_WAMMAR006"; break;        //  Lightning Arrow
                    case 10 : sAmmo = "NW_WAMMBU007"; break;        // Lightning Bullet
                    case 11 : sAmmo = "NW_WAMMAR004"; break;        //  Piercing Arrow/
                    case 12 : sAmmo = "arrow3"; break;              //  Arrow +3
                    case 13 : sAmmo = "bolt3"; break;               //  Bolt + 3
                    case 14 : sAmmo = "bullet3"; break;             // Bullet +3
                    case 15 : sAmmo = "NW_WAMMBU002"; break;        //  Bullet of Screaming
                    case 16 : sAmmo = "NW_WAMMBU003"; break;        //   Farel's Gold
                    case 17 : sAmmo = "NW_WAMMBU001"; break;        // Giant's Bane
                    case 18 : sAmmo = "NW_WAMMAR007"; break;        //   Mild Poison Arrow
                    case 19 : sAmmo = "NW_WAMMBO006"; break;        //  Mild Poison Bolt
                }
                break;
            case 3:  case 4:
                nRandom= Random(8);
                switch (nRandom)
                {
                    case  1 : sAmmo = "arrow4"; break;              //  Arrow +4
                    case  2 : sAmmo = "bolt4"; break;               //  Bolt +4
                    case  3 : sAmmo = "bullet4"; break;             //  Bullet +4
                    case  4 : sAmmo = "arrow5"; break;              // Arrow +5
                    case  5 : sAmmo = "bolt5"; break;               // Bolt +5
                    case  6 : sAmmo = "bullet5"; break;             //  Bullet +5
                    case  7 : sAmmo = "NW_WAMMAR008"; break;        //   Poison Arrow
                    case  8 : sAmmo = "NW_WAMMBO007"; break;        // Poison Bolt
                }
                break;
        }
        CreateItemOnObject (sAmmo, oCreateOn, d10(3));    //Creates 3 - 30 arrows.
}

    void CreateThrown (object oCreateOn, int nTClass)
    {
        string sAmmo = ""; int nRandom = 1;
        switch (nTClass)
        {
            case 1:
                nRandom = Random(3);
                switch (nRandom)
                {
                    case 1 : sAmmo = "NW_WTHMDT002"; break;   // Dart +1
                    case 2 : sAmmo = "NW_WTHMSH002"; break;   // Shuriken +1
                    case 3 : sAmmo = "NW_WTHMAX002"; break;   //  Throwing Axe +
                }
                break;
            case 2:
                nRandom = Random(17);
                switch (nRandom)
                {
                    case  1 : sAmmo = "NW_WTHMSH006"; break;   //  Many Talons
                    case  2 : sAmmo = "NW_WTHMDT006"; break;   // Acid Dart
                    case  3 : sAmmo = "NW_WTHMAX005"; break;   //Black Raven Axe
                    case  4 : sAmmo = "NW_WTHMDT008"; break;   // Dart +2
                    case  5 : sAmmo = "NW_WTHMDT003"; break;   // Dart of Stunning
                    case  6 : sAmmo = "NW_WTHMAX007"; break;   //   Fire Axe
                    case  7 : sAmmo = "NW_WTHMSH007"; break;   //   Grains of Sand
                    case  8 : sAmmo = "NW_WTHMDT005"; break;   //  Ice Dart
                    case  9 : sAmmo = "NW_WTHMSH008"; break;   //  Shuriken +2
                    case 10 : sAmmo = "NW_WTHMSH003"; break;   //  Stars of Ojy-do
                    case 11 : sAmmo = "NW_WTHMAX008"; break;   //  Throwing Axe +2
                    case 12 : sAmmo = "NW_WTHMSH005"; break;   //  Shining Light
                    case 13 : sAmmo = "NW_WTHMDT004"; break;   //  Asp's Nest
                    case 14 : sAmmo = "NW_WTHMDT009"; break;   //  Dart +3
                    case 15 : sAmmo = "NW_WTHMSH004"; break;   //  Dragon's Tail
                    case 16 : sAmmo = "NW_WTHMSH009"; break;   // Shuriken +3
                    case 17 : sAmmo = "NW_WTHMAX009"; break;   //  Throwing Axe +3
                }
                break;
            case 3: case 4:
                nRandom= Random(10);
                switch (nRandom)
                {
                    case  1 : sAmmo = "NW_WTHMAX004"; break;    // Axe of the Coming Storm
                    case  2 : sAmmo = "dart4"; break;           //  Dart +4
                    case  3 : sAmmo = "NW_WTHMAX006"; break;    //  Rifthome Axe
                    case  4 : sAmmo = "shuriken4"; break;       //  Shuriken +4
                    case  5 : sAmmo = "throwingaxe4"; break;    //  Throwing Axe +4
                    case  6 : sAmmo = "NW_WTHMAX003"; break;    // Thunderbeast Axe
                    case  7 : sAmmo = "dart5"; break;           //  Dart +5
                    case  8 : sAmmo = "NW_WTHMDT007"; break;    //  Dart of Accuracy
                    case  9 : sAmmo = "shuriken5"; break;       //  Shuriken +5
                    case 10 : sAmmo = "throwingaxe5"; break;    //  Throwing Axe +5
                }
                break;
        }
        CreateItemOnObject (sAmmo, oCreateOn, d10(3));    //Create 3 - 30 thown items.   //
    }                                                                                  //
/////////////////////////////////////////////////////////////////////////////////////////

/////////////////CREATE A POTION////////////////////////////////
//////This table contains many custom items.  If you wish to eliminate these
///and go with the BioWare default potions, this can be done simply be altering
//the switch value since the custom potions are always in the higher numbered cases.
///////////////////////////////////////////////////////////////////////////////////
    void CreatePotion(object oCreateOn, int nTClass)
    {
        int nRandom = 1;
        string sPotion = "";
        switch (nTClass)
        {
            case 1 :
                nRandom = Random(9) + 1;
                switch (nRandom)
                {
                    case  1: case 2: sPotion = "nw_it_mpotion009";  break;      //Bless Potion
                    case  3: case 4: sPotion = "nw_it_mpotion001";  break;      //Cure LW Potion
                    case  5: sPotion = "nw_it_mpotion016";  break;      //Aid Potion
                    case  6: sPotion = "sy_potion001"    ;  break;      //Endure Elements
                    case  7: sPotion = "sy_potion002"    ;  break;      //Mage Armor
                    case  8: sPotion = "sy_potion003"    ;  break;      //Remove Fear
                    case  9: sPotion = "sy_potion004"    ;  break;      //Resistance
                }
                break;
            case 2 :
                nRandom = Random(28) + 1;
                switch (nRandom)
                {
                    case  1: case  2: sPotion = "nw_it_mpotion005";  break;      //Barkskin Potion
                    case  3: case  4: sPotion = "nw_it_mpotion015";  break;      //Bull's Strength
                    case  5: case  6: sPotion = "nw_it_mpotion014";  break;      //Cat's Grace
                    case  7: case  8: sPotion = "nw_it_mpotion007";  break;      //Clarity
                    case  9: case 10: sPotion = "nw_it_mpotion017";  break;      //Fox's Cunning
                    case 11: case 12: sPotion = "nw_it_mpotion010";  break;      //Eagle's Splendor
                    case 13: case 14: sPotion = "nw_it_mpotion013";  break;      //Endurance
                    case 15: case 16: sPotion = "nw_it_mpotion020";  break;      //Cure Mod. Wounds
                    case 17: case 18: sPotion = "nw_it_mpotion018";  break;      //Owl's Wisdom                                           //SY Potion
                    case 19: case 20: sPotion = "nw_it_mpotion019";  break;      //Lore (Identify)
                    case 21: case 22: sPotion = "nw_it_mpotion008";  break;      //Invisibility
                    case 23: case 24: sPotion = "nw_it_mpotion011";  break;      //Lesser Restoration
                    case 25: sPotion = "sy_potion005"    ;  break;      //Ghostly Visage
                    case 26: sPotion = "sy_potion006"    ;  break;      //Resist Elements
                    case 27: sPotion = "sy_potion007"    ;  break;      //See Invisibility
                    case 28: sPotion = "sy_potion008"    ;  break;      //Ultravision
                }
                break;
            case 3 :
                nRandom = Random(23) + 1;
                switch (nRandom)
                {
                    case  1: case  2: sPotion = "nw_it_mpotion006";  break;      //Neutralize Poison
                    case  3: case  4: sPotion = "nw_it_mpotion002";  break;      //Cure Serious
                    case  5: case  6: sPotion = "nw_it_mpotion004";  break;      //Haste
                    case  7: case  8: sPotion = "nw_it_mpotion003";  break;      //Cure Critical Wounds
                    case  9: sPotion = "sy_potion009"    ;  break;      //Clairaudience/ Voyance
                    case 10: sPotion = "sy_potion010"    ;  break;      //Belladona extract
                    case 11: sPotion = "sy_potion011"    ;  break;      //Garlic extract
                    case 12: sPotion = "sy_potion012"    ;  break;      //Negative Energy Protection
                    case 13: sPotion = "sy_potion013"    ;  break;      //Polymorph Self
                    case 14: sPotion = "sy_potion014"    ;  break;      //Protection from Elements
                    case 15: sPotion = "sy_potion015"    ;  break;      //Remove Blindness/Deafness
                    case 16: sPotion = "sy_potion016"    ;  break;      //Remove Curse
                    case 17: sPotion = "sy_potion017"    ;  break;      //Remvoe Disease
                    case 18: sPotion = "sy_potion018"    ;  break;      //Rogue;s Cunning
                    case 19: sPotion = "sy_potion019"    ;  break;      //Death Ward
                    case 20: sPotion = "sy_potion020"    ;  break;      //Divine Power
                    case 21: sPotion = "sy_potion021"    ;  break;      //Freedom of Movement
                    case 22: sPotion = "sy_potion022"    ;  break;      //Restoration
                    case 23: sPotion = "sy_potion023"    ;  break;      //Stoneskin
                }
                break;
            case 4 :
                nRandom = Random(15)+ 1;
                switch (nRandom)
                {
                case  1: case 2: sPotion = "nw_it_mpotion012";  break;      //Heal Potion
                case  3: sPotion = "sy_potion024"    ;  break;      //Elemental Shield
                case  4: sPotion = "sy_potion025"    ;  break;      //Ethereal Visage
                case  5: sPotion = "sy_potion026"    ;  break;      //Lesser Mind Blank
                case  6: sPotion = "sy_potion027"    ;  break;      //Spell Resistance
                case  7: sPotion = "sy_potion028"    ;  break;      //Greater Bull's Strength
                case  8: sPotion = "sy_potion029"    ;  break;      //Greater Cat's Grace
                case  9: sPotion = "sy_potion030"    ;  break;      //Greater Eagle's Splendor
                case 10: sPotion = "sy_potion031"    ;  break;      //Greater Endurance
                case 11: sPotion = "sy_potion032"    ;  break;      //Greater Fox's Cunning
                case 12: sPotion = "sy_potion033"    ;  break;      //Greater Owl's Wisdom
                case 13: sPotion = "sy_potion034"    ;  break;      //Greater Stoneskin
                case 14: sPotion = "sy_potion035"    ;  break;      //Tensor's Transformation
                case 15: sPotion = "sy_potion036"    ;  break;      //True Seeing
                }
                break;
         }
         CreateItemOnObject(sPotion, oCreateOn, 1);
    }
/////////////////////////////////////////////////////////////////////////////////


/////////////////CREATE A RING///////////////////////////////////////////////
    void CreateRing(object oCreateOn, int nTClass)
    {
        int nRandom = 1;
        string sRing = "";
        switch (nTClass)
        {
            case 1 :
                nRandom = Random(15) + 1;
                switch (nRandom)
                {
                    case 1:  sRing = "it_mring011";  break;         // Ring of Crimson (improved)
                    case 2:  sRing = "ringofcrystal";  break;       // Ring of Crystal+
                    case 3:  sRing = "it_mring010";  break;         // Ring of Cyan (improved)
                    case 4:  sRing = "nw_it_mring024";  break;      // Ring of Fortitude +1
                    case 5:  sRing = "nw_it_mring012";  break;      // Ring of Insight
                    case 6:  sRing = "it_mring012";  break;         // Ring of Jade (improved)
                    case 7:  sRing = "nw_it_mring001";  break;      // Ring of Protection +1
                    case 8:  sRing = "nw_it_mring013";  break;      // Ring of Scholars
                    case 9:  sRing = "ringofanimalfrie";  break;    // Ring of Animal Friendship
                    case 10: sRing = "nw_it_mring006";  break;      // Ring of Clear Thought +1
                    case 11: sRing = "ringofdivinity";  break;      // Ring of Divinity
                    case 12: sRing = "nw_it_mring025";  break;      // Ring of Fortitude +2
                    case 13: sRing = "ringofminoreleme";  break;    // Ring of Minor Elemental Resistance
                    case 14: sRing = "ringofsorceryi";  break;      // Ring of Sorcery I
                    case 15: sRing = "ringofwizardry1";  break;     // Ring of Wizardry I
                }
                break;
            case 2 :
                nRandom = Random(24) + 1;
                switch (nRandom)
                {
                    case  1: sRing = "lesserringoftheg";  break;    // Lesser Ring of the Ghost
                    case  2: sRing = "ringofmindshield";  break;    // Ring of Mindshielding
                    case  3: sRing = "nw_it_mring031";  break;      // Ring of Resistance +1
                    case  4: sRing = "leastringofregen";  break;    // Least Ring of Regeneration
                    case  5: sRing = "ringofdivinit001";  break;    // Ring of Divinity II
                    case  6: sRing = "ringofforceshiel";  break;    // Ring of Force Shield
                    case  7: sRing = "nw_it_mring026";  break;      // Ring of Fortitude +3
                    case  8: sRing = "nw_it_mring008";  break;      // Ring of Protection +2
                    case  9: sRing = "ringofsorceryii";  break;     // Ring of Sorcery II
                    case 10: sRing = "ringofchameleon";  break;     // Ring of the Chameleon
                    case 11: sRing = "ringofwizardryii";  break;    // Ring of Wizardry II
                    case 12: sRing = "nw_it_mring003";  break;      // Ring of Invisibility
                    case 13: sRing = "ringoftheram";  break;        // Ring of the Ram
                    case 14: sRing = "nw_it_mring014";  break;      // Ring of Clear Thought +2
                    case 15: sRing = "ringofdivinityii";  break;    // Ring of Divinity III
                    case 16: sRing = "nw_it_mring027";  break;      // Ring of Fortitude +4
                    case 17: sRing = "nw_it_mring018";  break;      // Ring of Protection +3
                    case 18: sRing = "ringofsorceryiii";  break;    // Ring of Sorcery III
                    case 19: sRing = "ringofwizardr001";  break;    // Ring of Wizardry III
                    case 20: sRing = "nw_it_mring029";  break;      // Lesser Ring of Power
                    case 21: sRing = "nw_it_mring002";  break;      // Ring of Elemental Resistance
                    case 22: sRing = "ringofevasion";  break;       // Ring of Evasion
                    case 23: sRing = "nw_it_mring032";  break;      // Ring of Resistance +2
                    case 24: sRing = "NW_IT_NOVEL001";  break;      // Ring of the Wood Elves
                }
                break;
            case 3 :
                nRandom = Random(14) + 1;
                switch (nRandom)
                {
                    case  1: sRing = "nw_it_mring028";  break;      // Ring of Fortitude +5
                    case  2: sRing = "nw_it_mring007";  break;      // Ring of Holiness
                    case  3: sRing = "nw_it_mring005";  break;      // Ring of Magic Defenses
                    case  4: sRing = "lesserringofrege";  break;    // Lesser Ring of Regeneration
                    case  5: sRing = "nw_it_mring015";  break;      // Ring of Clear Thought +3
                    case  6: sRing = "nw_it_mring019";  break;      // Ring of Protection +4
                    case  7: sRing = "lesserringoft001";  break;    // Ring of the Ghost
                    case  8: sRing = "ringofxrayvision";  break;    // Ring of Clear Sight
                    case  9: sRing = "ringoffreedom";  break;       // Ring of Freedom of Movement
                    case 10: sRing = "nw_it_mring020";  break;      // Ring of Protection +5
                    case 11: sRing = "nw_it_mring033";  break;      // Ring of Resistance +3
                    case 12: sRing = "nw_it_mring016";  break;      // Ring of Clear Thought +4
                    case 13: sRing = "nw_it_mring017";  break;      // Ring of Clear Thought +5
                    case 14: sRing = "ringofthegreater";  break;    // Ring of the Greater Ghost
                }
                break;
            case 4 :
                nRandom = Random(5) + 1;
                switch (nRandom)
                {
                    case 1: sRing = "ringofgreaterdiv";  break;     // Ring of Greater Divinity
                    case 2: sRing = "ringofgreatersor";  break;     // Ring of Greater Sorcery
                    case 3: sRing = "ringofgreaterwiz";  break;     // RIng of Greater Wizardry
                    case 4: sRing = "nw_it_mring030";  break;       // Ring of Power
                    case 5: sRing = "nw_it_mring004";  break;       // Ring of Regeneration
                }
                break;
        }                                                                                 //
        CreateItemOnObject(sRing, oCreateOn, 1);                                            //
}                                                                                         //
////////////////////////////////////////////////////////////////////////////////////////////////
 /////////////////////////CREATE AN AMULET/////////////////////
    void CreateAmulet(object oCreateOn, int nTClass)
    {                                                       //
        int nRandom = Random(10) + 1;                       //
        string sAmulet = "";                                //
        switch (nTClass)
        {
            case 1 :
                nRandom = Random(10) +  1;                  //
                switch (nRandom)                                //
                {                                               //////
                    case 1: sAmulet = "nw_it_mneck032"; break;          //Acid Resist
                    case 2: sAmulet = "nw_it_mneck030"; break;          //Cold Resist
                    case 3: sAmulet = "NW_IT_MNECK001"; break;          //Natural Armor +1
                    case 4: sAmulet = "nw_it_mneck024"; break;          //Will +1
                    case 5: sAmulet = "NW_IT_MNECK023"; break;          //Glittering
                    case 6: sAmulet = "necklaceofprayer"; break;        //Prayer Beads I
                    case 7: sAmulet = "nw_it_mneck031"; break;          //Electric Resist
                    case 8: sAmulet = "nw_it_mneck029"; break;          //Fire Resist
                    case 9: sAmulet = "periaptofhealth"; break;         //Periapt of Health
                    case 10: sAmulet = "NW_IT_MNECK007"; break;         //Wisdom +1
                }
                break;                                                       //
            case 2 :
                nRandom = Random(14) + 1;
                switch (nRandom)
                {
                    case 1: sAmulet = "NW_IT_MNECK006"; break;         //Protection +1
                    case 2: sAmulet = "nw_it_mneck025"; break;         //WIll +2
                    case 3: sAmulet = "necklaceofpra003"; break;         //Prayer Beads II
                    case 4: sAmulet = "NW_IT_MNECK012"; break;         //Natural Armor +2
                    case 5: sAmulet = "nw_it_mneck026"; break;         //Will +3
                    case 6: sAmulet = "NW_IT_MNECK035"; break;         //Lesser Health
                    case 7: sAmulet = "necklaceoffireba"; break;         //Fireballs I
                    case 8: sAmulet = "periaptofproofag"; break;         //Periapt Proof vs Poison
                    case 9: sAmulet = "nw_it_mneck027"; break;         //Will +4
                    case 10: sAmulet = "NW_IT_MNECK033"; break;         //Lesser Master
                    case 11: sAmulet = "NW_IT_MNECK008"; break;         //Wisdom +2
                    case 12: sAmulet = "NW_IT_MNECK016"; break;         //Protection +2
                    case 13: sAmulet = "NW_IT_MNECK013"; break;         //Natural Armor +3
                    case 14: sAmulet = "necklaceoffir001"; break;         //Fireballs II
                 }
                break;                                               //
            case 3 :
                nRandom = Random(16) + 1;
                switch (nRandom)
                {
                    case 1:  sAmulet = "nw_it_mneck028"; break;         //Will +5
                    case 2:  sAmulet = "necklaceofpra001"; break;         //Prayer Beads III
                    case 3:  sAmulet = "NW_IT_MNECK036"; break;         //Health
                    case 4:  sAmulet = "NW_IT_MNECK014"; break;         //Natural Armor +4
                    case 5:  sAmulet = "NW_IT_MNECK003"; break;         //Prayer Beads
                    case 6:  sAmulet = "necklaceofpra002"; break;         //Prayer Beads IV
                    case 7:  sAmulet = "NW_IT_MNECK009"; break;         //Wisdom +3
                    case 8:  sAmulet = "scarabofprotecti"; break;         //Scarab of Protection
                    case 9:  sAmulet = "NW_IT_MNECK017"; break;         //Protection +3
                    case 10: sAmulet = "NW_IT_MNECK015"; break;         //Natural Armor +4
                    case 11: sAmulet = "NW_IT_MNECK005"; break;         //Power
                    case 12: sAmulet = "NW_IT_MNECK010"; break;         //Wisdom +4
                    case 13: sAmulet = "NW_IT_MNECK018"; break;         //Protection +4
                    case 14: sAmulet = "NW_IT_MNECK037"; break;         //Greater Health
                    case 15: sAmulet = "NW_IT_MNECK011"; break;         //Wisdom +5
                    case 16: sAmulet = "NW_IT_MNECK019"; break;         //Protection +5
                }
                break;
            case 4 :
                nRandom = Random(3) + 1;
                switch (nRandom)
                {
                    case 1: sAmulet = "NW_IT_MNECK034"; break;         //Master
                    case 2: sAmulet = "NW_IT_MNECK002"; break;         //Pure Evil
                    case 3: sAmulet = "NW_IT_MNECK004"; break;         //Pure Good
                }
                break;
        }
        CreateItemOnObject(sAmulet, oCreateOn, 1);
    }                                                           //
                                                            //
//////////////////////////////////////////////////////////////// ///

/////////////////CREATE A MISCELLANEOUS ITEM////////////////////////////
////////////////////////////////////////////////////////////////////////
void CreateMisc (object oCreateOn, int nTClass)
{
    string sMisc = "";int nRandom = 1;
    switch (nTClass)
    {
    case 1:
        nRandom = Random(3);
        switch (nRandom)
        {
            case  1 : sMisc =  "NW_IT_CONTAIN002"; break;       // Magic Bag (20%)
            case  2 : sMisc =  "NW_IT_CONTAIN003"; break;       // Magic Bag (40%)
            case  3 : sMisc =  "NW_IT_CONTAIN004"; break;       //  Magic Bag (60%)
        }
        break;
    case 2:
        nRandom = Random(7);
        switch (nRandom)
        {
            case  1 : sMisc =  "NW_IT_MMIDMISC02"; break;       //  Harp of Haunting
            case  2 : sMisc =  "NW_IT_MMIDMISC03"; break;       //  Harp of Pandemonium
            case  3 : sMisc =  "hornofgoodnessev"; break;       //  Horn of Goodness/Evil
            case  4 : sMisc =  "NW_IT_CONTAIN006"; break;       //  Bag of Holding
            case  5 : sMisc =  "NW_IT_CONTAIN005"; break;       // Magic Bag (80)
            case  6 : sMisc =  "pipesofhaunting"; break;        //  Pipes of Haunting
            case  7 : sMisc =  "NW_IT_MMIDMISC04"; break;       // Scabbard of Blessing
        }
    break;
    case 3: case 4:
        nRandom= Random(10);
        switch (nRandom)
        {
            case  1 : sMisc =  "pipesofhaunting"; break;   //  Pipes of Haunting
            case  2 : sMisc =  "NW_IT_MMIDMISC04"; break;   // Scabbard of Blessing
            case  3 : sMisc =  "hornofgoodnessev"; break;   //  Horn of Goodness/Evil
            case  4 : sMisc =  "NW_IT_MMIDMISC03"; break;   //  Harp of Pandemonium
            case  5 : sMisc =  "NW_IT_MMIDMISC02"; break;   //  Harp of Haunting
            case  6 : sMisc =  "pipesofthecellar"; break;   // Pipes of the Cellar
            case  7 : sMisc =  "NW_IT_MSMLMISC05"; break;   //  Saintsblood Pearl
            case  8 : sMisc =  "lanternofreveali"; break;   //  Lantern of Revealing
            case  9 : sMisc =  "NW_IT_MMIDMISC01"; break;   //  Harp of Charming
            case 10 : sMisc =  "NW_IT_NOVEL002"; break;   //   Instrument of the Windsh
        }
        break;
    }
    CreateItemOnObject (sMisc, oCreateOn, 1);
}
///////////////////////////////////////////////////////////////////////////

/////////////////CREATE A ROD, STAFF or WAND ITEM////////////////////////////
////////////////////////////////////////////////////////////////////////
void CreateWand (object oCreateOn, int nTClass)
{
    int nRandom = 1;
    string sWand = "";
    switch (nTClass)
    {
        case 1:
            nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1 :  sWand = "nw_wmgmrd006"; break;   // Rod of Frost
                case 2 :  sWand = "wandofcharmperso"; break;   //  Wand of Charm Person
                case 3 :  sWand = "wandofcuringi"; break;   // Wand of Curing I
                case 4 :  sWand = "NW_WMGWN013"; break;   // Wand of Lesser Summoning
                case 5 :  sWand = "wandoflight"; break;   // Wand of Light
                case 6 :  sWand = "NW_WMGWN004"; break;   // Wand of Missiles
                case 7 :  sWand = "NW_WMGWN006"; break;   // Wand of Negative Energy
            }
            break;
        case 2:
            nRandom = Random(16) + 1;
            switch (nRandom)
            {
                case  1 : sWand = "wandofcuringii"; break;   //  Wand of Curing II
                case  2 : sWand = "wandofmissilesii"; break;   // Wand of Missiles II
                case  3 : sWand = "wandofburninghan"; break;   // Wand of Burning Hands
                case  4 : sWand = "wandofcolorspray"; break;   //  Wand of Color Spray
                case  5 : sWand = "wandofcuringiii"; break;   //  Wand of Curing III
                case  6 : sWand = "wandofenfeebleme"; break;   // Wand of Enfeeblement
                case  7 : sWand = "nw_wmgwn012"; break;   // Wand of Sleep
                case  8 : sWand = "NW_WMGRD002"; break;   // Rod of the Ghost
                case  9 : sWand = "wandofdarkness"; break;   // Wand of Darkness
                case 10 : sWand = "wandofholdperson"; break;   // Wand of Hold Person
                case 11 : sWand = "wandofinvisibili"; break;   // Wand of Invisibility
                case 12 : sWand = "wandofknock"; break;   // Wand of Knock
                case 13 : sWand = "wandofmelfs"; break;   // Wand of Melf's
                case 14 : sWand = "wandofmissile001"; break;   // Wand of Missiles III
                case 15 : sWand = "wandofsilence"; break;   // Wand of Silence
                case 16 : sWand = "wandofweb"; break;   // Wand of Web
             }
            break;
        case 3:
            nRandom = Random(20) + 1;
            switch (nRandom)
            {
                case  1 : sWand = "NW_WMGST006"; break;   // Staff of the Holy
                case  2 : sWand = "NW_WMGWN002"; break;   // Wand of Fire
                case  3 : sWand = "NW_WMGWN007"; break;   //  Wand of Lightning
                case  4 : sWand = "NW_WMGMRD003"; break;   // Rod of Terror
                case  5 : sWand = "NW_WMGST004"; break;   // Staff of Defense
                case  6 : sWand = "NW_WMGWN011"; break;   // Wand of Arcane Disjunction
                case  7 : sWand = "wandofcharmmonst"; break;   // Wand of Charm Monster
                case  8 : sWand = "wandofcontagion"; break;   // Wand of Contagion
                case  9 : sWand = "wandofcuringiv"; break;   //  Wand of Curing IV
                case 10 : sWand = "NW_WMGWN003"; break;   // Wand of Fear
                case 11 : sWand = "wandofneutralize"; break;   // Wand of Neutralize Poison
                case 12 : sWand = "wandofpoison"; break;   // Wand of Poison
                case 13 : sWand = "wandofsearinglig"; break;   //   Wand of Searing Light
                case 14 : sWand = "wandofslow"; break;   // Wand of Slow
                case 15 : sWand = "NW_WMGWN010"; break;   // Wand of Stinking Cloud
                case 16 : sWand = "NW_WMGST005"; break;   // Staff of Power
                case 17 : sWand = "NW_WMGWN005"; break;   // Wand of Paralyzation
                case 18 : sWand = "wandofpolymorphs"; break;   // Wand of Polymorph Self
                case 19 : sWand = "NW_WMGWN008"; break;   //  Wand of Summonin
                case 20 : sWand = "NW_WMGWN009"; break;   // Wand of the Heavens
            }
            break;
        case 4:
            nRandom = Random(10) + 1;
            switch (nRandom)
            {
                case  1 : sWand = "wandofholysmite"; break;   // Wand of Divine Wrath
                case  2 : sWand = "wandoffirewall"; break;   // Wand of Fire Wall
                case  3 : sWand = "wandofstoneskin"; break;   // Wand of Stoneskin
                case  4 : sWand = "NW_WMGMRD004"; break;   // Rod of Beguiling
                case  5 : sWand = "NW_WMGMRD005"; break;   // Rod of Reversal
                case  6 : sWand = "wandoficestorm"; break;   //  Wand of Ice Storm
                case  7 : sWand = "NW_WMGST002"; break;   //  Staff of Command
                case  8 : sWand = "NW_WMGMRD002"; break;   // Rod of Resurrection
                case  9 : sWand = "NW_IT_NOVEL008"; break;   // Staff of Valmaxian
                case 10 : sWand = "NW_WMGST003"; break;   // Staff of the Magi
            }                                     //
            break;                                                                       //
    }                                                                                    //
    CreateItemOnObject(sWand, oCreateOn, 1);                                               ///
 }                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////

/////////////////CREATE AN ITEM OF MAGICAL CLOTHING////////////////////////////
////////////////////////////////////////////////////////////////////////


void CreateBelt (object oCreateOn, int nTClass)
{
    string sGarb = "";
    int nRandom = 1;
    switch (nTClass)
    {
        case 1:
            nRandom = Random(4)+ 1;   // Minor Item only
            switch (nRandom)
            {
                case  1 : sGarb = "nw_it_mbelt011"; break;  //  Archer's Belt
                case  2 : sGarb = "nw_it_mbelt010"; break;  //  Brawler's Belt
                case  3 : sGarb = "nw_it_mbelt009"; break;  //  Swordsman's Belt
                case  4 : sGarb = "nw_it_mbelt015"; break;  //  Lesser Belt of Guiding Light
            }
            break;
        case 2:
            nRandom = Random(5) + 1;   //Medium Item
            switch (nRandom)
            {
                case  1 : sGarb = "NW_IT_MBELT005"; break;  //  Sash of Shimmering
                case  2 : sGarb = "NW_ITEM_000"; break;     //  Belt of Inertial Barrier
                case  3 : sGarb = "NW_IT_MBELT004"; break;  //  Encircling Scale
                case  4 : sGarb = "nw_it_mbelt016"; break;  //  Belt of Guiding Light
                case  5 : sGarb = "nw_it_mbelt002"; break;  //  Belt of Hill Giant Strength
            }
            break;
        case 3:
            nRandom = Random(7) + 1;   //Major Item
            switch (nRandom)
            {
                case 1 : sGarb = "nw_it_mbelt007"; break;  //  Belt of Frost Giant Strength
                case 2 : sGarb = "nw_it_mbelt018"; break;  //  Belt of Agility +1
                case 3 : sGarb = "NW_IT_MBELT001"; break;  //  Girdle of Holy Might
                case 4 : sGarb = "nw_it_mbelt008"; break;  //  Belt of Fire Giant Strength
                case 5 : sGarb = "nw_it_mbelt014"; break;  //  Greater Archer's Belt
                case 6 : sGarb = "nw_it_mbelt013"; break;  //  Greater Brawler's Belt
                case 7 : sGarb = "nw_it_mbelt012"; break;  //  Greater Swordsman's Belt
            }
            break;
        case 4:
            nRandom = Random(5) + 1;     //Epic Item
            switch (nRandom)
            {
                case 1 : sGarb = "nw_it_mbelt019"; break;  //  Belt of Agility +2
                case 2 : sGarb = "nw_it_mbelt017"; break;  //  Greater Belt of Guiding Light
                case 3 : sGarb = "nw_it_mbelt020"; break;  //  Belt of Agility +3
                case 4 : sGarb = "NW_IT_MBELT003"; break;  //  Ceremonial Uthgardt Belt
                case 5 : sGarb = "nw_it_mbelt021"; break;  //  Belt of Agility +4
            }                     //
            break;
    }
    CreateItemOnObject(sGarb, oCreateOn, 1);
}

void CreateBoots (object oCreateOn, int nTClass)
{
    string sGarb = ""; int nRandom = 1;
    switch (nTClass)
    {
        case 1:
            nRandom = Random(4) + 1;
            switch (nRandom)
            {
                case  1 : sGarb = "NW_IT_MBOOTS010"; break;   //  Boots of Reflexes +1
                case  2 : sGarb = "NW_IT_MBOOTS018"; break;   //  Boots of the Sun Soul +1 //
                case  3 : sGarb = "NW_IT_MBOOTS001"; break;   //  Boots of Striding +1  //
                case  4 : sGarb = "NW_IT_MBOOTS015"; break;   //  Boots of Hardiness +1
            }                     //
            break;
        case 2:
            nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1 : sGarb = "NW_IT_MBOOTS019"; break;   //  Boots of the Sun Soul +2
                case 2 : sGarb = "NW_IT_MBOOTS011"; break;   //  Boots of Reflexes +2
                case 3 : sGarb = "NW_IT_MBOOTS006"; break;   //  Boots of Striding +2
                case 4 : sGarb = "NW_IT_MBOOTS020"; break;   //  Boots of the Sun Soul +3
                case 5 : sGarb = "NW_IT_MBOOTS012"; break;   //  Boots of Reflexes +3
                case 6 : sGarb = "NW_IT_MBOOTS002"; break;   //  Boots of Elvenkind
                case 7 : sGarb = "bootsofspeed"; break; //  Boots of speed
            }                      //
            break;
        case 3:
            nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1 : sGarb = "NW_IT_MBOOTS013"; break;   //  Boots of Reflexes +4
                case 2 : sGarb = "NW_IT_MBOOTS007"; break;   //  Boots of Striding +3
                case 3 : sGarb = "NW_IT_MBOOTS007"; break;   //  Boots of Striding +3
                case 4 : sGarb = "NW_IT_MBOOTS008"; break;   //  Boots of Striding +4
                case 5 : sGarb = "NW_IT_MBOOTS016"; break;   //  Boots of Hardiness +2
                case 6 : sGarb = "NW_IT_MBOOTS003"; break;   //  Dragon Slippers
                case 7 : sGarb = "NW_IT_MBOOTS004"; break;   //  Gargoyle Boots
            }                      //
            break;
        case 4:
            nRandom = Random(5) + 1;
            switch (nRandom)
            {
                case 1 : sGarb = "NW_IT_MBOOTS017"; break;   //  Boots of Hardiness +3
                case 2 : sGarb = "NW_IT_MBOOTS021"; break;   //  Boots of the Sun Soul +4
                case 3 : sGarb = "NW_IT_MBOOTS014"; break;   //  Boots of Reflexes +5
                case 4 : sGarb = "NW_IT_MBOOTS009"; break;   //  Boots of Striding +5
                case 5 : sGarb = "NW_IT_MBOOTS022"; break;   //  Boots of the Sun Soul +5
            }                      //
            break;
    }
    CreateItemOnObject(sGarb, oCreateOn, 1);
}

void CreateCloak (object oCreateOn, int nTClass)
{
    string sGarb = ""; int nRandom = 1;
    switch (nTClass)
    {
        case 1:
            nRandom = Random(8) + 1;
            switch (nRandom)
            {
                case  1 : sGarb = "NW_MAARCL096"; break;     // Cloak of Proection vs Good
                case  2 : sGarb = "NW_MAARCL055"; break;     // Cloak of Protection +1
                case  3 : sGarb = "NW_MAARCL098"; break;     //  Cloak of Protection vs Chaos
                case  4 : sGarb = "NW_MAARCL097"; break;     // Cloak of Protection vs Evil
                case  5 : sGarb = "NW_MAARCL099"; break;     // Cloak of Protection vs Law
                case  6 : sGarb = "NW_MAARCL057"; break;     //Cloak of Elvenkind
                case  7 : sGarb = "NW_MAARCL031"; break;     // Nymph Cloak +1
                case  8 : sGarb = "NW_MAARCL104"; break;     //  Cloak of Fortification +1
            }                           //
            break;
        case 2:
            nRandom = Random(8) + 1;
            switch (nRandom)
            {
                case 1 : sGarb = "NW_MAARCL088"; break;     //  Cloak of Protection +2
                case 2 : sGarb = "NW_MAARCL030"; break;     //  Cloak of the High Forest
                case 3 : sGarb = "NW_maarcl102"; break;     // Greater Cloak of Protection vs Chaos
                case 4 : sGarb = "NW_maarcl101"; break;     //  Greater Cloak of Protection vs Evil
                case 5 : sGarb = "NW_maarcl100"; break;     // Greater Cloak of Protection vs Good
                case 6 : sGarb = "nw_maarcl103"; break;     // Greater Cloak of Protection vs Law
                case 7 : sGarb = "NW_MAARCL092"; break;     //  Nymph Cloak +2
                case 8 : sGarb = "NW_MAARCL089"; break;     // Cloak of Protection +3
            }                      //
            break;
        case 3:
            nRandom = Random(8) + 1;
            switch (nRandom)
                {
                    case 1 : sGarb = "NW_MAARCL090"; break;     // Cloak of Protection +4
                    case 2 : sGarb = "NW_MAARCL093"; break;     // Nymph Cloak +3
                    case 3 : sGarb = "vestofescape" ; break;  // Vest of Escape
                    case 4 : sGarb = "NW_MAARCL105"; break;     // Cloak of Fortification  +2
                    case 5 : sGarb = "NW_MAARCL056"; break;     // Cloak of Movement
                    case 6 : sGarb = "NW_MAARCL094"; break;      // Nymph Cloak +4
                    case 7 : sGarb = "druidsvestament"; break;  // Druid's Vestment
                    case 8 : sGarb = "vestmentsoffaith"; break;  //  Vestments of Faith
                }                           //
            break;
        case 4:
            nRandom = Random(4) + 1;
            switch (nRandom)
            {
                case 1 : sGarb = "NW_MAARCL091"; break;     // Cloak of Protection +5
                case 2 : sGarb = "NW_MAARCL106"; break;     // Cloak of Fortification +3
                case 3 : sGarb = "NW_MAARCL095"; break;     //  Nymph Cloak +5
                case 4 : sGarb = "mantleofspellres"; break;  //  Mantle of Spell Resistance
            }                      //
            break;
    }
    CreateItemOnObject(sGarb, oCreateOn, 1);
}

void CreateHands (object oCreateOn, int nTClass)
{
    string sGarb = ""; int nRandom = 1;
    switch (nTClass)
    {
        case 1:
            nRandom = Random(11) + 1;
            switch (nRandom)
            {
                case  1 : sGarb = "NW_IT_MBRACER002"; break;      //  Bracers of Armor +1
                case  2 : sGarb = "nw_it_mglove006"; break;       //  Gloves of Animal Handling
                case  3 : sGarb = "nw_it_mglove004"; break;       //  Gloves of Concentration
                case  4 : sGarb = "nw_it_mglove008"; break;       //  Gloves of Discipline
                case  5 : sGarb = "nw_it_mglove007"; break;       //  Gloves of Spellcraft
                case  6 : sGarb = "nw_it_mglove009"; break;       //  Gloves of Swordplay
                case  7 : sGarb = "nw_it_mglove016"; break;       //  Gloves of the Hin Fist +1
                case  8 : sGarb = "nw_it_mglove021"; break;       //  Gloves of the Long Death +1
                case  9 : sGarb = "nw_it_mglove005"; break;       //  Gloves of the Minstrel
                case 10 : sGarb = "nw_it_mglove003"; break;       //  Gloves of the Rogue
                case 11 : sGarb = "nw_it_mglove026"; break;       //  Gloves of the Yellow Rose + 1
            }                      //
            break;
        case 2:
            nRandom = Random(12) + 1;
            switch (nRandom)
            {
                case 1 : sGarb = "nw_it_mglove012"; break;       //  Greater Gloves of Animal Handling
                case 2 : sGarb = "nw_it_mglove010"; break;       //  Greater Gloves of Concentration
                case 3 : sGarb = "nw_it_mglove014"; break;       //  Greater Gloves of Discipline
                case 4 : sGarb = "nw_it_mglove013"; break;       //  Greater Gloves of Spellcraft
                case 5 : sGarb = "nw_it_mglove015"; break;       //  Greater Gloves of Swordplay
                case 6 : sGarb = "nw_it_mglove011"; break;       //  Greater Gloves of the Minstrel
                case 7 : sGarb = "NW_IT_MBRACER001"; break;      //  Bracers of Dexterity +1
                case 8 : sGarb = "NW_IT_MBRACER012"; break;   //  Lesser Gauntlets of Ogre Power  //
                case 9 : sGarb = "nw_it_mglove027"; break;       //  Gloves of the Yellow Rose +2
                case 10 : sGarb = "NW_IT_MBRACER007"; break;      //  Bracers of Armor +2
                case 11 : sGarb = "nw_it_mglove017"; break;       //  Gloves of the Hin Fist +2
                case 12 : sGarb = "nw_it_mglove022"; break;       //  Gloves of the Long Death +2
            }                      //
            break;
        case 3:
            nRandom = Random(13) + 1;
            switch (nRandom)
            {
                case 1 : sGarb = "nw_it_mglove028"; break;       //  Gloves of the Yellow Rose +3
                case 2 : sGarb = "NW_IT_MGLOVE001"; break;       //  Wondrous Gloves
                case 3 : sGarb = "NW_IT_MBRACER003"; break;      //  Bracers of Dexterity +2
                case 4 : sGarb = "NW_IT_MBRACER011"; break;      //  Gauntlets of Locking Grip
                case 5 : sGarb = "NW_IT_MBRACER013"; break;         //  Gauntlets of Ogre Power
                case 6 : sGarb = "nw_it_mglove018"; break;       //  Gloves of the Hin Fist +3
                case 7 : sGarb = "nw_it_mglove023"; break;       //  Gloves of the Long Death +3
                case 8 : sGarb = "nw_it_mglove029"; break;       //  Gloves of the Yellow Rose +4
                case 9 : sGarb = "NW_IT_MBRACER008"; break;      //  Bracers of Armor +3
                case 10 : sGarb = "nw_it_mglove019"; break;       //  Gloves of the Hin Fist +4
                case 11 : sGarb = "nw_it_mglove024"; break;       //  Gloves of the Long Death +4
                case 12 : sGarb = "NW_IT_MBRACER004"; break;      //  Bracers of Dexterity +3
                case 13 : sGarb = "NW_IT_MBRACER009"; break;      //  Bracers of Armor +4
            }                      //
            break;
        case 4:
            nRandom = Random(6);
            switch (nRandom)
            {
                case 1 : sGarb = "nw_it_mglove030"; break;       //  Gloves of the Yellow Rose +5
                case 2 : sGarb = "nw_it_mglove020"; break;       //  Gloves of the Hin Fist +5
                case 3 : sGarb = "nw_it_mglove025"; break;       //  Gloves of the Long Death +5
                case 4 : sGarb = "NW_IT_MBRACER010"; break;      //  Bracers of Armor +5
                case 5 : sGarb = "NW_IT_MBRACER005"; break;      //  Bracers of Dexterity +4
                case 6 : sGarb = "NW_IT_MBRACER006"; break;      //  Bracers of Dexterity +5
            }                     //
            break;
    }
    CreateItemOnObject(sGarb, oCreateOn, 1);
}

void CreateHelm (object oCreateOn, int nTClass)
{
    string sGarb = ""; int nRandom = 1;
    switch (nTClass)
    {
        case 1:
            nRandom = Random(13) + 1;
            switch (nRandom)
            {
                case  1 : sGarb = "helmofdefense"; break;   //  Helm of Defense
                case  2 : sGarb = "helmofcourtesy"; break;   //  Helm of Protocol
                case  3 : sGarb = "helmofknowledge"; break;   //  Toq of Sagacity
                case  4 : sGarb = "helmofrighteousn"; break;   //  Helm of Righteousness
                case  5 : sGarb = "helmofthegladiat"; break;   //  Helm of the Gladiator
                case  6 : sGarb = "helmofthewoodlan"; break;   //  Helm of the Woodlands
                case  7 : sGarb = "helmofthestalker"; break;   //  Horns of the Stalker
                case  8 : sGarb = "helmofthefence"; break;   //  Mask of the Fence
                case  9 : sGarb = "helmoftheway"; break;   //  Skullcap of the Way
                case 10 : sGarb = "helmofsorcery"; break;   //  Sorcerer's Cap
                case 11 : sGarb = "helmofthelight"; break;   //   Helm of the Light
                case 12 : sGarb = "NW_ARMHE011"; break;   //  Mask of Persuasion
                case 13 : sGarb = "helmofrage"; break;   //  Helm of Reckless Might
            }                             //
        break;
    case 2:
        nRandom = Random(6) + 1;
        switch (nRandom)
        {
            case 1 : sGarb = "NW_ARMHE008"; break;   //  Shukenja Helm
            case 2 : sGarb = "headbandofintell"; break;   //  Headband of Intellect +2
            case 3 : sGarb = "NW_ARMHE006"; break;   //   Watchman's Helm
            case 4 : sGarb = "NW_ARMHE007"; break;   //  Thieve's Hood
            case 5 : sGarb = "NW_NOVEL004"; break;   //  Moonstone Mask
            case 6 : sGarb = "NW_ARMHE012"; break;   //Greater Mask of Persuasion
        }                     //
        break;
    case 3:
        nRandom = Random(4) + 1;
        switch (nRandom)
        {
            case 1 : sGarb = "NW_ARMHE009"; break;   //  Thayvian Circlet
            case 2:  sGarb = "NW_ARMHE010"; break;   //  Golden Circlet
            case 3 : sGarb = "headbandofint001"; break;   // Headband of Intellect +4
            case 4 : sGarb = "maskoftheskull"; break;   //  Mask of the Skull
        }                     //
        break;
    case 4:
        nRandom = Random(4) + 1;
        switch (nRandom)
        {
            case 1 : sGarb = "NW_ARMHE009"; break;   //  Thayvian Circlet
            case 2:  sGarb = "NW_ARMHE010"; break;   //  Golden Circlet
            case 3 : sGarb = "headbandofint002"; break;   // Headband of Intellect +6
            case 4 : sGarb = "maskoftheskull"; break;   //  Mask of the Skull
        }                     //
        break;
    }
    CreateItemOnObject(sGarb, oCreateOn, 1);
}
////////////////////////////////////////////////////////////////////
void CreateGarb (object oCreateOn, int nTClass)
{
    int nRandom = Random(7) + 1;
    switch (nRandom)
        {
        case 1: CreateBelt(oCreateOn, nTClass); break;//
        case 2: CreateBoots (oCreateOn, nTClass); break;//
        case 3: case 4: CreateCloak (oCreateOn, nTClass); break;//
        case 5: case 6: CreateHands (oCreateOn, nTClass); break;  //
        case 7: CreateHelm (oCreateOn, nTClass); break;//
        }
}

  //////////////////CREATE A WEAPON////////////////////////////////////////
 /////////This will create a melee or range weapon////////////////////////
 /////////////////////////////////////////////////////////////////////////
  ////////Determine what type of Weapon is to be created////////////////////
    void CreateWeapon (object oCreateOn, int nTClass)                //
    {                                                                   //
        object oCreateOn = OBJECT_SELF;
        int nRandom = Random(10) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: CreateBasicMeleeWeapon(oCreateOn, nTClass); break;
            case 5: case 6: case 7: CreateBasicRangeWeapon (oCreateOn, nTClass); break;             //
            case 8: case 9: CreateSpecialMeleeWeapon (oCreateOn, nTClass); break;           //
            case 10: CreateSpecialRangeWeapon (oCreateOn, nTClass); break;           //
        }
    }                                                                   //
//////////////////////////////////////////////////////////////////////////
                                                                        //
 ////////Create a Melee Weapon with an Enhancement Bonus, but           //
 /////but no special abilities////////////////////////////////////////////
void CreateBasicMeleeWeapon (object oCreateOn, int nTClass)//
    {                                                                   //
    int nRandom = 1;
    string sBMWeapon = "";                                              //
    switch (nTClass)
    {
        case 1:
            nRandom =  Random(25) + 1;
            switch (nRandom)
            {
                //Minor Items//
                case 1:   sBMWeapon = "NW_WSWMBS002"; break;    // +1 Bastard Sword
                case 2:   sBMWeapon = "NW_WAXMBT002"; break;    // +1 Battleaxe
                case 3:   sBMWeapon = "NW_WBLMCL002"; break;    // +1 Club
                case 4:   sBMWeapon = "NW_WSWMDG002"; break;    // +1 Dagger
                case 5:   sBMWeapon = "NW_WAXMGR002"; break;    // +1 Greataxe
                case 6:   sBMWeapon = "NW_WSWMGS002"; break;    // +1 Greatsword
                case 7:   sBMWeapon = "NW_WPLMHB002"; break;    // +1 Halberd
                case 8:   sBMWeapon = "NW_WAXMHN002"; break;    // +1 Handaxe
                case 9:   sBMWeapon = "NW_WBLMFH002"; break;    // +1 Heavy Flail
                case 10:  sBMWeapon = "NW_WSPMKA002"; break;    // +1 Kama
                case 11:  sBMWeapon = "NW_WSWMKA002"; break;    // +1 Katana
                case 12:  sBMWeapon = "NW_WSPMKU002"; break;    // +1 Kukri
                case 13:  sBMWeapon = "NW_WBLMFL002"; break;    // +1 Light Flail
                case 14:  sBMWeapon = "NW_WBLMHL002"; break;    // +1 Light Hammer
                case 15:  sBMWeapon = "NW_WSWMLS002"; break;    // +1 Longsword
                case 16:  sBMWeapon = "NW_WBLMML002"; break;    // +1 Mace
                case 17:  sBMWeapon = "NW_WBLMMS002"; break;    // +1 Morningstar
                case 18:  sBMWeapon = "NW_WDBMQS002"; break;    // +1 Quarterstaff
                case 19:  sBMWeapon = "NW_WSWMRP002"; break;    // +1 Rapier
                case 20:  sBMWeapon = "NW_WSWMSC002"; break;    // +1 Scimitar
                case 21:  sBMWeapon = "NW_WPLMSC002"; break;    // +1 Scythe
                case 22:  sBMWeapon = "NW_WSWMSS002"; break;    // +1 Short Sword
                case 23:  sBMWeapon = "NW_WSPMSC002"; break;    // +1 Sickle
                case 24:  sBMWeapon = "NW_WPLMSS002"; break;    // +1 Spear
                case 25:  sBMWeapon = "NW_WBLMHW002"; break;    // +1 Warhammer
            }             //
            break;
        case 2:
            nRandom =  Random(56) + 1;
            switch (nRandom)
            {
                //Medium Items //
                case 1:  sBMWeapon = "NW_WDBMMA002"; break;    // +1 Dire Mace
                case 2:  sBMWeapon = "NW_WDBMAX002"; break;    // +1 Double Axe
                case 3:  sBMWeapon = "NW_WDBMSW002"; break;    // +1 Two Bladed Sword
                case 4:  sBMWeapon = "NW_WSWMBS009"; break;    // +1 Bastard Sword
                case 5:  sBMWeapon = "NW_WAXMBT010"; break;    // +2 Battleaxe
                case 6:  sBMWeapon = "NW_WBLMCL010"; break;    // +2 Club
                case 7:  sBMWeapon = "NW_WSWMDG008"; break;    // +2 Dagger
                case 8:  sBMWeapon = "NW_WAXMGR009"; break;    // +2 Greataxe
                case 9:  sBMWeapon = "NW_WSWMGS011"; break;    // +2 Greatsword
                case 10:  sBMWeapon = "NW_WPLMHB010"; break;    // +2 Halberd
                case 11:  sBMWeapon = "NW_WAXMHN010"; break;    // +2 Handaxe
                case 12:  sBMWeapon = "NW_WBLMFH010"; break;    // +2 Heavy Flail
                case 13:  sBMWeapon = "NW_WSPMKA008"; break;    // +2 Kama
                case 14:  sBMWeapon = "NW_WSWMKA010"; break;    // +2 Katana
                case 15:  sBMWeapon = "NW_WSPMKU008"; break;    // +2 Kukri
                case 16:  sBMWeapon = "NW_WBLMFL010"; break;    // +2 Light Flail
                case 17:  sBMWeapon = "NW_WBLMHL010"; break;    // +2 Light Hammer
                case 18:  sBMWeapon = "NW_WSWMLS010"; break;    // +2 Longsword
                case 19:  sBMWeapon = "NW_WBLMML011"; break;    // +2 Mace
                case 20:  sBMWeapon = "NW_WBLMMS010"; break;    // +2 Morningstar               //
                case 21:  sBMWeapon = "NW_WDBMQS008"; break;    // +2 Quarterstaff
                case 22:  sBMWeapon = "NW_WSWMRP010"; break;    // +2 Rapier         //
                case 23:  sBMWeapon = "NW_WSWMSC010"; break;    // +2 Scimitar         //
                case 24:  sBMWeapon = "NW_WPLMSC010"; break;    // +2 Scythe         //
                case 25:  sBMWeapon = "NW_WSWMSS009"; break;    // +2 Short Sword      //
                case 26:  sBMWeapon = "NW_WSPMSC010"; break;    // +2 Sickle            //
                case 27:  sBMWeapon = "NW_WPLMSS010"; break;    // +2 Spear          //
                case 28:  sBMWeapon = "NW_WBLMHW011"; break;    // +2 Warhammer         //
                case 29:  sBMWeapon = "NW_WDBMMA010"; break;    // +2 Dire Mace        //
                case 30:  sBMWeapon = "NW_WDBMAX010"; break;    // +2 Double Axe       //
                case 31:  sBMWeapon = "NW_WDBMSW010"; break;    // +2 Two Bladed Sword      //
                case 32:  sBMWeapon = "NW_WSWMBS010"; break;    // +3 Bastard Sword            //
                case 33:  sBMWeapon = "NW_WAXMBT011"; break;    // +3Battleaxe           //
                case 34:  sBMWeapon = "NW_WBLMCL011"; break;    // +3 Club            //
                case 35:  sBMWeapon = "NW_WSWMDG009"; break;    // +3 Dagger                    //
                case 36:  sBMWeapon = "NW_WAXMGR011"; break;    // +3 Greataxe   //
                case 37:  sBMWeapon = "NW_WSWMGS012"; break;    // +3 Greatsword            //
                case 38:  sBMWeapon = "NW_WPLMHB011"; break;    // +3 Halberd           //
                case 39:  sBMWeapon = "NW_WAXMHN011"; break;    // +3 Handaxe       //
                case 40:  sBMWeapon = "NW_WBLMFH011"; break;    // +3 Heavy Flail        //
                case 41:  sBMWeapon = "NW_WSPMKA009"; break;    // +3 Kama           //
                case 42:  sBMWeapon = "NW_WSWMKA011"; break;    // +3 Katana         //
                case 43:  sBMWeapon = "NW_WSPMKU009"; break;    // +3 Kukri             //
                case 44:  sBMWeapon = "NW_WBLMFL011"; break;    // +3 Light Flail               //
                case 45:  sBMWeapon = "NW_WBLMHL011"; break;    // +3 Light Hammer         //
                case 46:  sBMWeapon = "NW_WSWMLS012"; break;    // +3 Longsword            //
                case 47:  sBMWeapon = "NW_WBLMML012"; break;    // +3 Mace               //
                case 48:  sBMWeapon = "NW_WBLMMS011"; break;    // +3 Morningstar            //
                case 49:  sBMWeapon = "NW_WDBMQS009"; break;    // +3 Quarterstaff          //
                case 50:  sBMWeapon = "NW_WSWMRP011"; break;    // +3 Rapier             //
                case 51:  sBMWeapon = "NW_WSWMSC011"; break;    // +3 Scimitar            //
                case 52:  sBMWeapon = "NW_WPLMSC011"; break;    // +3 Scythe          //
                case 53:  sBMWeapon = "NW_WSWMSS011"; break;    // +3 Short Sword         //
                case 54:  sBMWeapon = "NW_WSPMSC011"; break;    // +3 Sickle          //
                case 55:  sBMWeapon = "NW_WPLMSS011"; break;    // +3 Spear           //
                case 56:  sBMWeapon = "NW_WBLMHW012"; break;    // +3 Warhammer          //
            }            //
            break;
        case 3:
            nRandom =  Random(28)+ 1;
            switch (nRandom)
            {
                 // Major Items //
                case  1:  sBMWeapon = "NW_WDBMMA011"; break;    // +3 Dire Mace            //
                case  2:  sBMWeapon = "NW_WDBMAX011"; break;    // +3 Double Axe           //
                case  3:  sBMWeapon = "NW_WDBMSW011"; break;    // +3 Two Bladed Sword        //
                case  4:  sBMWeapon = "bastardsword4"; break;   // +4 Bastard Sword                     //
                case  5:  sBMWeapon = "battleaxe4"; break;      // +4 Battleaxe                           //
                case  6:  sBMWeapon = "club4"; break;           // +4 Club                    //
                case  7:  sBMWeapon = "dagger4"; break;         // +4 Dagger                     //
                case  8:  sBMWeapon = "greataxe4"; break;       // +4 Greataxe   //               //
                case  9:  sBMWeapon = "greatsword4"; break;     // +4 Greatsword                    //
                case 10:  sBMWeapon = "halberd4"; break;        // +4 Halberd                    //
                case 11:  sBMWeapon = "handaxe4"; break;        // +4 Handaxe                  //
                case 12:  sBMWeapon = "heavyflail4"; break;     // +4 Heavy Flail             //
                case 13:  sBMWeapon = "kama4"; break;           // +4 Kama               //
                case 14:  sBMWeapon = "katana4"; break;         // +4 Katana                       //
                case 15:  sBMWeapon = "kukri4"; break;          // +4 Kukri                      //
                case 16:  sBMWeapon = "lightflail4"; break;     // +4 Light Flail              //
                case 17:  sBMWeapon = "lighthammer4"; break;    // +4 Light Hammer                //
                case 18:  sBMWeapon = "longsword4"; break;      // +4 Longsword                 //
                case 19: sBMWeapon = "mace4"; break;            // +4 Mace              //
                case 20: sBMWeapon = "morningstar4"; break;     // +4 Morningstar              //
                case 21: sBMWeapon = "quarterstaff4"; break;    // +4 Quarterstaff              //
                case 22: sBMWeapon = "rapier4"; break;          // +4 Rapier                //
                case 23: sBMWeapon = "scimitar4"; break;        // +4 Scimitar            //
                case 24: sBMWeapon = "scythe4"; break;          // +4 Scythe               //
                case 25: sBMWeapon = "shortsword4"; break;      // +4 Short Sword           //
                case 26: sBMWeapon = "sickle4"; break;          // +4 Sickle         //
                case 27: sBMWeapon = "spear4"; break;           // +4 Spear         //
                case 28: sBMWeapon = "warhammer4";break;        // +4 Warhammer //
            }                    //
            break;
        case 4:
            nRandom =  Random(31) + 1;
            switch (nRandom)
            {
                // Epic Items //
                case  1: sBMWeapon = "diremace4"; break;        // +4 Dire Mace        //
                case  2: sBMWeapon = "doubleaxe4"; break;       // +4 Double Axe           //
                case  3: sBMWeapon = "twobladedsword4"; break;  // +4 Two Bladed Sword       //
                case  4: sBMWeapon = "bastardsword5"; break;    // +5 Bastard Sword                  //
                case  5: sBMWeapon = "battleaxe5"; break;       // +5 Battleaxe                 //
                case  6: sBMWeapon = "club5"; break;            // +5 Club                //
                case  7: sBMWeapon = "dagger5"; break;          // +5 Dagger           //
                case  8: sBMWeapon = "greataxe5"; break;        // +5 Greataxe   //             //
                case  9: sBMWeapon = "greatsword5"; break;      // +5 Greatsword              //
                case 10: sBMWeapon = "halberd5"; break;         // +5 Halberd                 //
                case 11: sBMWeapon = "handaxe5"; break;         // +5 Handaxe               //
                case 12: sBMWeapon = "heavyflail5"; break;      // +5 Heavy Flail              //
                case 13: sBMWeapon = "kama5"; break;            // +5 Kama              //
                case 14: sBMWeapon = "katana5"; break;          // +5 Katana               //
                case 15: sBMWeapon = "kukri5"; break;           // +5 Kukri           //
                case 16: sBMWeapon = "lightflail5"; break;      // +5 Light Flail            //
                case 17: sBMWeapon = "lighthammer5"; break;     // +5 Light Hammer           //
                case 18: sBMWeapon = "longsword5"; break;       // +5 Longsword          //
                case 19: sBMWeapon = "mace5"; break;            // +5 Mace        //
                case 20: sBMWeapon = "morningstar5"; break;     // +5 Morningstar         //
                case 21: sBMWeapon = "quarterstaff5"; break;    // +5 Quarterstaff        //
                case 22: sBMWeapon = "rapier5"; break;          // +5 Rapier       //
                case 23: sBMWeapon = "scimitar5"; break;        // +5 Scimitar      //
                case 24: sBMWeapon = "scythe5"; break;          // +5 Scythe    //
                case 25: sBMWeapon = "shortsword5"; break;      // +5 Short Sword     //
                case 26: sBMWeapon = "sickle5"; break;          // +5 Sickle     //
                case 27: sBMWeapon = "spear5"; break;           // +5 Spear   //
                case 28: sBMWeapon = "warhammer5"; break;       // +5 Warhammer    //
                case 29: sBMWeapon = "diremace5"; break;        // +5 Dire Mace    //
                case 30: sBMWeapon = "doubleaxe5"; break;       // +5 Double Axe  //
                case 31: sBMWeapon = "twobladedsword5"; break;  // +5 Two Bladed Sword
            }            //
            break;
    }
    CreateItemOnObject(sBMWeapon, oCreateOn, 1);
}
 //////////////////////////////////////////////////////////////////////////////////

  ////////Create a Melee Weapon with Special Abilities////////////////////
  /////////////////////////////////////////////////////////////////////////
void CreateSpecialMeleeWeapon (object oCreateOn, int nTClass)  //
{                                                                   //
    int nRandom = 1;
    string sSMWeapon = "";                                          //
    switch (nTClass)
    {
        case 1:
            nRandom = Random(18) + 1;
            switch (nRandom)
            {
                case 1: case 2: case 3: case 4: case 5: case 6:
                case 7: case 8: case 9: case 10: case 11: case 12:
                case 13: case 14: case 15: case 16: case 17: //create +1, +2 racial weapons
                case 18:  sSMWeapon = "NW_WSPMSC008"; break; // Golden Sickle +1
            }                 //        //
            break;
        case 2:
            nRandom = Random(60) + 1;                     //
            switch (nRandom)
            {
                case 1  : sSMWeapon = "NW_WSPMSC008"; break; // Golden Sickle +1
                case 2  : sSMWeapon = "NW_WDBMMA008"; break; // Ironwood Mace
                case 3  : sSMWeapon = "NW_WBLMML009"; break; // Mace of Disruption +2
                case 4  : sSMWeapon = "NW_WSPMKU006"; break; // Sharpshadow Blade
                case 5  : sSMWeapon = "NW_WDBMQS005"; break; // Staff of Curing
                case 6  : sSMWeapon = "NW_WSWMKA008"; break; // Sword Saint Legacy +1
                case 7  : sSMWeapon = "NW_WSWMLS009"; break; // Astral Blade +1
                case 8  : sSMWeapon = "NW_WDBMAX008"; break; // Axe for the Tall Kin
                case 9  : sSMWeapon = "NW_WDBMQS006"; break; // Blackforest Staff
                case 10 : sSMWeapon = "NW_WPLMSS008"; break; // Fey Spear +1
                case 11 : sSMWeapon = "NW_WSWMSS008"; break; // Feyduster +1
                case 12 : sSMWeapon = "NW_WBLMCL008"; break; // Gladiator's Club +1
                case 13 : sSMWeapon = "NW_WSWMGS009"; break; // Harbinger's Kin +1
                case 14 : sSMWeapon = "NW_WSWMKA005"; break; // Kaga -T0
                case 15 : sSMWeapon = "NW_WSWMRP008"; break; // Namarra +1
                case 16 : sSMWeapon = "NW_WBLMMS007"; break; // One of Many
                case 17 : sSMWeapon = "NW_WBLMHW009"; break; // Rune Hammer +1
                case 18 : sSMWeapon = "NW_WAXMBT008"; break; // Sentinel +1
                case 19 : sSMWeapon = "NW_WAXMGR008"; break; // Stonefire Axe +1
                case 20 : sSMWeapon = "NW_WBLMHL008"; break; // Storm +1
                case 21 : sSMWeapon = "NW_WSWMRP004"; break; // Black Rider Quill
                case 22 : sSMWeapon = "NW_WSPMSC004"; break; // Blacksoul Sickle
                case 23 : sSMWeapon = "NW_WBLMHL004"; break; // Daraz Hammer
                case 24 : sSMWeapon = "NW_WBLMMS008"; break; // Drone +1
                case 25 : sSMWeapon = "NW_WBLMML006"; break; // Fist of the Legion
                case 26 : sSMWeapon = "NW_WBLMFL008"; break; // Foundation +1
                case 27 : sSMWeapon = "NW_WBLMHW006"; break; // Hammer of Justice
                case 28 : sSMWeapon = "NW_WSPMKA007"; break; // Imaskari Kama
                case 29 : sSMWeapon = "NW_WDBMMA003"; break; // Krotan's Skullcrusher
                case 30 : sSMWeapon = "NW_WPLMSC008"; break; // Sea Reaver +1
                case 31 : sSMWeapon = "NW_WDBMSW006"; break; // Sword of Bao
                case 32 : sSMWeapon = "NW_WSWMDG006"; break; // Taggert's Talon
                case 33 : sSMWeapon = "NW_WBLMFL004"; break; // Writ of the Vizier
                case 34 : sSMWeapon = "NW_WBLMFH004"; break; // Asp Flail
                case 35 : sSMWeapon = "NW_WBLMMS003"; break; // Bone Phoenix
                case 36 : sSMWeapon = "NW_WSWMSC008"; break; // Desert Wind
                case 37 : sSMWeapon = "NW_WBLMFL005"; break; // Heirs of Osiris
                case 38 : sSMWeapon = "NW_WSPMKA004"; break; // Hideo's Kama
                case 39 : sSMWeapon = "NW_WAXMHN008"; break; // Ice Reaver +1
                case 40 : sSMWeapon = "NW_WPLMSC003"; break; // Nature's Scythe
                case 41 : sSMWeapon = "NW_WDBMQS004"; break; // Negastaff
                case 42 : sSMWeapon = "NW_WAXMGR003"; break; // Netherese Axe
                case 43 : sSMWeapon = "NW_WSPMKA005"; break; // Peasant Dynasty
                case 44 : sSMWeapon = "NW_WPLMHB008"; break; // Ravager +1
                case 45 : sSMWeapon = "NW_WBLMFH008"; break; // Reaver +1
                case 46 : sSMWeapon = "NW_WBLMHW005"; break; // Rift Hammer
                case 47 : sSMWeapon = "NW_WSWMGS006"; break; // Vermin's Bane
                case 48 : sSMWeapon = "NW_WBLMCL003"; break; // Watchman's Club
                case 49 : sSMWeapon = "NW_WPLMHB004"; break; // Will of Altair
                case 50 : sSMWeapon = "NW_WBLMCL004"; break; // Will of the Lost
                case 51 : sSMWeapon = "NW_WDBMAX006"; break; //Ascorian Double Axe
                case 52 : sSMWeapon = "NW_WPLMSS005"; break; // Black Kumade
                case 53 : sSMWeapon = "NW_WSWMGS004"; break; // Blade of the Rashemi
                case 54 : sSMWeapon = "NW_WSPMSC003"; break; // Blightbringer Lineage
                case 55 : sSMWeapon = "NW_WAXMGR006"; break; // Gruumsh Hand
                case 56 : sSMWeapon = "NW_WSWMBS005"; break; // Lawgiver
                case 57 : sSMWeapon = "NW_WSWMRP005"; break; // Mercykiller Blade
                case 58 : sSMWeapon = "NW_WSPMKU004"; break; // Neverwinger Kukri
                case 59 : sSMWeapon = "NW_WSWMSC004"; break; // Shimmering Blade
                case 60 : sSMWeapon = "NW_WDBMSW008"; break; // Uthgardt Ceremonial Blade +1
            }            //
            break;
        case 3:
            nRandom = Random(63) + 1;                     //
            switch (nRandom)                                            //
            {                                                           //
                case 1  : sSMWeapon = "NW_WPLMHB003"; break; // Arc Asunder
                case 2  : sSMWeapon = "NW_WSWMKA007"; break; // Blade of the Elements
                case 3  : sSMWeapon = "NW_WSWMSS005"; break;// Breath of the Maider
                case 4  : sSMWeapon = "NW_WSWMLS007"; break;// Cold Iron Blade
                case 5  : sSMWeapon = "NW_WDBMAX005"; break;// Death Shroud Axe
                case 6  : sSMWeapon = "NW_WSPMKA006"; break; // Empty Fields
                case 7  : sSMWeapon = "NW_WSPMSC009"; break;// Golden Sickle +2
                case 8  : sSMWeapon = "NW_WBLMHL005"; break;// Hammer of the Beast
                case 9  : sSMWeapon = "NW_WBLMML004"; break;  // Kiss of Sune
                case 10 : sSMWeapon = "NW_WBLMML010"; break;// Mace of Disruption +5
                case 11 : sSMWeapon = "NW_WSPMKU007"; break; // Messenger Blade
                case 12 : sSMWeapon = "NW_WPLMSC009"; break; // Sea Reaver +2
                case 13 : sSMWeapon = "NW_WAXMHN004"; break; // Woodcutter's Axe
                case 14 : sSMWeapon = "NW_WDBMQS003"; break; // Aiedo Wither Stick
                case 15 : sSMWeapon = "NW_WSWMLS005"; break; // Anguvadal (Flame Tongue)
                case 16 : sSMWeapon = "NW_IT_NOVEL007"; break; // Blade of the Gladiator
                case 17 : sSMWeapon = "NW_WAXMHN005"; break;  // Blood Rust Axe
                case 18 : sSMWeapon = "NW_WPLMSS007"; break;  // Briarspike
                case 19 : sSMWeapon = "NW_WSWMBS006"; break;  // Dragonslayer
                case 20 : sSMWeapon = "NW_WAXMHN003"; break; // Ember's Axe
                case 21 : sSMWeapon = "NW_WBLMFL006"; break; // Flail of Destruction
                case 22 : sSMWeapon = "NW_WBLMFH003"; break; // Flail of Jergal
                case 23 : sSMWeapon = "NW_WBLMHL006"; break;// Forge Fire
                case 24 : sSMWeapon = "NW_WBLMHW003"; break;// Hammer of the Wisp
                case 25 : sSMWeapon = "NW_WSWMDG004"; break; // Ice Talon
                case 26 : sSMWeapon = "NW_WSWMDG004"; break; // Ice Talon
                case 27 : sSMWeapon = "NW_WBLMFH006"; break; // Kinthasia
                case 28 : sSMWeapon = "NW_WBLMFH006"; break; // Kinthasia
                case 29 : sSMWeapon = "NW_WBLMML005"; break; // Planar Mace
                case 30 : sSMWeapon = "NW_WSWMRP007"; break; // Rapier of the High Hand
                case 31 : sSMWeapon = "NW_WSWMGS005"; break; // Shining Light of Lathand
                case 32 : sSMWeapon = "NW_WPLMSS006"; break; // Spear of Withering
                case 33 : sSMWeapon = "NW_WAXMGR010"; break; // Stonefire Axe +2
                case 34 : sSMWeapon = "NW_WSPMSC006"; break; // Teneraard's Sickle
                case 35 : sSMWeapon = "NW_WBLMCL005"; break; // Tethir-Wood Cudgel
                case 36 : sSMWeapon = "NW_WPLMSC006"; break; // Wicked Union
                case 37 : sSMWeapon = "NW_WDBMSW005"; break; // Blade of the Red Masque
                case 38 : sSMWeapon = "NW_WBLMMS006"; break; // Circling Star
                case 39 : sSMWeapon = "NW_WDBMMA004"; break; // Dire Mace
                case 40 : sSMWeapon = "NW_WDBMMA009"; break; // Ironwood Mace +3
                case 41 : sSMWeapon = "NW_WSPMKU003"; break; // Ladymist Talon
                case 42 : sSMWeapon = "NW_WSWMKA006"; break; // Master Li's Way
                case 43 : sSMWeapon = "NW_WAXMGR005"; break; // Re's Redemption
                case 44 : sSMWeapon = "NW_WDBMAX004"; break; // Red Tiger Double Axe
                case 45 : sSMWeapon = "NW_WSPMKA003"; break; // Thread of Life
                case 46 : sSMWeapon = "NW_WDBMAX009"; break; // Axe of the Tall Kin +3
                case 47 : sSMWeapon = "NW_WDBMSW007"; break; // Blade of Corellion
                case 48 : sSMWeapon = "NW_WSWMRP006"; break; // Bleederkin
                case 49 : sSMWeapon = "NW_WBLMCL012"; break; // Club of Smiting
                case 50 : sSMWeapon = "NW_WSWMDG003"; break; // Courtesan Blade
                case 51 : sSMWeapon = "NW_WDBMMA006"; break; // Ebon Dire Mace
                case 52 : sSMWeapon = "NW_WBLMFL007"; break; // Elberond's Flail
                case 53 : sSMWeapon = "NW_WSWMSS010"; break; // Feyduster +2
                case 54 : sSMWeapon = "NW_WAXMHN009"; break; // Ice Reaver +3
                case 55 : sSMWeapon = "NW_WPLMSC005"; break; // King's Scythe
                case 56 : sSMWeapon = "NW_WSWMRP009"; break; // Namara +2
                case 57 : sSMWeapon = "NW_WSWMDG007"; break; // Pixie Lance
                case 58 : sSMWeapon = "NW_WBLMMS004"; break; // Sleepwalker Kin
                case 59 : sSMWeapon = "NW_WBLMHL009"; break; // Storm +2
                case 60 : sSMWeapon = "NW_WDBMMA005"; break; // Stoutcorps Key
                case 61 : sSMWeapon = "NW_WSWMSS006"; break; // The Lucky One
                case 62 : sSMWeapon = "NW_WSWMSC007"; break; // Ula's Heart
                case 63 : sSMWeapon = "NW_WPLMHB007"; break; // Water's Edge
            }
           //
            break;
        case 4:
            nRandom = Random(45) + 1;
            switch (nRandom)
            {
                case  1 : sSMWeapon = "NW_WAXMBT003"; break; // Axe of Dead Illusk
                case  2 : sSMWeapon = "NW_WDBMAX007"; break; // Bloodstone Double Axe
                case  3 : sSMWeapon = "NW_WSWMBS007"; break; // Discord
                case  4 : sSMWeapon = "NW_WBLMFH005"; break; // Flail of Stars
                case  5 : sSMWeapon = "NW_WSWMGS003"; break; // Gemsword
                case  6 : sSMWeapon = "NW_WSWMGS010"; break; // Harbinger Kin +3
                case  7 : sSMWeapon = "NW_WBLMML007"; break; // Petty's Tempest
                case  8 : sSMWeapon = "NW_IT_NOVEL006"; break;//Silvermane Axe
                case  9 : sSMWeapon = "NW_WSWMLS004"; break; // Soulrazor Minion
                case 10 : sSMWeapon = "NW_IT_NOVEL009"; break;//The Dagger of Chaos
                case 11 : sSMWeapon = "NW_WSWMLS011"; break; // Astral Blade +3
                case 12 : sSMWeapon = "NW_WSPMKU005"; break; // Cutting Star
                case 13 : sSMWeapon = "NW_WSWMSC009"; break; // Desert Wind +2
                case 14 : sSMWeapon = "NW_WBLMFL009"; break; // Foundation +4
                case 15 : sSMWeapon = "NW_WBLMCL009"; break; // Gladiator's Club
                case 16 : sSMWeapon = "NW_WAXMBT004"; break; // Mordan's WIthering Blade
                case 17 : sSMWeapon = "NW_WBLMFH009"; break; // Reaver +2
                case 18 : sSMWeapon = "NW_WBLMHW010"; break; // Rune Hammer +2
                case 19 : sSMWeapon = "NW_WSPMSC005"; break; // Sickle of Holy Mourning
                case 20 : sSMWeapon = "NW_WSWMKA009"; break; // Sword Saint Legacy
                case 21 : sSMWeapon = "NW_WSWMLS006"; break; // Blessing of the Daystar
                case 22 : sSMWeapon = "NW_WAXMBT005"; break; // Clangeddin's Wayward Axe
                case 23 : sSMWeapon = "NW_WAXMBT006"; break; // Deepstone Progeny
                case 24 : sSMWeapon = "NW_WSWMKA004"; break; // Divine Fury
                case 25 : sSMWeapon = "NW_WBLMHL003"; break; // Hammer of Blasting
                case 26 : sSMWeapon = "NW_WSWMBS003"; break; // Nameless Light
                case 27 : sSMWeapon = "NW_WDBMQS007"; break; // Staff of Ascension
                case 28 : sSMWeapon = "NW_WBLMCL006"; break; // The Angry Soul
                case 29 : sSMWeapon = "NW_WDBMSW009"; break; // Uthgardt Ceremonial Blade +2
                case 30 : sSMWeapon = "NW_WPLMSS004"; break; // Heartwood Spear
                case 31 : sSMWeapon = "NW_WAXMHN006"; break; // Offhand Axe
                case 32 : sSMWeapon = "NW_WPLMHB009"; break; //Ravager +4
                case 33 : sSMWeapon = "NW_WSWMSC005"; break; //Scimitar of Speed
                case 34 : sSMWeapon = "NW_WSWMSS003"; break; // Shortsword of Quickness
                case 35 : sSMWeapon = "NW_WBLMML008"; break; // Soldier's Might
                case 36 : sSMWeapon = "NW_WPLMSC004"; break; // Death's Handmaiden
                case 37 : sSMWeapon = "NW_WPLMHB006"; break; // Dragon's Breath
                case 38 : sSMWeapon = "NW_WBLMMS009"; break; // Drone +4
                case 39 : sSMWeapon = "NW_WPLMSS009"; break; // Fey Spear +3
                case 40 : sSMWeapon = "NW_WSWMDG005"; break; // Leech
                case 41 : sSMWeapon = "NW_WAXMBT009"; break; // Sentinel +2
                case 42 : sSMWeapon = "NW_WSWMBS004"; break; // Bloodletter
                case 43 : sSMWeapon = "NW_WBLMHW004"; break; // Hammer of Thunderbolts
                case 44 : sSMWeapon = "NW_WDBMSW004"; break; // Sword of Lyons
                case 45 : sSMWeapon = "NW_WAXMGR004"; break; // Axe of the Culling
            }   //
            break;
        }
        CreateItemOnObject(sSMWeapon, oCreateOn, 1); //
}

 ////////Create a Range Weapon with an Enhancement Bonus, but/////////////
 /////but no special abilities////////////////////////////////////////////
void CreateBasicRangeWeapon (object oCreateOn, int nTClass)    //
{                                                                   //
    int nRandom = 1;
    string sBRWeapon = "";                                              //
    switch (nTClass)
    {
        case 1:
            nRandom = Random(5) + 1;
            switch (nRandom)
            {
                case 1: sBRWeapon = "NW_WBWMXH002"; break; // +1 Heavy Crossbow
                case 2: sBRWeapon = "NW_WBWMXL002"; break; // +1 Light Crossbow
                case 3: sBRWeapon = "NW_WBWMLN002"; break; // +1 Longbow
                case 4: sBRWeapon = "NW_WBWMSH002"; break; // +1 Shortbow
                case 5: sBRWeapon = "NW_WBWMSL001"; break; // +1 Sling
            }              //
            break;
        case 2:
            nRandom = Random(14) + 1;
            switch (nRandom)
            {
                case 1:  sBRWeapon = "NW_WBWMXH008"; break; // +2 Heavy Crossbow
                case 2:  sBRWeapon = "NW_WBWMXL008"; break; // +2 Light Crossbow
                case 3:  sBRWeapon = "NW_WBWMLN008"; break; // +2 Longbow
                case 4:  sBRWeapon = "NW_WBWMSH008"; break; // +2 Shortbow
                case 5:  sBRWeapon = "NW_WBWMSL009"; break; // +2 Sling
                case 6:  sBRWeapon = "NW_WBWMLN010"; break; // +1 M Composite Longbow
                case 7:  sBRWeapon = "NW_WBWMSH010"; break; // +1 M Composite Shortbow
                case 8:  sBRWeapon = "NW_WBWMXH009"; break; // +3 Heavy Crossbow
                case 9:  sBRWeapon = "NW_WBWMXL009"; break; // +3 Light Crossbow
                case 10: sBRWeapon = "NW_WBWMLN009"; break; // +3 Longbow
                case 11: sBRWeapon = "NW_WBWMSH009"; break; // +3 Shortbow
                case 12: sBRWeapon = "NW_WBWMSL010"; break; // +3 Sling
                case 13: sBRWeapon = "NW_WBWMLN011"; break; // +2 M Composite Longbow
                case 14: sBRWeapon = "NW_WBWMSH011"; break; // +2 M Composite Shortbow
            }           //
            break;
        case 3:
            nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1: sBRWeapon = "heavycrossbow4"; break; // +4 Heavy Crossbow
                case 2: sBRWeapon = "lightcrossbow4"; break; // +4 Light Crossbow
                case 3: sBRWeapon = "longbow4"; break;       // +4 Longbow
                case 4: sBRWeapon = "shortbow4"; break;     // +4 Shortbow
                case 5: sBRWeapon = "sling4"; break;        // +4 Sling
                case 6: sBRWeapon = "NW_WBWMLN012"; break;  // +3 Mighty Composite Longbow
                case 7: sBRWeapon = "NW_WBWMSH012"; break;  // +3 Mighty Composite Shortbow
             }             //
             break;
        case 4:
            nRandom = Random(9) + 1;
            switch (nRandom)
            {
                case 1: sBRWeapon = "heavycrossbow5"; break;    // +5 Heavy Crossbow
                case 2: sBRWeapon = "lightcrossbow5"; break;    // +5 Light Crossbow
                case 3: sBRWeapon = "longbow5"; break;          // +5 Longbow
                case 4: sBRWeapon = "shortbow5"; break;         // +5 Shortbow
                case 5: sBRWeapon = "sling5"; break;            // +5 Sling
                case 6: sBRWeapon = "mightcompositelo"; break; // +4 Mighty Composite Longbow
                case 7: sBRWeapon = "mightcompositesh"; break; // +4 Mighty Composite Shortbow
                case 8: sBRWeapon = "mightycompositel"; break; // +5 Mighty Composite Longbow
                case 9: sBRWeapon = "mightycomposites"; break; // +5 Mighty Composite Shortbow
            }               //
            break;
    }
    CreateItemOnObject(sBRWeapon, oCreateOn, 1);
}
///////////////////////////////////////////////////////////////////////////////

                                                               //
  ////////Create a Range Weapon with Special Abilities/////////////////////
  //////////////////////////////////////////////////////////////////////////
void CreateSpecialRangeWeapon (object oCreateOn, int nTClass)    //
{                                                                     //
    int nRandom = 1;
    string sSRWeapon = "";                                            //
    switch (nTClass)
    {
        case 1:
            nRandom = Random(11) + 1;              //
            switch (nRandom)
            {
                case 1: sSRWeapon = "NW_WBWMXL005"; break; // Ruby Crossbow
                case 2: sSRWeapon = "SY_MWXBOW005"; break; // Crossbow of Law
                case 3: sSRWeapon = "SY_MWXBOW006"; break; // Eternal Rest
                case 4: sSRWeapon = "SY_MWXBOW007"; break; // Crossbow of the Guardians
                case 5: sSRWeapon = "SY_MWXBOW008"; break; // Melf's Crossbow
                case 6: sSRWeapon = "SY_MWLBOW005"; break; // Bow of the Elven Guard
                case 7: sSRWeapon = "SY_MWLBOW006"; break; // Bow of the Orc Chieftain
                case 8: sSRWeapon = "SY_MWSBOW005"; break; // Silent Death
                case 9: sSRWeapon = "SY_MWSBOW006"; break; // Sorcerous Bow
                case 10: sSRWeapon = "SY_MWSLI005"; break; // Hunter's Sling
                case 11: sSRWeapon = "SY_MWSLI005"; break; // Sling of the Darkwoods
            }              //
            break;
        case 2:
            nRandom = Random(8) + 1;
            switch (nRandom)
            {
                case  1 : sSRWeapon = "NW_WBWMXH005"; break; // Feywarden Crossbow
                case  2 : sSRWeapon = "NW_WBWMXL005"; break; // Ruby Crossbow
                case  3 : sSRWeapon = "NW_WBWMSL003"; break; // Sunlight Sling
                case  4 : sSRWeapon = "NW_WBWMSH003"; break; // Eaglebow
                case  5 : sSRWeapon = "NW_WBWMSH003"; break; // Eaglebow
                case  6 : sSRWeapon = "NW_WBWMSH006"; break; // Lesser Oathbow
                case  7 : sSRWeapon = "NW_WBWMXH003"; break; // Crossbow of Accuracy
                case  8 : sSRWeapon = "NW_WBWMSL003"; break; // Sling of Seeking
            }               //
            break;
        case 3:
            nRandom = Random(11) + 1;
            switch (nRandom)
            {
                case  1 : sSRWeapon = "NW_WBWMXL003"; break; // Crossbow of Affliction
                case  2 : sSRWeapon = "NW_WBWMXL003"; break; // Crossbow of Affliction
                case  3 : sSRWeapon = "NW_WBWMLN007"; break; // North Wind Bow
                case  4 : sSRWeapon = "NW_WBWMXH004"; break; // Crossbow of Enchantment
                case  5 : sSRWeapon = "NW_WBWMSH007"; break; // Lilting Note
                case  6 : sSRWeapon = "NW_WBWMSL007"; break; // Charming Sling
                case  7 : sSRWeapon = "NW_WBWMXL004"; break; // Crossbow of the High Forest
                case  8 : sSRWeapon = "NW_WBWMXL004"; break; // Crossbow of the High Forest
                case  9 : sSRWeapon = "NW_WBWMLN006"; break; // Longarm
                case 10 : sSRWeapon = "WBWMSH005"; break;    // Tansheron's Bow
                case 11 : sSRWeapon = "NW_WBWMSL008"; break; // Tempertupin's Ever-Thrower
            }                //
            break;
        case 4:
            nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case  1 : sSRWeapon = "NW_WBWMSL006"; break; // Sling of Force
                case  2 : sSRWeapon = "NW_WBWMLN005"; break; // Ripper
                case  3 : sSRWeapon = "NW_WBWMXL006"; break; // Crossbow of the Unicorn
                case  4 : sSRWeapon = "NW_WBWMXH006"; break; // Graceblood Bow
                case  5 : sSRWeapon = "NW_WBWMSH004"; break; // Phantom Bow
                case  6 : sSRWeapon = "NW_WBWMSL004"; break; // Sling of Avereen
                case  7 : sSRWeapon = "NW_WBWMLN003"; break; // Taralash
            }                //
            break;
    }
    CreateItemOnObject(sSRWeapon, oCreateOn, 1);
}
///////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////
////////////////////CREATE ARMOR////////////////////////////////////////
void CreateArmor (object oCreateOn, int nTClass)               //
{                                                                    //
    object oCreateOn = oCreateOn;
    int nRandom = Random(5) + 1;                        //
    switch (nRandom)                                    //
        {                                                   //
            case 1: CreateLightArmor(oCreateOn, nTClass); break;        //
            case 2: CreateMediumArmor(oCreateOn, nTClass); break;       //
            case 3: CreateHeavyArmor(oCreateOn, nTClass); break;        //
            case 4: CreateRobes(oCreateOn, nTClass); break;              //
            case 5: CreateShield(oCreateOn, nTClass); break;
          }
}                                                                    //
////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
    void CreateLightArmor (object oCreateOn, int nTClass)
    {
        int nRandom = 1;
        string sArmor = "";
        switch (nTClass)
        {
            case 1:
                nRandom = Random(4) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MAARCL047"; break;   //  Hide Armor +1
                    case  2 : sArmor = "NW_MAARCL044"; break;   //  Leather Armor +1
                    case  3 : sArmor = "NW_MAARCL043"; break;   //  Padded Armor +1
                    case  4 : sArmor = "NW_MAARCL045"; break;   //  Studded Leather +1
                }
                // remove CreateItemOnObject(sArmor, oCreateOn, 1);
                break;
            case 2:
                nRandom = Random(10) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MAARCL070"; break;   // Hide Armor +2
                    case  2 : sArmor = "NW_MAARCL071"; break;   //  Leather Armor +2
                    case  3 : sArmor = "NW_MAARCL072"; break;   //  Padded Armor +2
                    case  4 : sArmor = "NW_MAARCL075"; break;   // Studded Leather +2
                    case  5 : sArmor = "NW_MAARCL011"; break;   //  Armor of Loyalty
                    case  6 : sArmor = "NW_MAARCL013"; break;   // Armor of Thorns
                    case  7 : sArmor = "NW_MAARCL082"; break;   // Hide Armor +3
                    case  8 : sArmor = "NW_MAARCL083"; break;   // Leather Armor +3
                    case  9 : sArmor = "NW_MAARCL084"; break;   //   Padded Armor +3
                    case 10 : sArmor = "NW_MAARCL087"; break;   // Studded Leather +1
                }                      //
                break;
            case 3:
                nRandom = Random(13) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MAARCL006"; break;   // Aurumvorax Armor
                    case  2 : sArmor = "NW_MAARCL032"; break;   //  Benzo's Luck
                    case  3 : sArmor = "NW_MAARCL013"; break;   // Callurdan Smoothhand's Armor
                    case  4 : sArmor = "NW_MAARCL007"; break;   // The Great Oak
                    case  5 : sArmor = "NW_MAARCL003"; break;   // Armor of the Stars
                    case  6 : sArmor = "NW_MAARCL001"; break;   //  Armor of the Wolf
                    case  7 : sArmor = "NW_MAARCL034"; break;   //  Rogue Links
                    case  8 : sArmor = "NW_MAARCL005"; break;   // Shadow Legion Armor
                    case  9 : sArmor = "NW_MAARCL002"; break;   // Mirrored Armor
                    case 10 : sArmor = "NW_IT_NOVEL003"; break;   // Storm Armor
                    case 11 : sArmor = "NW_MCLOTH005"; break;   // Aslyferund Elven Chain
                    case 12 : sArmor = "NW_MAARCL033"; break;   //  Greenleaf
                    case 13 : sArmor = "NW_MAARCL008"; break;   // Squire's Defense
                }                     //
                break;
            case 4:
                nRandom = Random(3) + 1;
                switch (nRandom)
                {
                    case 1 : sArmor = "NW_MAARCL010"; break;   // Kumakawa
                    case 2 : sArmor = "NW_MAARCL004"; break;   // Armor of Fleetness
                    case 3 : sArmor = "NW_MAARCL009"; break;   // Black Flame Armor
                }                   //
                break;
    }
    CreateItemOnObject(sArmor, oCreateOn, 1);
}
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
    void CreateMediumArmor(object oCreateOn, int nTClass)
    {
     int nRandom = 1;
     string sArmor = "";
     switch (nTClass)
     {
        case 1:
            nRandom = Random(4) + 1;
            switch (nRandom)
            {
                case 1  : sArmor = "NW_MAARCL049"; break;   //  Breastplate +1
                case 2  : sArmor = "NW_MAARCL046"; break;   // Chain Shirt +1
                case 3  : sArmor = "NW_MAARCL035"; break;   // Chainmail +1
                case 4  : sArmor = "NW_MAARCL048"; break;   // Scale Mail +1
            }                //
            break;
        case 2:
            nRandom = Random(9) + 1;
            switch (nRandom)
            {
                case  1  : sArmor = "NW_MAARCL065"; break;   // Breastplate +2
                case  2  : sArmor = "NW_MAARCL067"; break;   //  Chain Shirt +2
                case  3  : sArmor = "NW_MAARCL066"; break;   // Chainmail +2
                case  4  : sArmor = "NW_MAARCL073"; break;   // Scale Mail +2
                case  5  : sArmor = "NW_MAARCL077"; break;   // Breastplate +3
                case  6 : sArmor = "NW_MAARCL079"; break;   //  hain Shirt +3
                case  7 : sArmor = "NW_MAARCL078"; break;   //  Chainmail +3
                case  8 : sArmor = "NW_MAARCL058"; break;   // Chromatic Breastplate +1
                case  9 : sArmor = "NW_MAARCL085"; break;   // Scale Mail +3
            }               //
            break;
        case 3:
            nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1 :  sArmor = "NW_MAARCL036"; break;   // Doron's Mistake
                case 2 :  sArmor = "NW_MAARCL037"; break;   // Elven Chainmailc
                case 3 :  sArmor = "NW_MAARCL040"; break;   // Adamantine Breastplate
                case 4 :  sArmor = "NW_MAARCL016"; break;   // Armor of Horus Re
                case 5 :  sArmor = "NW_MAARCL017"; break;   //  Broewende Family Armor
                case 6 :  sArmor = "NW_MAARCL061"; break;   // Chromatic Breastplate +3
                case 7 :  sArmor = "NW_MAARCL039"; break;   // Chainmail of Speed
            }                  //
            break;
        case 4:
            nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1 :  sArmor = "NW_MAARCL014"; break;   //  Armor of Command
                case 2 :  sArmor = "NW_MAARCL015"; break;   // Dragon Armor
            }                //
            break;
   }
   CreateItemOnObject(sArmor, oCreateOn, 1);
}
/////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
    void CreateHeavyArmor(object oCreateOn, int nTClass)
    {
        int nRandom = 1;
        string sArmor = "";
        switch (nTClass)
        {
            case 1:
                nRandom = Random(4) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MAARCL051"; break;   // Banded Mail +1
                    case  2 : sArmor = "NW_MAARCL050"; break;   // Splint Mail +1
                    case  3 : sArmor = "NW_MAARCL052"; break;   // Half Plate +1
                    case  4 : sArmor = "NW_MAARCL053"; break;   // Full Plate +1
                }                      //
                break;
            case 2:
                nRandom = Random(14) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MAARCL064"; break;   // anded Mail +2
                    case  2 : sArmor = "NW_MAARCL074"; break;   // Splint Mail +2
                    case  3 : sArmor = "NW_MAARCL068"; break;   // Full Plate +2
                    case  4 : sArmor = "NW_MAARCL069"; break;   // Half Plate +2
                    case  5 : sArmor = "NW_MAARCL059"; break;   // Scales of Truth +1
                    case  6 : sArmor = "NW_MAARCL060"; break;   //  Whitebone Armor
                    case  7 : sArmor = "NW_MAARCL021"; break;   // Armor of Comfort
                    case  8 : sArmor = "NW_MAARCL026"; break;   // Gnomish Magnetic Armor
                    case  9 : sArmor = "NW_MAARCL076"; break;   // Banded Mail +3
                    case 10 : sArmor = "NW_MAARCL029"; break;   // Enkidu's Armor
                    case 11 : sArmor = "NW_MAARCL080"; break;   // Full Plate +3
                    case 12 : sArmor = "NW_MAARCL081"; break;   // Half Plate +3
                    case 13 : sArmor = "NW_MAARCL020"; break;   // Rainbow Armor
                    case 14 : sArmor = "NW_MAARCL086"; break;   // Splint Mail +3
                }                //
                break;
            case 3:
                nRandom = Random(10) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MAARCL042"; break;   // Copper Dragon Armor
                    case  2 : sArmor = "NW_MAARCL041"; break;   // Mithral Splint Mail
                    case  3 : sArmor = "NW_MAARCL018"; break;   // White Dragon Armor
                    case  4 : sArmor = "NW_MAARCL024"; break;   //  Delver's Armor
                    case  5 : sArmor = "NW_MAARCL022"; break;   // Elven Ceremonial Armor
                    case  6 : sArmor = "NW_MAARCL062"; break;   // Scales of Truth +3
                    case  7 : sArmor = "NW_MAARCL028"; break;   //  Blue Dragon Armor
                    case  8 : sArmor = "NW_MAARCL063"; break;   // Silverbone Armor +2
                    case  9 : sArmor = "NW_MAARCL027"; break;   // Red Dragon Armor
                    case 10 : sArmor = "NW_MAARCL054"; break;   // Armor of Freedom
                }                        //
                break;
            case 4:
                nRandom = Random(3) + 1;
                switch (nRandom)
                {
                    case 1 : sArmor = "NW_MAARCL027"; break;   // Red Dragon Armor
                    case 2 : sArmor = "NW_MAARCL054"; break;   // Armor of Freedom
                    case 3 : sArmor = "NW_MAARCL025"; break;   // Balduran's Armor
                }                    //
                break;
    }
    CreateItemOnObject(sArmor, oCreateOn, 1);
}
/////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
    void CreateRobes(object oCreateOn, int nTClass)
    {
        int nRandom = 1;
        string sArmor = "";
        switch (nTClass)
        {
            case 1:
                nRandom = Random(7) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MCLOTH012"; break;   //  Conjurer's Robe
                    case  2 : sArmor = "NW_MCLOTH007"; break;   // Robe of Acid Resistance
                    case  3 : sArmor = "NW_MCLOTH008"; break;   // Robe of Cold Resistance
                    case  4 : sArmor = "NW_MCLOTH010"; break;   // Robe of Electrical Resistance
                    case  5 : sArmor = "NW_MCLOTH009"; break;   //  Robe of Fire Resistance
                    case  6 : sArmor = "NW_MCLOTH006"; break;   // Robe of Light
                    case  7 : sArmor = "robesofblurredde"; break;
                }                  //
                break;
            case 2:
                nRandom = Random(7) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MCLOTH013"; break;   //  Mage's Battle Robe
                    case  2 : sArmor = "NW_MCLOTH019"; break;   //  Robes of the Shining Hand +2
                    case  3 : sArmor = "robeofscintillat"; break;   //  Robe of Scintillating Colors
                    case  4 : sArmor = "NW_MCLOTH011"; break;   // Adventurer's Robe
                    case  5 : sArmor = "robeofblending"; break;   //  Robe of Blending
                    case  6 : sArmor = "NW_MCLOTH015"; break;   // Robes of the Old Order
                    case  7 : sArmor = "NW_MCLOTH020"; break;   // Robes of the Shining Hand +3
                }                  //
                break;
            case 3:
                nRandom = Random(6) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MCLOTH017"; break;   //  Robes of the Dark Moon
                    case  2 : sArmor = "NW_MCLOTH021"; break;   // Robes of the Shining Hand +4
                    case  3 : sArmor = "NW_MCLOTH014"; break;   // Greater Battle Robe
                    case  4 : sArmor = "NW_MCLOTH022"; break;   // Robes of the Shining Hand +5
                    case  5 : sArmor = "NW_MCLOTH012"; break;   //  Master Adventurer's Robe
                    case  6 : sArmor = "robeofeyes"; break;   // Robe of Eyes
                }                //
                break;
            case 4:
                nRandom = Random(5) + 1;
                switch (nRandom)
                {
                    case  1 : sArmor = "NW_MCLOTH001"; break;   // Robe of Vecna
                    case  2 : sArmor = "NW_MCLOTH004"; break;   //  Black Robe of the Archmagi
                    case  3 : sArmor = "NW_MCLOTH003"; break;   // Grey Robe of the Archmagi
                    case  4 : sArmor = "NW_MCLOTH002"; break;   // White Robe of the Archmagi
                    case  5 : sArmor = "NW_MCLOTH016"; break;   // Improved Robes of the Old Order
                }                      //
                break;
    }
    CreateItemOnObject(sArmor, oCreateOn, 1);
}
////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
    void CreateShield(object oCreateOn, int nTClass)
    {
        string sArmor = "";int nRandom = 1;
        switch (nTClass)
        {
            case 1:
            nRandom = Random(5);
            switch (nRandom)
            {
                case 1 : sArmor = "NW_ASHMLW002"; break;   //    Large Shield +1
                case 2 : sArmor = "nw_ashmsw011"; break;   //  Shield of the Watch
                case 3 : sArmor = "NW_ASHMSW002"; break;   //  Small Shield +1
                case 4 : sArmor = "NW_ASHMTO002"; break;   // Tower Shield +1
                case 5 : sArmor = "nw_ashmsw010"; break;   // Shield of Dawn;
            }                 //
            break;
            case 2:
            nRandom = Random(13);
            switch (nRandom)
            {
                case  1 : sArmor = "NW_ASHMLW008"; break;   // Large Shield +2
                case  2 : sArmor = "NW_ASHMSW008"; break;   // Small Shield +2
                case  3 : sArmor = "NW_ASHMTO008"; break;   // Tower Shield +2
                case  4 : sArmor = "NW_ASHMTO003"; break;   //  masakari Shield
                case  5 : sArmor = "NW_ASHMSW006"; break;   //   Shield of the Wisp Hunter
                case  6 : sArmor = "NW_ASHMLW009"; break;   //   Large Shield +3
                case  7 : sArmor = "NW_ASHMSW009"; break;   //  Small Shield +3
                case  8 : sArmor = "NW_ASHMTO009"; break;   // Tower Shield +3
                case  9 : sArmor = "NW_ASHMSW005"; break;   //  Dwarven Mirth
                case 10 : sArmor = "NW_ASHMTO005"; break;   //  Goblin Shield of Nulbish
                case 11 : sArmor = "NW_ASHMTO007"; break;   //  Darksteel Tower Shield
                case 12 : sArmor = "nw_ashmto010"; break;   //   Greater Shield of Dawn
                case 13 : sArmor = "NW_ASHMSW004"; break;   // Hearth Shield
            }            //
        break;
        case 3:
            nRandom= Random(5);
            switch (nRandom)
            {
                case  1 : sArmor = "largeshield4"; break;   //  Large Shield +4
                case  2 : sArmor = "smallshield4"; break;   // Small Shield +4
                case  3 : sArmor = "towershield4"; break;   // Tower Shield +4
                case  4 : sArmor = "NW_ASHMLW006"; break;   //Dragon Shield
                case  5 : sArmor = "nw_ashmto011"; break;   // Greater Shield of the Watch
            }                   //
            break;
        case 4:
            nRandom= Random(11);
            switch (nRandom)
            {
                case  1 : sArmor = "largeshield5"; break;   //  Large Shield +5
                case  2 : sArmor = "NW_ASHMLW005"; break;   //  Mirror Shield
                case  3 : sArmor = "NW_ASHMSW003"; break;   //   Protector
                case  4 : sArmor = "NW_ASHMLW004"; break;   //  Shield of the Sun
                case  5 : sArmor = "smallshield5"; break;   //  Small Shield +5
                case  6 : sArmor = "NW_ASHMLW007"; break;   // Uthgardt Holy Shield
                case  7 : sArmor = "NW_ASHMTO006"; break;   //  Hastsezini's Shield
                case  8 : sArmor = "NW_ASHMLW003"; break;   //  Shield of the Holy
                case  9 : sArmor = "towershield5"; break;   //  Tower Shield +5
                case 10 : sArmor = "NW_ASHMTO004"; break;   //  Shield of the Dragonslayer
                case 11 : sArmor = "NW_ASHMSW007"; break;   // Mithral Shield
            }            //
        break;
        }
        CreateItemOnObject (sArmor, oCreateOn, 1);
}
////////////////////////////////////////////////////////////////////////////
//


void CreateGem(object oCreateOn, int nCR)
{
    int nLootOdds = Random (100);
    string sGem = ""; int nGemClass = Random(80) + nCR; int nRandom = 1;
    if (nGemClass < 25)
    {
        nRandom = d3();
        switch (nRandom)
        {
            case 1: sGem = "NW_IT_GEM001"; break;   //  Greenstone  7 gp
            case 2: sGem = "NW_IT_GEM007"; break;   //  Malachite   8 gp
            case 3: sGem = "NW_IT_GEM002"; break;   //  Fire Agate  10 gp
        }
    }
    else if (nGemClass < 50)
    {
        nRandom = d4();
        switch (nRandom)
        {
            case 1: sGem = "NW_IT_GEM014"; break;   //  Aventurine  20
            case 2: sGem = "NW_IT_GEM004"; break;   //  Phenalope   20
            case 3: sGem = "NW_IT_GEM003"; break;   //  Amethyst    40
            case 4: sGem = "NW_IT_GEM015"; break;   //  Fluorspar   50
        }
    }
    else if (nGemClass < 70)
    {
        nRandom = d2();
        switch (nRandom)
        {
            case 1: sGem = "NW_IT_GEM011"; break;   //  Garnet  120
            case 2: sGem = "NW_IT_GEM013"; break;   //  Alexandrite 145
        }
    }
    else if (nGemClass < 90)
    {
        nRandom = 1;
        switch (nRandom)
        {
            case 1: sGem = "NW_IT_GEM010"; break;   //  Topaz   250
        }
    }
    else if (nGemClass < 99)
    {
        nRandom = d2();
        switch (nRandom)
        {
            case 1: sGem = "NW_IT_GEM008"; break;   // Sapphire    1000
            case 2: sGem = "NW_IT_GEM009"; break;   // Fire Opal   1500
        }
    }
    else
    {
        nRandom = d3();
        switch (nRandom)
        {
            case 1: sGem = "NW_IT_GEM005"; break;   //  Diamond 2000
            case 2: sGem = "NW_IT_GEM006"; break;   //  Ruby 3000
            case 3: sGem = "NW_IT_GEM012"; break;   //  Emerald    4000
        }
    }
    CreateItemOnObject (sGem, oCreateOn, 1);
}
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////




void CreateNMClothing (object oCreateOn)
    {
    string sItem; int nRandom = Random(28);
    switch (nRandom)
    {
        case  1 : sItem = "NW_CLOTH027"; break;  // Adept's Tunic
        case  2 : sItem = "NW_CLOTH001"; break;  //  Woodsman's Outfit
        case  3 : sItem = "NW_CLOTH017"; break;  // Assassin's Garb
        case  4 : sItem = "NW_CLOTH015"; break;  //  Barbarian's Outfit
        case  5 : sItem = "NW_CLOTH021"; break;  //  Bard's Tunic
        case  6 : sItem = "NW_CLOTH022"; break;  // Commoner's Outfit
        case  7 : sItem = "NW_CLOTH024"; break;  // Commoner's Tunic
        case  8 : sItem = "NW_CLOTH012"; break;  //  Conjurer's Robe
        case  9 : sItem = "NW_CLOTH011"; break;  //  Gladiator's Outfit
        case 10 : sItem = "NW_CLOTH020"; break;  // Ilusionist's Robe
        case 11 : sItem = "NW_CLOTH014"; break;  //  Jester's Outfit
        case 12 : sItem = "NW_CLOTH016"; break;  //  Monk's Outfit
        case 13 : sItem = "NW_CLOTH026"; break;  //  Necromancer's Robe
        case 14 : sItem = "NW_CLOTH018"; break;  //  Noble Guardsman Tunic
        case 15 : sItem = "NW_CLOTH003"; break;  //  Noble Outfit
        case 16 : sItem = "NW_CLOTH028"; break;  // Noble's Tunic
        case 17 : sItem = "NW_CLOTH010"; break;  //  Paladin's Tunic
        case 18 : sItem = "NW_CLOTH002"; break;  //  Performer's Outfit
        case 19 : sItem = "NW_CLOTH007"; break;  //  Priest's Robe
        case 20 : sItem = "NW_CLOTH004"; break;  // Rogue's Tunic
        case 21 : sItem = "NW_CLOTH019"; break;  // Soldier's Tunic
        case 22 : sItem = "NW_CLOTH008"; break;  //   Sorcerer's Robe
        case 23 : sItem = "NW_CLOTH013"; break;  // Squire's Tunic
        case 24 : sItem = "NW_CLOTH009"; break;  // Urchin Rags
        case 25 : sItem = "NW_CLOTH023"; break;  // Vagabond Rags
        case 26 : sItem = "NW_CLOTH006"; break;  // Veteran's Outfit
        case 27 : sItem = "NW_CLOTH025"; break;  // Warrior's Tunic
        case 28 : sItem = "NW_CLOTH005"; break;  //  Wizard's Robe
    }
    CreateItemOnObject (sItem, oCreateOn, 1);
    }
//////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

void CreateNMArmor (object oCreateOn)
{
    string sItem; int nRandom = Random(28);
    switch (nRandom)
    {
        case  1 : sItem = "NW_AARCL011"; break;  //  Banded Mail
        case  2 : sItem = "NW_AARCL010"; break;  //  Breastplate
        case  3 : sItem = "NW_AARCL012"; break;  // Chain Shirt
        case  4 : sItem = "NW_AARCL004"; break;  // Chainmail
        case  5 : sItem = "NW_AARCL007"; break;  //  Full Plate
        case  6 : sItem = "NW_AARCL006"; break;  // Half Plate
        case  7 : sItem = "NW_AARCL008"; break;  // Hide Armor
        case  8 : sItem = "NW_AARCL001"; break;  //   Leather Armor
        case  9 : sItem = "NW_AARCL009"; break;  //  Padded Armor
        case 10 : sItem = "NW_AARCL003"; break;  //  Scale Mail
        case 11 : sItem = "NW_AARCL005"; break;  //  Splint Mail
        case 12 : sItem = "NW_AARCL002"; break;  //  Studded Leather Armor
        case 13 : sItem = "NW_ASHLW001"; break;  // Large Shield
        case 14 : sItem = "NW_ASHSW001"; break;  //  Small Shield
        case 15 : sItem = "NW_ASHTO001"; break;  //  Tower Shield
        case 16 : sItem = "NW_ARHE004"; break;  // Horse Hair Helmet
        case 17 : sItem = "NW_ARHE001"; break;  // Pot Helmet
        case 18 : sItem = "NW_ARHE002"; break;  //  Spike Helmet
        case 19 : sItem = "NW_ARHE005"; break;  //  Stag Helmet
        case 20 : sItem = "NW_ARHE003"; break;  // Winged Helmet
    }
    CreateItemOnObject (sItem, oCreateOn, 1);
}
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

void CreateNMWeapon (object oCreateOn)
{
    string sItem; int nRandom = Random(33);
    switch (nRandom)
    {
        case  1 : sItem = "NW_WSWBS001"; break;  //  Bastard Sword
        case  2 : sItem = "NW_WAXBT001"; break;  //  Battleaxe
        case  3 : sItem = "NW_WBLCL001"; break;  //   Club
        case  4 : sItem = "NW_WSWDG001"; break;  //   Dagger
        case  5 : sItem = "NW_WDBMA001"; break;  // Dire Mace
        case  6 : sItem = "NW_WDBAX001"; break;  //  Double Axe
        case  7 : sItem = "NW_WAXGR001"; break;  // Greataxe
        case  8 : sItem = "NW_WSWGS001"; break;  //   Greatsword
        case  9 : sItem = "NW_WPLHB001"; break;  //  Halberd
        case 10 : sItem = "NW_WAXHN001"; break;  //  Handaxe
        case 11 : sItem = "NW_WBLFH001"; break;  //   Heavy Flail
        case 12 : sItem = "NW_WSPKA001"; break;  //     Kama
        case 13 : sItem = "NW_WSWKA001"; break;  //  Katana
        case 14 : sItem = "NW_WSPKU001"; break;  //   Kukri
        case 15 : sItem = "NW_WBLFL001"; break;  // Light Flail
        case 16 : sItem = "NW_WBLHL001"; break;  // Light Hammer
        case 17 : sItem = "NW_WSWLS001"; break;  //   Longsword
        case 18 : sItem = "NW_WBLML001"; break;  // Mace
        case 19 : sItem = "NW_WBLMS001"; break;  // Morningstar
        case 20 : sItem = "NW_WDBQS001"; break;  //  Quarterstaff
        case 21 : sItem = "NW_WSWRP001"; break;  //   Rapier
        case 22 : sItem = "NW_WSWSC001"; break;  //  Scimitar
        case 23 : sItem = "NW_WPLSC001"; break;  // Scythe
        case 24 : sItem = "NW_WSWSS001"; break;  //    Short Sword
        case 25 : sItem = "NW_WSPSC001"; break;  // Sickle
        case 26 : sItem = "NW_WPLSS001"; break;  //  Spear
        case 27 : sItem = "NW_WDBSW001"; break;  // Two Bladed Sword
        case 28 : sItem = "NW_WBLHW001"; break;  // War Hammer
        case 29 : sItem = "NW_WBWXH001"; break;  // Heavy Crossbow
        case 30 : sItem = "NW_WBWXL001"; break;  // Light Crossbow
        case 31 : sItem = "NW_WBWLN001"; break;  //  Longbow
        case 32 : sItem = "NW_WBWSH001"; break;  //  Shortbow
        case 33 : sItem = "NW_WBWSL001"; break;  //  Sling
        }
        CreateItemOnObject (sItem, oCreateOn, 1);
}
///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
    void CreateNMAmmo (object oCreateOn)
    {
        string sItem = ""; int nRandom = (6);
        switch (nRandom)
        {
            case 1 : sItem = "NW_WAMAR001"; break;  //  Arrow
            case 2 : sItem = "NW_WAMBO001"; break;  //  Bolt
            case 3 : sItem = "NW_WAMBU001"; break;  //  Bullet
            case 4 : sItem = "NW_WTHDT001"; break;  //  Dart
            case 5 : sItem = "NW_WTHSH001"; break;  //  Shuriken
            case 6 : sItem = "NW_WTHAX001"; break;  //  Throwing Axe
        }
        CreateItemOnObject (sItem, oCreateOn, d6(6));
    }
//////////////////////////////////////////////////////////////////////////////////
    void CreateJunk (object oCreateOn)
    {
        string sItem = ""; int nRandom = (17);
        switch (nRandom)
        {
        case  1 : sItem = "NW_IT_MSMLMISC16"; break;  // Adamantine
        case  2 : sItem = "NW_IT_MPOTION021"; break;  // Ale
        case  3 : sItem = "NW_IT_MSMLMISC23"; break;  // Belladonna
        case  4 : sItem = "NW_IT_THNMISC002"; break;  // Empty Ale Stein
        case  5 : sItem = "NW_IT_THNMISC001"; break;  // Empty Bottle
        case  6 : sItem = "NW_IT_THNMISC003"; break;  // Empty Spirits Bottle
        case  7 : sItem = "NW_IT_THNMISC004"; break;  // Empty Wine Bottle
        case  8 : sItem = "NW_IT_MSMLMISC24"; break;  // Garlic
        case  9 : sItem = "NW_IT_MSMLMISC18"; break;  // Ironwood
        case 10 : sItem = "NW_IT_CONTAIN001"; break;  // Large Box
        case 11 : sItem = "NW_IT_MSMLMISC11"; break;  // Quartz Crystal
        case 12 : sItem = "NW_IT_MSMLMISC21"; break;  // Rags
        case 13 : sItem = "NW_IT_MPOTION022"; break;  // Spirits
        case 14 : sItem = "NW_IT_MSMLMISC22"; break;  // Top
        case 15 : sItem = "NW_IT_TORCH001"; break;    // Torch
        case 16 : sItem = "NW_IT_MPOTION023"; break;  // Wine
        case 17 : sItem = "windwalkerstale"; break; // Windwalker's Tale
        }
        CreateItemOnObject (sItem, oCreateOn, 1);
    }

/////CREATE A BOOK ////////////////////////////////////////
////////This section is copied directly out of ////////////////////
////////////nw_o2_coinclude by Bioware///////////////////////////////
///////////////////////////////////////////////////////////////////

    void CreateBook(object oCreateOn)                               //
    {                                                             //
        int nBook1 = Random(31) + 1;                              //
        string sRes = "NW_IT_BOOK01";                             //
                                                                  //
        if (nBook1 < 10)                                          //
        {                                                         //
            sRes = "NW_IT_BOOK00" + IntToString(nBook1);          //
        }                                                         //
        else                                                      //
        {                                                         //
            sRes = "NW_IT_BOOK0" + IntToString(nBook1);           //
        }                                                         //
        CreateItemOnObject(sRes, oCreateOn);                        //
    }                                                            //
////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
/////////Generate a Kit (Healing, Trap or Lockpick///////////////////
/////////Copied from nw_o2_coinclude by BioWare////////////////////////
///////////////////////////////////////////////////////////////////////
//////////////DETERMINE WHAT KIT TO MAKE/////////////////
void GenerateKit(object oCreateOn, int nCR)
    {
        switch (Random(8) + 1)
        {
            case 1: CreateTrapKit(oCreateOn, nCR); break;
            case 2: case 3: case 4: case 5: CreateHealingKit(oCreateOn, nCR); break;
            case 6: case 7: case 8: CreateLockPick(oCreateOn, nCR); break;
        }
    }

/////////////CREATE TRAP KIT////////////////////////////////
void CreateTrapKit(object oCreateOn, int nCR)
    {
        string sKit = "";  int nRandom = 1;
        int nRange = nCR / 4 + 1;
        switch (nRange)
        {
            case 1:
                nRandom = Random(11);
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_trap033";    break;  // Minor Acid Splash
                    case 2: sKit = "nw_it_trap013";    break; //  Minor Blob of Acid
                    case 3: sKit = "nw_it_trap021";    break; // Minor Electrical
                    case 4: sKit = "nw_it_trap017";    break; // Minor Fire
                    case 5: sKit = "nw_it_trap029";    break; // Minor Frost
                    case 6: sKit = "nw_it_trap025";    break; // Minor Gas
                    case 7: sKit = "nw_it_trap005";   break;  // Minor Holy
                    case 8: sKit = "nw_it_trap041";   break;  // Minor Negative
                    case 9: sKit = "nw_it_trap037";   break;  // Minor Sonic
                    case 10: sKit = "nw_it_trap001";   break; // Minor Spike
                    case 11: sKit = "nw_it_trap009";    break;// Minor Tangle Trap
                }
                break;
            case 2:
                nRandom = Random(11) + 1;
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_trap034";  break; // Average Traps (same order)
                    case 2: sKit = "nw_it_trap014";  break;
                    case 3: sKit = "nw_it_trap022";  break;
                    case 4: sKit = "nw_it_trap018";   break;
                    case 5: sKit = "nw_it_trap030";  break;
                    case 6: sKit = "nw_it_trap026";   break;
                    case 7: sKit = "nw_it_trap006";   break;
                    case 8: sKit = "nw_it_trap042";   break;
                    case 9: sKit = "nw_it_trap038";   break;
                    case 10: sKit = "nw_it_trap002";   break;
                    case 11: sKit = "nw_it_trap010";   break;
                }
                break;
            case 3:
                nRandom = Random(11) + 1;
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_trap035";  break; // Strong Traps (same order)
                    case 2: sKit = "nw_it_trap015";  break;
                    case 3: sKit = "nw_it_trap023";  break;
                    case 4: sKit = "nw_it_trap019";   break;
                    case 5: sKit = "nw_it_trap031";   break;
                    case 6: sKit = "nw_it_trap027";   break;
                    case 7: sKit = "nw_it_trap007";   break;
                    case 8: sKit = "nw_it_trap043";   break;
                    case 9: sKit = "nw_it_trap039";   break;
                    case 10: sKit = "nw_it_trap003";  break;
                    case 11: sKit = "nw_it_trap011";  break;
                }
                break;
            default:
                nRandom = Random(11) + 1;
                switch (nRandom)
                {
                    case 1:  sKit = "nw_it_trap036";  break; // Deadly Traps (same order)
                    case 2:  sKit = "nw_it_trap016";  break;
                    case 3:  sKit = "nw_it_trap024";  break;
                    case 4:  sKit = "nw_it_trap020";  break;
                    case 5:  sKit = "nw_it_trap032";  break;
                    case 6:  sKit = "nw_it_trap028";  break;
                    case 7:  sKit = "nw_it_trap008";  break;
                    case 8:  sKit = "nw_it_trap044";  break;
                    case 9:  sKit = "nw_it_trap040";  break;
                    case 10: sKit = "nw_it_trap004";  break;
                    case 11: sKit = "nw_it_trap012";  break;
                }
                break;
        }
        CreateItemOnObject(sKit, oCreateOn, 1);
    }

    ///////////////////CREATE A HEALING KIT/////////////////////////
    void CreateHealingKit(object oCreateOn, int nCR)
    {
        string sKit = ""; int nRandom = 1;
        int nRange = nCR / 4 + 1;
        switch (nRange)
        {
            case 1:
                nRandom = Random(1) + 1;
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_medkit001";  break;
                }
                break;
            case 2:
                nRandom = Random(2) + 1;
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_medkit001";  break;
                    case 2: sKit = "nw_it_medkit002";  break;
                }
                break;
            case 3:
                nRandom = Random(2) + 1;
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_medkit002"; break;
                    case 2: sKit = "nw_it_medkit003";  break;
                }
                break;
            default:
                nRandom = Random(2) + 1;
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_medkit003";break;
                    case 2: sKit = "nw_it_medkit004"; break;
                }
                break;
      }
      CreateItemOnObject(sKit, oCreateOn, 1);
}
    /////////////////CREATE A LOCKPICK///////////////////////////
    void CreateLockPick(object oCreateOn, int nCR)
    {
        string sKit = "";int nRandom = 1;
        int nRange = nCR / 4 + 1;
        switch (nRange)
        {
            case 1:
                nRandom = d3();
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_picks001";   break;   //+1 Lockpicks
                    case 2: sKit = "nw_it_picks002";   break;   //+3 Lockpicks
                    case 3: sKit = "nw_it_picks001";   break;   //+1 Lockpicks
                }
                break;
            case 2:
                nRandom = d4();
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_picks001";   break;   //+1 Lockpicks
                    case 2: sKit = "nw_it_picks002";    break;  //+3 Lockpick
                    case 3: sKit = "nw_it_picks002";   break;   //+3 Lockpick
                    case 4: sKit = "nw_it_picks003";    break;  //+6 Lockpicks
                }
                break;
            case 3:
                nRandom = d6();
                switch (nRandom)
                {
                    case 1:  sKit = "nw_it_picks001";  break;   //+1 Lockpick
                    case 2:  sKit = "nw_it_picks002";    break; //+3 Lockpick
                    case 3:  sKit = "nw_it_picks002";    break; //+3 Lockpick
                    case 4:  sKit = "nw_it_picks003";  break;   //+6 Lockpicks
                    case 5:  sKit = "nw_it_picks003";  break;   //+6 Lockpicks
                    case 6:  sKit = "nw_it_picks004";  break;   //+10 Lockpicks
                }
                break;
            default:
                nRandom = d6();
                switch (nRandom)
                {
                    case 1: sKit = "nw_it_picks002";  break;    //+3 Lockpick
                    case 2: sKit = "nw_it_picks002";  break;    //+3 Lockpick
                    case 3: sKit = "nw_it_picks003";  break;    //+6 Lockpicks
                    case 4: sKit = "nw_it_picks003";  break;    //+6 Lockpicks
                    case 5: sKit = "nw_it_picks004";  break;    //+10 Lockpicks
                    case 6: sKit = "nw_it_picks004";  break;    //+10 Lockpicks
                }
                break;
    }
    CreateItemOnObject(sKit, oCreateOn, 1);
}

//void main() {}   //Used for compiling to test program.  Should be commented out for use.
