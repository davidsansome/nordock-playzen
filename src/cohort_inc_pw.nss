//::///////////////////////////////////////////////
//:: Cohort Pesistent World Include
//:: cohort_inc_pw
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This include file provide Cohort PW support specific
    funtions:

        GetOffsetGameDate()
        PWCohort_RestoreState()
        PWCohort_SaveState()
        PWCohort_InitState()
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
/*
    v1.0.6  - Poorly written functions to deal with Persistent Cohorts
*/
#include "cohort_inc"

//::///////////////////////////////////////////////
//:: GetOffsetGameDate(int iOffset = 0)
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function was written by DragonTayl for the DragonTayl
    Persistent Wold Jail System.

    This will be used when comparing world dates when we implement Cohorts
    or Masters abandoning each other.
*/
//:://////////////////////////////////////////////
//:: Created By: DragonTayl
//:: Created On:
//:://////////////////////////////////////////////
int GetOffsetGameDate(int iOffset = 0)
{
      /* If a negative number was given (note that -1
         is the default from the calling scripts) then
         this variable does not automatically expire. */
      if (iOffset < 0)
        return -1;
      else
      /* Otherwise, return the number of days from "0/0/0".
         Which means if a zero was sent, the variable
         expires at the end of the current game day.*/
      {
          // Get the game calendar date
          int iYear = GetCalendarYear();
          int iMonth = GetCalendarMonth();
          int iDay = GetCalendarDay();

          // Add to the appropriate integer until iOffset == 0
          while (iOffset > 335)
            {
              iYear++;
              iOffset -= 336;
            }
          while (iOffset > 27)
            {
              iMonth++;
              iOffset -= 28;
            }
          while (iOffset > 1)
            {
              iDay++;
              iOffset--;
            }
          /* Now, if we have more than 28 days, roll the
             month, and if we have more than 12 months,
             roll the year - due to the way the year, month,
             and days were added above, it should be impossible
             to have more than 24 months or 56 days. */
          if (iDay > 28)
            {
              iDay -= 28;
              iMonth++;
            }
          if (iMonth > 12)
            {
              iMonth -= 12;
              iYear++;
            }
          return iYear*336 + iMonth*28 + iDay;
    }
}

//::///////////////////////////////////////////////
//:: PWCohort_RestoreState(object oCohort = OBJECT_SELF)
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function is used in cohort_ac9. Calling this function will restore
    the last saved Cohort state to the caller.
*/
//:://////////////////////////////////////////////
//:: Created By: yibble
//:: Created On:
//:://////////////////////////////////////////////
void PWCohort_RestoreState(object oCohort = OBJECT_SELF)
{
    object oItem;
    int nCount = 1;
    int nNumItems = 0;
    object oModule = GetModule();
    string sTag = GetTag(oCohort);

    // clear current stock.

    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oCohort)))
        DestroyObject(oItem);
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oCohort)))
        DestroyObject(oItem);

    oItem = GetFirstItemInInventory(oCohort);
    while((GetIsObjectValid(oItem)) && (nCount < NUM_INVENTORY_SLOTS))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oCohort);
        nCount ++;
    }

    //destroy existing gold.
    TakeGoldFromCreature(GetGold(oCohort), oCohort, TRUE);

    // create new stock.
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_ARMS_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_BELT_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_BOOTS_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_CHEST_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_CLOACK_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_HEAD_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_LEFTHAND_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_LEFTRING_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_NECK_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_RIGHTHAND_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_RIGHTRING_ItemResRef"), oCohort);
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_ARROWS_ItemResRef"), oCohort, GetPersistentInt(oCohort, "INVENTORY_SLOT_ARROWS_ItemStack"));
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_BOLTS_ItemResRef"), oCohort, GetPersistentInt(oCohort, "INVENTORY_SLOT_BOLTS_ItemStack"));
    CreateItemOnObject(GetPersistentString(oCohort, "INVENTORY_SLOT_BULLETS_ItemResRef"), oCohort, GetPersistentInt(oCohort, "INVENTORY_SLOT_BULLETS_ItemStack"));

    nCount = 1;
    string sItemResRef = GetPersistentString(oCohort, "ItemResRef1");
    nNumItems = GetPersistentInt(oCohort, "ItemStack1");

    while((GetStringLength(sItemResRef) != -1) && (nCount < NUM_INVENTORY_SLOTS))
    {
        if(nNumItems > 1)
            CreateItemOnObject(sItemResRef, oCohort, nNumItems);
        else
            CreateItemOnObject(sItemResRef, oCohort);
        nCount ++;
        nNumItems = GetPersistentInt(oCohort, "ItemStack" + IntToString(nCount));
        sItemResRef = GetPersistentString(oCohort, "ItemResRef" + IntToString(nCount));
    }

    // create gold.
    GiveGoldToCreature(oCohort, GetPersistentInt(oCohort, "ItemGold"));

    // get dressed!
    ExecuteScript("cohort_equip",oCohort);

/*
    This comment here for reference purposes only.

    int PWS_PLAYER_STATE_ALIVE = 0;
    int PWS_PLAYER_STATE_DYING = 1;
    int PWS_PLAYER_STATE_DEAD = 2;
    int PWS_PLAYER_STATE_STABLE = 3;
    int PWS_PLAYER_STATE_DISABLED = 4;
    int PWS_PLAYER_STATE_RECOVERY = 5;
    int PWS_PLAYER_STATE_STABLEHEAL = 6;
    int PWS_PLAYER_STATE_RESURRECTED = 7;
    int PWS_PLAYER_STATE_RESTRUE = 8;
    int PWS_PLAYER_STATE_RAISEDEAD = 9;
*/

    int nCurrentState = GPS(oCohort);

    switch(nCurrentState)
    {
        case 0:     ActionDoCommand(ActionJumpToLocation(GetPersistentLocation(oCohort, "PV_START_LOCATION")));
                    break;

        case 2:     DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, FALSE), oCohort));
                    break;

        default:    ActionDoCommand(ActionJumpToLocation(GetPersistentLocation(oCohort, "PV_START_LOCATION")));
                    break;
    }
}

//::///////////////////////////////////////////////
//:: PWCohort_SaveState(object oCohort = OBJECT_SELF)
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Guess what, we save the state using this.
*/
//:://////////////////////////////////////////////
//:: Created By: yibble
//:: Created On:
//:://////////////////////////////////////////////
void PWCohort_SaveState(object oCohort = OBJECT_SELF)
{
    object oItem;
    int nCount = 1;
    int nNumItems = 0;
    object oModule = GetModule();
    string sTag = GetTag(oCohort);
    int nTotalItems = 0;

    // clear current stock list.
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_ARMS_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_BELT_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_BOOTS_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_CHEST_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_CLOAK_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_HEAD_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_LEFTHAND_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_LEFTRING_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_NECK_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_RIGHTHAND_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_RIGHTRING_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_ARROWS_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_BULLETS_ItemResRef");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_BOLTS_ItemResRef");

    DeletePersistentInt(oCohort, "INVENTORY_SLOT_ARROWS_ItemStack");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_BULLETS_ItemStack");
    DeletePersistentInt(oCohort, "INVENTORY_SLOT_BOLTS_ItemStack");

    while(nCount < NUM_INVENTORY_SLOTS)
    {
        DeletePersistentString(oCohort, "ItemResRef" + IntToString(nCount));
        DeletePersistentInt(oCohort, "ItemStack" + IntToString(nCount));
        nCount ++;
    }


    // create new stock list.
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_ARMS_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_BELT_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_BOOTS_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_CHEST_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_CLOAK_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_HEAD_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_LEFTHAND_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_LEFTRING_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_NECK_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort,"INVENTORY_SLOT_RIGHTHAND_ItemResRef", GetResRef(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort,"INVENTORY_SLOT_RIGHTRING_ItemResRef", GetResRef(oItem));
    }

    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort,"INVENTORY_SLOT_ARROWS_ItemResRef", GetResRef(oItem));
        SetPersistentInt(oCohort, "INVENTORY_SLOT_ARROWS_ItemStack", GetNumStackedItems(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_BOLTS_ItemResRef", GetResRef(oItem));
        SetPersistentInt(oCohort, "INVENTORY_SLOT_BOLTS_ItemStack", GetNumStackedItems(oItem));
    }
    if(GetIsObjectValid(oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oCohort)))
    {
        nTotalItems ++;
        SetPersistentString(oCohort, "INVENTORY_SLOT_BULLETS_ItemResRef", GetResRef(oItem));
        SetPersistentInt(oCohort, "INVENTORY_SLOT_BULLETS_ItemStack", GetNumStackedItems(oItem));
    }



    oItem = GetFirstItemInInventory(oCohort);
    nCount = 1;
    while((GetIsObjectValid(oItem)) && (nCount < NUM_INVENTORY_SLOTS))
    {
        SetPersistentString(oCohort, "ItemResRef" + IntToString(nCount), GetResRef(oItem));
        if(nNumItems = GetNumStackedItems(oItem) > 1)
            SetPersistentInt(oCohort, "ItemStack" + IntToString(nCount), nNumItems);
        oItem = GetNextItemInInventory(oCohort);
        nCount ++;
        nTotalItems ++;
    }

    // take note of gold.
    SetPersistentInt(oCohort, "ItemGold", GetGold(oCohort));

    // save current location as well.
    SetPersistentLocation(oCohort, "PV_START_LOCATION", GetLocation(oCohort));

    // save hitdice.
    SetPersistentInt(oCohort, "HitDice", GetHitDice(oCohort));

    SendMessageToPC(GetRealMaster(oCohort), GetName(oCohort) + ": I have noted " + IntToString(nTotalItems) + " items, and " + IntToString(GetGold(oCohort)) + " gold pieces. My current location is " + GetName(GetArea(oCohort)) + ".");
}

//::///////////////////////////////////////////////
//:: PWCohort_InitState(object oCohort = OBJECT_SELF)
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Use to initialise the Cohort state. Used in cohort_ac9 when the cohort is
    first ever spawned.
*/
//:://////////////////////////////////////////////
//:: Created By: yibble
//:: Created On:
//:://////////////////////////////////////////////
void PWCohort_InitState(object oCohort = OBJECT_SELF)
{
    string sTag = GetTag(oCohort);

    SetPersistentLocation(oCohort, "EmergencyHomeBase", GetLocation(GetObjectByTag(COHORTTOWNCENTRE + sTag)));
    SetPersistentLocation(oCohort, "PV_START_LOCATION", GetLocation(oCohort));
    SetPersistentInt(oCohort, "HitDice", GetHitDice(oCohort));
}
