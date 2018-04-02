//Hardcore Client Entering
//Archaegeo 2002 Jun 24

// This script goes in OnClientEnter in Module Properties - Events
// It checks to see if they have a Death Amulet on them, and if so
// It sets thier player state to Dead and rekills them.

#include "nw_i0_tool"
#include "hc_inc"
#include "hc_inc_subrace"
#include "hc_inc_on_enter"
#include "ats_inc_init"



void main()
{
  if(!preEvent()) return;
  object oPC = GetEnteringObject();
  SetPlotFlag(oPC,FALSE);

  if(GetLocalInt(oMod,"PKTRACKER"))
  {
    string sCDK=GetPCPublicCDKey(oPC);
    if(GetLocalInt(oMod,"PKCOUNT"+sCDK)>GetLocalInt(oMod,"PKTRACKER"))
    {
        SendMessageToAllDMs("Booting CDKEY: "+sCDK+" for excessive PK");
        DelayCommand(3.0,BootPC(oPC));
        postEvent();
        return;
    }
  }
  if(GetLocalInt(oMod,"SINGLECHARACTER") && !GetIsDM(oPC))
  {
    string sCDK=GetPCPublicCDKey(oPC);
    if(GetLocalString(oMod,"SINGLECHARACTER"+sCDK) != "" &&
       GetLocalString(oMod,"SINGLECHARACTER"+sCDK) != GetName(oPC))
    {
        SendMessageToPC(oPC,"You are only allowed one character at a time on this "+
            "server. Your registered character is: "+GetLocalString(oMod,
                "SINGLECHARACTER"+sCDK));
        DelayCommand(3.0,BootPC(oPC));
        postEvent();
    }
    else
    {
        SetLocalString(oMod,"SINGLECHARACTER"+sCDK,GetName(oPC));
        SendMessageToPC(oPC,"This character is now registered for this server.");
    }
  }
  if(GetLocalInt(oMod,"LOCKED") && !GetIsDM(oPC))
  {
    SendMessageToPC(oPC,"The module is currently locked.  Please try back later.");
    DelayCommand(3.0,BootPC(oPC));
  }
  if(GetLocalInt(oMod,"DMRESERVE"))
  {
    int nC;
    object oPlayers=GetFirstPC();
    while(GetIsObjectValid(oPlayers) && GetIsDM(oPC)==FALSE)
    {
        nC++;
        oPlayers=GetNextPC();
    }
    if(nC > GetLocalInt(oMod,"DMRESERVE") && GetIsDM(oPC)==FALSE)
    {
        SendMessageToPC(oPC,"Server is full so you are being booted, please try "+
            "again later.");
        DelayCommand(3.0,BootPC(oPC));
        postEvent();
        return;
    }
  }
  if(GetLocalInt(oMod,"STORESYSTEM"))
  {
    if(GetIsPC(oPC) && !(GetXP(oPC)) && !(GetIsDM(oPC)))
    {
        string  STORE_NAME      = "NewbieMerchant";

//If you want everyone to have the same amount of starting gold, modify the
//lines below
//      int     STARTING_GOLD = 150;
        int     STARTING_GOLD;
        int     PLAYER_STRIPS   = TRUE;

// Giving PC its starting gold.
        if(!STARTING_GOLD)
        {
            if(GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)) STARTING_GOLD=d4(4)*10;
            else if(GetLevelByClass(CLASS_TYPE_BARD, oPC)) STARTING_GOLD=d4(4)*10;
            else if(GetLevelByClass(CLASS_TYPE_CLERIC, oPC)) STARTING_GOLD=d4(5)*10;
            else if(GetLevelByClass(CLASS_TYPE_DRUID, oPC)) STARTING_GOLD=d4(2)*10;
            else if(GetLevelByClass(CLASS_TYPE_FIGHTER, oPC)) STARTING_GOLD=d4(6)*10;
            else if(GetLevelByClass(CLASS_TYPE_MONK, oPC)) STARTING_GOLD=d4(5);
            else if(GetLevelByClass(CLASS_TYPE_PALADIN, oPC)) STARTING_GOLD=d4(6)*10;
            else if(GetLevelByClass(CLASS_TYPE_RANGER, oPC)) STARTING_GOLD=d4(6)*10;
            else if(GetLevelByClass(CLASS_TYPE_ROGUE, oPC)) STARTING_GOLD=d4(5)*10;
            else if(GetLevelByClass(CLASS_TYPE_SORCERER, oPC)) STARTING_GOLD=d4(3)*10;
            else if(GetLevelByClass(CLASS_TYPE_WIZARD, oPC)) STARTING_GOLD=d4(3)*10;
            else STARTING_GOLD=d4(4)*10;
        }        if (GetLocalInt(oMod,"GIVELEVEL") > 1)
        if(GetLocalInt(oMod,"GIVELEVEL") > 1)
        {
            switch (GetLocalInt(oMod,"GIVELEVEL"))
            {
                case 2:  STARTING_GOLD = 900; break;
                case 3:  STARTING_GOLD = 2700; break;
                case 4:  STARTING_GOLD = 5400; break;
                case 5:  STARTING_GOLD = 9000; break;
                case 6:  STARTING_GOLD = 13000; break;
                case 7:  STARTING_GOLD = 19000; break;
                case 8:  STARTING_GOLD = 27000; break;
                case 9:  STARTING_GOLD = 36000; break;
                case 10: STARTING_GOLD = 49000; break;
                case 11: STARTING_GOLD = 66000; break;
                case 12: STARTING_GOLD = 88000; break;
                case 13: STARTING_GOLD = 110000; break;
                case 14: STARTING_GOLD = 150000; break;
                case 15: STARTING_GOLD = 200000; break;
                case 16: STARTING_GOLD = 260000 ; break;
                case 17: STARTING_GOLD = 340000; break;
                case 18: STARTING_GOLD = 440000; break;
                case 19: STARTING_GOLD = 580000; break;
                case 20: STARTING_GOLD = 760000; break;
            }
        }
        GiveGoldToCreature(oPC, STARTING_GOLD - GetGold(oPC));
        if (PLAYER_STRIPS)
        {

// Removing PC's equipment.

            object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
        }

// Removing PC's inventory.

        object oStuff = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oStuff))
        {
            DestroyObject(oStuff);
            oStuff = GetNextItemInInventory(oPC);
        }

// Greet PC.

        DelayCommand(3.0, SendMessageToPC(oPC, "Welcome, " +
            GetPCPlayerName(oPC) + "! You have been stripped of all your "+
            "belongings and credited with " + IntToString(STARTING_GOLD) + " gp."));
        DelayCommand(3.0, SendMessageToPC(oPC, "The Newbie store will appear shortly."+
            "You will have one chance to use it."));

// Taking PC shopping.
        object oStore = GetObjectByTag("NewbieMerchant");
        DelayCommand(12.0, OpenStore(oStore, oPC));

    }
  }


  if(GetHitDice(oPC)< GetLocalInt(oMod,"GIVELEVEL") &&
        GetLocalInt(oMod,"GIVELEVEL") > 1)
  {
    SendMessageToPC(oPC, "You have been advanced to level "+
        IntToString(GetLocalInt(oMod,"GIVELEVEL")));
    int nNewXP= (GetLocalInt(oMod,"GIVELEVEL") * (GetLocalInt(oMod,"GIVELEVEL")-1)) / 2 * 1000;
    DelayCommand(2.0,SetXP(oPC,nNewXP));
  }
// Give PC's a Trap Tool in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"searchtool"))==FALSE)
           CreateItemOnObject("searchtool", oPC);
// Give PC DM's a wand version of the HCR helper
//    if(GetPCPublicCDKey(oPC) != "" && GetPCPublicCDKey(oPC)==GetLocalString(oMod,"PLAYERDM"))
//        CreateItemOnObject("HCRHelpwand", oPC);
// Give DM's a HCR Helper in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"HCRHelper"))==FALSE &&
        GetIsDM(oPC) )
           CreateItemOnObject("HCRHelper", oPC);
// Give DM's a DMHelper in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"DMsHelper"))==FALSE &&
       (GetIsDM(oPC) || GetPCPublicCDKey(oPC)==GetLocalString(oMod,"PLAYERDM")))
           CreateItemOnObject("DMsHelper", oPC);
// Give DM's a FXWand in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"WandOfFX"))==FALSE &&
       (GetIsDM(oPC) || GetPCPublicCDKey(oPC)==GetLocalString(oMod,"PLAYERDM")))
           CreateItemOnObject("WandOfFX", oPC);
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"EmoteWand"))==FALSE)
           CreateItemOnObject("EmoteWand", oPC);
// Give new PC's some food.
    if(GetLocalInt(oMod,"FOODSYSTEM"))
    {
        if(GetIsPC(oPC) && !(GetXP(oPC)) && !(GetIsDM(oPC)))
             CreateItemOnObject("FoodRation", oPC);
    }
// Give new PC's a bedroll for the rest system
    if(GetLocalInt(oMod,"BEDROLLSYSTEM"))
    {
        if(GetIsPC(oPC) && !(GetXP(oPC)) && !(GetIsDM(oPC)))
            if(GetIsObjectValid(GetItemPossessedBy(oPC,"bedroll"))==FALSE)
                CreateItemOnObject("bedroll", oPC);
    }
    if(SUBRACESYSTEM)
    {

// Sets up subrace if legal one chosen
        if(use_pc_subrace())
            SendMessageToPC(oPC,"Your subrace of "+GetSubRace(oPC)+" has been enabled.");
            if (GetStringLowerCase(GetSubRace(oPC))=="drow")
            {
                AdjustReputation(oPC,GetObjectByTag("FACTION_DROW"),100);
                if (!HasItem(oPC,"BondofH_NOD"))
                    AdjustReputation(oPC,GetObjectByTag("good_boy"),-100);
            }

    }
    int nCurState=GPS(oPC);
    int nHP=GetLocalInt(oMod,"LastHP"+GetName(oPC)+GetPCPublicCDKey(oPC));
    int nCHP=GetCurrentHitPoints(oPC);
    if(GetLocalInt(oMod,"BLEEDSYSTEM"))
    {
      if(nCurState==PWS_PLAYER_STATE_ALIVE)
      {
        if(nHP && nCHP>nHP)
        {
            effect eDam=EffectDamage(nCHP-nHP);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
        }
      }
      else if(nCurState != PWS_PLAYER_STATE_ALIVE)
      {
        if(nCurState==PWS_PLAYER_STATE_DYING ||
           nCurState==PWS_PLAYER_STATE_STABLE ||
           nCurState==PWS_PLAYER_STATE_STABLEHEAL)
        {
            effect eDam=EffectDamage(abs(nHP)+nCHP);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
        }
        else if(nCurState==PWS_PLAYER_STATE_DEAD)
        {
            SetLocalInt(oPC,"LOGINDEATH",1);
            effect eDeath = EffectDeath(FALSE, FALSE);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC));
        }
        else if(nCurState==PWS_PLAYER_STATE_DISABLED ||
                nCurState==PWS_PLAYER_STATE_RECOVERY)
        {
            effect eDam=EffectDamage(GetCurrentHitPoints(oPC)-1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
        }
      }
    }
    else if(GetLocalInt(oMod,"DEATHSYSTEM"))
    {
        SetLocalInt(oPC,"LOGINDEATH",1);
        effect eDeath = EffectDeath(FALSE, FALSE);
        if(nCurState == PWS_PLAYER_STATE_DEAD)
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
    }
    // Altered by Grug 25-May-2004 to replace with death variable
    if(GetItemPossessedBy(oPC,"fugue_NOD")!=OBJECT_INVALID)
    {
        SPI(oPC, "NCP_DEAD", 0); // Set the player as alive
        DestroyObject( GetItemPossessedBy(oPC,"fugue_NOD"));
        if(GetLocalInt(oMod,"DEATHOVERREBOOT") &&
            nCurState==PWS_PLAYER_STATE_ALIVE)
        {
            SetLocalInt(oPC,"LOGINDEATH",1);
            effect eDeath = EffectDeath(FALSE, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
        }
    }
    if(GPI(oPC, "NCP_DEAD"))
    {
        //SPI(oPC, "NCP_DEAD", 0); // Set the player as alive
        if(GetLocalInt(oMod,"DEATHOVERREBOOT") &&
            nCurState==PWS_PLAYER_STATE_ALIVE)
        {
            SetLocalInt(oPC,"LOGINDEATH",1);
            effect eDeath = EffectDeath(FALSE, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
        }
    }
// set local var for non-damage Inn resting

    SetLocalInt(oPC,"INNREST",0);

// Rogue?? Need to be a rogue in primary class for this to work

    if (GetClassByPosition(1,oPC)==CLASS_TYPE_ROGUE)
        AdjustReputation(oPC,GetObjectByTag("rigorogue"),100);

// Kick ATS into drive
    ATS_InitializePlayer(oPC);

// Send a login message to all players if one exists
    if(!(GetXP(oPC)))
        SetXP(oPC, 1);
    if(GetLocalString(oMod,"LOGINMESSAGE") != "NONE")
        SendMessageToPC(oPC,GetLocalString(oMod,"LOGINMESSAGE"));
      if (!(GetTag(GetArea(oPC))=="Entrance"))
  {
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("playerstart"))));
  }
    postEvent();
}


