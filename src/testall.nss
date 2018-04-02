#include "sy_t_magic"

//////////////////////////////////////////////////////////////////////////////
//////TestAll is a testing script designed to test the generation scripts.////
///////////////////////////////////////////////////////////////////////////////
// This script will generate one item for each of the following functions. ///
///////////////////////////////////////////////////////////////////////////////

void main()
{
if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
    object oCreateOn = OBJECT_SELF;
  int nTClass = 4;       ///Choose the Treasure Class to test: 1) minor, 2) medium, 3) major, 4) epic.
  int nCR = 20;          ///Choose the CR to test: 1 - 20.
  int nTModifier = 6;    ///Choose the Treasure Modifier to test: Poor = 2; standard = 6; rich = 10.
  CreateArcaneScroll( oCreateOn,nTClass);      //Arcane Scroll//
  CreateDivineScroll(oCreateOn, nTClass);      //Divine Scroll//
  GenerateExhRange(oCreateOn, nTClass); //Ammo and Thrown Weapons
      CreateAmmo (oCreateOn, nTClass);            //Ammunition//
      CreateThrown (oCreateOn, nTClass);//Throwing Hammers, Darts and Shuriken//
      CreatePotion(oCreateOn, nTClass);              //Potions//
  CreateRing (oCreateOn, nTClass);                    //Rings//
  CreateAmulet (oCreateOn, nTClass);                 //Amulets//
  CreateMisc (oCreateOn, nTClass);       //Miscellaneous Items//
  CreateWand (oCreateOn, nTClass);     //Rods, Staves and Wands//
  CreateGarb (oCreateOn, nTClass);                      //Garb//
    CreateBelt  (oCreateOn, nTClass);
    CreateBoots (oCreateOn, nTClass);
    CreateCloak (oCreateOn, nTClass);
    CreateHands (oCreateOn, nTClass);
    CreateHelm (oCreateOn, nTClass);
  CreateWeapon (oCreateOn,   nTClass);                  //Weapon//
      CreateBasicMeleeWeapon(oCreateOn,   nTClass);   //+x Weapons//
      CreateSpecialMeleeWeapon(oCreateOn,   nTClass);//w/abilities//
      CreateBasicRangeWeapon(  oCreateOn,    nTClass);  //+x Weapons//
      CreateSpecialRangeWeapon(  oCreateOn,   nTClass);//w/abilities//
  CreateArmor (  oCreateOn,   nTClass);                    //Armor//
      CreateLightArmor(  oCreateOn,   nTClass);                   //
      CreateMediumArmor(  oCreateOn,   nTClass);                  //
      CreateHeavyArmor(  oCreateOn,   nTClass);                   //
      CreateRobes(  oCreateOn,   nTClass);                        //
      CreateShield(  oCreateOn,   nTClass);                       //
  CreateGold(  oCreateOn,   nCR,   nTModifier);             //Gold//
  CreateGem(  oCreateOn,   nCR);                              //Gems//
  CreateNMClothing (  oCreateOn);                 //Non-magic clothing//
  CreateNMArmor (  oCreateOn);                     //Non-magical armor//
  CreateNMWeapon (  oCreateOn);                  //Non-magical weapons//
  CreateNMAmmo (  oCreateOn);  //Non-magical ammo and throwing weapons//
  CreateJunk (  oCreateOn);          //Miscellaneous non-magical stuff//
  CreateBook (  oCreateOn);                          //BioWare's Books//
  GenerateKit(  oCreateOn,   nTClass);                              //
      CreateTrapKit(  oCreateOn,   nCR);                     //Traps//
      CreateHealingKit(  oCreateOn,   nCR);   //BioWare Healing Kits//
      CreateLockPick(  oCreateOn,   nCR);        //BioWare Lockpicks//

SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    }

