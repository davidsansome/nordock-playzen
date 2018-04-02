//------------------------------------------------------------------------------
//
// syr_tg_inc_npctg
//
// No idea what this one does
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

#include "syr_tg_inc_table"

//------------------------------------------------------------------------------

struct Equipment
    {
    object oTemp;
    object oHead;
    object oChest;
    object oBoots;
    object oArms;
    object oDouble;
    object oCloak;
    object oLRing;
    object oRRing;
    object oNeck;
    object oBelt;
    object oArrows;
    object oBullets;
    object oBolts;
    object oMedW;
    object oSmallW;
    object oSmallW2;
    object oBow;
    object o2Hand;
    object oShield;
    };
struct Equipment QueueStuff(struct Equipment EquipQue, int nTClass);
struct Equipment Queueing(struct Equipment EquipQue, int nSlot);
int WhereToEquip(struct Equipment EquipQueue, int nTClass);
int GetMajorClass(object oCritter);
object CreateBag();

struct Equipment EquipGenT (struct Treasure SyGeneratedTreasure, struct Equipment EquipQueue, object oBag, int nCr);
 ////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


void GenerateNPCTreasure()
{
    ///////////////////////////////////////
    struct Treasure Scroll;  struct Equipment EquipQueue;
    ////////////////////////////////////////
    int nCR = GetHitDice(OBJECT_SELF);
    int nTClass = nCR/4 -1;
        if (nTClass > 4) {nTClass = 4;}
        if (nTClass < 1) {nTClass = 0;}
//////////////////////////////////////////////////////////////////////////////////
//////////Creates a Container to put stuff in//////////////////////////////////////
    object oGem; struct Treasure GeneratedTreasure;
    object oBag = CreateBag();
    SetLocked(oBag,TRUE);
/////////////////////////////////////////////////////////////////////////////////////////
   int CreatureRHand = FALSE; int CreatureLHand = FALSE;
   if (    (GetSubString(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)),1,8) == GetSubString("NW_IT_CREW",1,8))
            ||  (GetSubString(GetTag(EquipQueue.oTemp),1,5) == GetSubString("NW_HEN",1,5))  )
            {CreatureRHand = TRUE;}
    if (    (GetSubString(GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND)),1,8) == GetSubString("NW_IT_CREW",1,8))
            ||  (GetSubString(GetTag(EquipQueue.oTemp),1,5) == GetSubString("NW_HEN",1,5))  )
            {CreatureLHand = TRUE;}
   EquipQueue = QueueStuff(EquipQueue,nTClass); //Puts equipped items into Queue.
    int nMajorClass = GetMajorClass(OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////////////
    switch(nMajorClass)
    {
        case CLASS_TYPE_FIGHTER   : /* =  4;*/
        case CLASS_TYPE_PALADIN   : /* =  6;*/
            if (d3() == 1)
                {if (Random(200) < nCR*MagicLevel)
                {
                    EquipQueue.oTemp =CreateItemOnObject(SyCreateHeavyArmor (nTClass), OBJECT_SELF, 1);
                    EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                    ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }}
            else if (   (Random(200) < nCR*MagicLevel) & (CreatureRHand == FALSE) & (CreatureLHand == FALSE))
                {
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateMeleeWeapon(nTClass),OBJECT_SELF,1);
                    EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                    ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            oGem = CreateItemOnObject (SyCreateGem (nCR, TREASURE_STANDARD),OBJECT_SELF, 1); ActionGiveItem(oGem,oBag);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_CLERIC    : /* =  2;*/
            if (Random(100) < GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF)*MagicLevel)
                {   Scroll = SyCreateDivineScroll(nCR);Scroll = Itemize(Scroll); }
            if (d3() == 1)
                {
                    if (Random(200) < nCR*MagicLevel)
                    {
                        EquipQueue.oTemp = CreateItemOnObject(SyCreateAmulet(nTClass),OBJECT_SELF,1);
                        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                        ActionGiveItem(EquipQueue.oTemp,oBag);  SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                }
            else if (Random(200) < nCR*MagicLevel)
                {
                    EquipQueue.oTemp =CreateItemOnObject(SyCreateHeavyArmor (nTClass), OBJECT_SELF, 1);
                    EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                    ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            oGem = CreateItemOnObject (SyCreateGem (nCR, TREASURE_STANDARD),OBJECT_SELF, 1); ActionGiveItem(oGem,oBag);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_BARBARIAN : /*=  0;*/
        case CLASS_TYPE_BARD      : /* =  1;*/
        case CLASS_TYPE_GIANT     : /* =  22;*/
            if (d3() == 1)
                {
                    if (Random(200) < nCR*MagicLevel)
                    {
                        EquipQueue.oTemp = CreateItemOnObject(SyCreateMediumArmor(nTClass),OBJECT_SELF,1);
                        EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                        ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                }
            else if (   (Random(200) < nCR*MagicLevel)  & (CreatureRHand == FALSE) & (CreatureLHand == FALSE))
                    {
                        EquipQueue.oTemp = CreateItemOnObject(SyCreateMeleeWeapon(nTClass),OBJECT_SELF,1);
                        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                        ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            CreateItemOnObject (SyCreateGem (nCR, TREASURE_STANDARD),OBJECT_SELF, 1);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_DRUID     : /* =  3;*/
            if (Random(100) < GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF)*MagicLevel)
                {   Scroll = SyCreateDivineScroll(nCR);Scroll = Itemize(Scroll); }
            if (Random(200) < nCR*MagicLevel)
                {
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateLightArmor(nTClass),OBJECT_SELF,1);
                    EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                    ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            else if (   (Random(200) < nCR*MagicLevel)  & (CreatureRHand == FALSE) & (CreatureLHand == FALSE))
                {
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateMeleeWeapon(nTClass),OBJECT_SELF,1);
                    EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                    ActionGiveItem(EquipQueue.oTemp,oBag);  SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            CreateItemOnObject (SyCreateGem (nCR,TREASURE_STANDARD),OBJECT_SELF, 1);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_RANGER    : /* =  7;*/
        case CLASS_TYPE_ROGUE     : /* =  8;*/
        case CLASS_TYPE_HUMANOID  : /* =  14;*/
        case CLASS_TYPE_SHAPECHANGER : /* =  25;*/
            if (d3() == 1)
            {
                if (Random(200) < nCR*MagicLevel)
                {
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateLightArmor(nTClass),OBJECT_SELF,1);
                    EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                    ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            }
            else if (   (Random(200) < nCR*MagicLevel) & (CreatureRHand == FALSE) & (CreatureLHand == FALSE))
                {
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateMeleeWeapon(nTClass),OBJECT_SELF,1);
                    EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                    ActionGiveItem(EquipQueue.oTemp,oBag);  SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            CreateItemOnObject (SyCreateGem (nCR,TREASURE_STANDARD),OBJECT_SELF, 1);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_MONK      : /* =  5;*/
        case CLASS_TYPE_FEY       : /* =  17;*/
                if (d3() == 1)
                {
                    if (Random(200) < nCR*MagicLevel)
                    {
                        EquipQueue.oTemp = CreateItemOnObject(SyCreateHands(nTClass),OBJECT_SELF,1);
                        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                        ActionGiveItem(EquipQueue.oTemp,oBag);  SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                }
                else if (Random(200) < nCR*MagicLevel)
                {
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateRobes(nTClass),OBJECT_SELF,1);
                    EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                    ActionGiveItem(EquipQueue.oTemp,oBag);  SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            CreateItemOnObject (SyCreateGem (nCR,TREASURE_STANDARD),OBJECT_SELF, 1);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_SORCERER  : /* =  9;*/
        case CLASS_TYPE_WIZARD    : /* =  10;*/
                if (Random(100) < GetCasterLevel(OBJECT_SELF)*MagicLevel)
                {   Scroll = SyCreateArcaneScroll(nCR);Scroll = Itemize(Scroll); }
                if (d3() == 1)
                {
                    if (Random(200) < nCR*MagicLevel)
                    {
                        EquipQueue.oTemp = CreateItemOnObject(SyCreateWand(nTClass),OBJECT_SELF,1);
                        SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                }
            else if (Random(200) < nCR*MagicLevel)
                {
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateRobes(nTClass),OBJECT_SELF,1);
                    EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                    ActionGiveItem(EquipQueue.oTemp,oBag);  SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            CreateItemOnObject (SyCreateGem (nCR,TREASURE_STANDARD),OBJECT_SELF, 1);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_DRAGON    : /* =  18;*/
            EquipQueue.oTemp = CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_RICH));
                ActionGiveItem(EquipQueue.oTemp,oBag); EquipQueue.oTemp = OBJECT_INVALID;
            CreateItemOnObject (SyCreateGem (nCR,TREASURE_RICH),OBJECT_SELF, 1);
                ActionGiveItem(EquipQueue.oTemp,oBag); EquipQueue.oTemp = OBJECT_INVALID;
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_RICH);
                EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            CreateItemOnObject (SyCreateGem (nCR,TREASURE_STANDARD),OBJECT_SELF, 1);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            SetLocked(oBag,TRUE);
            break;
        case CLASS_TYPE_COMMONER  : /* =  20;*/
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_POOR));
            break;
        case CLASS_TYPE_ABERRATION : /* =  11;*/
        case CLASS_TYPE_MONSTROUS : /* =  15;*/
        case CLASS_TYPE_OUTSIDER  : /* =  24; */
            CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF,SyCreateGold(nCR,TREASURE_STANDARD));
            CreateItemOnObject (SyCreateGem (nCR,TREASURE_STANDARD),OBJECT_SELF, 1);
            GeneratedTreasure = SyGenerateTreasure(OBJECT_SELF, nCR, TREASURE_STANDARD);
            EquipQueue = EquipGenT(GeneratedTreasure, EquipQueue, oBag, nCR);
            break;
        case CLASS_TYPE_ANIMAL    : /* =  12;*/
        case CLASS_TYPE_CONSTRUCT : /* =  13;*/
        case CLASS_TYPE_ELEMENTAL : /* =  16;*/
        case CLASS_TYPE_UNDEAD    : /* =  19;*/
        case CLASS_TYPE_BEAST     : /* =  21;*/
        case CLASS_TYPE_MAGICAL_BEAST : /* =  23;*/
        case CLASS_TYPE_VERMIN    : /* =  26; */
        default: break;
    }
//GIVING CHARACTER CLASSES SOME MINIMAL EQUIPMENT:
           if   (     (nMajorClass == CLASS_TYPE_BARBARIAN)
                  || (nMajorClass == CLASS_TYPE_FIGHTER)
                  || (nMajorClass == CLASS_TYPE_PALADIN)
                  || (nMajorClass == CLASS_TYPE_RANGER)    )
                {
                  if    (  (GetIsObjectValid(EquipQueue.oMedW) == FALSE)
                        & (GetIsObjectValid(EquipQueue.oSmallW) == FALSE)
                        & (CreatureRHand == FALSE)
                        & (CreatureLHand == FALSE)  )
                        {
                        if (GetCreatureSize(OBJECT_SELF) > 2)
                             {EquipQueue.oMedW =CreateItemOnObject("nw_wswls001", OBJECT_SELF, 1);}
                        else {EquipQueue.oMedW =CreateItemOnObject("nw_wswss001", OBJECT_SELF, 1);}
                        }
                  if (GetIsObjectValid(EquipQueue.oChest) == FALSE)
                        {
                        DestroyObject(EquipQueue.oTemp);
                        EquipQueue.oTemp =CreateItemOnObject(SyCreateLightArmor (0), OBJECT_SELF, 1);
                        EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                        EquipQueue.oTemp = OBJECT_INVALID;
                        }
                }
            if   (   (nMajorClass == CLASS_TYPE_BARD)
                  || (nMajorClass == CLASS_TYPE_CLERIC)
                  || (nMajorClass == CLASS_TYPE_ROGUE)
                  || (nMajorClass == CLASS_TYPE_DRUID)   )
                {
                    if  (   (GetIsObjectValid(EquipQueue.oMedW) == FALSE)
                        & (GetIsObjectValid(EquipQueue.oSmallW) == FALSE)
                        & (CreatureRHand == FALSE)
                        & (CreatureLHand == FALSE) )
                        {
                        if (GetCreatureSize(OBJECT_SELF) > 2)
                            {EquipQueue.oMedW =CreateItemOnObject("nw_wbcl001", OBJECT_SELF, 1);  }
                        else {EquipQueue.oMedW =CreateItemOnObject("nw_wsdg001", OBJECT_SELF, 1); }
                        }
                    if (GetIsObjectValid(EquipQueue.oChest) == FALSE)
                    {
                        DestroyObject(EquipQueue.oTemp);
                        EquipQueue.oTemp =CreateItemOnObject(SyCreateLightArmor (0), OBJECT_SELF, 1);
                        EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                }
            if   (  (nMajorClass == CLASS_TYPE_SORCERER)
                    || (nMajorClass == CLASS_TYPE_WIZARD)   )
                {
                    if (    (GetIsObjectValid(EquipQueue.oMedW) == FALSE)
                        & (GetIsObjectValid(EquipQueue.oSmallW) == FALSE)
                        & (CreatureRHand == FALSE)
                        & (CreatureLHand == FALSE) )
                    {
                        EquipQueue.oSmallW =CreateItemOnObject("nw_wsdg001", OBJECT_SELF, 1);
                    }
                    if (GetIsObjectValid(EquipQueue.oChest) == FALSE)
                    {
                        DestroyObject(EquipQueue.oTemp);
                        EquipQueue.oTemp =CreateItemOnObject(SyCreateRobes (0), OBJECT_SELF, 1);
                        EquipQueue = Queueing (EquipQueue,INVENTORY_SLOT_CHEST);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                }
        if  (   (GetGoldPieceValue(EquipQueue.oSmallW2) > GetGoldPieceValue(EquipQueue.oSmallW))
            & (CreatureRHand == FALSE)
            & (CreatureLHand == FALSE) )
            {
                EquipQueue.oTemp = EquipQueue.oSmallW;
                EquipQueue.oSmallW = EquipQueue.oSmallW2;
                EquipQueue.oSmallW2 = EquipQueue.oTemp;
                EquipQueue.oTemp = OBJECT_INVALID;
            }


        if (GetIsObjectValid(oBag))
            {
            int nGold = GetGold(OBJECT_SELF);
            TakeGoldFromCreature(nGold,OBJECT_SELF,TRUE);
            CreateItemOnObject("NW_IT_GOLD001", oBag,nGold);
            }



// EQUIPPING THE ITEMS
        ActionEquipItem(EquipQueue.oHead, INVENTORY_SLOT_HEAD);SetIdentified(EquipQueue.oHead,FALSE);
        ActionEquipItem(EquipQueue.oChest, INVENTORY_SLOT_CHEST);SetIdentified(EquipQueue.oChest,FALSE);
        ActionEquipItem(EquipQueue.oBoots, INVENTORY_SLOT_BOOTS);SetIdentified(EquipQueue.oBoots,FALSE);
        ActionEquipItem(EquipQueue.oArms, INVENTORY_SLOT_ARMS);SetIdentified(EquipQueue.oArms,FALSE);
        ActionEquipItem(EquipQueue.oCloak,  INVENTORY_SLOT_CLOAK );SetIdentified(EquipQueue.oCloak,FALSE);
        ActionEquipItem(EquipQueue.oLRing, INVENTORY_SLOT_LEFTRING);SetIdentified(EquipQueue.oLRing,FALSE);
        ActionEquipItem(EquipQueue.oRRing, INVENTORY_SLOT_RIGHTRING);SetIdentified(EquipQueue.oRRing,FALSE);
        ActionEquipItem(EquipQueue.oNeck, INVENTORY_SLOT_NECK );SetIdentified(EquipQueue.oNeck,FALSE);
        ActionEquipItem(EquipQueue.oBelt, INVENTORY_SLOT_BELT );SetIdentified(EquipQueue.oBelt,FALSE);
        ActionEquipItem(EquipQueue.oArrows, INVENTORY_SLOT_ARROWS ); SetIdentified(EquipQueue.oArrows,FALSE);
        ActionEquipItem(EquipQueue.oBullets, INVENTORY_SLOT_BULLETS); SetIdentified(EquipQueue.oBullets,FALSE);
        ActionEquipItem(EquipQueue.oBolts,  INVENTORY_SLOT_BOLTS); SetIdentified(EquipQueue.oBolts,FALSE);
////Ranged Weapons////////////////////////////////////////////////////////////////////////////////////
    if  ((CreatureRHand == TRUE) & (CreatureLHand == TRUE))
        {return;}
    if  (
            (GetHasFeat(FEAT_POINT_BLANK_SHOT))
            &   (GetIsObjectValid(EquipQueue.oBow)
            &   (CreatureRHand == FALSE)
            & (CreatureLHand == FALSE))
        )
            {
                ActionEquipItem(EquipQueue.oBow, INVENTORY_SLOT_RIGHTHAND);
                    if
                    (
                        (GetBaseItemType(EquipQueue.oBow) == BASE_ITEM_LONGBOW) ||
                        (GetBaseItemType(EquipQueue.oBow) == BASE_ITEM_SHORTBOW)
                    )
                    {
                        EquipQueue.oTemp = CreateItemOnObject("NW_WAMAR001",OBJECT_SELF,d10(3));
                        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                        ActionEquipItem(EquipQueue.oArrows, INVENTORY_SLOT_ARROWS );
                        SetIdentified(EquipQueue.oArrows,FALSE);
                        SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                    else if
                    (
                        (GetBaseItemType(EquipQueue.oBow) == BASE_ITEM_HEAVYCROSSBOW) ||
                        (GetBaseItemType(EquipQueue.oBow) == BASE_ITEM_LIGHTCROSSBOW)
                    )
                    {
                        EquipQueue.oTemp = CreateItemOnObject("NW_WAMBO001",OBJECT_SELF,d10(3));
                        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                        ActionEquipItem(EquipQueue.oBullets, INVENTORY_SLOT_BULLETS);
                        SetIdentified(EquipQueue.oBullets,FALSE);
                        SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                    else if (GetBaseItemType(EquipQueue.oBow) == BASE_ITEM_SLING)
                    {
                        EquipQueue.oTemp = CreateItemOnObject("NW_WAMBU001",OBJECT_SELF,d10(3));
                        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                        ActionEquipItem(EquipQueue.oBolts,  INVENTORY_SLOT_BOLTS);
                        SetIdentified(EquipQueue.oBolts,FALSE);
                        SetIdentified(EquipQueue.oTemp,FALSE);
                        EquipQueue.oTemp = OBJECT_INVALID;
                    }
                EquipQueue.oBow = OBJECT_INVALID;
                    if
                    (
                        (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC))     &
                        (GetIsObjectValid(EquipQueue.oDouble))
                    )
                        {EquipQueue.oDouble = OBJECT_INVALID;}
                    else if (GetIsObjectValid(EquipQueue.o2Hand))
                        {EquipQueue.o2Hand = OBJECT_INVALID;}
                    else if  (GetGoldPieceValue(EquipQueue.oSmallW) > GetGoldPieceValue(EquipQueue.oMedW))
                        {
                            EquipQueue.oSmallW = OBJECT_INVALID; EquipQueue.oShield = OBJECT_INVALID;
                        }
                    else {EquipQueue.oMedW = OBJECT_INVALID; EquipQueue.oShield = OBJECT_INVALID;}
                    ActionGiveItem(EquipQueue.oDouble,oBag);
                        SetIdentified(EquipQueue.oDouble,FALSE);
                        EquipQueue.oDouble = OBJECT_INVALID;
                    ActionGiveItem(EquipQueue.o2Hand,oBag);
                        SetIdentified(EquipQueue.o2Hand,FALSE);
                        EquipQueue.o2Hand = OBJECT_INVALID;
                    ActionGiveItem(EquipQueue.oSmallW2,oBag);
                        SetIdentified(EquipQueue.oSmallW2,FALSE);
                        EquipQueue.oSmallW2 = OBJECT_INVALID;
                    ActionGiveItem(EquipQueue.oSmallW,oBag);
                        SetIdentified(EquipQueue.oSmallW,FALSE);
                        EquipQueue.oSmallW = OBJECT_INVALID;
                    ActionGiveItem(EquipQueue.oMedW,oBag);
                        SetIdentified(EquipQueue.oMedW,FALSE);
                        EquipQueue.oMedW = OBJECT_INVALID;
                    return;
            }
////Dual Wielders////////////////////////////////////////////
        if  (   (nMajorClass == CLASS_TYPE_RANGER)
            ||  (
                (GetHasFeat(FEAT_TWO_WEAPON_FIGHTING,OBJECT_SELF)) &
                (GetHasFeat(FEAT_AMBIDEXTERITY,OBJECT_SELF))
                )
            ||  (GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_FIGHTING,OBJECT_SELF))
            )
`              {
                    if (GetIsObjectValid(EquipQueue.oSmallW))
                     {
                        if (GetIsObjectValid(EquipQueue.oMedW))
                            {
                                if (CreatureRHand = FALSE)
                                    {   ActionEquipItem(EquipQueue.oMedW, INVENTORY_SLOT_RIGHTHAND);    }
                                    SetIdentified(EquipQueue.oMedW,FALSE);
                                    EquipQueue.oMedW = OBJECT_INVALID;
                                if  (CreatureLHand = FALSE)
                                    {   ActionEquipItem(EquipQueue.oSmallW, INVENTORY_SLOT_LEFTHAND);   }
                                    SetIdentified(EquipQueue.oSmallW,FALSE);
                                    EquipQueue.oSmallW = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.oSmallW2, oBag);
                                    SetIdentified(EquipQueue.oSmallW2,FALSE);
                                    EquipQueue.oSmallW2 = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.oShield,oBag);
                                    SetIdentified(EquipQueue.oShield,FALSE);
                                    EquipQueue.oShield = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.o2Hand,oBag);
                                    SetIdentified(EquipQueue.o2Hand,FALSE);
                                    EquipQueue.o2Hand = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.oDouble,oBag);
                                    SetIdentified(EquipQueue.oDouble,FALSE);
                                    EquipQueue.oDouble = OBJECT_INVALID;
                                    return;
                            }
                        else if (GetIsObjectValid(EquipQueue.oSmallW2))
                            {
                                if (CreatureRHand = FALSE)
                                    {   ActionEquipItem(EquipQueue.oSmallW, INVENTORY_SLOT_RIGHTHAND);    }
                                    SetIdentified(EquipQueue.oSmallW,FALSE);
                                    EquipQueue.oSmallW = OBJECT_INVALID;
                                if  (CreatureLHand = FALSE)
                                    {   ActionEquipItem(EquipQueue.oSmallW2, INVENTORY_SLOT_LEFTHAND);   }
                                    SetIdentified(EquipQueue.oSmallW2,FALSE);
                                    EquipQueue.oSmallW2 = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.oSmallW2, oBag);
                                    SetIdentified(EquipQueue.oSmallW2,FALSE);
                                    EquipQueue.oSmallW2 = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.oShield,oBag);
                                    SetIdentified(EquipQueue.oShield,FALSE);
                                    EquipQueue.oShield = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.o2Hand,oBag);
                                    SetIdentified(EquipQueue.o2Hand,FALSE);
                                    EquipQueue.o2Hand = OBJECT_INVALID;
                                ActionGiveItem(EquipQueue.oDouble,oBag);
                                    SetIdentified(EquipQueue.oDouble,FALSE);
                                    EquipQueue.oDouble = OBJECT_INVALID;
                                    return;
                            }
                    }
               }
            if  (   (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC))
                &   (GetIsObjectValid(EquipQueue.oDouble))
                &   (CreatureRHand = FALSE)
                &   (CreatureLHand = FALSE) )
                    {
                        ActionEquipItem(EquipQueue.oDouble, INVENTORY_SLOT_RIGHTHAND);
                            SetIdentified(EquipQueue.oDouble,FALSE);
                            EquipQueue.oDouble = OBJECT_INVALID;
                        //Keep the Bow if there is one.
                            SetIdentified(EquipQueue.oBow,FALSE);
                            EquipQueue.oBow = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oMedW, oBag);
                            SetIdentified(EquipQueue.oMedW,FALSE);
                            EquipQueue.oMedW = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oSmallW, oBag);
                            SetIdentified(EquipQueue.oSmallW,FALSE);
                            EquipQueue.oSmallW = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oSmallW2, oBag);
                            SetIdentified(EquipQueue.oSmallW2,FALSE);
                            EquipQueue.oSmallW2 = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oShield,oBag);
                            SetIdentified(EquipQueue.oShield,FALSE);
                            EquipQueue.oShield = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.o2Hand,oBag);
                            SetIdentified(EquipQueue.o2Hand,FALSE);
                            EquipQueue.o2Hand = OBJECT_INVALID;
                        return;
                    }
            if  (   (GetIsObjectValid(EquipQueue.o2Hand))
                &   (CreatureRHand = FALSE)
                &   (CreatureLHand = FALSE) )
                    {
                        ActionEquipItem(EquipQueue.o2Hand, INVENTORY_SLOT_RIGHTHAND);
                            SetIdentified(EquipQueue.o2Hand,FALSE);
                            EquipQueue.o2Hand = OBJECT_INVALID;
                        //Keep the Bow if there is one.
                            SetIdentified(EquipQueue.oBow,FALSE);
                            EquipQueue.oBow = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oMedW, oBag);
                            SetIdentified(EquipQueue.oMedW,FALSE);
                            EquipQueue.oMedW = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oSmallW, oBag);
                            SetIdentified(EquipQueue.oSmallW,FALSE);
                            EquipQueue.oSmallW = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oSmallW2, oBag);
                            SetIdentified(EquipQueue.oSmallW2,FALSE);
                            EquipQueue.oSmallW2 = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oShield,oBag);
                            SetIdentified(EquipQueue.oShield,FALSE);
                            EquipQueue.oShield = OBJECT_INVALID;
                        ActionGiveItem(EquipQueue.oDouble,oBag);
                            SetIdentified(EquipQueue.oDouble,FALSE);
                            EquipQueue.oDouble = OBJECT_INVALID;
                        return;
                    }
            if  (GetGoldPieceValue(EquipQueue.oSmallW) >= GetGoldPieceValue(EquipQueue.oMedW))
                    {
                       if   (CreatureRHand = FALSE)
                            {   ActionEquipItem(EquipQueue.oSmallW, INVENTORY_SLOT_RIGHTHAND);  }
                        if  (CreatureLHand = FALSE)
                            {   ActionEquipItem(EquipQueue.oShield, INVENTORY_SLOT_LEFTHAND);   }
                       SetIdentified(EquipQueue.oSmallW,FALSE); EquipQueue.oSmallW = OBJECT_INVALID;
                       SetIdentified(EquipQueue.oShield,FALSE); EquipQueue.oShield = OBJECT_INVALID;
                    }
            else
                    {
                        if (CreatureRHand = FALSE)
                            {   ActionEquipItem(EquipQueue.oMedW, INVENTORY_SLOT_RIGHTHAND);    }
                        if (CreatureLHand = FALSE)
                            {   ActionEquipItem(EquipQueue.oShield, INVENTORY_SLOT_LEFTHAND);   }
                        SetIdentified(EquipQueue.oMedW,FALSE);EquipQueue.oShield = OBJECT_INVALID;
                        SetIdentified(EquipQueue.oShield,FALSE);EquipQueue.oMedW = OBJECT_INVALID;
                    }
            ActionGiveItem(EquipQueue.oDouble, oBag);
                SetIdentified(EquipQueue.oDouble,FALSE);
            ActionGiveItem(EquipQueue.o2Hand,oBag);
                SetIdentified(EquipQueue.o2Hand,FALSE);
            ActionGiveItem(EquipQueue.oSmallW2,oBag);
                SetIdentified(EquipQueue.oSmallW2,FALSE);
            ActionGiveItem(EquipQueue.oSmallW,oBag);
                SetIdentified(EquipQueue.oSmallW,FALSE);
            ActionGiveItem(EquipQueue.oMedW,oBag);
                SetIdentified(EquipQueue.oMedW,FALSE);

}
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
object CreateBag()
{   location lWhere = GetLocation(OBJECT_SELF);
    object oBag = GetNearestObjectByTag("SYR_NPC_VIC",OBJECT_SELF,1);
    if  (
            (GetIsObjectValid(oBag)) &
            (GetDistanceToObject(oBag) < 10.0f)
            )
            {return oBag;}
    else if (CreateNPCBag == TRUE)
        {
            int nRace = GetRacialType(OBJECT_SELF);
            switch(nRace)
            {
                case RACIAL_TYPE_DWARF: //                = 0;
                case RACIAL_TYPE_ELF:      //            = 1;
                case RACIAL_TYPE_GNOME:    //             = 2;
                case RACIAL_TYPE_HALFLING: //            = 3;
                case RACIAL_TYPE_HALFELF:  //              = 4;
                case RACIAL_TYPE_HALFORC:  //             = 5;
                case RACIAL_TYPE_HUMAN:    //             = 6;
                case RACIAL_TYPE_DRAGON:   //             = 11;
                case RACIAL_TYPE_OUTSIDER: //            = 20;
                    if (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 10)
                        {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtualco",lWhere, FALSE);}
                    else if (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 6)
                        {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtua001",lWhere, FALSE);}
                    else  {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtua002",lWhere, FALSE);}
                    break;
                case RACIAL_TYPE_HUMANOID_GOBLINOID:   //= 12;
                case RACIAL_TYPE_HUMANOID_MONSTROUS:   //= 13;
                case RACIAL_TYPE_HUMANOID_ORC:         //= 14;
                case RACIAL_TYPE_HUMANOID_REPTILIAN:   //= 15;
                case RACIAL_TYPE_GIANT:                //= 18;
                case RACIAL_TYPE_FEY:                  //= 17;
                case RACIAL_TYPE_SHAPECHANGER:         //= 23;
                    if (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 10)
                        {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtua001",lWhere, FALSE);}
                    else if (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 6)
                        {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtua002",lWhere, FALSE);}
                    else  {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtua003",lWhere, FALSE);}
                    break;
                case RACIAL_TYPE_ABERRATION:            //= 7;
                case RACIAL_TYPE_ELEMENTAL:             //= 16;
                case RACIAL_TYPE_UNDEAD:                //= 24;
                    if (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 10)    if (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 10)
                        {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtua002",lWhere, FALSE);}
                    else if (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 6)
                        {   oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtua003",lWhere, FALSE);}
                    else  oBag = OBJECT_INVALID;
                    break;
                case RACIAL_TYPE_ANIMAL:              // = 8;
                case RACIAL_TYPE_BEAST:               // = 9;
                case RACIAL_TYPE_CONSTRUCT:           // = 10;
                case RACIAL_TYPE_MAGICAL_BEAST:       // = 19;
                case RACIAL_TYPE_VERMIN:              // = 25;
                case RACIAL_TYPE_ALL:                 // = 28;
//                case RACIAL_TYPE_INVALID:             // = 29;    ALL and INVALID are now the same value
                    oBag = OBJECT_INVALID; break;
            }
            return oBag;
        }
    else {return OBJECT_INVALID;}
}

//////////////////////////////////////////////////////////////////////////////////////////////
struct Equipment QueueStuff(struct Equipment EquipQueue, int nTClass)
{
    EquipQueue.oHead = GetItemInSlot(INVENTORY_SLOT_HEAD);
        SetIdentified(EquipQueue.oHead,TRUE);
    EquipQueue.oChest = GetItemInSlot(INVENTORY_SLOT_CHEST);
        SetIdentified(EquipQueue.oChest,TRUE);
    EquipQueue.oBoots = GetItemInSlot(INVENTORY_SLOT_BOOTS);
        SetIdentified(EquipQueue.oBoots,TRUE);
    EquipQueue.oArms = GetItemInSlot(INVENTORY_SLOT_ARMS);
        SetIdentified(EquipQueue.oArms,TRUE);
    EquipQueue.oCloak = GetItemInSlot( INVENTORY_SLOT_CLOAK );
        SetIdentified(EquipQueue.oCloak,TRUE);
    EquipQueue.oLRing = GetItemInSlot(INVENTORY_SLOT_LEFTRING);
        SetIdentified(EquipQueue.oLRing,TRUE);
    EquipQueue.oRRing = GetItemInSlot(INVENTORY_SLOT_RIGHTRING);
        SetIdentified(EquipQueue.oRRing,TRUE);
    EquipQueue.oNeck = GetItemInSlot(INVENTORY_SLOT_NECK );
        SetIdentified(EquipQueue.oNeck,TRUE);
    EquipQueue.oBelt = GetItemInSlot(INVENTORY_SLOT_BELT );
        SetIdentified(EquipQueue.oBelt,TRUE);
    EquipQueue.oArrows = GetItemInSlot(INVENTORY_SLOT_ARROWS );
        SetIdentified(EquipQueue.oArrows,TRUE);
    EquipQueue.oBullets = GetItemInSlot(INVENTORY_SLOT_BULLETS);
        SetIdentified(EquipQueue.oBullets,TRUE);
    EquipQueue.oBolts = GetItemInSlot(INVENTORY_SLOT_BOLTS);
        SetIdentified(EquipQueue.oBolts,TRUE);
    EquipQueue.oTemp = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
        EquipQueue.oTemp = OBJECT_INVALID;
    EquipQueue.oTemp = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
        EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
        EquipQueue.oTemp = OBJECT_INVALID;

    return EquipQueue;
}
////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////
int GetMajorClass(object oCritter)
{
    int nMajorClass = CLASS_TYPE_INVALID;
    int nLevOne = GetLevelByPosition(1,oCritter);
    int nLevTwo = GetLevelByPosition(2,oCritter);
    int nLevThr = GetLevelByPosition(3,oCritter);
    int nTotal = nLevOne + nLevTwo + nLevThr;
    if (nLevOne*2 >= nTotal) {nMajorClass = GetClassByPosition(1,oCritter);}
    else if (nLevTwo*2 >= nTotal) {nMajorClass = GetClassByPosition(2,oCritter);}
    else if (nLevThr*2 >= nTotal) {nMajorClass = GetClassByPosition(3,oCritter);}
    else
    {
        nMajorClass = GetClassByPosition(1,oCritter);
        if (GetClassByPosition(2,oCritter) >= nMajorClass)
            {nMajorClass = GetClassByPosition(2,oCritter);}
        if (GetClassByPosition(3,oCritter) >= nMajorClass)
            {nMajorClass = GetClassByPosition(3,oCritter);}
    }
    return nMajorClass;
}
/////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
int WhereToEquip(struct Equipment EquipQueue,int nTClass)
{
    int INVENTORY_SLOT_2HANDED = 20;
    int INVENTORY_SLOT_BOW = 21;
    int INVENTORY_SLOT_SHIELD = 22;
    int INVENTORY_SLOT_PACK = 25;
    int INVENTORY_SLOT_DOUBLE = 26;
    int INVENTORY_SLOT_NONE = 99;
    int nSlot = INVENTORY_SLOT_NONE;
    switch (GetBaseItemType(EquipQueue.oTemp))
    {
        case BASE_ITEM_ARMOR:
            if      (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, OBJECT_SELF))
            {
            nSlot = INVENTORY_SLOT_CHEST;
            }
            else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, OBJECT_SELF))
            {
                if  (GetItemACValue(EquipQueue.oTemp) < 6)
                    {nSlot = INVENTORY_SLOT_CHEST;}
                else
                    {
                    DestroyObject(EquipQueue.oTemp,0.0f);
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateMediumArmor(nTClass),OBJECT_SELF,1);
                    SetIdentified(EquipQueue.oTemp,TRUE);
                    nSlot = INVENTORY_SLOT_CHEST;
                    }
            }
            else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, OBJECT_SELF))
            {
                if  (GetItemACValue(EquipQueue.oTemp) < 4)
                    {nSlot = INVENTORY_SLOT_CHEST;}
                else
                    {
                    DestroyObject(EquipQueue.oTemp,0.0f);
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateLightArmor(nTClass),OBJECT_SELF,1);
                    SetIdentified(EquipQueue.oTemp,TRUE);
                    nSlot = INVENTORY_SLOT_CHEST;
                    }
            }
            else
            {
                if  (GetItemACValue(EquipQueue.oTemp) < 1)
                    {nSlot = INVENTORY_SLOT_CHEST;}
                else
                    {
                    DestroyObject(EquipQueue.oTemp,0.0f);
                    EquipQueue.oTemp = CreateItemOnObject(SyCreateRobes(nTClass),OBJECT_SELF,1);
                    SetIdentified(EquipQueue.oTemp,TRUE);
                    nSlot = INVENTORY_SLOT_CHEST;
                    }
            }
            break;
        case BASE_ITEM_HELMET: nSlot = INVENTORY_SLOT_HEAD;   break;
        case BASE_ITEM_BELT:    nSlot = INVENTORY_SLOT_BELT;   break;
        case BASE_ITEM_BOOTS:  nSlot = INVENTORY_SLOT_BOOTS;  break;
        case BASE_ITEM_GLOVES: nSlot = INVENTORY_SLOT_ARMS; break;
        case BASE_ITEM_BRACER: nSlot = INVENTORY_SLOT_ARMS; break;
        case BASE_ITEM_CLOAK: nSlot = INVENTORY_SLOT_CLOAK; break;
        case BASE_ITEM_AMULET: nSlot = INVENTORY_SLOT_NECK; break;
        case BASE_ITEM_ARROW: nSlot = INVENTORY_SLOT_ARROWS; break;
        case BASE_ITEM_BOLT: nSlot = INVENTORY_SLOT_BOLTS; break;
        case BASE_ITEM_BULLET: nSlot = INVENTORY_SLOT_BULLETS; break;
        case BASE_ITEM_RING: nSlot = INVENTORY_SLOT_LEFTRING;break;
        case BASE_ITEM_TWOBLADEDSWORD: //        = 12;
        case BASE_ITEM_DIREMACE: //              = 32;
        case BASE_ITEM_DOUBLEAXE: //             = 33;
            if (GetCreatureSize(OBJECT_SELF) > 2)
                {nSlot = INVENTORY_SLOT_DOUBLE;}
            else return INVENTORY_SLOT_NONE;
        case BASE_ITEM_SCYTHE: //                = 55;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: case 2: return nSlot; break;     //Can't Use
                    case 3: nSlot = INVENTORY_SLOT_2HANDED; break; //Can only use Two Handed.
                    case 4: nSlot = INVENTORY_SLOT_RIGHTHAND; break; //Use One Handed in Main Hand.
                    case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break;
                }
            }
            else {nSlot = INVENTORY_SLOT_NONE;}
            break;
        case BASE_ITEM_HALBERD: //               = 10 -> 4;
        case BASE_ITEM_GREATSWORD: //            = 13;
        case BASE_ITEM_GREATAXE: //              = 18;
        case BASE_ITEM_HEAVYFLAIL: //            = 35;
             if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: case 2: return nSlot; break;     //Can't Use
                    case 3: nSlot = INVENTORY_SLOT_2HANDED; break; //Can only use Two Handed.
                    case 4: nSlot = INVENTORY_SLOT_RIGHTHAND; break; //Use One Handed in Main Hand.
                    case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break;
                }
            }
            else {nSlot = INVENTORY_SLOT_NONE;}
            break;
       case BASE_ITEM_QUARTERSTAFF: //          = 50;
       case BASE_ITEM_SHORTSPEAR: //            = 58;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: case 2: return nSlot; break;     //Can't Use
                    case 3: nSlot = INVENTORY_SLOT_2HANDED; break; //Can only use Two Handed.
                    case 4: nSlot = INVENTORY_SLOT_RIGHTHAND; break; //Use One Handed in Main Hand.
                    case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break;
                }
            }
            else {nSlot = INVENTORY_SLOT_NONE;}
            break;
        case BASE_ITEM_KATANA: //                = 41;
        case BASE_ITEM_BASTARDSWORD: //          = 3;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: return nSlot; break;     //Can't Use
                    case 2: nSlot = INVENTORY_SLOT_2HANDED; break; //Can Only Use Two Handed;
                    case 3: nSlot = INVENTORY_SLOT_RIGHTHAND; break;
                    case 4: case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break;
                }
            }
            break;
        case BASE_ITEM_LONGSWORD: //             = 1;
        case BASE_ITEM_BATTLEAXE : //            = 2;
        case BASE_ITEM_LIGHTFLAIL: //            = 4;
        case BASE_ITEM_RAPIER: //                = 51;
        case BASE_ITEM_WARHAMMER: //             = 5;
        case BASE_ITEM_SCIMITAR: //              = 53;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: return nSlot; break;     //Can't Use
                    case 2: nSlot = INVENTORY_SLOT_2HANDED; break; //Can Only Use Two Handed;
                    case 3: nSlot = INVENTORY_SLOT_RIGHTHAND; break;
                    case 4: case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break;
                }
            }
            break;
        case BASE_ITEM_CLUB: //                  = 28;
        case BASE_ITEM_MORNINGSTAR: //           = 47;
        case BASE_ITEM_LIGHTMACE: //              = 9;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: return nSlot; break;     //Can't Use
                    case 2: nSlot = INVENTORY_SLOT_2HANDED; break; //Can Only Use Two Handed;
                    case 3: nSlot = INVENTORY_SLOT_RIGHTHAND; break;
                    case 4: case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break;
                }
            }
            break;
        case BASE_ITEM_SHORTSWORD: //            = 0;
        case BASE_ITEM_LIGHTHAMMER: //           = 37;
        case BASE_ITEM_HANDAXE: //               = 38;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: nSlot = INVENTORY_SLOT_2HANDED; break;  //Use Two Handed
                case 2: nSlot = INVENTORY_SLOT_RIGHTHAND; break;
                case 3: case 4: case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break; //Use One Handed
                }
            }
            break;
        case BASE_ITEM_SICKLE: //                = 60;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: nSlot = INVENTORY_SLOT_2HANDED; break;  //Use Two Handed
                    case 2: nSlot = INVENTORY_SLOT_RIGHTHAND; break;
                    case 3: case 4: case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break; //Use One Handed
                }
            }
            break;
        case BASE_ITEM_DAGGER://                 = 22;
        case BASE_ITEM_KAMA: //                  = 40;
        case BASE_ITEM_KUKRI: //                 = 42;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE))
            {
                switch (GetCreatureSize(OBJECT_SELF))
                {
                    case 1: nSlot = INVENTORY_SLOT_RIGHTHAND; break;
                    case 2: case 3: case 4: case 5: nSlot = INVENTORY_SLOT_LEFTHAND; break;
                }
            }
            else nSlot = INVENTORY_SLOT_NONE;
            break;
        case BASE_ITEM_LONGBOW: //               = 8;
        case BASE_ITEM_SHORTBOW: //              = 11;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL) & (GetCreatureSize(OBJECT_SELF) > 2))
                {nSlot = INVENTORY_SLOT_BOW;}
            else {nSlot = INVENTORY_SLOT_NONE;}
        case BASE_ITEM_HEAVYCROSSBOW: //         = 6;
        case BASE_ITEM_LIGHTCROSSBOW:                //         = 7;
        case BASE_ITEM_SLING: //                 = 61;
            if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE) & (GetCreatureSize(OBJECT_SELF) > 2))
                {nSlot = INVENTORY_SLOT_BOW;}
            else {nSlot = INVENTORY_SLOT_NONE;}

        case BASE_ITEM_THROWINGAXE: //           = 63;
            if  ((GetCreatureSize(OBJECT_SELF) > 1) & GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL))
            {nSlot = INVENTORY_SLOT_RIGHTHAND;}
            else {nSlot = INVENTORY_SLOT_NONE;}
            break;
        case BASE_ITEM_DART: //                  = 31;
            if  ((GetCreatureSize(OBJECT_SELF) > 1) & GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE))
            {nSlot = INVENTORY_SLOT_RIGHTHAND;}
            else {nSlot = INVENTORY_SLOT_NONE;}
            break;
        case BASE_ITEM_SHURIKEN: //              = 59;
            if  (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE))
            {nSlot = INVENTORY_SLOT_RIGHTHAND;}
            else {nSlot = INVENTORY_SLOT_NONE;}
            break;
        case BASE_ITEM_SMALLSHIELD: //           = 14;
        case BASE_ITEM_LARGESHIELD: //           = 56;
        case BASE_ITEM_TOWERSHIELD: //           = 57;
        case BASE_ITEM_TORCH:
            nSlot = INVENTORY_SLOT_SHIELD;
            break;
        case BASE_ITEM_GOLD: //  = 76;
            break;
        case BASE_ITEM_MISCLARGE: //             = 34;
        case BASE_ITEM_MISCTALL: //              = 43;
        case BASE_ITEM_MISCWIDE: //              = 68;
        case BASE_ITEM_MISCTHIN: //              = 79;
        case BASE_ITEM_THIEVESTOOLS: //          = 62;
        case BASE_ITEM_TRAPKIT: //               = 64;
        case BASE_ITEM_BOOK: //                  = 74;
            nSlot = INVENTORY_SLOT_NONE;
            break;
        case BASE_ITEM_GEM: //                   = 77;
        case BASE_ITEM_MAGICWAND: //             = 46;
        case BASE_ITEM_SCROLL: //                = 54;
        case BASE_ITEM_SPELLSCROLL: //           = 75;
            if (GetCasterLevel(OBJECT_SELF)> 0)
            {nSlot = INVENTORY_SLOT_PACK;}
            else {nSlot = INVENTORY_SLOT_NONE;}
        case BASE_ITEM_MISCMEDIUM: //            = 29;
        case BASE_ITEM_MISCSMALL: //             = 24;
        case BASE_ITEM_HEALERSKIT: //            = 39;
        case BASE_ITEM_KEY: //                   = 65;
        case BASE_ITEM_LARGEBOX: //              = 66;
        case BASE_ITEM_MAGICROD: //              = 44;
        case BASE_ITEM_MAGICSTAFF: //            = 45;
        case BASE_ITEM_POTIONS: //               = 49;
        case BASE_ITEM_CSLASHWEAPON: //          = 69;
        case BASE_ITEM_CPIERCWEAPON: //          = 70;
        case BASE_ITEM_CBLUDGWEAPON: //          = 71;
        case BASE_ITEM_CSLSHPRCWEAP: //          = 72;
        case BASE_ITEM_CREATUREITEM: //          = 73;
            nSlot = INVENTORY_SLOT_PACK;
            break;
        case BASE_ITEM_INVALID: //             = 256;
            break;
    }
    return nSlot;
}
/////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
struct Equipment Queueing(struct Equipment EquipQue, int nSlot)

    {
    object oSwap = OBJECT_INVALID;
    SetIdentified(EquipQue.oTemp,TRUE);
    switch (nSlot)
    {
        case INVENTORY_SLOT_HEAD:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oHead))
                {oSwap = EquipQue.oHead; EquipQue.oHead = EquipQue.oTemp; EquipQue.oTemp = oSwap; }
                break;
        case INVENTORY_SLOT_CHEST:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oChest))
                {oSwap = EquipQue.oChest; EquipQue.oChest = EquipQue.oTemp;EquipQue.oTemp = oSwap; }
                break;
        case INVENTORY_SLOT_BOOTS:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oBoots))
                {oSwap = EquipQue.oBoots; EquipQue.oBoots = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_ARMS:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oArms))
                {oSwap = EquipQue.oArms; EquipQue.oArms = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_CLOAK :
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oCloak))
                {oSwap = EquipQue.oCloak; EquipQue.oCloak = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_LEFTRING:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oLRing))
                {oSwap = EquipQue.oLRing; EquipQue.oLRing = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            //break removed.
        case INVENTORY_SLOT_RIGHTRING:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oRRing))
                {oSwap = EquipQue.oRRing; EquipQue.oRRing = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_NECK :
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oNeck))
                {oSwap = EquipQue.oNeck; EquipQue.oNeck = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_BELT :
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oBelt))
                {oSwap = EquipQue.oBelt; EquipQue.oBelt = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_LEFTHAND:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oSmallW))
                {oSwap = EquipQue.oSmallW; EquipQue.oSmallW = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oSmallW2))
                {oSwap = EquipQue.oSmallW2; EquipQue.oSmallW2 = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            // break; removed
        case INVENTORY_SLOT_RIGHTHAND:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oMedW))
                {oSwap = EquipQue.oMedW; EquipQue.oMedW = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
           break;
        case 20: //INVENTORY_SLOT_2HANDED:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.o2Hand))
                {oSwap = EquipQue.o2Hand; EquipQue.o2Hand = EquipQue.oTemp;EquipQue.oTemp = oSwap;}
            break;
        case 21: //INVENTORY_SLOT_BOW:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oBow))
                {oSwap = EquipQue.oBow; EquipQue.oBow = EquipQue.oTemp;EquipQue.oTemp = oSwap;}
            break;
        case 22: //INVENTORY_SLOT_SHIELD:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oShield))
                {oSwap = EquipQue.oShield; EquipQue.oShield = EquipQue.oTemp;EquipQue.oTemp = oSwap;}
        case INVENTORY_SLOT_ARROWS :
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oArrows))
                {oSwap = EquipQue.oArrows; EquipQue.oArrows = EquipQue.oTemp; EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_BULLETS:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oBullets))
                {oSwap = EquipQue.oBullets; EquipQue.oBullets = EquipQue.oTemp;EquipQue.oTemp = oSwap;}
            break;
        case INVENTORY_SLOT_BOLTS:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oBolts))
                {oSwap = EquipQue.oBolts; EquipQue.oBolts = EquipQue.oTemp;EquipQue.oTemp = oSwap; }
            break;
        case 26: //INVENTORY_SLOT_DOUBLE:
            if (GetGoldPieceValue(EquipQue.oTemp) > GetGoldPieceValue(EquipQue.oDouble))
                {oSwap = EquipQue.oDouble;EquipQue.oDouble = EquipQue.oTemp;EquipQue.oTemp = oSwap; }
            break;
        case 25: //INVENTORY_SLOT_PACK:
            EquipQue.oTemp = OBJECT_INVALID;break;
        default: EquipQue.oTemp = OBJECT_INVALID; break;
        case 99: //INVENTORY_SLOT_NONE:
            break;
        }
        return EquipQue;
}
///////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////
struct Equipment EquipGenT (struct Treasure GeneratedTreasure, struct Equipment EquipQueue, object oBag, int nCr)
{
    struct Treasure Scroll;
    int nTClass = nCr/4; if (nTClass > 4) {nTClass = 4;}
    if (GeneratedTreasure.ItemOne == "arcanescrollshee")
            {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);
                GeneratedTreasure.ItemOne == "";    }
    else if (GeneratedTreasure.ItemOne == "divinescrollshee")
            {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);
                GeneratedTreasure.ItemOne == "";    }
    else
        {
            EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemOne, OBJECT_SELF,1);
            if (IsArrows(EquipQueue.oTemp))
                {EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemOne,OBJECT_SELF,d10(3)); }
            EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
            ActionGiveItem(EquipQueue.oTemp,oBag);  SetIdentified(EquipQueue.oTemp,FALSE);
            EquipQueue.oTemp = OBJECT_INVALID;
    }

    if (MagicLevel = SYR_HIGH)
        {
            if (GeneratedTreasure.ItemTwo == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);
                GeneratedTreasure.ItemTwo == "";    }
            else if (GeneratedTreasure.ItemTwo == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemTwo == "";    }
            else
            {
                EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemTwo, OBJECT_SELF,1);
                if (IsArrows(EquipQueue.oTemp))
                    {EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemTwo,OBJECT_SELF,d10(3)); }
                EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                EquipQueue.oTemp = OBJECT_INVALID;
            }
        }
    if (MagicLevel != SYR_LOW)
        {
            if (GeneratedTreasure.ItemThree == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemThree == "";    }
            else if (GeneratedTreasure.ItemThree == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemThree == "";    }
            else
            {
                EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemThree, OBJECT_SELF,1);
                if (IsArrows(EquipQueue.oTemp))
                    {EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemThree,OBJECT_SELF,d10(3)); }
                EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                EquipQueue.oTemp = OBJECT_INVALID;
            }

            if (GeneratedTreasure.ItemFour == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemFour == "";    }
            else if (GeneratedTreasure.ItemFour == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemFour == "";    }
            else
            {
                EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemFour, OBJECT_SELF,1);
                if (IsArrows(EquipQueue.oTemp))
                    {EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemFour,OBJECT_SELF,d10(3)); }
                EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                EquipQueue.oTemp = OBJECT_INVALID;
            }

            if (GeneratedTreasure.ItemFive == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemFive == "";    }
            else if (GeneratedTreasure.ItemFive == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemFive == "";    }
            else
                {
                    EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemFive, OBJECT_SELF,1);
                    if (IsArrows(EquipQueue.oTemp))
                        {EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemFive,OBJECT_SELF,d10(3)); }
                    EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                    ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }

            if (GeneratedTreasure.ItemSix == "arcanescrollshee")
                {   Scroll = SyCreateArcaneScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemSix == "";    }
            else if (GeneratedTreasure.ItemSix == "divinescrollshee")
                {   Scroll = SyCreateDivineScroll(nCr);Scroll = Itemize(Scroll);
                    GeneratedTreasure.ItemSix == "";    }
            else
                {
                    EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemSix, OBJECT_SELF,1);
                    if (IsArrows(EquipQueue.oTemp))
                        {EquipQueue.oTemp = CreateItemOnObject(GeneratedTreasure.ItemSix,OBJECT_SELF,d10(3)); }
                    EquipQueue = Queueing (EquipQueue,WhereToEquip(EquipQueue,nTClass));
                    ActionGiveItem(EquipQueue.oTemp,oBag); SetIdentified(EquipQueue.oTemp,FALSE);
                    EquipQueue.oTemp = OBJECT_INVALID;
                }
        }
    return EquipQueue;
}

