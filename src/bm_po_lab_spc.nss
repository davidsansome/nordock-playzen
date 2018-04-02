#include "bm_po_inc"

void main()
{

   int iSpellID = GetLastSpell();
   object oPlayer = GetLastSpellCaster();
   int iCost;
   int nXP = GetXP(oPlayer);
   int nXPCost;
   int iSpellLevel;
   int iCastLevel;
   int nTime;
   string sPotionTag;
   int iSuccess;
   int nHD = GetHitDice ( oPlayer );
   int nMinXP = ((( nHD * ( nHD - 1) ) / 2 ) * 1000) + 1; //Minimum amount of XP needed to keep level

   object oBottle = GetItemPossessedBy(OBJECT_SELF, "NW_IT_THNMISC001");
   object oMod = GetModule();
   string sPCName = GetName(oPlayer);
   string sCDK = GetPCPublicCDKey(oPlayer);


   if (oBottle == OBJECT_INVALID)
        return;

   switch (iSpellID)
   {
        case SPELL_AID:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION016";
              iCastLevel = 3;
              break;
        case SPELL_NEUTRALIZE_POISON:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION006";
              iCastLevel = 5;
              break;
        case SPELL_BARKSKIN:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION005";
              iCastLevel = 3;
              break;
        case SPELL_BLESS:
              iSpellLevel = 1;
              sPotionTag = "NW_IT_MPOTION009";
              iCastLevel = 2;
              break;
        case SPELL_BULLS_STRENGTH:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION015";
              iCastLevel = 3;
              break;
        case SPELL_CATS_GRACE:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION014";
              iCastLevel = 3;
              break;
        case SPELL_CLARITY:
              iSpellLevel = 3;
              sPotionTag = "NW_IT_MPOTION007";
              iCastLevel = 3;
              break;
        case SPELL_CURE_CRITICAL_WOUNDS:
              iSpellLevel = 4;
              //sPotionTag = "NW_IT_MPOTION003";
              sPotionTag = "potionofcurel004";
              iCastLevel = 7;
              break;
        case SPELL_CURE_LIGHT_WOUNDS:
              iSpellLevel = 1;
              //sPotionTag = "NW_IT_MPOTION001";
              sPotionTag = "potionofcurel003";
              iCastLevel = 2;
              break;
        case SPELL_CURE_MODERATE_WOUNDS:
              iSpellLevel = 2;
              //sPotionTag = "NW_IT_MPOTION020";
              sPotionTag = "potionofcurel001";
              iCastLevel = 3;
              break;
        case SPELL_CURE_SERIOUS_WOUNDS:
              iSpellLevel = 3;
              //sPotionTag = "NW_IT_MPOTION002";
              sPotionTag = "potionofcurel002";
              iCastLevel = 5;
              break;
        case SPELL_EAGLE_SPLEDOR:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION010";
              iCastLevel = 3;
              break;
        case SPELL_ENDURANCE:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION013";
              iCastLevel = 3;
              break;
        case SPELL_FOXS_CUNNING:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION017";
              iCastLevel = 3;
              break;
        case SPELL_HEAL:
              iSpellLevel = 6;
              sPotionTag = "NW_IT_MPOTION012";
              iCastLevel = 11;
              break;
        case SPELL_INVISIBILITY:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION008";
              iCastLevel = 3;
              break;
        case SPELL_LESSER_RESTORATION:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION011";
              iCastLevel = 3;
              break;
        case SPELL_IDENTIFY:
              iSpellLevel = 1;
              sPotionTag = "NW_IT_MPOTION019";
              iCastLevel = 3;
              break;
        case SPELL_OWLS_WISDOM:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION018";
              iCastLevel = 3;
              break;
        case SPELL_HASTE:
              iSpellLevel = 3;
              sPotionTag = "NW_IT_MPOTION004";
              iCastLevel = 5;
              break;
        case SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE:
              iSpellLevel = 3;
              sPotionTag = "sy_potion009";
              iCastLevel = 5;
              break;
        case SPELL_DEATH_WARD:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion019";
              iCastLevel = 7;
              break;
        case SPELL_DIVINE_POWER:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion020";
              iCastLevel = 7;
              break;
        case SPELL_ELEMENTAL_SHIELD:
              iSpellLevel = 5;
              sPotionTag = "SY_Potion024";
              iCastLevel = 9;
              break;
        case SPELL_ETHEREAL_VISAGE:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion025";
              iCastLevel = 11;
              break;
        case SPELL_FREEDOM_OF_MOVEMENT:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion021";
              iCastLevel = 7;
              break;
        case SPELL_GHOSTLY_VISAGE:
              iSpellLevel = 2;
              sPotionTag = "SY_Potion005";
              iCastLevel = 3;
              break;
        case SPELL_ENDURE_ELEMENTS:
              iSpellLevel = 1;
              sPotionTag = "SY_Potion001";
              iCastLevel = 1;
              break;
        case SPELL_GREATER_BULLS_STRENGTH:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion028";
              iCastLevel = 11;
              break;
        case SPELL_GREATER_CATS_GRACE:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion029";
              iCastLevel = 11;
              break;
        case SPELL_GREATER_EAGLE_SPLENDOR:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion030";
              iCastLevel = 11;
              break;
        case SPELL_GREATER_ENDURANCE:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion031";
              iCastLevel = 11;
              break;
        case SPELL_GREATER_FOXS_CUNNING:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion032";
              iCastLevel = 11;
              break;
        case SPELL_GREATER_OWLS_WISDOM:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion033";
              iCastLevel = 11;
              break;
        case SPELL_GREATER_STONESKIN:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion034";
              iCastLevel = 11;
              break;
        case SPELL_LESSER_MIND_BLANK:
              iSpellLevel = 5;
              sPotionTag = "SY_Potion026";
              iCastLevel = 9;
              break;
        case SPELL_MAGE_ARMOR:
              iSpellLevel = 1;
              sPotionTag = "SY_Potion002";
              iCastLevel = 1;
              break;
        case SPELL_NEGATIVE_ENERGY_PROTECTION:
              iSpellLevel = 3;
              sPotionTag = "SY_Potion012";
              iCastLevel = 5;
              break;
        case SPELL_POLYMORPH_SELF:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion013";
              iCastLevel = 7;
              break;
        case SPELL_PROTECTION_FROM_ELEMENTS:
              iSpellLevel = 3;
              sPotionTag = "SY_Potion014";
              iCastLevel = 5;
              break;
        case SPELL_REMOVE_BLINDNESS_AND_DEAFNESS:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion015";
              iCastLevel = 7;
              break;
        case SPELL_REMOVE_CURSE:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion016";
              iCastLevel = 7;
              break;
        case SPELL_REMOVE_DISEASE:
              iSpellLevel = 3;
              sPotionTag = "SY_Potion017";
              iCastLevel = 5;
              break;
        case SPELL_REMOVE_FEAR:
              iSpellLevel = 1;
              sPotionTag = "SY_Potion003";
              iCastLevel = 1;
              break;
        case SPELL_RESIST_ELEMENTS:
              iSpellLevel = 2;
              sPotionTag = "SY_Potion006";
              iCastLevel = 3;
              break;
        case SPELL_RESISTANCE:
              iSpellLevel = 1;
              sPotionTag = "SY_Potion004";
              iCastLevel = 1;
              break;
        case SPELL_RESTORATION:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion022";
              iCastLevel = 7;
              break;
        case SPELL_SEE_INVISIBILITY:
              iSpellLevel = 2;
              sPotionTag = "SY_Potion007";
              iCastLevel = 3;
              break;
        case SPELL_SPELL_RESISTANCE:
              iSpellLevel = 5;
              sPotionTag = "SY_Potion027";
              iCastLevel = 9;
              break;
        case SPELL_STONESKIN:
              iSpellLevel = 4;
              sPotionTag = "SY_Potion023";
              iCastLevel = 7;
              break;
        case SPELL_TENSERS_TRANSFORMATION:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion035";
              iCastLevel = 11;
              break;
        case SPELL_TRUE_SEEING:
              iSpellLevel = 6;
              sPotionTag = "SY_Potion036";
              iCastLevel = 11;
              break;
        case SPELL_PREMONITION:
              iSpellLevel = 8;
              sPotionTag = "SY_Potion038";
              iCastLevel = 15;
              break;
        case SPELL_GREATER_SPELL_MANTLE:
              iSpellLevel = 9;
              sPotionTag = "SY_Potion037";
              iCastLevel = 17;
              break;
        case SPELL_SHADOW_SHIELD:
              iSpellLevel = 7;
              sPotionTag = "SY_Potion040";
              iCastLevel = 13;
              break;
        case SPELL_SPELL_MANTLE:
              iSpellLevel = 7;
              sPotionTag = "SY_Potion039";
              iCastLevel = 13;
              break;
        case SPELL_LESSER_SPELL_MANTLE:
              iSpellLevel = 5;
              sPotionTag = "SY_Potion041";
              iCastLevel = 9;
              break;
        default:
              sPotionTag = "NOTSUPPORTED";
              break;

   }
   if (sPotionTag != "NOTSUPPORTED")
   {
        iCost = iSpellLevel*iSpellLevel*iCastLevel*5;
        nXPCost = iSpellLevel*iCastLevel;
        nTime = 1;
        if (nXP >= nXPCost && (nXP-nXPCost) >= nMinXP)
        {
            if (GetGold(oPlayer) >= iCost/2)
            {
                //Take Gold
                //Take XP
                TakeGoldFromCreature(iCost, oPlayer, TRUE);
                SetXP(oPlayer, nXP-nXPCost);

                //Remove Bottle from Chest
                DestroyObject(oBottle);
                if (POTIONWAITTIME)
                {
                    //Delay Creation of Potion -- set global flags
                    SetLocalInt(oMod, "PotionCreated"+sPCName+sCDK, 1);
                    SetLocalInt(oMod, "nPotionCreatedHour"+sPCName+sCDK, GetTimeHour());
                    SetLocalInt(oMod, "nPotionCreatedDay"+sPCName+sCDK, GetCalendarDay());
                    SetLocalInt(oMod, "nPotionCreatedMonth"+sPCName+sCDK, GetCalendarMonth());
                    SetLocalInt(oMod, "nPotionCreatedYear"+sPCName+sCDK, GetCalendarYear());
                    SetLocalInt(oMod, "nPotionCreationTime"+sPCName+sCDK, nTime);
                    SetLocalString(oMod, "sCreatedPotion"+sPCName+sCDK, sPotionTag);
                    iSuccess = 1;
                }
                else
                    CreateItemOnObject(sPotionTag, oPlayer);
            }
            else
                //Not enough gold
                SendMessageToPC(oPlayer, "Not enough gold. You need " + IntToString(iCost/2) + "gp to create this potion.");
                iSuccess = 2;
        }
        else
            //Not enough xp
            SendMessageToPC(oPlayer, "Not enough XP. You need " + IntToString(nMinXP + nXPCost) + "xp to create this potion.");
            iSuccess = 3;

   }
}

