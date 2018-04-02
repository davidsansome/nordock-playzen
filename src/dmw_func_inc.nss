//------------------------------------------------------------------------------
//
// dmw_func_inc
//
// Useful functions for the DM's Helper
//
//------------------------------------------------------------------------------
//
// Created By:    xxxxx
// Created On:    xx-xx-xxxx
//
// Altered By:    Michael Tuffin [Grug]
// Altered On:    22-12-2003
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
// - Commented out lines that included constants that no longer exist
//
// Version: 000 (Anything previous to 22-12-2003)
// - None
//
//------------------------------------------------------------------------------

#include "dmw_proto_inc"

//------------------------------------------------------------------------------

void dmwand_AbilityCheck(int nAbility, int nSecret = TRUE)
{
   int nRoll=d20();
   int nRank=GetAbilityModifier (nAbility, oMyTarget);
   int nResult=nRoll+nRank;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);
   string sAbility;

   switch(nAbility)
   {
      case ABILITY_CHARISMA:
         sAbility = "Charisma"; break;
      case ABILITY_CONSTITUTION:
         sAbility = "Constitution"; break;
      case ABILITY_DEXTERITY:
         sAbility = "Dexterity"; break;
      case ABILITY_INTELLIGENCE:
         sAbility = "Intelligence"; break;
      case ABILITY_STRENGTH:
         sAbility = "Strength"; break;
      case ABILITY_WISDOM:
         sAbility = "Wisdom"; break;
   }

   SendMessageToPC(oMySpeaker, GetName(oMyTarget)+"'s "+sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult);

   if (!nSecret)
   {
      AssignCommand( oMyTarget, SpeakString(sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
   }
}

void dmwand_AdvanceTime(int nHours)
{
   int nCurrentHour = GetTimeHour();
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   nCurrentHour += nHours;
   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
   dmwand_BuildConversation("TimeOfDay", "");
}

string dmwand_Alignment(object oEntity)
{
   string sReturnString;

   switch (GetAlignmentLawChaos(oEntity))
   {
      case ALIGNMENT_LAWFUL:   sReturnString = "Lawful "; break;
      case ALIGNMENT_NEUTRAL: sReturnString = "Neutral "; break;
      case ALIGNMENT_CHAOTIC:   sReturnString = "Chaotic ";  break;
   }

   switch (GetAlignmentGoodEvil(oEntity))
   {
      case ALIGNMENT_GOOD:   sReturnString = sReturnString + "Good"; break;
      case ALIGNMENT_NEUTRAL: sReturnString = sReturnString +  "Neutral"; break;
      case ALIGNMENT_EVIL:   sReturnString = sReturnString +  "Evil";  break;
   }

   if (sReturnString == "Neutral Neutral"){sReturnString = "True Neutral";}

   return sReturnString;
}

string dmwand_ClassLevel(object oEntity)
{
   string sReturnString;
   string sClass;
   string sClassOne;
   string sClassTwo;
   string sClassThree;
   int nLevelOne;
   int nLevelTwo;
   int nLevelThree;
   int iIndex;

   // Loop through all three classes and pull out info
   for(iIndex == 1;iIndex < 4;iIndex++)
   {
      switch (GetClassByPosition(iIndex,oEntity))
      {
         case CLASS_TYPE_ABERRATION: sClass ="Aberration";break;
         case CLASS_TYPE_ANIMAL:     sClass ="Animal"; break;
         case CLASS_TYPE_BARBARIAN:  sClass ="Barbarian";break;
         case CLASS_TYPE_BARD:         sClass ="Bard"; break;
         case CLASS_TYPE_BEAST:        sClass ="Beast"; break;
         case CLASS_TYPE_CLERIC:       sClass ="Cleric"; break;
         case CLASS_TYPE_COMMONER:     sClass ="Commoner";break;
         case CLASS_TYPE_CONSTRUCT:    sClass ="Construct"; break;
         case CLASS_TYPE_DRAGON:       sClass ="Dragon"; break;
         case CLASS_TYPE_DRUID:        sClass ="Druid";break;
         case CLASS_TYPE_ELEMENTAL:    sClass ="Elemental"; break;
         case CLASS_TYPE_FEY:          sClass ="Fey";break;
         case CLASS_TYPE_FIGHTER:      sClass ="Fighter";  break;
         case CLASS_TYPE_GIANT:        sClass ="Giant";  break;
         case CLASS_TYPE_HUMANOID:     sClass ="Humanoid"; break;
         case CLASS_TYPE_INVALID:      sClass ="";break;
         case CLASS_TYPE_MAGICAL_BEAST:sClass ="Magical Beast"; break;
         case CLASS_TYPE_MONK:         sClass ="Monk";   break;
         case CLASS_TYPE_OUTSIDER:     sClass ="Outsider"; break;
         case CLASS_TYPE_MONSTROUS:    sClass ="Monstrous"; break;
         case CLASS_TYPE_PALADIN:      sClass ="Paladin";break;
         case CLASS_TYPE_RANGER:       sClass ="Ranger";break;
         case CLASS_TYPE_ROGUE:        sClass ="Rogue";break;
         case CLASS_TYPE_SHAPECHANGER: sClass ="Shapechanger";break;
         case CLASS_TYPE_SORCERER:     sClass ="Sorcerer";break;
         case CLASS_TYPE_UNDEAD:       sClass ="Undead";break;
         case CLASS_TYPE_VERMIN:       sClass ="Vermin"; break;
         case CLASS_TYPE_WIZARD:       sClass ="Wizard"; break;
      }

      // Now depending on which iteration we just went through
      // assign it to the proper class
      switch (iIndex)
      {
         case 1: sClassOne =   sClass;  break;
         case 2: sClassTwo =   sClass;  break;
         case 3: sClassThree = sClass;  break;
      }
   };

   // Now get all three class levels.  Wil be 0 if does class pos
   //does not exists
   nLevelOne =   GetLevelByPosition(1,oEntity);
   nLevelTwo =   GetLevelByPosition(2,oEntity);
   nLevelThree = GetLevelByPosition(3,oEntity);

   //Start building return string
   sReturnString = sClassOne + "(" + IntToString(nLevelOne) + ")" ;

   //If second class exists append to return string
   if(nLevelTwo > 0)
   {
      sReturnString =sReturnString + "/" + sClassTwo + "(" + IntToString(nLevelTwo) + ")";
   }

   //If third class exists append to return string
   if(nLevelThree > 0)
   {
      sReturnString =sReturnString + "/" + sClassThree + "(" + IntToString(nLevelThree) + ")";
   }

   return sReturnString;
}

void dmwand_DestroyItem()
{
   object oItem = GetLocalObject(oMySpeaker, "dmw_item");

   if(GetIsObjectValid(oItem))
   {
      DestroyObject(oItem);
   }
   dmwand_BuildConversation("ListInventory", "");
}

void dmwand_DestroyNearbyTarget()
{
   effect eDestroy = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      DestroyObject(oMyTest);
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDestroy, lMyLoc);
   }
   dmwand_BuildConversation("Start", "");
}

void dmwand_DestroyTarget()
{
   effect eDestroy = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

   DestroyObject(oMyTarget);
   ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDestroy, lMyLoc);
   dmwand_BuildConversation("Start", "");
}

void dmwand_ExportChars()
{
   ExportAllCharacters();

    // ===== This is code for fixing shifters =====
    object oPCSF = GetFirstPC();
    while ( GetIsObjectValid(oPCSF) ) // Loop through all the Players
    {
        if ( GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCSF)) )
            DelayCommand(0.1, ExecuteScript("ws_saveall_sub", oPCSF));
            // We HAVE to use DelayCommand here or else properties will not carry over no matter what you do.

        oPCSF = GetNextPC();
    } // while
}

void dmwand_FollowMe()
{
   AssignCommand ( oMyTarget, ActionForceFollowObject( oMySpeaker));
}

void dmwand_FollowTarget()
{
      AssignCommand ( oMySpeaker, ActionForceFollowObject(oMyTarget));
}

string dmwand_Gender(object oEntity)
{
   switch (GetGender(oEntity))
   {
      case GENDER_MALE:   return "Male"; break;
      case GENDER_FEMALE: return "Female"; break;
      case GENDER_BOTH:   return "Both";  break;
      case GENDER_NONE:   return "None";  break;
      case GENDER_OTHER:  return "Other";  break;
   }

   return "Wierdo";
}

void dmwand_IdentifyItem()
{
   object oItem = GetLocalObject(oMySpeaker, "dmw_item");

   if(GetIsObjectValid(oItem))
   {
      SetIdentified(oItem, (GetIdentified(oItem)?FALSE:TRUE));
   }
   dmwand_BuildConversation("ItemListConv", "");
}

string dmwand_Inventory(object oEntity)
{

   string sBaseType;
   string sReturnString;

   object oItem = GetFirstItemInInventory(oEntity);

   while(oItem != OBJECT_INVALID)
   {
      sReturnString = sReturnString + "\n" + dmwand_ItemInfo(oItem, 0);
      oItem = GetNextItemInInventory(oEntity);
   };

   sReturnString = sReturnString + "\nEquipped:\n";
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget))){ sReturnString = sReturnString + "Arms: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget))){ sReturnString = sReturnString + "Belt: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget))){ sReturnString = sReturnString + "Boots: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget))){ sReturnString = sReturnString + "Chest: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget))){ sReturnString = sReturnString + "Cloak: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget))){ sReturnString = sReturnString + "Head" + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget))){ sReturnString = sReturnString + "Left Hand: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget))){ sReturnString = sReturnString + "Left Ring: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget))){ sReturnString = sReturnString + "Neck: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget))){ sReturnString = sReturnString + "Right Hand: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget))){ sReturnString = sReturnString + "Right Ring: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget))){ sReturnString = sReturnString + "Arrows: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget))){ sReturnString = sReturnString + "Bolts: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget))){ sReturnString = sReturnString + "Bullets" + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oMyTarget))){ sReturnString = sReturnString + "Creature Armor: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oMyTarget))){ sReturnString = sReturnString + "Creature Bite: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oMyTarget))){ sReturnString = sReturnString + "Creature Left: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oMyTarget))){ sReturnString = sReturnString + "Creature Right: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oMyTarget),0) + "\n"; }

   return sReturnString;
}

string dmwand_ItemInfo(object oItem, int nLongForm = 0)
{
   string sReturnString = "";
   string sBaseType = "";
   string sStacked = "";
   string sIdentified = "";
   string sGPValue = "";
   string sACValue = "";
   string sProperties = "";

   switch(GetBaseItemType(oItem))
   {
      case BASE_ITEM_AMULET: sBaseType ="Amulet";break;
      case BASE_ITEM_ARMOR: sBaseType ="Armor";break;
      case BASE_ITEM_ARROW: sBaseType ="Arrow";break;
      case BASE_ITEM_BASTARDSWORD: sBaseType ="Bastard Sword";break;
      case BASE_ITEM_BATTLEAXE: sBaseType ="Battle Axe";break;
      case BASE_ITEM_BELT: sBaseType ="Belt";break;
      case BASE_ITEM_BOLT : sBaseType ="Bolt";break;
      case BASE_ITEM_BOOK: sBaseType ="Book";break;
      case BASE_ITEM_BOOTS: sBaseType ="Boots";break;
      case BASE_ITEM_BRACER: sBaseType ="Bracer";break;
      case BASE_ITEM_BULLET: sBaseType ="Bullet";break;
      case BASE_ITEM_CBLUDGWEAPON: sBaseType ="Bludgeoning Weap.";break;
      case BASE_ITEM_CLOAK: sBaseType ="Cloak";break;
      case BASE_ITEM_CLUB: sBaseType ="Club";break;
      case BASE_ITEM_CPIERCWEAPON: sBaseType ="Pierceing Weap.";break;
      case BASE_ITEM_CREATUREITEM: sBaseType ="Creature Item";break;
      case BASE_ITEM_CSLASHWEAPON: sBaseType ="Slash Weap.";break;
      case BASE_ITEM_CSLSHPRCWEAP: sBaseType ="Slash/Pierce Weap.";break;
      case BASE_ITEM_DAGGER: sBaseType ="Dagger";break;
      case BASE_ITEM_DART: sBaseType ="Dart";break;
      case BASE_ITEM_DIREMACE: sBaseType ="Mace";break;
      case BASE_ITEM_DOUBLEAXE: sBaseType ="Double Axe";break;
      case BASE_ITEM_GEM: sBaseType ="Gem";break;
      case BASE_ITEM_GLOVES: sBaseType ="Gloves";break;
      case BASE_ITEM_GOLD: sBaseType ="Gold";break;
      case BASE_ITEM_GREATAXE: sBaseType ="Great Axe";break;
      case BASE_ITEM_GREATSWORD: sBaseType ="Great Sword";break;
      case BASE_ITEM_HALBERD: sBaseType ="Halberd";break;
      case BASE_ITEM_HANDAXE: sBaseType ="Hand Axe";break;
      case BASE_ITEM_HEALERSKIT: sBaseType ="Healers Kit";break;
      case BASE_ITEM_HEAVYCROSSBOW: sBaseType ="Heavy Xbow";break;
      case BASE_ITEM_HEAVYFLAIL: sBaseType ="Heavy Flail";break;
      case BASE_ITEM_HELMET: sBaseType ="Helmet";break;
      case BASE_ITEM_INVALID: sBaseType ="";break;
      case BASE_ITEM_KAMA: sBaseType ="Kama";break;
      case BASE_ITEM_KATANA: sBaseType ="Katana";break;
      case BASE_ITEM_KEY: sBaseType ="Key";break;
      case BASE_ITEM_KUKRI: sBaseType ="Kukri";break;
      case BASE_ITEM_LARGEBOX: sBaseType ="Large Box";break;
      case BASE_ITEM_LARGESHIELD: sBaseType ="Large Shield";break;
      case BASE_ITEM_LIGHTCROSSBOW: sBaseType ="Light Xbow";break;
      case BASE_ITEM_LIGHTFLAIL: sBaseType ="Light Flail";break;
      case BASE_ITEM_LIGHTHAMMER: sBaseType ="Light Hammer";break;
      case BASE_ITEM_LIGHTMACE: sBaseType ="Light Mace";break;
      case BASE_ITEM_LONGBOW: sBaseType ="Long Bow";break;
      case BASE_ITEM_LONGSWORD: sBaseType ="Long Sword";break;
      case BASE_ITEM_MAGICROD: sBaseType ="Magic Rod";break;
      case BASE_ITEM_MAGICSTAFF: sBaseType ="Magic Staff";break;
      case BASE_ITEM_MAGICWAND: sBaseType ="Magic Wand";break;
      case BASE_ITEM_MISCLARGE: sBaseType ="Misc. Large";break;
      case BASE_ITEM_MISCMEDIUM: sBaseType ="Misc. Medium";break;
      case BASE_ITEM_MISCSMALL: sBaseType ="Misc. Small";break;
      case BASE_ITEM_MISCTALL: sBaseType ="Misc. Small";break;
      case BASE_ITEM_MISCTHIN: sBaseType ="Misc. Thin";break;
      case BASE_ITEM_MISCWIDE: sBaseType ="Misc. Wide";break;
      case BASE_ITEM_MORNINGSTAR: sBaseType ="Morningstar";break;
      case BASE_ITEM_POTIONS: sBaseType ="Potion";break;
      case BASE_ITEM_QUARTERSTAFF: sBaseType ="Quarterstaff";break;
      case BASE_ITEM_RAPIER: sBaseType ="Rapier";break;
      case BASE_ITEM_RING: sBaseType ="Ring";break;
      case BASE_ITEM_SCIMITAR: sBaseType ="Scimitar";break;
      case BASE_ITEM_SCROLL: sBaseType ="Scroll";break;
      case BASE_ITEM_SCYTHE: sBaseType ="Scythe";break;
      case BASE_ITEM_SHORTBOW: sBaseType ="Shortbow";break;
      case BASE_ITEM_SHORTSPEAR: sBaseType ="Short Spear";break;
      case BASE_ITEM_SHORTSWORD: sBaseType ="Short Sword";break;
      case BASE_ITEM_SHURIKEN: sBaseType ="Shuriken";break;
      case BASE_ITEM_SICKLE: sBaseType ="Sickle";break;
      case BASE_ITEM_SLING: sBaseType ="Sling";break;
      case BASE_ITEM_SMALLSHIELD: sBaseType ="Small Shield";break;
      case BASE_ITEM_SPELLSCROLL: sBaseType ="Spell Scroll";break;
      case BASE_ITEM_THIEVESTOOLS: sBaseType ="Thieves Tools";break;
      case BASE_ITEM_THROWINGAXE: sBaseType ="Throwing Axe";break;
      case BASE_ITEM_TORCH: sBaseType ="Torch";break;
      case BASE_ITEM_TOWERSHIELD: sBaseType ="Tower Shield";break;
      case BASE_ITEM_TRAPKIT: sBaseType ="Trap Kit";break;
      case BASE_ITEM_TWOBLADEDSWORD: sBaseType ="2 Bladed Sword";break;
      case BASE_ITEM_WARHAMMER: sBaseType ="Warhammer";break;
   }

   if (sBaseType != "Gold")
   {
      // If more than one item (stacked)
      if (GetNumStackedItems(oItem) > 1 )
      {
         sStacked = "(" + IntToString(GetNumStackedItems(oItem)) + ") ";
      }
      else
      {
         // Build remainder of output string
         sStacked = "";
      }
   }

   if(nLongForm)
   {
      sIdentified = "Identified: " + ((GetIdentified(oItem))?"Yes":"No");
      sGPValue = "Gold Piece Value: " + IntToString(GetGoldPieceValue(oItem));
      int nACValue = GetItemACValue(oItem);
      if(nACValue) { sACValue = "AC: " + IntToString(nACValue); }

      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ABILITY_BONUS)) { sProperties = sProperties + "Ability Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS)) { sProperties = sProperties + "AC Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "AC Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)) { sProperties = sProperties + "AC Bonus vs. Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "AC Bonus vs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "AC Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS)) { sProperties = sProperties + "Attack Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "Attack Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "Attack Bonusvs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "Attack Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)) { sProperties = sProperties + "Weight Reduction\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BONUS_FEAT)) { sProperties = sProperties + "Bonus Feat\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)) { sProperties = sProperties + "Bonus Spell Slot\n"; }
//      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BOOMERANG)) { sProperties = sProperties + "Boomerang\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL)) { sProperties = sProperties + "Cast Spell\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS)) { sProperties = sProperties + "Damage Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "Damage Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "Damage Bonus vs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "Damage Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_REDUCTION)) { sProperties = sProperties + "Damage Reduction\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_RESISTANCE)) { sProperties = sProperties + "Damage Resistance\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_VULNERABILITY)) { sProperties = sProperties + "Damage Vulnerability\n"; }
//      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DANCING)) { sProperties = sProperties + "Dancing\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DARKVISION)) { sProperties = sProperties + "Darkvision\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_ABILITY_SCORE)) { sProperties = sProperties + "Decreased Ability\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_AC)) { sProperties = sProperties + "Decreased AC\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER)) { sProperties = sProperties + "Decreased Attack Modifier\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_DAMAGE)) { sProperties = sProperties + "Decreased Damage\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER)) { sProperties = sProperties + "Decreased Enhancement Modifier\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_SAVING_THROWS)) { sProperties = sProperties + "Decreased Saving Throws\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC)) { sProperties = sProperties + "Decreased Specific Saving Throw\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)) { sProperties = sProperties + "Decreased Skill Modifier\n"; }
//      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DOUBLE_STACK)) { sProperties = sProperties + "Double Stack\n"; }
//      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCED_CONTAINER_BONUS_SLOTS)) { sProperties = sProperties + "Enhanced Container Bonus Slots\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)) { sProperties = sProperties + "Enhanced Container Reduced Weight\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS)) { sProperties = sProperties + "Enhancement Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "Enhancement Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "Enhancement Bonus vs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)) { sProperties = sProperties + "Enhancement Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)) { sProperties = sProperties + "Extra Melee Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)) { sProperties = sProperties + "Extra Ranged Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)) { sProperties = sProperties + "Freedom of Movement\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_HASTE)) { sProperties = sProperties + "Haste\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_HOLY_AVENGER)) { sProperties = sProperties + "Holy Avenger\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)) { sProperties = sProperties + "Immunity Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)) { sProperties = sProperties + "Immunity Miscellaneous\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)) { sProperties = sProperties + "Immunity Specific Spell\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)) { sProperties = sProperties + "Immunity Spell School\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)) { sProperties = sProperties + "Immunity Spell Level\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMPROVED_EVASION)) { sProperties = sProperties + "Improved Evasion\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_KEEN)) { sProperties = sProperties + "Keen\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_LIGHT)) { sProperties = sProperties + "Light\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MASSIVE_CRITICALS)) { sProperties = sProperties + "Massive Criticals\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MIGHTY)) { sProperties = sProperties + "Mighty\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MIND_BLANK)) { sProperties = sProperties + "Mind Blank\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MONSTER_DAMAGE)) { sProperties = sProperties + "Monster Damage\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_NO_DAMAGE)) { sProperties = sProperties + "No Damage\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ON_HIT_PROPERTIES)) { sProperties = sProperties + "On Hit\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ON_MONSTER_HIT)) { sProperties = sProperties + "On Monster Hit\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_POISON)) { sProperties = sProperties + "Poison\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION)) { sProperties = sProperties + "Regeneration\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION_VAMPIRIC)) { sProperties = sProperties + "Vampiric Regeneration\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SAVING_THROW_BONUS)) { sProperties = sProperties + "Saving Throw Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)) { sProperties = sProperties + "Specific Saving Throw Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SKILL_BONUS)) { sProperties = sProperties + "Skill Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SPELL_RESISTANCE)) { sProperties = sProperties + "Spell Resistance\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_THIEVES_TOOLS)) { sProperties = sProperties + "Thieves Tools\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_TRAP)) { sProperties = sProperties + "Trap\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_TRUE_SEEING)) { sProperties = sProperties + "True Seeing\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_TURN_RESISTANCE)) { sProperties = sProperties + "Turn Resistance\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_UNLIMITED_AMMUNITION)) { sProperties = sProperties + "Unlimited Ammo\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)) { sProperties = sProperties + "Alignment Group Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_CLASS)) { sProperties = sProperties + "Class Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE)) { sProperties = sProperties + "Racial Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "Alignment Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_TILESET)) { sProperties = sProperties + "Tileset Use Limitation\n"; }
//      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_VORPAL)) { sProperties = sProperties + "Vorpal\n"; }
//      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_WOUNDING)) { sProperties = sProperties + "Wounding\n"; }
      if(sProperties != "") { sProperties = "Properties:\n" + sProperties; }

      sReturnString = sStacked + GetName(oItem) + "\n" +
                      "-------------------------------------------\n" +
                      sBaseType + "\n" +
                      sIdentified + "\n" +
                      ((nACValue)?sACValue + "\n":"") +
                      sProperties;
   }
   else
   {
      sReturnString = sStacked + GetName(oItem) + " (" + sBaseType + ")";
   }
   return sReturnString;
}

void dmwand_JoinParty()
{
   AssignCommand(oMySpeaker, AddToParty( oMySpeaker, GetFactionLeader(oMyTarget)));
}

void dmwand_JumpPlayerHere()
{
   location lJumpLoc = GetLocation(oMySpeaker);
   AssignCommand(oMyTarget, ActionJumpToLocation(lJumpLoc));
}

void dmwand_JumpToPlayer()
{
   location lJumpLoc = GetLocation(oMyTarget);
   AssignCommand(oMySpeaker, ActionJumpToLocation(lJumpLoc));
}

void dmwand_KickPC()
{
   // Create a lightning strike, thunder, scorch mark, and random small
   // lightnings at target's location
   AssignCommand( oMySpeaker, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lMyLoc));
   AssignCommand ( oMySpeaker, PlaySound ("as_wt_thundercl3"));
   object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lMyLoc, FALSE);
   object oTargetArea = GetArea(oMySpeaker);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 5; nCount++)
   {
      nXPos = Random(10) - 5;
      nYPos = Random(10) - 5;

      vector vNewVector = GetPositionFromLocation(lMyLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
      AssignCommand( oMySpeaker, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
   }
   DelayCommand ( 20.0, DestroyObject ( oScorch));

   // Kick the target out of the game
   BootPC(oMyTarget);
}

void dmwand_KillAndReplace()
{
   SetPlotFlag(oMyTarget, FALSE);
   AssignCommand(oMyTarget, SetIsDestroyable(FALSE, FALSE));
   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMyTarget));
}

void dmwand_LeaveParty()
{
   RemoveFromParty(oMySpeaker);
}

void dmwand_MapArea()
{
   object omyarea = GetArea(oMySpeaker);
   ExploreAreaForPlayer(omyarea, oMyTarget);
}

void dmwand_ModOneRep(string sPlayer)
{
   string sAmt = GetLocalString(oMySpeaker, "dmw_repamt");
   int nAmt = StringToInt(sAmt);
   object oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + sPlayer);

   AdjustReputation(oPlayer, oMyTarget, nAmt);
   AdjustReputation(oMyTarget, oPlayer, nAmt);
}

void dmwand_ModRep(string sAmt)
{
   SetLocalString(oMySpeaker, "dmw_repamt", sAmt);
   string sAllOrOne = GetLocalString(oMySpeaker, "dmw_repargs");
   if(TestStringAgainstPattern(sAllOrOne, "one"))
   {
      dmwand_BuildConversation("ListPlayers", "func_ModOneRep");
      return;
   }
   int nAmt = StringToInt(sAmt);

   object oPlayer = GetFirstPC();
   while(GetIsObjectValid(oPlayer))
   {
      AdjustReputation(oPlayer, oMyTarget, nAmt);
      AdjustReputation(oMyTarget, oPlayer, nAmt);
      oPlayer = GetNextPC();
   }
}

void dmwand_PlayerListConv(string sParams)
{
   int nPlayer = StringToInt(sParams);
   int nCache;
   int nCount;

   object oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nPlayer));
   oMyTarget = oPlayer;
   SetLocalObject(oMySpeaker, "dmwandtarget", oMyTarget);

   //Go back to the first conversation level
   dmwand_BuildConversation("Start", "");
}

string dmwand_Race(object oEntity)
{
   switch (GetRacialType(oEntity))
   {
      case RACIAL_TYPE_ALL:   return "All"; break;
      case RACIAL_TYPE_ANIMAL:   return "Animal"; break;
      case RACIAL_TYPE_BEAST:   return "Beast"; break;
      case RACIAL_TYPE_CONSTRUCT:   return "Construct"; break;
      case RACIAL_TYPE_DRAGON:   return "Dragon"; break;
      case RACIAL_TYPE_DWARF:   return "Dwarf"; break;
      case RACIAL_TYPE_ELEMENTAL:   return "Elemental"; break;
      case RACIAL_TYPE_ELF:   return "Elf"; break;
      case RACIAL_TYPE_FEY:   return "Fey"; break;
      case RACIAL_TYPE_GIANT:   return "Giant"; break;
      case RACIAL_TYPE_GNOME:   return "Gnome"; break;
      case RACIAL_TYPE_HALFELF:   return "Half Elf"; break;
      case RACIAL_TYPE_HALFLING:   return "Halfling"; break;
      case RACIAL_TYPE_HALFORC:   return "Half Orc"; break;
      case RACIAL_TYPE_HUMAN:   return "Human"; break;
      case RACIAL_TYPE_HUMANOID_GOBLINOID:   return "Goblinoid"; break;
      case RACIAL_TYPE_HUMANOID_MONSTROUS:   return "Monstrous"; break;
      case RACIAL_TYPE_HUMANOID_ORC:   return "Orc"; break;
      case RACIAL_TYPE_HUMANOID_REPTILIAN:   return "Reptillian"; break;
//      case RACIAL_TYPE_INVALID:   return "Unknown"; break;
      case RACIAL_TYPE_MAGICAL_BEAST:   return "Magical Beast"; break;
      case RACIAL_TYPE_OUTSIDER:   return "Outsider"; break;
      case RACIAL_TYPE_SHAPECHANGER:   return "Shapechanger"; break;
      case RACIAL_TYPE_UNDEAD:   return "Undead"; break;
      case RACIAL_TYPE_VERMIN:   return "Vermin"; break;
   }

   return "Unknown";
}

void dmwand_ReloadModule()
{
   string sModuleName = GetModuleName();
//   SendMessageToPC(oMySpeaker,"CRASHES MODULE-DISABLED");
   StartNewModule(sModuleName);
}

void dmwand_ResumeDefault()
{
   if(GetIsPC(oMyTarget))
   {
      AssignCommand ( oMyTarget, ClearAllActions());
   }
   else
   {
      ExecuteScript ( "nw_c2_default9", oMyTarget);
   }
}

void dmwand_ShiftAlignment(string sAlign, int nShift)
{
   if(TestStringAgainstPattern(sAlign, "law__"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_LAWFUL, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "chaos"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_CHAOTIC, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "good_"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_GOOD, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "evil_"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_EVIL, nShift);
      return;
   }
}

void dmwand_ShowAllAttribs()
{
   string sSTR = IntToString(GetAbilityScore(oMyTarget,ABILITY_STRENGTH));
   string sINT = IntToString(GetAbilityScore(oMyTarget,ABILITY_INTELLIGENCE));
   string sDEX = IntToString(GetAbilityScore(oMyTarget,ABILITY_DEXTERITY));
   string sWIS = IntToString(GetAbilityScore(oMyTarget,ABILITY_WISDOM));
   string sCON = IntToString(GetAbilityScore(oMyTarget,ABILITY_CONSTITUTION));
   string sCHA = IntToString(GetAbilityScore(oMyTarget,ABILITY_CHARISMA));
   string sReport = "\n-------------------------------------------" +
                    "\nReported: " + IntToString(GetTimeHour()) + ":" + IntToString(GetTimeMinute()) +
                    "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                    "PubCDKey: " + GetPCPublicCDKey(oMyTarget) +
                    "\nChar Name:   " + GetName(oMyTarget) +
                    "\n-------------------------------------------" +
                    "\nRace:    " + dmwand_Race(oMyTarget) +
                    "\nClass:    " + dmwand_ClassLevel(oMyTarget) +
                    "\nXP:     " + IntToString(GetXP(oMyTarget)) +
                    "\nGender: " + dmwand_Gender(oMyTarget) +
                    "\nAign:    " + dmwand_Alignment(oMyTarget) +
                    "\nDiety:  " + GetDeity(oMyTarget) +
                    "\n" +
                    "\nSTR:  " + sSTR +
                    "\nINT:   " + sINT +
                    "\nWIS:  " + sWIS +
                    "\nDEX:  " + sDEX +
                    "\nCON: " + sCON +
                    "\nCHA:  " + sCHA +
                    "\n" +
                    "\nHPs:  " + IntToString(GetCurrentHitPoints(oMyTarget)) +
                    " of " + IntToString(GetMaxHitPoints(oMyTarget)) +
                    "\nAC:  " + IntToString(GetAC(oMyTarget)) +
                    "\n\nGold:  " + IntToString(GetGold(oMyTarget)) +
                    "\nInventory:\n  " + dmwand_Inventory(oMyTarget) +
                    "\n-------------------------------------------";

   SetLocalString(oMySpeaker, "dmw_dialog0", sReport);
}

void dmwand_ShowBasicAttribs()
{
   string sSTR = IntToString(GetAbilityScore(oMyTarget,ABILITY_STRENGTH));
   string sINT = IntToString(GetAbilityScore(oMyTarget,ABILITY_INTELLIGENCE));
   string sDEX = IntToString(GetAbilityScore(oMyTarget,ABILITY_DEXTERITY));
   string sWIS = IntToString(GetAbilityScore(oMyTarget,ABILITY_WISDOM));
   string sCON = IntToString(GetAbilityScore(oMyTarget,ABILITY_CONSTITUTION));
   string sCHA = IntToString(GetAbilityScore(oMyTarget,ABILITY_CHARISMA));
   string sReport = "\n-------------------------------------------" +
                    "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                    "\nChar Name:   " + GetName(oMyTarget) +
                    "\n-------------------------------------------" +
                    "\nRace:    " + dmwand_Race(oMyTarget) +
                    "\nClass:    " + dmwand_ClassLevel(oMyTarget) +
                    "\nXP:     " + IntToString(GetXP(oMyTarget)) +
                    "\nGender: " + dmwand_Gender(oMyTarget) +
                    "\nAign:    " + dmwand_Alignment(oMyTarget) +
                    "\nDiety:  " + GetDeity(oMyTarget) +
                    "\n" +
                    "\nSTR:  " + sSTR +
                    "\nINT:   " + sINT +
                    "\nWIS:  " + sWIS +
                    "\nDEX:  " + sDEX +
                    "\nCON: " + sCON +
                    "\nCHA:  " + sCHA +
                    "\n" +
                    "\nHPs:  " + IntToString(GetCurrentHitPoints(oMyTarget)) +
                    " of " + IntToString(GetMaxHitPoints(oMyTarget)) +
                    "\nAC:  " + IntToString(GetAC(oMyTarget)) +
                    "\n\nGold:  " + IntToString(GetGold(oMyTarget)) +
                    "\n-------------------------------------------";
   SetLocalString(oMySpeaker, "dmw_dialog0", sReport);
}

void dmwand_ShowInventory()
{
   string sReport = "\n-------------------------------------------" +
                    "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                    "\nChar Name:   " + GetName(oMyTarget) +
                    "\n-------------------------------------------" +
                    "\nInventory:\n  " + dmwand_Inventory(oMyTarget) +
                    "\n-------------------------------------------";
   SetLocalString(oMySpeaker, "dmw_dialog0", sReport);
}

void dmwand_SkillCheck(int nSkill, int nSecret = TRUE)
{
   int nRoll=d20();
   int nRank=GetSkillRank (nSkill, oMyTarget);
   int nResult=nRoll+nRank;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);
   string sSkill;

   switch(nSkill)
   {
      case SKILL_ANIMAL_EMPATHY:
         sSkill = "Animal Empathy"; break;
      case SKILL_CONCENTRATION:
         sSkill = "Concentration"; break;
      case SKILL_DISABLE_TRAP:
         sSkill = "Disable Trap"; break;
      case SKILL_DISCIPLINE:
         sSkill = "Discipline"; break;
      case SKILL_HEAL:
         sSkill = "Heal"; break;
      case SKILL_HIDE:
         sSkill = "Hide"; break;
      case SKILL_LISTEN:
         sSkill = "Listen"; break;
      case SKILL_LORE:
         sSkill = "Lore"; break;
      case SKILL_MOVE_SILENTLY:
         sSkill = "Move Silently"; break;
      case SKILL_OPEN_LOCK:
         sSkill = "Open Lock"; break;
      case SKILL_PARRY:
         sSkill = "Parry"; break;
      case SKILL_PERFORM:
         sSkill = "Perform"; break;
      case SKILL_PERSUADE:
         sSkill = "Persuade"; break;
      case SKILL_PICK_POCKET:
         sSkill = "Pick Pocket"; break;
      case SKILL_SEARCH:
         sSkill = "Search"; break;
      case SKILL_SET_TRAP:
         sSkill = "Set Trap"; break;
      case SKILL_SPELLCRAFT:
         sSkill = "Spellcraft"; break;
      case SKILL_SPOT:
         sSkill = "Spot"; break;
      case SKILL_TAUNT:
         sSkill = "Taunt"; break;
      case SKILL_USE_MAGIC_DEVICE:
         sSkill = "Use Magic Device"; break;
   }
   SendMessageToPC(oMySpeaker, GetName(oMyTarget)+"'s "+sSkill+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult);

   if (!nSecret)
   {
      AssignCommand( oMyTarget, SpeakString(sSkill+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
   }
}

void dmwand_SwapDayNight(int nDay)
{
   int nCurrentHour;
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   nCurrentHour = ((nDay == 1)?7:19);

   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
   dmwand_BuildConversation("TimeOfDay", "");
}

void dmwand_TakeAll()
{
   dmwand_TakeAllEquipped();
   dmwand_TakeAllUnequipped();
}

void dmwand_TakeAllEquipped()
{
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget));
}

void dmwand_TakeAllUnequipped()
{
   object oEquip = GetFirstItemInInventory(oMyTarget);
   while(GetIsObjectValid(oEquip))
   {
      dmwand_takeoneitem(oEquip);
      oEquip = GetNextItemInInventory(oMyTarget);
   }
}

void dmwand_TakeItem()
{
   object oItem = GetLocalObject(oMySpeaker, "dmw_item");

   dmwand_takeoneitem(oItem);
   dmwand_BuildConversation("ListInventory", "");
}

void dmwand_takeoneitem(object oEquip)
{
   if (GetIsObjectValid(oEquip) != 0)
   {
      AssignCommand(oMySpeaker, ActionTakeItem(oEquip, oMyTarget));
   }
}

void dmwand_Toad()
{
   effect ePenguin = EffectPolymorph(POLYMORPH_TYPE_PENGUIN);
   effect eParalyze = EffectParalyze();
   SendMessageToPC(oMySpeaker, "Penguin?  Don't you mean toad?");

   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenguin, oMyTarget));
   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oMyTarget));
   SetLocalInt(oMyTarget, "toaded", 1);
}

void dmwand_TurnNearOff()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      dmwand_TurnOff(oMyTest);
   }
}

void dmwand_TurnNearOn()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      dmwand_TurnOn(oMyTest);
   }
}

void dmwand_TurnOff(object oMyPlaceable)
{
   AssignCommand(oMyPlaceable, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
   DelayCommand(0.4,SetPlaceableIllumination(oMyPlaceable, FALSE));
   DelayCommand(0.5,RecomputeStaticLighting(GetArea(oMyPlaceable)));
}

void dmwand_TurnOn(object oMyPlaceable)
{
   AssignCommand(oMyPlaceable, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
   DelayCommand(0.4,SetPlaceableIllumination(oMyPlaceable, TRUE));
   DelayCommand(0.5,RecomputeStaticLighting(GetArea(oMyPlaceable)));
}

void dmwand_TurnTargetOff()
{
   dmwand_TurnOff(oMyTarget);
}

void dmwand_TurnTargetOn()
{
   dmwand_TurnOn(oMyTarget);
}

void dmwand_Untoad()
{
   effect eMyEffect = GetFirstEffect(oMyTarget);
   while(GetIsEffectValid(eMyEffect))
   {
      if(GetEffectType(eMyEffect) == EFFECT_TYPE_POLYMORPH ||
         GetEffectType(eMyEffect) == EFFECT_TYPE_PARALYZE)
      {
         RemoveEffect(oMyTarget, eMyEffect);
      }
      eMyEffect = GetNextEffect(oMyTarget);
   }
}
