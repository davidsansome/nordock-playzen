//------------------------------------------------------------------------------
//
// hc_on_cl_enter
//
// Hardcore Client Entering
// This script goes in OnClientEnter in Module Properties - Events
// It checks to see if they have a Death Amulet on them, and if so
// It sets thier player state to Dead and rekills them.
//
//------------------------------------------------------------------------------
//
// Created By: Archaegeo
// Created On: 24-06-2002
//
// Altered By: Michael Tuffin [Grug]
// Altered On: 05-01-2004
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 003 (05-01-2004)
// - Sending player details to log file on connect
//
// Version: 002 (05-01-2004)
// - Added an ExecuteScript to prevent temporary weapon spells from lasting
//   forever
//
// Version: 001 (21-12-2003)
// - Improved cheat detection for new characters
// - Attempted to add some structure and commenting to the code
//
// Version: 000 (Anything before 20-12-2003)
// - Hardcore ruleset
// - Nordock public
// - DMFI
// - ATS
// - Basic cheat detection
// - DM console ban checks
//
//------------------------------------------------------------------------------

//#include "ats_inc_cl_enter"
#include "hc_inc"
#include "hc_inc_on_enter"
#include "hc_text_enter"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_inc_htf"
#include "nw_i0_tool"
#include "rr_strip_inc"
#include "apts_inc_ptok"
#include "rr_persist"
#include "journal_include"

//------------------------------------------------------------------------------

void HCRBoot(object oPC, string sReason)
{
    SendMessageToPC(oPC,sReason);
    DelayCommand(3.0,BootPC(oPC));
}

//------------------------------------------------------------------------------

location GetSavedLocation(object oPC)
{
    location lLoc = GetPersistentLocation(oPC, "PV_START_LOCATION");
    if (GetAreaFromLocation(lLoc) == OBJECT_INVALID)
    {
        SetLocalInt(oPC, "TMP_VALID_SPAWN", 0);
    }
    else
    {
        SetLocalInt(oPC, "TMP_VALID_SPAWN", 1);
    }

    return lLoc;
}

//------------------------------------------------------------------------------

void PWDB_PlaceCharacter(object oPC)
{
    location lStartPoint;
    object oClient = oPC;
    // Exit and do nothing if this isn't a player.
    if (!GetIsPC(oClient)) return;
    {
        // First check and see if the player has a saved prior location.
        lStartPoint = GetSavedLocation(oClient);
    }
    int iValidSpawn = GetLocalInt(oClient, "TMP_VALID_SPAWN");
    DeleteLocalInt(oClient, "TMP_VALID_SPAWN");
    // If the start is valid, move us there, else do nothing and let the game
    // use the standard start point.
    if (iValidSpawn == 1)
    {
        AssignCommand(oClient, ActionJumpToLocation(lStartPoint));
        SendMessageToPC(oClient, "You have been moved to your previously saved start location");
    }
}

//------------------------------------------------------------------------------


void main()
{
    object oPC = GetEnteringObject();

    // Added by Grug 11-03-2004
    WriteTimestampedLogEntry("<<[ " + GetPCPlayerName(oPC) + " || " +
                             GetName(oPC) + " || " + GetPCPublicCDKey(oPC) +
                             " || " + GetPCIPAddress(oPC) + " ]>>");

    // Added By Death 08 November 2003 - DM Console
    if (GetIsPC(oPC) && !GetIsDM(oPC))
    {
        SQLExecDirect("SELECT * FROM `nordock_banlist`" +
                      " WHERE (`accountname` = '" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "')");
        if (SQLFetch() == SQL_SUCCESS)
        {
            SendMessageToAllDMs("PC '" + GetPCPlayerName(oPC) + "' Booted (In the ban list)");
            PrintString("PC '" + GetPCPlayerName(oPC) + "' Booted (In the ban list)");
            BootPC(oPC);
            return;
        }
    }

  if(!preEvent()) return;
  SetPlotFlag(oPC,FALSE);
  int nPKT=GetLocalInt(oMod,"PKTRACKER");
  int nDM=GetIsDM(oPC);
  string sCDK=GetPCPublicCDKey(oPC);

  // Added by Grug 21-12-2003 to replace old cheat checking script, delete old one
  // if this works well (old one follows)
  // Removed by Robin May 05
  //StatCheck(oPC);
  /*
  if (!GetIsDM(oPC))
  {
  int iSTR = GetAbilityScore(oPC,ABILITY_STRENGTH);
    int iINT = GetAbilityScore(oPC,ABILITY_INTELLIGENCE);
    int iDEX = GetAbilityScore(oPC,ABILITY_DEXTERITY);
    int iWIS = GetAbilityScore(oPC,ABILITY_WISDOM);
    int iCON = GetAbilityScore(oPC,ABILITY_CONSTITUTION);
    int iCHA = GetAbilityScore(oPC,ABILITY_CHARISMA);
    int iTotalAbility = iSTR + iINT + iDEX + iWIS + iCON + iCHA;
    if (iTotalAbility < 175)
        {
        }
    else if (iTotalAbility < 250)
        {
       string sDescription = "\nSuspisious player warning (stats>175)";
       string sSTR = IntToString(GetAbilityScore(oPC,ABILITY_STRENGTH));
       string sINT = IntToString(GetAbilityScore(oPC,ABILITY_INTELLIGENCE));
       string sDEX = IntToString(GetAbilityScore(oPC,ABILITY_DEXTERITY));
       string sWIS = IntToString(GetAbilityScore(oPC,ABILITY_WISDOM));
       string sCON = IntToString(GetAbilityScore(oPC,ABILITY_CONSTITUTION));
       string sCHA = IntToString(GetAbilityScore(oPC,ABILITY_CHARISMA));
       string sMain =  "\n" + GetPCPlayerName(oPC) +
                        " || " + GetName(oPC) +
                        " || " + GetPCPublicCDKey(oPC) +
                        " || " + GetPCIPAddress(oPC) +
                        "\n" + sSTR +
                        " " + sDEX +
                        " " + sCON +
                        " " + sINT +
                        " " + sWIS +
                        " " + sCHA +
                        " || " + IntToString(GetGold(oPC)) +
                        "";
        SendMessageToAllDMs(sDescription + sMain);
        }
    else
        {
       string sDescription = "\nSuspisious player disconnected (stats>250)";
       string sSTR = IntToString(GetAbilityScore(oPC,ABILITY_STRENGTH));
       string sINT = IntToString(GetAbilityScore(oPC,ABILITY_INTELLIGENCE));
       string sDEX = IntToString(GetAbilityScore(oPC,ABILITY_DEXTERITY));
       string sWIS = IntToString(GetAbilityScore(oPC,ABILITY_WISDOM));
       string sCON = IntToString(GetAbilityScore(oPC,ABILITY_CONSTITUTION));
       string sCHA = IntToString(GetAbilityScore(oPC,ABILITY_CHARISMA));
       string sMain =  "\n" + GetPCPlayerName(oPC) +
                        " || " + GetName(oPC) +
                        " || " + GetPCPublicCDKey(oPC) +
                        " || " + GetPCIPAddress(oPC) +
                        "\n" + sSTR +
                        " " + sDEX +
                        " " + sCON +
                        " " + sINT +
                        " " + sWIS +
                        " " + sCHA +
                        " || " + IntToString(GetGold(oPC)) +
                        "";
        SendMessageToAllDMs(sDescription + sMain);
        BootPC(oPC);
        }
   }
  */
  ExecuteScript("fixtempspells", oPC);
  if(nPKT)
  {
    if(GetLocalInt(oMod,"PKCOUNT"+sCDK)>nPKT)
    {
        SendMessageToAllDMs(sCDK+DMBOOTPK);
        HCRBoot(oPC,PCBOOTPK);
        postEvent();
        return;
    }
  }
  if(GetLocalInt(oMod,"SINGLECHARACTER") && !nDM)
  {
    string sRegChar=GetPersistentString(oMod,"SINGLECHARACTER"+sCDK);
    if(sRegChar != "" && sRegChar != GetName(oPC))
    {
        HCRBoot(oPC,SINGLEBOOT+sRegChar);
        postEvent();
        return;
    }
    else
    {
        SetPersistentString(oMod,"SINGLECHARACTER"+sCDK,GetName(oPC));
        SendMessageToPC(oPC,SINGLEREG);
    }
  }
  if(GetLocalInt(oMod,"BANNED"+sCDK))
  {
    HCRBoot(oPC, BANNED);
    postEvent();
    return;
  }
  if(GetLocalInt(oMod,"LOCKED") && !nDM)
  {
    HCRBoot(oPC,LOCKED);
    postEvent();
    return;
  }
  if(GetLocalInt(oMod,"DMRESERVE"))
  {
    int nC;
    object oPlayers=GetFirstPC();
    if(!nDM)
    {
        while(GetIsObjectValid(oPlayers))
        {
            if(!GetIsDM(oPlayers)) nC++;
            oPlayers=GetNextPC();
        }
    }
    if(nC > GetLocalInt(oMod,"DMRESERVE") && nDM==FALSE)
    {
        HCRBoot(oPC,DMRES);
        postEvent();
        return;
    }
  }
  if(!GetLocalInt(oMod,"HCRREAD"))
  {
    SendMessageToPC(oPC,NOHCRENABLED);
    return;
  }
  int nGiveLevel=GetLocalInt(oMod,"GIVELEVEL");
  if(GetLocalInt(oMod,"STORESYSTEM"))
  {
    if(GetIsPC(oPC) && !(GetXP(oPC)) && !nDM)
    {
        string  STORE_NAME      = "NewbieMerchant";

        int     STARTING_GOLD=0;
        int     PLAYER_STRIPS   = TRUE;

        // Giving PC its starting gold.
        if(nGiveLevel > 1 && STARTING_GOLD==0)
        {
            switch (nGiveLevel)
            {
                //case 2:  STARTING_GOLD = 900; break;
                case 2:  STARTING_GOLD = 300; break;
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

        DelayCommand(9.0, SendMessageToPC(oPC, "Welcome, " +
            GetPCPlayerName(oPC) + "! You have been stripped of all your "+
            "belongings and credited with " + IntToString(STARTING_GOLD) + " gp."));

        // Robin - 15-02-2005
        //DelayCommand(9.5, SendMessageToPC(oPC, "The Newbie store will appear shortly."+
        //    "You will have one chance to use it."));

        // Taking PC shopping.
        //object oStore = GetObjectByTag("NewbieMerchant");
        //DelayCommand(12.0, OpenStore(oStore, oPC));
        SetLocalInt(oPC, "CanUseNewbieStore", TRUE);
    }
  }

    if (GetHitDice(oPC) == 40)
    {
        if (GPI(oPC, "GaldorBren") != 1)
            dhAddJournalQuestEntry("bren", 1, oPC, FALSE);
    }


  Subraces_InitSubrace(oPC);
  if (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM")))
  {
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_TRAP);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmune, oPC);
  }


  if(GetHitDice(oPC)< nGiveLevel &&
        nGiveLevel > 1)
  {
    SendMessageToPC(oPC, NEWLEVEL+
        IntToString(nGiveLevel));
    int nNewXP= (nGiveLevel * (nGiveLevel-1)) / 2 * 1000;
    DelayCommand(2.0,SetXP(oPC,nNewXP));
  }
    if(GetLevelByClass(CLASS_TYPE_RANGER,oPC) &&
        GetIsObjectValid(GetItemPossessedBy(oPC,"TrackerTool"))==FALSE)
           CreateItemOnObject("trackertool", oPC);
    // Give Paladins their tools that simulate missing abilities
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>1 &&
        GetIsObjectValid(GetItemPossessedBy(oPC,"hc_palbadgecour"))==FALSE)
           CreateItemOnObject("paladinsbadgeofc", oPC);
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) &&
        GetIsObjectValid(GetItemPossessedBy(oPC,"hc_paladinsymb"))==FALSE)
           CreateItemOnObject("paladinsholysymb", oPC);
    // Give PC's a Trap Tool in inventory
    //    if(GetLocalInt(oMod,"HCRTRAPS") && GetIsObjectValid(GetItemPossessedBy
    //        (oPC,"searchtool"))==FALSE)
    //           CreateItemOnObject("searchtool", oPC);

    // kill search tool, as we no longer need it and it's NODROP
    object TTool=GetItemPossessedBy(oPC,"searchtool");
    if (GetIsObjectValid(TTool))
        DestroyObject(TTool);

    // Give PC's an EmoteWand if using the DMHelper set.
    // if(!GetIsObjectValid(GetItemPossessedBy(oPC,"dmfi_pc_emote")))
    //      CreateItemOnObject("dmfi_pc_emote", oPC);

    // Robin - Jun 05 - Removed autofollow widget
    /*if(!GetIsObjectValid(GetItemPossessedBy(oPC,"dmfi_pc_follow")))
         CreateItemOnObject("dmfi_pc_follow", oPC);*/
    TTool=GetItemPossessedBy(oPC,"dmfi_pc_follow");
    if (GetIsObjectValid(TTool))
        DestroyObject(TTool);

    // Give DM's an ATS Skill Wand in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"ATS_D_DMSW_N_NON"))==FALSE &&
       (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM"))))
           CreateItemOnObject("ats_d_dmsw_n_non", oPC);

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"DMsHelper"))==FALSE &&
       (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM"))))
           CreateItemOnObject("DMsHelper", oPC);
    // Give DM's a FXWand in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"WandOfFX"))==FALSE &&
       (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM"))))
           CreateItemOnObject("WandOfFX", oPC);
    // Give DMs a Quest Wand
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"DMQuestWand"))==FALSE &&
       (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM"))))
           CreateItemOnObject("dmquestwand", oPC);
    // Give new PC's some food.
    if(GetLocalInt(oMod,"FOODSYSTEM") || GetLocalInt(oMod,"HUNGERSYSTEM"))
    {
        if(!GetXP(oPC) && !nDM)
             CreateItemOnObject("FoodRation", oPC);
    }
    // Give new PC's a bedroll for the rest system
    if(GetLocalInt(oMod,"BEDROLLSYSTEM"))
    {
        if(!GetXP(oPC) && !nDM)
            if(GetIsObjectValid(GetItemPossessedBy(oPC,"bedroll"))==FALSE)
                CreateItemOnObject("bedroll", oPC);
    }
    //give a racial ear/language
    if(!GetXP(oPC) && !nDM)
        {
        switch (GetRacialType(oPC))
            {
            case RACIAL_TYPE_DWARF:
                if(GetIsObjectValid(GetItemPossessedBy(oPC,"hlslang_4"))==FALSE)
                    CreateItemOnObject("hlslang_4", oPC);
                break;
            case RACIAL_TYPE_ELF:
                if(GetIsObjectValid(GetItemPossessedBy(oPC,"hlslang_1"))==FALSE)
                    CreateItemOnObject("hlslang_1", oPC);
                break;
            case RACIAL_TYPE_GNOME:
                if(GetIsObjectValid(GetItemPossessedBy(oPC,"hlslang_2"))==FALSE)
                    CreateItemOnObject("hlslang_2", oPC);
                break;
            case RACIAL_TYPE_HALFELF:
                if(GetIsObjectValid(GetItemPossessedBy(oPC,"hlslang_1"))==FALSE)
                    CreateItemOnObject("hlslang_1", oPC);
                break;
            case RACIAL_TYPE_HALFLING:
                if(GetIsObjectValid(GetItemPossessedBy(oPC,"hlslang_3"))==FALSE)
                    CreateItemOnObject("hlslang_3", oPC);
                break;
            case RACIAL_TYPE_HALFORC:
                if(GetIsObjectValid(GetItemPossessedBy(oPC,"hlslang_5"))==FALSE)
                    CreateItemOnObject("hlslang_5", oPC);
                break;
            case RACIAL_TYPE_HUMAN:
                break;
            default:
                break;
            }
        }

    int nCurState=GPS(oPC);
    PrintString(GetPCPlayerName(oPC)+" has current player state of "+IntToString(nCurState));
    int nHP=GetLocalInt(oMod,"LastHP"+GetName(oPC)+sCDK);
    int nCHP=GetCurrentHitPoints(oPC);
    if(GetLocalInt(oMod,"BLEEDSYSTEM"))
    {
      if (nCurState==PWS_PLAYER_STATE_RESURRECTED ||
          nCurState==PWS_PLAYER_STATE_RESTRUE ||
          nCurState==PWS_PLAYER_STATE_RAISEDEAD)
      {
          // Altered by Grug 25-May-2004 to replace with death variable
          if(GetItemPossessedBy(oPC,"fugue_NOD")!=OBJECT_INVALID)
              DestroyObject( GetItemPossessedBy(oPC,"fugue_NOD"));
          if(GPI(oPC, "NCP_DEAD"))
              {
              SPI(oPC, "NCP_DEAD", 0); // Set the player as alive
              }
          if(nCurState!=PWS_PLAYER_STATE_RESTRUE &&
             GetLocalInt(oMod,"REZPENALTY"))
                DelayCommand(5.0,hcRezPenalty(oPC));
          if(nCurState==PWS_PLAYER_STATE_RAISEDEAD)
          {
            effect eDam=EffectDamage(GetCurrentHitPoints(oPC)-1);
            if( !GetLocalInt(oMod,"REZPENALTY"))
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
          }
          SPS(oPC,PWS_PLAYER_STATE_ALIVE);
          RemoveEffects(oPC);
          location lWhere=GetPersistentLocation(oMod,"RESLOC"+GetName(oPC)+sCDK);
          DelayCommand(5.0,AssignCommand(oPC,JumpToLocation(lWhere)));
          DeletePersistentLocation(oMod, "RESLOC"+GetName(oPC)+sCDK);
      }
      // Altered by Grug 25-May-2004 to replace with death variable
      //else if(GetItemPossessedBy(oPC,"fugue_NOD")!=OBJECT_INVALID)
      else if(GPI(oPC, "NCP_DEAD") || (GetItemPossessedBy(oPC,"fugue_NOD")!=OBJECT_INVALID))
      {
        //SPI(oPC, "NCP_DEAD", 0); // Set the player as alive (albeit temporary until they reach fugue again)
        // Remove deprecated robes
        if(GetItemPossessedBy(oPC,"fugue_NOD")!=OBJECT_INVALID)
            {
            DestroyObject( GetItemPossessedBy(oPC,"fugue_NOD"));
            }
        if(GetLocalInt(oMod,"DEATHOVERREBOOT") &&
            nCurState==PWS_PLAYER_STATE_ALIVE)
        {
            SetLocalInt(oPC,"LOGINDEATH",1);
            PrintString(GetPCPlayerName(oPC)+" is dead on login. Sending to Fugue.");
            effect eDeath = EffectDeath(FALSE, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
        }

      }
      else if(nCurState==PWS_PLAYER_STATE_ALIVE)
      {
        if(nHP && nCHP>nHP)
        {
            effect eDam=EffectDamage(nCHP-nHP);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC));
        }
      }
      else if(nCurState != PWS_PLAYER_STATE_ALIVE)
      {
        if(nCurState==PWS_PLAYER_STATE_DYING ||
           nCurState==PWS_PLAYER_STATE_STABLE ||
           nCurState==PWS_PLAYER_STATE_STABLEHEAL)
        {
            effect eDam=EffectDamage(abs(nHP)+nCHP);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC));
        }
        else if(nCurState==PWS_PLAYER_STATE_DEAD)
        {
            PrintString(GetPCPlayerName(oPC)+" is dead on login. Sending to Fugue.");
            SetLocalInt(oPC,"LOGINDEATH",1);
            effect eDeath = EffectDeath(FALSE, FALSE);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC));
        }
        else if(nCurState==PWS_PLAYER_STATE_DISABLED ||
                nCurState==PWS_PLAYER_STATE_RECOVERY)
        {
            effect eDam=EffectDamage(GetCurrentHitPoints(oPC)-1);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC));
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
    if(!GetLocalInt(oMod,"PRIORTHISREBOOT"+sCDK+GetName(oPC)))
    {
        if(nCurState!=PWS_PLAYER_STATE_DEAD)

            if(GetLocalInt(oMod,"purgatory"+sCDK+GetName(oPC)))
                AssignCommand(oPC,JumpToLocation(GetLocation(GetObjectByTag ("purgatory"))));
    //      else
    //          DelayCommand(5.0,PWDB_PdefalaceCharacter(oPC));


        SetLocalInt(oMod,"PRIORTHISREBOOT"+sCDK+GetName(oPC),1);
    }

    InitPCHTFLevels(oPC);

    if(!(GetXP(oPC)))
        SetXP(oPC, 1);
    if(GetLocalInt(oMod,"PWEXP"))
    {
        if(!DND_get_exp(oPC))
            SetUpExp(oPC, 0);
    }
 //Setting custom factions
    //if (GetSubRace(oPC)=="Drow")
    if (GetStringLowerCase(GetSubRace(oPC))=="drow")
    {
           AdjustReputation(oPC,GetObjectByTag("FACTION_DROW"),100);
           AdjustReputation(oPC,GetObjectByTag("FACTION_UNDERDARK"),100);
           AdjustReputation(oPC,GetObjectByTag("Faction_Merchant"),-100);
           AdjustReputation(oPC,GetObjectByTag("Faction_Defender"),-100);
           AdjustReputation(oPC,GetObjectByTag("good_boy"),-100);
    }
    else if (GetStringLowerCase(GetSubRace(oPC))=="duergar")
    {
           AdjustReputation(oPC,GetObjectByTag("duergar_faction"),100);
           AdjustReputation(oPC,GetObjectByTag("FACTION_UNDERDARK"),100);
           AdjustReputation(oPC,GetObjectByTag("Faction_Merchant"),-100);
           AdjustReputation(oPC,GetObjectByTag("Faction_Defender"),-100);
           AdjustReputation(oPC,GetObjectByTag("good_boy"),-100);
    }

    if (GetClassByPosition(1,oPC)==CLASS_TYPE_ROGUE)
    {
           AdjustReputation(oPC,GetObjectByTag("rigorogue"),100);
    }

    //Grug 08/10/2003
    //dropped_level detection removed from remainder of mod, this line left for compatibility
    // clear deleveled variable
    SetLocalInt(oPC,"dropped_level",FALSE);

    // Strip spells and feats if over level 1

     if (GetHitDice(oPC)>1)
         strip_spells(oPC);

    // check for soul frag

    if (HasItem(oPC,"SoulFrag_NOD"))
    {
        SetLocalInt(oPC,"SOULFRAG"+GetName(oPC)+GetPCPublicCDKey(oPC),TRUE);
    }


    // Journal Entries written by HonorBound and implemented by Jarketh Thavin
    DelayCommand(1.0, AddJournalQuestEntry("onenter8", 1, oPC, FALSE, FALSE, FALSE));
    DelayCommand(1.5, AddJournalQuestEntry("onenter7", 1, oPC, FALSE, FALSE, FALSE));
    DelayCommand(2.0, AddJournalQuestEntry("onenter6", 1, oPC, FALSE, FALSE, FALSE));
    DelayCommand(2.5, AddJournalQuestEntry("onenter5", 1, oPC, FALSE, FALSE, FALSE));
    DelayCommand(3.0, AddJournalQuestEntry("onenter4", 1, oPC, FALSE, FALSE, FALSE));
    DelayCommand(3.5, AddJournalQuestEntry("onenter3", 1, oPC, FALSE, FALSE, FALSE));
    DelayCommand(4.0, AddJournalQuestEntry("onenter2", 1, oPC, FALSE, FALSE, FALSE));
    DelayCommand(4.5, AddJournalQuestEntry("onenter1", 1, oPC, FALSE, FALSE, FALSE));

    // Read persistent journal entries
    dhLoadJournalQuestStates(oPC);

    // Send a login message to all players if one exists
    if(GetLocalString(oMod,"LOGINMESSAGE") != "NONE")
        DelayCommand(15.0,SendMessageToPC(oPC,GetLocalString(oMod,"LOGINMESSAGE")));

    // Fix illegal gear
    ExecuteScript("rr_strip_gear",oPC);
    // added for housing

    object oOwner = GetLocalObject(OBJECT_SELF,"Owner");

    int IsPC = GetLocalInt(oPC,"IsAPC");
    int pop = GetLocalInt(OBJECT_SELF,"PCPop");

    if(IsPC)
        SetLocalInt(OBJECT_SELF,"PCPop",pop+1);

    if((IsPC && (oOwner == OBJECT_INVALID)) || (oOwner == oPC))
    {
        SetLocalObject(OBJECT_SELF,"Owner",oPC);
        SignalEvent(OBJECT_SELF,EventUserDefined(500));
    }

    postEvent();
}

//------------------------------------------------------------------------------
