//cohort_inc, built from nw_i0_henchman
//originally modified by Pausanias, and 69MEH69.
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier integration. Added modified multiple henchmen support originally
//based off the work of mistermister.
/*
    v1.0.6  - Added PW Cohort support.
*/

#include "paus_inc_generic"
#include "cohort_inc_vars"
#include "hc_inc_transfer"
#include "hc_inc_remeff"

object PC()
{
    return GetPCLevellingUp();
}

// * this is turned off again when the player talks to
// * his henchman after finding him again.
void SetDidDie(int bDie)
{
    if(PWCOHORT)
        SetPersistentInt(OBJECT_SELF, "NW_L_HEN_I_DIED", bDie);
    else
        SetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED", bDie);
}
int GetDidDie()
{
    if(PWCOHORT)
    {
        int oDied = GetPersistentInt(OBJECT_SELF, "NW_L_HEN_I_DIED");
        if (oDied == 1)
        {
            SetPersistentInt(OBJECT_SELF, "NW_L_HEN_I_DIED", 0);
            return TRUE;
        }
    }
    else
    {
        int oDied = GetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED");
        if (oDied == 1)
        {
            SetLocalInt(OBJECT_SELF,  "NW_L_HEN_I_DIED", 0);
            return TRUE;
        }
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Set/GetBeenHired
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Henchmen can only be hired once, ever.
  This checks or sets the local on the henchmen
  that keeps track whether they've ever been hired.
  STORED: On Henchman
  RETURNS: Boolean
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
void SetBeenHired(int bHired=TRUE, object oTarget=OBJECT_SELF)
{
    if(PWCOHORT)
        SetPersistentInt(oTarget, "NW_L_HENHIRED", 10);
    else
        SetLocalInt(oTarget,"NW_L_HENHIRED",10);
}
int GetBeenHired(object oTarget=OBJECT_SELF)
{
    if(PWCOHORT)
        return GetPersistentInt(oTarget, "NW_L_HENHIRED") == 10;
    else
        return GetLocalInt(oTarget,"NW_L_HENHIRED") == 10;
}
// * This local is on the player
// * it is true if this particular henchman
// * is working for the player
void SetWorkingForPlayer(object oPC)
{
    if(PWCOHORT)
        SetPersistentInt(oPC,"NW_L_HIRED" + GetTag(OBJECT_SELF),10);
    else
        SetLocalInt(oPC,"NW_L_HIRED" + GetTag(OBJECT_SELF),10);
}
int GetWorkingForPlayer(object oPC)
{
    if(PWCOHORT)
        return GetPersistentInt(oPC,"NW_L_HIRED" + GetTag(OBJECT_SELF)) == 10;
    else
        return GetLocalInt(oPC,"NW_L_HIRED" + GetTag(OBJECT_SELF)) == 10;
}

//Written by 69MEH69 03Sep2002
//modified by 0100010.
//Checks to see whether or not the PC can hire the NPC
int GetCanWork(object oHirer, object oHiree)
{
    int nHirer = GetHitDice(oHirer);
    int nHiree = GetHitDice(oHiree);
    int nLevel = nHirer - nHiree;

    if (USELEADERSHIP) {
        if (nHirer < 6 || !GetHasFeat(FEAT_SKILL_FOCUS_PERSUADE,oHirer))
            return FALSE;
    }
    if(nLevel < COHORTLAG)
        return FALSE;
    return TRUE;
}

int GetAlignmentIsOK(object oHirer, object oHiree)
{
    if (ALIGNRESTRICT==2) return TRUE;
    if (ALIGNRESTRICT==0) {
        if (GetAlignmentLawChaos(oHirer)==GetAlignmentLawChaos(oHiree) &&
            GetAlignmentGoodEvil(oHirer)==GetAlignmentGoodEvil(oHiree))
        {
            return TRUE;
        }
    }
    else {
        switch (GetAlignmentLawChaos(oHirer)) {
            case ALIGNMENT_NEUTRAL: break;
            case ALIGNMENT_LAWFUL:
                    if (GetAlignmentLawChaos(oHiree)==ALIGNMENT_CHAOTIC)
                        return FALSE;
                    break;
            case ALIGNMENT_CHAOTIC:
                    if (GetAlignmentLawChaos(oHiree)==ALIGNMENT_LAWFUL)
                        return FALSE;
        }
        switch (GetAlignmentGoodEvil(oHirer)) {
            case ALIGNMENT_NEUTRAL: break;
            case ALIGNMENT_GOOD:
                    if (GetAlignmentGoodEvil(oHiree)==ALIGNMENT_EVIL)
                        return FALSE;
                    break;
            case ALIGNMENT_EVIL:
                    if (GetAlignmentGoodEvil(oHiree)==ALIGNMENT_GOOD)
                        return FALSE;
        }
        return TRUE;
    }
    return FALSE;
}

//By 0100010
//Checks to see if it is ok to hire more cohorts
int CanAddMoreHenchmen(object oMaster)
{
    object oHench = GetHenchman(oMaster);
    int henchcount = 0;
    while (GetIsObjectValid(oHench))
    {
        henchcount = henchcount + 1;
        oHench = GetHenchman(oHench);
    }
    return (henchcount < MAXCOHORTS);
}

void strip_equiped(object oPlayer, object oDeathCorpse, object oEquip)
{
    if(GetIsObjectValid(oEquip))
        AssignCommand(oDeathCorpse, ActionTakeItem(oEquip, oPlayer));
}

void MakeCohortDeathCorpse(object oDeadCohort)
{
    // If we are using the loot sytem, strip all items from the dead man
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
    {
        location lDiedHere = GetLocation(oDeadCohort);
        string sID = GetName(OBJECT_SELF);
        object oDeathCorpse = GetLocalObject(oMod,"DeathCorpse"+sID);

        // If the player went strait to DEAD without going through DYING then we
        // need to make a Death Corpse to put things in
        if(GetIsObjectValid(oDeathCorpse) == FALSE)
        {
            oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse", lDiedHere);
            SetLocalObject(oDeathCorpse,"Owner",oDeadCohort);
            SetLocalString(oDeathCorpse,"Name",GetName(oDeadCohort));
            SetLocalString(oDeathCorpse,"Key",sID);
            SetLocalObject(oMod,"DeathCorpse"+sID,oDeathCorpse);
            hcTransferObjects(oDeadCohort, oDeathCorpse, 2);
        }
        else if(GetTag(oDeathCorpse)=="DyingCorpse")
        {
            object oDC = oDeathCorpse;
            oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse", lDiedHere);
            SetLocalObject(oDeathCorpse,"Owner",oDeadCohort);
            SetLocalString(oDeathCorpse,"Name",GetName(oDeadCohort));
            SetLocalString(oDeathCorpse,"Key",sID);
            SetLocalObject(oMod,"DeathCorpse"+sID,oDeathCorpse);
            hcTransferObjects(oDC, oDeathCorpse, 2);
        }
        // Now that they are DEAD, make a Player Corpse Token that others can use
        // to drag their carcass to a cleric
        object oDeadMan;
        if(GetIsObjectValid(
            oDeadMan = GetLocalObject(oMod,"PlayerCorpse"+sID))==FALSE)
            oDeadMan = CreateItemOnObject("PlayerCorpse", oDeathCorpse);
        else
            SetLocalInt(oDeadCohort,"REDEATH",0);
        SetLocalObject(oDeadMan,"Owner",oDeadCohort);
        SetLocalObject(oDeadMan,"DeathCorpse",oDeathCorpse);
        SetLocalString(oDeadMan,"Name",GetName(oDeadCohort));
        SetLocalString(oDeadMan,"Key",sID);
        SetLocalInt(oDeadMan,"Alignment",GetAlignmentGoodEvil(oDeadCohort));
        SetLocalString(oDeadMan,"Deity",GetDeity(oDeadCohort));
        SetLocalObject(oDeathCorpse,"PlayerCorpse",oDeadMan);
        SetLocalObject(oMod,"PlayerCorpse"+sID,oDeadMan);
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_ARMS, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_ARROWS, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BELT, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BOLTS, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BOOTS, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_BULLETS, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_CHEST, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_CLOAK, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_HEAD, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_LEFTRING, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_NECK, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDeadCohort));
        strip_equiped(oDeadCohort, oDeathCorpse, GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oDeadCohort));
    }
}

void SendDeadCohortToRepository(object formerMaster)
{
    SPS(OBJECT_SELF, PWS_PLAYER_STATE_DEAD);
    SetLocalInt(OBJECT_SELF,"MOVING",1);

    if(PWCOHORT)
        SetPersistentObject(OBJECT_SELF, "NW_L_FORMERMASTER", formerMaster);
    else
        SetLocalObject(OBJECT_SELF,"NW_L_FORMERMASTER", formerMaster);

    MakeCohortDeathCorpse(OBJECT_SELF);
    DelayCommand(0.1, RemoveEffects(OBJECT_SELF));
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), OBJECT_SELF));
    object oWay = GetObjectByTag("COHORT_REPOSITORY");
    if (GetIsObjectValid(oWay) == TRUE)
    {
        if(PWCOHORT)
            SetPersistentLocation(OBJECT_SELF, "PV_START_LOCATION", GetLocation(oWay));
        AssignCommand(OBJECT_SELF,DelayCommand(0.2, JumpToObject(oWay, FALSE)));
    }
    else
        AssignCommand(OBJECT_SELF,DelayCommand(0.2, ActionSpeakString("Debug Info: I have no place to go on death. COHORT_REPOSITORY not placed.")));
    DeleteLocalInt(OBJECT_SELF,"NEGATIVEHP");
    DeleteLocalInt(OBJECT_SELF,"BLEEDCOUNTER");
}

// * Had to fix NW_CH_CHECK_37 so that it checks
// * to see if the player is the former master of the henchman

object GetFormerMaster(object oHench = OBJECT_SELF)
{
    if(PWCOHORT)
        return GetPersistentObject(oHench, "NW_L_FORMERMASTER");
    else
        return GetLocalObject(oHench,"NW_L_FORMERMASTER");
}
void SetFormerMaster(object oPC, object oHench)
{
    if(PWCOHORT)
        SetPersistentObject(oHench, "NW_L_FORMERMASTER", oPC);
    else
        SetLocalObject(oHench,"NW_L_FORMERMASTER", oPC);
}

int GetCanLevelUp(object oPC, object meLevel = OBJECT_SELF)
{
    int nMasterLevel = GetHitDice(oPC);
    int nMyLevel = GetHitDice(meLevel);
    if ((nMasterLevel > (nMyLevel + COHORTLAG)) && (nMyLevel < MAXCOHORTLEVEL))
        return TRUE;
    return FALSE;
}
//::///////////////////////////////////////////////
//:: CopyLocals
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Copies locals from the 'earlier'
    level henchmen to the newer henchman.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:
//:://////////////////////////////////////////////
void CopyLocals(object oSource, object oTarget)
{
    if (GetIsObjectValid(oTarget) == FALSE)
        AssignCommand(PC(), SpeakString("Target invalid"));
    else {
        if (GetIsObjectValid(oSource) == FALSE)
            AssignCommand(PC(), SpeakString("Source invalid"));
    }
  SetBeenHired(GetBeenHired(oSource), oTarget);
  SetLocalInt(oTarget, "NW_ASSOCIATE_MASTER", GetLocalInt(oSource, "NW_ASSOCIATE_MASTER"));
}
// * assumes that a succesful GetCanLevelUp has already
// * been tested.    Will level up character to one level
// * less than player.
// * meLevel defaults to object self unless another object is passed in
// * returns the new creature


// Modified by Pausanias: DoLevelUp gives items to new henchman

// GetHasSimilarItem: this is to check whether the henchman has upgraded items
int GetHasSimilarItem(object oHench,object oTest)
{
   int i,is1;
   string s1, s2;

   PrintString(GetName(oTest));
   if (GetBaseItemType(oTest) == BASE_ITEM_POTIONS) return FALSE;

   object oItem = GetItemPossessedBy(oHench,GetTag(oTest));
   if (GetIsObjectValid(oItem)) {
        if (GetIdentified(oTest)) SetIdentified(oItem,TRUE);
        return TRUE;
   }

   for(i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oItem = GetItemInSlot(i,oHench);
        PrintString(IntToString(i)+GetName(oItem));
        if (oItem != OBJECT_INVALID)
           switch (GetBaseItemType(oItem)) {
            case BASE_ITEM_CREATUREITEM: break;

            default: {
                int iLength = GetStringLength(GetName(oTest))-2;
                s1 = GetName(oItem);
                s2 = GetName(oTest);
                PrintString(s1+s2+IntToString(GetStringLength(s1))+
                            IntToString(GetStringLength(s2)));

                if (GetStringLength(s1) == GetStringLength(s2)) {
                   is1 = StringToInt(GetStringRight(s1,1));

                   if (GetStringLeft(s1,iLength) == GetStringLeft(s2,iLength)) {
                       PrintString("Match!");
                       if (is1 > 0 && is1 > StringToInt(GetStringRight(s2,1))) {
                           if (GetIdentified(oTest)) SetIdentified(oItem,TRUE);
                           PrintString(GetName(oTest)+" is similar to "+GetName(oItem));
                           return TRUE;
                       }
                       else {
                           DestroyObject(oItem);
                           return FALSE;
                       }
                   }
                }
            }
            break;
          }
   }

    oItem = GetFirstItemInInventory(oHench);
    while (GetIsObjectValid(oItem)) {
        s1 = GetName(oItem);
        s2 = GetName(oTest);
        int iLength = GetStringLength(GetName(oTest))-2;
        PrintString(s1+s2+IntToString(GetStringLength(s1)) + IntToString(GetStringLength(s2)));
        if (GetStringLength(s1) == GetStringLength(s2)) {
            is1 = StringToInt(GetStringRight(s1,1));

            if (GetStringLeft(s1,iLength) == GetStringLeft(s2,iLength)) {
                if (is1 > 0 && is1 > StringToInt(GetStringRight(s2,1))) {
                    if (GetIdentified(oTest))
                        SetIdentified(oItem,TRUE);
                    PrintString(GetName(oTest)+" is similar to "+GetName(oItem));
                    return TRUE;
                }
                else {
                    DestroyObject(oItem);
                    return FALSE;
                }
            }
        }
        oItem = GetNextItemInInventory(oHench);
    }
    return FALSE;
}

object DoLevelUp(object oPC, object MeLevel = OBJECT_SELF)
{
    int  i;
    int nMasterLevel = GetHitDice(oPC);
    int nLevel =  nMasterLevel - COHORTLAG;
    object oItem,oCopy;

    // * Copy variables to the PC for 'safekeeping'
    CopyLocals(MeLevel, oPC);

    if (nLevel > MAXCOHORTLEVEL)
        nLevel = MAXCOHORTLEVEL;

    // * if already the highest level henchmen
    // * then do nothing.
    if (GetHitDice(MeLevel) >= nLevel)
        return OBJECT_INVALID;


    string sLevel = IntToString(nLevel);
    // * add a 0 if necessary
    if (GetStringLength(sLevel) == 1)
        sLevel = "0" + sLevel;

    //0100010: Added extra leading zero because that is the default naming when
    //you use "Edit Copy" off of an existing blueprint. Got tired of always forgeting
    //to delete the extra zero.
    sLevel = "0" + sLevel;

    string sNewFile = GetTag(MeLevel) + sLevel;
    AssignCommand(MeLevel, ClearAllActions());
    AssignCommand(MeLevel, PlayAnimation(ANIMATION_LOOPING_MEDITATE));

    object henchmenrepository = GetObjectByTag("COHORT_REPOSITORY");
    object oNew;
    if (GetIsObjectValid(henchmenrepository))
        oNew = CreateObject(OBJECT_TYPE_CREATURE, sNewFile, GetLocation(henchmenrepository), TRUE);
    else
        oNew = CreateObject(OBJECT_TYPE_CREATURE, sNewFile, GetLocation(MeLevel), TRUE);

    if (!GetIsObjectValid(oNew) || GetTag(oNew)=="NW_BADGER") {
        //Badgers? I don't need no stinking Badgers!
        SendMessageToPC(GetRealMaster(MeLevel),"Object for blueprint '" + sNewFile + "' not found. Aborting level up.");
        DestroyObject(oNew, 1.0);
        return OBJECT_INVALID;
    }

    //cannot use the RemoveCohort function becaue we are both removing from and adding
    //to the chain.
    object oMaster = GetMaster(MeLevel);
    RemoveHenchman(oMaster, MeLevel);
    //MR: <new code>
    object oldHench = GetHenchman(MeLevel);
    if (GetIsObjectValid(oldHench))
    {
        RemoveHenchman(MeLevel, oldHench);
        AddHenchman(oNew, oldHench);
    }
    //MR: </new code>

    // Pausanias: copy items for now
    AssignCommand(MeLevel, AddHenchman(oMaster, oNew));

    object oNewItem;
    for(i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oItem = GetItemInSlot(i,MeLevel);
        if (oItem != OBJECT_INVALID)
           switch (GetBaseItemType(oItem)) {
            case BASE_ITEM_CREATUREITEM: break;

            default: {
                if (!GetHasSimilarItem(oNew,oItem)) {
                    oNewItem = CreateItemOnObject(GetTag(oItem),oNew,GetNumStackedItems(oItem));
                    if (GetIdentified(oItem)) SetIdentified(oNewItem,TRUE);
                }
            }
            break;
        }
    }

    oItem = GetFirstItemInInventory(MeLevel);
    while (GetIsObjectValid(oItem)) {
        //if (!GetHasSimilarItem(oNew,oItem)) {
            oNewItem = CreateItemOnObject(GetTag(oItem),oNew,GetNumStackedItems(oItem));
            if (GetIdentified(oItem)) SetIdentified(oNewItem,TRUE);
        //}
        oItem = GetNextItemInInventory(MeLevel);
    }


    ExecuteScript("cohort_equip",oNew);

    if (GetIsObjectValid(henchmenrepository))
        AssignCommand(oNew,DelayCommand(0.5,ActionJumpToLocation(GetLocation(MeLevel))));

    SetIsDestroyable(TRUE,FALSE,FALSE);

    // Pausanias: transfer local variables
    SetLocalObject(oNew,"HenchBag",GetLocalObject(MeLevel,"HenchBag"));
    SetLocalInt(oNew,"HenchmanInv",GetLocalInt(MeLevel,"HenchmanInv"));
    SetLocalInt(oNew,"NewHenchChallenge",GetLocalInt(MeLevel,"NewHenchChallenge"));
    SetLocalInt(oNew,"HenchRange",GetLocalInt(MeLevel,"HenchRange"));
    SetLocalInt(oNew,"DoNotCastMelee",GetLocalInt(MeLevel,"DoNotCastMelee"));
    SetLocalInt(oNew,"DoNotHealMelee",GetLocalInt(MeLevel,"DoNotHealMelee"));

    // yibble: transfer local variables
    if(SEEKEMPLOYMENT)
        if(GetIsObjectValid(GetLocalObject(MeLevel, "SeekingEmploymentBy")))
            SetLocalObject(oNew, "SeekingEmploymentBy", GetLocalObject(MeLevel, "SeekingEmploymentBy"));

    DestroyObject(MeLevel, 1.0);
    DelayCommand(0.4, CopyLocals(oPC, oNew));

    return oNew;
}

void UseScrollOnObject(int iSpell, object oTarget)
{
    object oItem;
    object oOwner = GetLocalObject(oTarget, "Owner");

    if(iSpell == SPELL_RESURRECTION)
    {
        if(!(GetIsObjectValid(oItem = GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR702"))))
            oItem = GetItemPossessedBy(OBJECT_SELF,"Resurrection");
        if(REZFEEDBACK)
        {
            SpeakString(REZFEEDBACK1);
            SendMessageToPC(oOwner, GetName(OBJECT_SELF) + ": " + REZFEEDBACK2);
        }
    }
    else if(iSpell == SPELL_RAISE_DEAD)
    {
        if(!(GetIsObjectValid(oItem = GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR501"))))
            oItem = GetItemPossessedBy(OBJECT_SELF,"RaiseDead");
        if(REZFEEDBACK)
        {
            SpeakString(REZFEEDBACK1);
            SendMessageToPC(oOwner, GetName(OBJECT_SELF) + ": " + REZFEEDBACK3);
        }
    }

    DestroyObject(oItem);
    ClearAllActions();
    ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
    AssignCommand(OBJECT_SELF, DelayCommand(3.0, ActionCastSpellAtObject(iSpell, oTarget, METAMAGIC_ANY, TRUE)));
}
