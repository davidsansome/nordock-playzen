//Hardcore DMTool Composite
//Archaegeo 2002 June 24

//(Individual credits in other scripts)

// ** This script goes in the OnItemActivation event of your Module
// ** Properties.  It checks to see if the item used is a DM Helper
// ** And if so, and the user isnt a DM, destroys it, otherwise it
// ** Starts the DM Helper working.  "jth_dmwand" contains the actual
// ** code that controls the Helpers effects.  If you update anything
// ** in it, you must recompile the calling dmw_<name> script to make
// ** the change take effect.
// 27 June - Modified to support player raise deads.

// Include files, first is for the DM Helper, second for Recall stones if you
// use them, and third is the hc_inc file for all hc constants

// Modified 7/9/2002 by Brandon Mathis
// Added if cleric is 17th level or higher, and the player has enough
// gold, the cleric will cast true ressurection.
// Changed: Raise dead now cost 50*Cleric Level + 500 per PhB.
// Ressurection cost 70*cleric level + 500 per phb.
// True Ressurection cost 90*Cleric Level + 5000 per PhB.

// Modified 8/17/2002 by Edward Beck (0100010)
// Added support for food,drink, and water canteen items for use with HTF system.

#include "hc_inc"
#include "hc_inc_on_act"
#include "hc_text_activate"
#include "ats_inc_activate"
#include "rr_drunk_inc"
#include "rr_persist"
//#include "wm_include"
#include "hc_inc_remeff"
//#include "hc_inc_pwdb_func"
//#include "hc_text_activate"
//#include "hc_inc_rezpen"
#include "tha_furniture"
#include "nky_functions"
#include "0_ntfm_inc"

object oOther;
string eTag = "________________________________";

  int isMeat(string oMeat)
{
    if (oMeat=="hc_meat")
        return TRUE;
    else
    if (oMeat=="ATS_R_BADG_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BEAR_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_COUG_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_DEER_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BBAT_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BLAB_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_POLB_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BCAT_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_CCAT_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_WSTA_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_WWOL_N_MEAT")
        return TRUE;
    else
    //'Cant cook on that' spam fix created by Death 08/08/2003
    if (FindSubString(GetStringUpperCase(oMeat),"RAW") != -1)
        return TRUE;
    else
        return FALSE;
}
// housing functions

void THA_PlaceableDeed(object oUser, object oItem, string sItemTag)
{
    object oOwner = GetLocalObject(GetArea(oUser),"Owner");

    if(oOwner == oUser)
    {
        object oDeed = GetFirstItemInInventory(oUser);

        object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,oUser);
        int nWP = StringToInt(GetStringRight(GetTag(oWP),2));
        location pLoc = GetLocation(oWP);

        while((oDeed!= OBJECT_INVALID))
        {
            if(GetResRef(oDeed) == "ahousedeed")
                break;

            oDeed = GetNextItemInInventory(oUser);
        }

        string dTag = GetTag(oDeed);
        string nTag, sFurnID;

        sFurnID = GetFurnitureID(sItemTag);

        if(sFurnID == "_")
        {
            FloatingTextStringOnCreature("Furniture ID error: "+sItemTag,oUser,FALSE);
            CopyObject(oItem,GetLocation(oUser),oUser,sItemTag);
            return;
        }

        if(dTag == "empty")
            nTag = GetSubString(eTag,0,(nWP-1))+sFurnID+GetSubString(eTag,nWP,(32-nWP));

        else
            nTag = GetSubString(dTag,0,(nWP-1))+sFurnID+GetSubString(dTag,nWP,(32-nWP));

        if(GetStringLength(nTag) != 32)
        {
            FloatingTextStringOnCreature("Fatal Housing Error, nTag not 32 - unknown reason.",oUser,FALSE);
            return;
        }

        //Update the House Deed for new furniture
        CopyObject(oDeed,GetLocation(oUser),oUser,nTag);
        DestroyObject(oDeed);

        //Create the furniture, destroy the deed.
        object oPLC = CreateObject(OBJECT_TYPE_PLACEABLE,sItemTag,pLoc);
        AssignCommand(oPLC,SetFacing(GetFurnitureFacing(sItemTag,oWP)));

        //Debug Strings
        //AssignCommand(oUser,SpeakString((nTag)+" len: "+IntToString(GetStringLength(nTag))));));
    }
}

void THA_DeletePlaceable(object oUser, object oItem, string sItemTag, object oOther)
{
    object oOwner = GetLocalObject(GetArea(oUser),"Owner");

    if(oOwner == oUser)
    {
        object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,oOther);
        int wNum = StringToInt(GetStringRight(GetTag(oWP),2));

        string nTag = GetSubString(sItemTag,0,(wNum-1))+"_"+GetSubString(sItemTag,(wNum),(32-wNum));

        if(nTag == eTag)
            nTag = "empty";

        if(GetStringLength(nTag) != 32)
        {
            FloatingTextStringOnCreature("Fatal Housing Error, nTag not 32 - unknown reason.",oUser,FALSE);
            return;
        }

        else
        {
            //Set int for furnisparks
            SetLocalInt(oWP,"furniplace",FALSE);
            //Destroy the furniture
            DestroyObject(oOther);

            //Update the house deed
            CopyObject(oItem,GetLocation(oUser),oUser,nTag);
            DestroyObject(oItem);

            //Debug Strings
            //AssignCommand(oUser,SpeakString((nTag)+" len: "+IntToString(GetStringLength(nTag))));
        }
    }

    return;
}

void THA_KeyUse(object oUser, object oItem, string sItemTag, object oOther)
{
    object oOwner = GetLocalObject(GetArea(oUser),"Owner");

    if(oOwner == oUser)
    {
        AssignCommand(oUser,SpeakString(GetName(oOther)+"!! I cast you out!!"));
        AssignCommand(oOther,ActionJumpToObject(GetLocalObject(GetArea(OBJECT_SELF),"FrontDoor")));
    }

    return;
}

//------------------------------------------------------------------------------

void main()
{
    object oItem=GetItemActivated();
    object oUser=GetItemActivator();
    object oOther=GetItemActivatedTarget();


    // Added By Death 08 November 2003 - DM Console
    ExecuteScript("dmc_onactivateit", GetItemActivator());

    //added for DMFI wandset
    ExecuteScript("dmfi_activate", GetItemActivator());

    if(!preEvent()) return;
    ATS_CheckActivatedItem(GetItemActivator(), GetItemActivated(),
        GetItemActivatedTarget(), GetItemActivatedTargetLocation());




    string sItemTag=GetTag(oItem);
    string sResRef = GetResRef(oItem);

//housing calls

    if(FindSubString(sItemTag,"furn") != -1)
        THA_PlaceableDeed(oUser,oItem,sItemTag);

    else if(FindSubString(sResRef,"house_key") != -1)
        THA_KeyUse(oUser,oItem,sItemTag,oOther);

    //Targetted placeable for destruction
    else if((sResRef == "ahousedeed") && (GetObjectType(oOther) == OBJECT_TYPE_PLACEABLE))
        THA_DeletePlaceable(oUser,oItem,sItemTag,oOther);

    //Targetted a location
    else if(sResRef == "ahousedeed")
        SignalEvent(GetArea(oUser),EventUserDefined(502));

    if(sItemTag=="TrackerTool" &&
       GetLevelByClass(CLASS_TYPE_RANGER, oUser) > 0)
    {
        ExecuteScript("hc_track_start", oUser);
        postEvent();
        return;
    }
    if(sItemTag=="hc_paladinsymb" &&
       GetLevelByClass(CLASS_TYPE_PALADIN,oUser)>0)
    {
        ExecuteScript("hc_pal_detevil",oUser);
        postEvent();
        return;
    }
    if ( sItemTag == "hc_palbadgecour" )
    {
        if(GetLevelByClass(CLASS_TYPE_PALADIN, oUser) < 2)
        {
            SendMessageToPC(oUser,NOINSPIRE);
            postEvent();
            return;
        }
        location lHere = GetItemActivatedTargetLocation();
        oOther=GetFirstObjectInShape(SHAPE_SPHERE,3.0,GetLocation(oUser),FALSE,OBJECT_TYPE_CREATURE);
        effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oUser);
        while ( GetIsObjectValid(oOther) )
        {
            if ( (GetIsFriend(oOther,oUser)) && (oOther != oUser ) )
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_WILL,4,SAVING_THROW_TYPE_FEAR),oOther,d6(2)*6.0);
                if ( GetIsPC(oOther) )
                    SendMessageToPC(oOther,IMBUECOURAGE);
            }
            oOther=GetNextObjectInShape(SHAPE_SPHERE,3.0,GetLocation(oUser),FALSE,OBJECT_TYPE_CREATURE);
        }
    }
// Thieves' Tools
    if ((sItemTag == "thievesTools") || (sItemTag == "thievesToolsMaster"))
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        SetLocalString(oUser,"TAG",sItemTag);
        ExecuteScript("hc_act_thieftool",oUser);
        postEvent();
        return;
    }
    if (sItemTag == "BookOfSummons")
    {
        AssignCommand(oUser,ActionStartConversation(oUser,"hc_c_bookofsummo",TRUE));
    }
    // Active trap searching, gets rid of auto Take 20 problem.
//    if (sItemTag == "searchtool")
//    {
//        SetLocalObject(oUser,"OTHER",oOther);
//        SetLocalObject(oUser,"ITEM",oItem);
//        ExecuteScript("hc_act_search",oUser);
//        postEvent();
//        return;
//    }
   //Begin Healer's Kit = With thanks to Andalus for taking the time to make.
    if(sItemTag=="hc_healkit")
    {
        if(GetIsPC(oOther) == FALSE)
        {
            postEvent();
            return;
        }
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("hc_act_healkit",oUser);
        postEvent();
        return;
    }
    //End Healer's Kit


    if(sItemTag=="hc_skinning")
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("hc_act_skinning",oUser);
        postEvent();
        return;
    }
    if(sItemTag=="hc_acidflask" ||
       sItemTag=="hc_alchfire" ||
       sItemTag=="hc_holywater" ||
       sItemTag=="hc_tangle" ||
       sItemTag=="hc_thunder")
    {
        SetLocalObject(oUser,"GRENADE",oItem);
        SetLocalObject(oUser,"GRENADETARGET",oOther);
        ExecuteScript("hc_grenade", oUser);
    }
    if(sItemTag=="hc_oilflask")
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("hc_act_oilflask",oUser);
        postEvent();
        return;
    }
    if(FindSubString(sItemTag,"PotionOf")!= -1)
    {
        object oTarget=GetItemActivatedTarget();
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        SetLocalString(oUser,"TAG",sItemTag);
        ExecuteScript("hc_act_potion",oUser);
        postEvent();
        return;
    }

//DM's Helper 2.0.2 Script Below
//Added by Jarketh Thavin Oct 3, 2002

   object oActivator=GetItemActivator();

   if(GetTag(oItem)=="DMsHelper")
   {
      // Test to make sure the activator is a DM, or is a DM
      // controlling a creature.
      if(GetIsDM(oActivator) != TRUE)
      {
         object oTest = GetFirstPC();
         string sTestName = GetPCPlayerName(oActivator);
         int nFound = FALSE;
         while (GetIsObjectValid(oTest) && (! nFound))
         {
            if (GetPCPlayerName(oTest) == sTestName)
            {
               if(GetIsDM(oTest))
               {
                  nFound = TRUE;
               }
               else
               {
                  DestroyObject(oItem);
                  SendMessageToPC(oActivator,"You are mortal and this is not yours!");
                  return;
               }
            }
            oTest=GetNextPC();
         }
      }
      // get the wand's activator and target, put target info into local vars on activator
      object oMyActivator = GetItemActivator();
      object oMyTarget = GetItemActivatedTarget();
      SetLocalObject(oMyActivator, "dmwandtarget", oMyTarget);
      location lMyLoc = GetItemActivatedTargetLocation();
      SetLocalLocation(oMyActivator, "dmwandloc", lMyLoc);

      //Make the activator start a conversation with itself
      AssignCommand(oMyActivator, ActionStartConversation(oMyActivator, "dmwand", TRUE));
      return;
   }

   if(GetTag(oItem)=="AutoFollow")
   {
      object oTarget = GetItemActivatedTarget();
      if(GetIsObjectValid(oTarget))
      {
         AssignCommand ( oActivator, ActionForceFollowObject(oTarget));
      }
      return;
   }

   if(GetTag(oItem)=="WandOfFX")
   {

       // get the wand's activator and target, put target info into local vars on activator
      object oDM = GetItemActivator();
      object oMyTarget = GetItemActivatedTarget();
      SetLocalObject(oDM, "FXWandTarget", oMyTarget);
      location lTargetLoc = GetItemActivatedTargetLocation();
      SetLocalLocation(oDM, "FXWandLoc", lTargetLoc);

      object oTest=GetFirstPC();
      string sTestName = GetPCPlayerName(oDM);
      // Test to make sure the activator is a DM, or is a DM
      // controlling a creature.

      if(GetIsDM(oDM) != TRUE)
      {
         object oTest = GetFirstPC();
         string sTestName = GetPCPlayerName(oDM);
         int nFound = FALSE;
         while (GetIsObjectValid(oTest) && (! nFound))
         {
            if (GetPCPlayerName(oTest) == sTestName)
            {
               if(GetIsDM(oTest))
               {
                  nFound = TRUE;
               }
               else
               {
                  DestroyObject(oItem);
                  SendMessageToPC(oDM,"You are mortal and this is not yours!");
                  return;
               }
            }
            oTest=GetNextPC();
         }
      }

      //Make the activator start a conversation with itself
      AssignCommand(oDM, ActionStartConversation(oDM, "fxwand", TRUE));
      return;

   }
   if(GetTag(oItem)=="EmoteWand")
   {
      AssignCommand(oActivator, ActionStartConversation(oActivator, "emotewand", TRUE));
      return;
   }
//End DM's Helpwe Scripts

  if(sItemTag=="PlayerCorpse")
  {
    object oCleric=GetItemActivatedTarget();
    object oRespawner=GetLocalObject(oItem, "Owner");
    SetLocalObject(oUser,"CLERIC",oCleric);
    SetLocalObject(oUser,"DEADMAN",oRespawner);
    SetLocalObject(oUser,"ITEM",oItem);
//    ExecuteScript("hc_act_pct",oUser);
  }

if (sItemTag=="BTokenofPossession")
{
    SendMessageToPC(oUser,"Token Passed");

    if (GetTag(oOther)=="summonpillar")

        {
        // setup
            location lTarget = GetLocation(GetObjectByTag("pillar"));
            object oMod = GetModule();
            //SPI(oUser, "nMainQuest", 1);

            SendMessageToPC(oUser,"Pillar passed");
            // Remmed out by EagleC so quest is repeatable by others
            // DestroyObject(GetObjectByTag("summonshaft"));
            effect eGate=EffectVisualEffect(VFX_FNF_SUMMON_GATE);
            AssignCommand(oUser, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGate, GetLocation(oUser), 4.0));
            AssignCommand(oUser, DelayCommand(1.5, JumpToObject(GetObjectByTag("Galdorpeak"))));
            AssignCommand(GetObjectByTag("pillar"), DelayCommand(1.0,ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE), lTarget)));
            SetLocalInt(oMod, "nQuestDone", TRUE);
            // Remmed out by EagleC so quest is repeatable by others
            // DestroyObject(GetObjectByTag("summonpillar"));
            // DestroyObject(GetObjectByTag("GaldorCity"));
            // CreateObject(OBJECT_TYPE_PLACEABLE,"galdorport",lTarget,TRUE);
            // Remmed out by EagleC so quest is repeatable by others
            // AssignCommand(GetObjectByTag("4th_StairDown"), ActionCloseDoor(OBJECT_SELF));
            // ActionWait(5.0);
            // SetLocked(GetObjectByTag("4th_StairDown"), 1);
        }
    return;
}
// Portal Pendant - Main Quest Winged Pendant Amulet

    if (sItemTag=="PendantWing")
    {
        string sPCLoc=GetTag(GetArea(oUser));
        int nPCLevel=GetHitDice(oUser);
// returns True or False
        int nAllow=GetAllowTeleport(GetArea(oUser));

        if ((nAllow==TRUE) && (nPCLevel>15))
        {
            SetLocalInt(GetEnteringObject(),"arena", FALSE);
            AssignCommand(oUser, ActionStartConversation(oUser,"goldportal", TRUE));
        }
        else if ((nAllow==FALSE) && (nPCLevel>15))
                    FloatingTextStringOnCreature("The pendant does not work here.", oUser);
        else if ((nAllow==TRUE) && (nPCLevel<16))
                    FloatingTextStringOnCreature("You are not experienced enough to use this.", oUser);
        return;
    }

// Booze!

    if (IsBooze(oItem))
    {
        AssignCommand(oUser, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        IncreaseBAC(oUser);
        return;
    }

// Ox
    if (sItemTag=="OxWhistle")
    {
        CreateObject(OBJECT_TYPE_CREATURE,"packox",GetLocation(oUser),TRUE);
        return;
    }

// Gnomish Automaton
    if (sItemTag=="ATS_C_Z307_N_GOL")
    {
        ExecuteScript("rr_automaton",oUser);
        return;
    }

// Gnomish Helper
    if (sItemTag=="ATS_C_Z309_N_BRO")
    {
        ExecuteScript("rr_gnome_help",oUser);
        return;
    }
// Balm of True Rez
    if (sItemTag == "balmoftrurez")
    {

    //check for cleric levels. If less than 17, no worky
        if ((GetLevelByClass(CLASS_TYPE_CLERIC, oUser)<17) && (!GetIsDM(oUser)))
        {
            SendMessageToPC(oUser,"You are not powerful enough to use this balm!");
            return;
        }
        SetLocalInt(oUser, "UsingBalm", 1);
        DelayCommand(60.0f, SetLocalInt(oUser, "UsingBalm", 0));
        ExecuteScript("tru_rez_list",oUser);
        AssignCommand(oUser, ActionStartConversation(oUser,"tru_rez_conv", TRUE));
    }


    //Used uncooked foods
    if (isMeat(sItemTag))
    {
        if(oOther==OBJECT_INVALID)
        {
            SendMessageToPC(oUser,COOKME);
            return;
        }
        if (FindSubString(GetStringUpperCase(GetTag(oOther)),"FIRE") == -1)
        {
            SendMessageToPC(oUser, CANTCOOK);
            return;
        }
        FloatingTextStringOnCreature(COOKFLOAT,oUser);
        DestroyObject(oItem);
        CreateItemOnObject("cookedfood",oUser);
        return;
    }

    // Changes by Nakey 25-01-04
    // When player uses magic bag they randomly create 1 of 3 items dependant on
    // which bag they used.
    // This line checks if the area has NCP_NO_ACTIVATE int set to 1, which means players cant activate the bags there.
    if(GetLocalInt(GetArea(oUser), "NCP_NO_ACTIVATE"))
    {
        SendMessageToPC(oUser, "This item does not function here.");
    }
    else
    {
        if(sItemTag == "QuiverArrow")
            CreateItemOnObject("Nky_Arows" + IntToString(d3()), oUser, 99);
        else if (sItemTag == "QuiverBolts")
            CreateItemOnObject("Nky_Bolts" + IntToString(d3()), oUser, 99);
        else if (sItemTag == "QuiverDarts")
            CreateItemOnObject("Nky_Darts" + IntToString(d3()), oUser, 50);
        else if (sItemTag == "QuiverShrkn")
            CreateItemOnObject("Nky_Shrkn" + IntToString(d3()), oUser, 50);
        else if (sItemTag == "QuiverThrAx")
            CreateItemOnObject("Nky_ThrAx" + IntToString(d3()), oUser, 50);
        else if (sItemTag == "QuiverBulet")
            CreateItemOnObject("Nky_Bulet" + IntToString(d3()), oUser, 99);
    }
    // DM Resses a player so they dont lose any xp - Added by Nakey on 18-02-04
    // See script nky_functions for further details
    if(GetTag(GetItemActivated()) == "Nky_DMResWand" && GetIsDM(oUser))
    {
        NkyDMRes(GetItemActivatedTarget());
    }

// The PC Head, appears on player corpses so that the bounty may be claimed
    if(GetTag(GetItemActivated()) == "PCHEAD")
    {
    string sName;
    sName="This is the head of " + GetLocalString(GetItemActivated(),"Name");
    FloatingTextStringOnCreature(sName, oUser);
    }

    // Tyln Castle Guard Tool
    // Robin - Feb 05
    if(sItemTag == "TylnGuardTool")
    {
        if (GetIsObjectValid(oOther))
        {
            if (FindSubString(GetTag(oOther), "_TCG") == -1)
                SetLocalInt(oUser, "TylnTargetType", 1);
            else
                SetLocalInt(oUser, "TylnTargetType", 2);

            SetLocalObject(oUser, "TylnTarget", oOther);
        }
        else
        {
            SetLocalInt(oUser, "TylnTargetType", 3);
            SetLocalLocation(oUser, "TylnTargetLocation", GetItemActivatedTargetLocation());
        }
        AssignCommand(oUser, ActionStartConversation(oUser, "tyln_guardtool", TRUE, FALSE));
    }

    // DM Quest Wand
    // Robin - Mar 05
    if (sItemTag == "DMQuestWand")
    {
        if (!GetIsDM(oUser))
        {
            DestroyObject(oItem);
            FloatingTextStringOnCreature("The wand vanishes before your very eyes", oUser);
            return;
        }
        if (GetIsObjectValid(oOther) && GetIsPC(oOther))
        {
            SetLocalObject(oUser, "DMQuestWandTarget", oOther);
            AssignCommand(oUser, ActionStartConversation(oUser, "dmquestwand", TRUE, FALSE));
        }
        else
        {
            FloatingTextStringOnCreature("Invalid target", oUser, FALSE);
        }
    }

    // Summons a Penguin
    // Robin - Mar 05
    if (sItemTag == "ArcticOrb")
    {
        ExecuteScript("penguin_summon", oUser);
    }

    // Molotov Cocktail
    // Robin - Mar 05
    if (sItemTag == "MolotovCocktail")
    {
        location lTarget;
        if (GetIsObjectValid(oOther))
            lTarget = GetLocation(oOther);
        else
            lTarget = GetItemActivatedTargetLocation();

        float fDistance = GetDistanceBetweenLocations(GetLocation(oUser), lTarget);

        if (fDistance <= 40.0f)
        {
            AssignCommand(oUser, PlaySound("as_cv_glasbreak2"));
            AssignCommand(oUser, ActionCastSpellAtLocation(SPELL_INCENDIARY_CLOUD, lTarget, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        }
        else
        {
            FloatingTextStringOnCreature("*You are too far away*", oUser, FALSE);
        }
    }

    // DeWolf Brothel Rod
    // Robin - Jun 05
    if (sItemTag == "DeWolfRod")
    {
        int iGold = GPI(oMod, "DeWolfBrothelGold");
        GiveGoldToCreature(oUser, iGold);
        SPI(oMod, "DeWolfBrothelGold", 0);
    }
  postEvent();
}
