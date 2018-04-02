//::///////////////////////////////////////////////
//:: Name  NPC Activities Version 3.0
//:: FileName  NPCACTIVITIES
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:  Deva Bryson Winblood
//:: Created On:  09/23/2002
//:://////////////////////////////////////////////

//--------------------------------------------------------[PROTOTYPES]-------
object GetNPCWaypoint(int nTime,string sIn); // Get a waypoint/object
int GetGNBTime(); // Return Dusk,Dawn,Day,Night
void MoveNPCToDestination(int nRun,object oD); // move the NPC
string ParseGNBDest(string sIn); // Parse version 3.0 destination
string ParseGNBPause(string sIn); // Parse version 3.0 pause interval
string ParseGNBWalkType(string sIn); // Parse version 3.0 Walk method
string ParseGNBHours(string sIn); // Parse version 3.0 hours of operation
void ProcessGNBCommands2(); // Process Version 2.0 commands
void ProcessGNBCommands3(); // Process Version 3.0 commands
string GetGNBWPNum(int nN); // Returns a 01-99 string
object GetObjectWithin(int nObjectType,float fDistance,string sTagPattern,int nNth);

//------------------------------[PROTOTYPES FOR ACTIONS]---------------------
void NPCActionSitChair();
void NPCActionUseNearby();
void NPCActionTalkNearby(int nParm);
void NPCActionHardSleep();
void NPCActionRest();
void NPCActionCleanup();
void NPCActionCloseDoor();
void NPCActionCloseContainer();
void NPCActionPickPockets();
void NPCActionDrink();
void NPCActionRandomInn();
void NPCActionHealOthers();
void NPCActionTaunt();
void NPCActionCreate(int nParm);
void NPCActionEatNearbyFood();
void NPCActionRandomWalk();
void NPCActionBully();
void NPCActionProposition();
void NPCActionFollow(int nParm);
void NPCActionWorship(int nParm);
void NPCActionAttackPlaceable();
void NPCActionLights(int nParm);
void NPCActionMagicEffect(int nParm);
void NPCActionAttackNearby();
void NPCActionDie();
void NPCActionDisappear(int nParm);
void NPCActionTurnUndead();
void NPCActionRandomSpeak(int nParm);
void NPCActionHealSelf();
void NPCActionSetTrap();
void NPCActionRemoveTrap();
void NPCActionPickLock();
void NPCActionKnockSpell();
void NPCActionSing(int nParm);
void NPCActionWakeupSleeper();
void NPCActionCallForHelp();
void NPCActionMakeCampfire();
void NPCActionSetVar(string sParm);
void NPCActionSayPhrase(string sParm);
void NPCActionCopyVar(string sParm);
void NPCActionIfStatement(string sParm);
void NPCActionAddTo(string sParm);
void NPCActionSubtractFrom(string sParm);
void NPCActionChangeClothes(string sParm);
void NPCActionSummonCreature(string sParm);
void NPCActionUserDefinedEvent();
void NPCAct3Set(string sIn);  // Set variable Integer or String
void NPCAct3Add(string sIn);  // Add to variable Integer or String
void NPCAct3Sub(string sIn);  // Subtract from integer variable
void NPCAct3If(string sIn);   // If statements
void NPCAct3NewWP(string sIn);// Specific Waypoint change
void NPCAct3Wait(string sIn); // Wait command
void NPCAct3Random(string sIn); // Random Command



//--------------------------------------------------------[CONSTANTS]--------
int NPCACT_TIME_DUSK        = 0;
int NPCACT_TIME_DAWN        = 1;
int NPCACT_TIME_DAY         = 2;
int NPCACT_TIME_NIGHT       = 3;
int NPCACT_MOVE_RUN         = 0x0000000000000001;
int NPCACT_MOVE_HIDE        = 0x0000000000000002;
int NPCACT_MOVE_SEARCH      = 0x0000000000000004;
int NPCACT_MOVE_TELEP       = 0x0000000000000008;
int NPCACT_MOVE_VFX         = 0x0000000000000010;

/////////////////////////////////////////////////////////////////////
// Main Control Function                              [GenericNPCBehavior]
/////////////////////////////////////////////////////////////////////
void GenericNPCBehavior()
{
  if(GetLocalInt(OBJECT_SELF,"nGNBDisabled")!=1&&!IsInConversation(OBJECT_SELF))
  { // !disabled
     object oDest; // destination object
     object oPC=GetFirstPC(); // Used only for debu purposes
     int nGNBState=GetLocalInt(OBJECT_SELF,"nGNBState");
     string sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
     int nGNBHBCount=GetLocalInt(OBJECT_SELF,"nGNBHBCount"); // hearbeat
     int nGNBMaxHB=GetLocalInt(OBJECT_SELF,"nGNBMaxHB");
     string sGNBDTag=GetLocalString(OBJECT_SELF,"sGNBDTag"); // Dest tag
     int nGNBRun=GetLocalInt(OBJECT_SELF,"nGNBRun"); // Run, Walk, hide, search
     float fGNBPause=GetLocalFloat(OBJECT_SELF,"fGNBPause"); // Pause amount
     string sGNBHours=GetLocalString(OBJECT_SELF,"sGNBHours"); // hours work
     nGNBHBCount++;
     if(nGNBState<0) nGNBState=0;
     if(nGNBState==0)
     {
        ClearAllActions();
        oDest=GetNPCWaypoint(GetGNBTime(),sGNBDTag);
        sGNBDTag=GetTag(oDest);
        MoveNPCToDestination(nGNBRun,oDest);
        nGNBHBCount=0;
        nGNBMaxHB=12;
        nGNBState=1;
        SetLocalInt(OBJECT_SELF,"nGNBVersion",0);
     } // Goto next destination CASE 0
     else if (nGNBState==1)
     {
        oDest=GetObjectByTag(sGNBDTag);
        if(GetCurrentAction()!=ACTION_INVALID)
        { // in motion
         if(nGNBHBCount==nGNBMaxHB)
         { // Kickstart
           ClearAllActions();
           MoveNPCToDestination(NPCACT_MOVE_RUN,oDest);
           nGNBState=1;
         } // Kickstart
         else if (nGNBHBCount>(nGNBMaxHB+5))
         { // Teleport
           ClearAllActions();
           MoveNPCToDestination(NPCACT_MOVE_TELEP,oDest);
           nGNBState=1;
         } // Teleport
        } // in motion
        else
        { // should be there
           if(GetDistanceToObject(oDest)>2.0||GetArea(oDest)!=GetArea(OBJECT_SELF))
           { // not close enough - kickstart
             ClearAllActions();
             MoveNPCToDestination(NPCACT_MOVE_RUN,oDest);
             nGNBState=1;
           } // not close enough - kickstart
           else
           {
            nGNBState=2;
            SetFacing(GetFacing(oDest));
           }
        } // should be there
     } // Wait for arrival      CASE 1
     if(nGNBState==2)
     {
       nGNBMaxHB=0;
       SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nGNBMaxHB);
       oDest=GetObjectByTag(sGNBDTag);
       string sHeader=GetName(oDest);
       if (GetStringLeft(sHeader,1)=="3")
       { // VERSION 3.0 ---------------------
         SetLocalInt(OBJECT_SELF,"nGNBVersion",3);
         sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-2);
         sHeader = ParseGNBDest(sHeader);
         sHeader = ParseGNBPause(sHeader);
         sHeader = ParseGNBWalkType(sHeader);
         sHeader = ParseGNBHours(sHeader);
         sGNBDTag=GetLocalString(OBJECT_SELF,"sGNBDTag");
         fGNBPause=GetLocalFloat(OBJECT_SELF,"fGNBPause");
         nGNBRun=GetLocalInt(OBJECT_SELF,"nGNBRun");
         sGNBHours=GetLocalString(OBJECT_SELF,"sGNBHours");
         sGNBActions=sHeader;
         //SendMessageToPC(oPC,GetTag(OBJECT_SELF)+":D>"+sGNBDTag+":P>"+FloatToString(fGNBPause)+":W>"+IntToString(nGNBRun)+":H>"+sGNBHours);
         //SendMessageToPC(oPC,GetTag(OBJECT_SELF)+"::ACTIONS::"+sGNBActions);
         if (GetStringLength(sGNBActions)>2)
          nGNBState=3;
         else
         { // no commands
           if(fGNBPause>0.0)
           { // do pause
             ActionWait(fGNBPause);
             nGNBState=4;
           } // do pause
           else
             nGNBState=0;
         } // no commands
       } // VERSION 3.0 ---------------------
       else if (GetStringLeft(sHeader,1)=="0"||GetStringLeft(sHeader,1)=="R")
       { // VERSION 2.0 ---------------------
         if (GetStringLeft(sHeader,1)!="R")
         {
           sGNBDTag=GetStringLeft(sHeader,3);
           sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-1);
         }
         else
         {
           sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-1);
           int nRV=Random(StringToInt(GetStringLeft(sHeader,2)))+1;
           sGNBDTag="0"+IntToString(nRV);
         }
         sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-3);
         fGNBPause=IntToFloat(StringToInt(GetStringLeft(sHeader,2)));
         sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-3);
         string cChar=GetStringLeft(sHeader,1);
         sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-2);
         nGNBRun=0;
         if (cChar=="R") nGNBRun=NPCACT_MOVE_RUN;
         else if (cChar=="H") nGNBRun=NPCACT_MOVE_HIDE;
         else if (cChar=="S") nGNBRun=NPCACT_MOVE_SEARCH;
         else if (cChar=="C") nGNBRun=NPCACT_MOVE_HIDE|NPCACT_MOVE_SEARCH;
         else if (cChar=="T") nGNBRun=NPCACT_MOVE_TELEP;
         SetLocalInt(OBJECT_SELF,"nGNBVersion",2);
         sGNBHours=GetStringLeft(sHeader,1);
         sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-2);
         sGNBActions=sHeader;
         if (GetStringLength(sGNBActions)>3)
          nGNBState=3;
         else
         { // no commands
           if (fGNBPause>0.0)
           {
             ActionWait(fGNBPause);
             nGNBState=4;
           }
           else
             nGNBState=0;
         } // no commands
       } // VERSION 2.0 ---------------------
       else
       { // BIOWARE WALKWAYPOINTS -----------
         int nRV=Random(4)+1;
         sGNBDTag="0"+IntToString(nRV);
         nGNBState=0;
       } // BIOWARE WALKWAYPOINTS -----------
      //SendMessageToPC(oPC,GetTag(OBJECT_SELF)+">"+sGNBDTag+":P>"+FloatToString(fGNBPause)+":W>"+IntToString(nGNBRun)+":H>"+sGNBHours+":A>"+sGNBActions);
     } // Interpret the header  CASE 2
     if(nGNBState==3)
     {
       int nGNBMode=GetLocalInt(OBJECT_SELF,"nGNBVersion");
       SetLocalString(OBJECT_SELF,"sGNBActions",sGNBActions);
       SetLocalString(OBJECT_SELF,"sGNBDTag",sGNBDTag);
       //SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" State 3");
       nGNBMaxHB=0;
       SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nGNBMaxHB);
       if (nGNBMode==2)
       { // 2.0 Commands---------------------------------------2.0
         ProcessGNBCommands2();
       } // 2.0 Commands---------------------------------------2.0
       else if (nGNBMode==3)
       { // 3.0 Commands---------------------------------------3.0
         ProcessGNBCommands3();
       } // 3.0 Commands---------------------------------------3.0
       sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
       sGNBDTag=GetLocalString(OBJECT_SELF,"sGNBDTag");
       nGNBMaxHB=GetLocalInt(OBJECT_SELF,"nGNBMaxHB");
       nGNBHBCount=0;
       nGNBState=4;
     } // Get command(s) processCASE 3
     else if (nGNBState==4)
     {
       if (GetCurrentAction()!=ACTION_INVALID)
       { // !AI
         if(nGNBHBCount>=nGNBMaxHB)
         { // stalling better kickstart
           ClearAllActions();
           if (GetStringLength(sGNBActions)>2)
            nGNBState=3;
           else
            nGNBState=0;
         } // stalling better kickstart
       } // !AI
       else
       { // done with commands
         if (GetStringLength(sGNBActions)>2)
           nGNBState=3;
         else
           nGNBState=0;
       } // done with commands
      //SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" State 4");
     } // Wait until done       CASE 4
     SetLocalInt(OBJECT_SELF,"nGNBState",nGNBState);
     SetLocalString(OBJECT_SELF,"sGNBActions",sGNBActions);
     SetLocalInt(OBJECT_SELF,"nGNBHBCount",nGNBHBCount);
     SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nGNBMaxHB);
     SetLocalString(OBJECT_SELF,"sGNBDTag",sGNBDTag);
     SetLocalInt(OBJECT_SELF,"nGNBRun",nGNBRun);
     SetLocalFloat(OBJECT_SELF,"fGNBPause",fGNBPause);
     SetLocalString(OBJECT_SELF,"sGNBHours",sGNBHours);
  } // !disabled
} // GenericNPCBehavior()

//////////////////////////////////////////////////////////////////////////////
//  Support Functions
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------[GNBDoAction]-----------
int GNBDoAction(string sAct,string sGNBActions)
{ // Process the commands
  int nGNBMaxHB=0;
  //object oPC=GetFirstPC(); // debug
  //SendMessageToPC(oPC,">>"+GetTag(OBJECT_SELF)+">>"+sAct);
  if (sAct=="SIT")
      {
        NPCActionSitChair();
        nGNBMaxHB=10;
      } // SIT ON SITABLE   [1]
     else if (sAct=="SITC")
      {
        ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,60.0);
        nGNBMaxHB=10;
      }// SIT ON SIT CROSS  [2]
     else if (sAct=="USE")
      {
         NPCActionUseNearby();
         nGNBMaxHB=3;
      } // USE NEARBY OBJ   [3]
     else if (sAct=="TALK")
      {
         NPCActionTalkNearby(0);
         nGNBMaxHB=3;
      } // Initiate Talk    [4]
     else if (sAct=="TANM")
     {
        NPCActionTalkNearby(1);
        nGNBMaxHB=3;
     } // Talk Normal       [5]
     else if (sAct=="TAFO")
     {
        NPCActionTalkNearby(2);
        nGNBMaxHB=3;
     } // Talk Forcefuk     [6]
     else if (sAct=="TAPL")
     {
        NPCActionTalkNearby(3);
        nGNBMaxHB=3;
     } // Talk Pleading     [7]
     else if (sAct=="TALA")
     {
        NPCActionTalkNearby(4);
        nGNBMaxHB=3;
     } // Talk Laughing     [8]
     else if (sAct=="SLEP")
     {
        NPCActionHardSleep();
        nGNBMaxHB=20;
     } // SLEEP  Prone      [9]
     else if (sAct=="REST")
     {
        NPCActionRest();
        nGNBMaxHB=20;
     } // REST Crosslegged  [10]
     else if (sAct=="SALT")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE,1.0,1.0);
     } // Salute            [11]
     else if (sAct=="CLEN")
     {
        NPCActionCleanup();
        nGNBMaxHB=3;
     } // Clean Non-Plot    [12]
     else if (sAct=="CLOS")
     {
        NPCActionCloseDoor();
        nGNBMaxHB=3;
     } // Close Nearby Door [13]
     else if (sAct=="CLLD")
     {
        NPCActionCloseContainer();
        nGNBMaxHB=3;
     } // Close containers  [14]
     else if (sAct=="PICK")
     {
        NPCActionPickPockets();
        nGNBMaxHB=5;
     } // Pick Pockets      [15]
     else if (sAct=="DRIN")
     {
       NPCActionDrink();
       nGNBMaxHB=1;
     } // Drink Animation   [16]
     else if (sAct=="INN")
     {
       NPCActionRandomInn();
       nGNBMaxHB=3;
     } // Perform Inn acts  [17]
     else if (sAct=="READ")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_READ,1.0,2.5);
       ActionWait(0.5);
       ActionPlayAnimation(ANIMATION_FIREFORGET_READ,1.0,2.5);
       nGNBMaxHB=1;
     } // Reading Animation [18]
     else if (sAct=="LOW")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0);
     } // Perform Get Low   [19]
     else if (sAct=="MID")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);
     } // Perform Get Mid   [20]
     else if (sAct=="MEDI")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,12.0);
       nGNBMaxHB=3;
     } // Meditation Anim   [21]
     else if (sAct=="HEAL")
     {
       NPCActionHealOthers();
       nGNBMaxHB=3;
     } // Heal nearby       [22]
     else if (sAct=="BOW")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,1.0);
     } // Perform Bow Anim  [23]
     else if (sAct=="GRET")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING,1.0,1.0);
     } // Greeting Animation[24]
     else if (sAct=="TAUN")
     {
       NPCActionTaunt();
       nGNBMaxHB=3;
     } // Taunt nearby      [25]
     else if (sAct=="LIST")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_LISTEN,1.0,2.0);
     } // Listen animation  [26]
     else if (sAct=="LOOK")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0,3.0);
     } // Look Far Anim     [27]
     else if (sAct=="DRUN")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,6.0);
       nGNBMaxHB=2;
     } // Drunk animation   [28]
     else if (sAct=="TIRD")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0,6.0);
       nGNBMaxHB=2;
     } // Tired Animation   [29]
     else if (sAct=="MEAT")
     {
       NPCActionCreate(0);
       nGNBMaxHB=2;
     } // Create Meat here  [30]
     else if (sAct=="FISH")
     {
       NPCActionCreate(1);
       nGNBMaxHB=2;
     } // Create Fish here  [31]
     else if (sAct=="ALE")
     {
       NPCActionCreate(2);
       nGNBMaxHB=2;
     } // Create Ale here   [32]
     else if (sAct=="WINE")
     {
       NPCActionCreate(3);
       nGNBMaxHB=2;
     } // Create Wine here  [33]
     else if (sAct=="SPRT")
     {
       NPCActionCreate(4);
       nGNBMaxHB=2;
     } // Create Spirits    [34]
     else if (sAct=="EAT")
     {
       NPCActionEatNearbyFood();
       nGNBMaxHB=3;
     } // Eat nearby food   [35]
     else if (sAct=="RAND")
     {
       NPCActionRandomWalk();
       nGNBMaxHB=3;
     } // Random Walk       [36]
     else if (sAct=="BULL")
     {
       NPCActionBully();
       nGNBMaxHB=3;
     } // Act as a Bully    [37]
     else if (sAct=="PROP")
     {
       NPCActionProposition();
       nGNBMaxHB=3;
     } // Proposition prost [38]
     else if (sAct=="FOFM")
     {
       NPCActionFollow(0);
       nGNBMaxHB=5;
     } // Follow Female     [39]
     else if (sAct=="FOMA")
     {
       NPCActionFollow(1);
       nGNBMaxHB=5;
     } // Follow Male       [40]
     else if (sAct=="FOAN")
     {
       NPCActionFollow(2);
       nGNBMaxHB=5;
     } // Follow Any        [41]
     else if (sAct=="FOPC")
     {
       NPCActionFollow(3);
       nGNBMaxHB=5;
     } // Follow any PC     [42]
     else if (sAct=="FOFP")
     {
       NPCActionFollow(4);
       nGNBMaxHB=5;
     } // Follow Female PC  [43]
     else if (sAct=="FOMP")
     {
       NPCActionFollow(5);
       nGNBMaxHB=5;
     } // Follow Male PC    [44]
     else if (sAct=="WORS")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,5.0);
       nGNBMaxHB=2;
     } // Worship Animation [45]
     else if (sAct=="WOPC")
     {
       NPCActionWorship(0);
       nGNBMaxHB=3;
     } // Worship PC        [46]
     else if (sAct=="WOCR")
     {
       NPCActionWorship(1);
       nGNBMaxHB=3;
     } // Worship Creature  [47]
     else if (sAct=="ATTK")
     {
       NPCActionAttackPlaceable();
       nGNBMaxHB=3;
     } // Attack Placeable  [48]
     else if (sAct=="LTON")
     {
       NPCActionLights(0);
       nGNBMaxHB=3;
     } // Turn Light on     [49]
     else if (sAct=="LTOF")
     {
       NPCActionLights(1);
       nGNBMaxHB=3;
     } // Turn Light off    [50]
     else if (sAct=="MAG1")
     {
       NPCActionMagicEffect(0);
     } // Magical Effect 1  [51]
     else if (sAct=="MAG2")
     {
       NPCActionMagicEffect(1);
     } // Magical Effect 1  [52]
     else if (sAct=="MAG3")
     {
       NPCActionMagicEffect(3);
     } // Magical Effect 1  [53]
     else if (sAct=="KILL")
     {
       NPCActionAttackNearby();
       nGNBMaxHB=3;
     } // Kill nearby NPC   [61]
     else if (sAct=="DIE")
     {
       NPCActionDie();
     } // NPC Dies here     [62]
     else if (sAct=="DISA")
     {
       NPCActionDisappear(0);
     } // NPC Disappears    [63]
     else if (sAct=="REAP")
     {
       NPCActionDisappear(1);
     } // NPC Reappears     [64]
     else if (sAct=="TURN")
     {
       NPCActionTurnUndead();
       nGNBMaxHB=3;
     } // Turn Undead       [66]
     else if (sAct=="SCRT")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0,1.0);
     } // Scratch Head      [67]
     else if (sAct=="BORD")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED,1.0,1.0);
     } // Bored animation   [68]
     else if (GetStringLeft(sAct,3)=="RNS")
     {
       int nV=StringToInt(GetStringRight(sAct,1))-1;
       if (nV<1) nV=0;
       NPCActionRandomSpeak(nV);
     } // Random Speaking   [69 - 77]
     else if (sAct=="VIC1")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0,1.0);
     } // Victory 1 Anim    [78]
     else if (sAct=="VIC2")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2,1.0,1.0);
     } // Victory 2 Anim    [79]
     else if (sAct=="VIC3")
     {
       ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3,1.0,1.0);
     } // Victory 3 Anim    [80]
     else if (sAct=="PAU1")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,3.0);
       nGNBMaxHB=2;
     } // Pause 1 Animation [81]
     else if (sAct=="PAU2")
     {
       ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,1.0,3.0);
       nGNBMaxHB=2;
     } // Pause 2 Animation [82]
     else if (sAct=="POIS")
     {
       effect ePoison=EffectPoison(POISON_TINY_SPIDER_VENOM);
       ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePoison,OBJECT_SELF,30.0));
     } // Poison Effect     [83]
     else if (sAct=="HELT")
     {
       NPCActionHealSelf();
     } // Heal self         [84]
     else if (sAct=="STTR")
     {
       NPCActionSetTrap();
       nGNBMaxHB=2;
     } // Set Traps         [85]
     else if (sAct=="RMTR")
     {
       NPCActionRemoveTrap();
       nGNBMaxHB=2;
     } // Remove Traps      [86]
     else if (sAct=="PKLK")
     {
       NPCActionPickLock();
       nGNBMaxHB=2;
     } // Pick Lock         [87]
     else if (sAct=="KNOC")
     {
       NPCActionKnockSpell();
       nGNBMaxHB=2;
     } // Cast Knock Spell  [88]
     else if (GetStringLeft(sAct,3)=="SNG")
     {
       int nV=StringToInt(GetStringRight(sAct,1))-1;
       if (nV<1)nV=0;
       NPCActionSing(nV);
       nGNBMaxHB=15;
     } // Sing Song         [89 - 95]
     else if (sAct=="CLAC")
     {
       ClearAllActions();
     } // ClearAllActions() [96]
     else if (sAct=="WAKE")
     {
       NPCActionWakeupSleeper();
       nGNBMaxHB=3;
     } // Wakeup sleeper    [97]
     else if (sAct=="HELP")
     {
       NPCActionCallForHelp();
       nGNBMaxHB=2;
     } // Call for help     [98]
     else if (sAct=="CAMP")
     {
       NPCActionMakeCampfire();
       nGNBMaxHB=2;
     } // Make a campfire   [99]
     else if (sAct=="FLEE")
     {
       nGNBMaxHB=3;
     } // Flee enemy        [117]
     else if (GetStringLeft(sAct,1)=="!")
     {
       NPCAct3Set(sAct);
     } // Set Variable      [103, 104, 108]
     else if (GetStringLeft(sAct,1)=="+")
     {
       NPCAct3Add(sAct);
     } // Add to Variable   [105,106]
     else if (GetStringLeft(sAct,1)=="-")
     {
       NPCAct3Sub(sAct);
     } // Subtract          [107]
     else if (GetStringLeft(sAct,1)=="&")
     {
       SetLocalString(OBJECT_SELF,"sGNBActions",sGNBActions);
       NPCAct3If(sAct);
       sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
     } // IF STATEMENTS     [109 - 116]
     else if (GetStringLeft(sAct,1)=="@")
     {
       sAct=GetStringRight(sAct,GetStringLength(sAct)-1);
       ExecuteScript(sAct,OBJECT_SELF);
       nGNBMaxHB=GetLocalInt(OBJECT_SELF,"nGNBMaxHB");
     } // Run Custom script [100]
     else if (GetStringLeft(sAct,4)=="CAST")
     {
       nGNBMaxHB=2;
     } // Cast spell        [118]
     else if (GetStringLeft(sAct,4)=="WAIT")
     {
       NPCAct3Wait(sAct);
       nGNBMaxHB=GetLocalInt(OBJECT_SELF,"nGNBMaxHB");
     } // Wait #.#          [119]
     else if (GetStringLeft(sAct,2)=="WP")
     {
       NPCAct3NewWP(sAct);
     } // WP<next>          [102]
     else if (GetStringLeft(sAct,2)=="RC")
     {
       NPCAct3Random(sAct);
       sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
     } // Random command    [101]
     else if (GetStringLeft(sAct,3)=="CLO")
     {
       NPCActionChangeClothes(sAct);
     } // Change Clothing   [60]
     else if (GetStringLeft(sAct,3)=="SUM")
     {
       NPCActionSummonCreature(sAct);
       nGNBMaxHB=2;
     } // Summon Creature   [65]
     else if (GetStringLeft(sAct,3)=="SAY")
     {
       NPCActionSayPhrase(sAct);
     } // Say Var #         [54]
     else if (GetStringLeft(sAct,3)=="COP")
     {
       NPCActionCopyVar(sAct);
     } // Copy Var #        [56]
     else if (GetStringLeft(sAct,1)=="V")
     {
       NPCActionSetVar(sAct);
     } // Set Var #         [55]
     else if (GetStringLeft(sAct,1)=="I")
     {
       NPCActionIfStatement(sAct);
     } // If Var #          [57]
     else if (GetStringLeft(sAct,1)=="A")
     {
       NPCActionAddTo(sAct);
     } // Add Var #         [58]
     else if (GetStringLeft(sAct,1)=="S")
     {
       NPCActionSubtractFrom(sAct);
     } // Subtract Var #    [59]
  SetLocalString(OBJECT_SELF,"sGNBActions",sGNBActions);
  return nGNBMaxHB;
} // GNBDoAction()


//----------------------------------------------------[ProcessGNBCommands2]---
void ProcessGNBCommands2()
{
  int nGNBMaxHB=GetLocalInt(OBJECT_SELF,"nGNBMaxHB");
  string sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
  //object oPC=GetFirstPC();
  if (nGNBMaxHB==0&&GetStringLength(sGNBActions)>3)
  { // Process another command
  //SendMessageToPC(oPC,"[v2]"+sGNBActions);
   while(GetStringLength(sGNBActions)>3&&nGNBMaxHB==0)
   { // get command
    string sAct=GetStringLeft(sGNBActions,4);
    if (GetStringRight(sAct,1)=="_") sAct=GetStringLeft(sAct,3);
    sGNBActions=GetStringRight(sGNBActions,GetStringLength(sGNBActions)-5);
    nGNBMaxHB=GNBDoAction(sAct,sGNBActions);
    sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
   } // get command
  } // process another command
  SetLocalString(OBJECT_SELF,"sGNBActions",sGNBActions);
  SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nGNBMaxHB);
} // ProcessGNBCommands2()

//----------------------------------------------------[ProcessGNBCommands3]---
void ProcessGNBCommands3()
{
  int nGNBMaxHB=GetLocalInt(OBJECT_SELF,"nGNBMaxHB");
  string sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
  //object oPC=GetFirstPC();
  if (nGNBMaxHB==0&&GetStringLength(sGNBActions)>0)
  { // Process another command
   //SendMessageToPC(oPC,"[v3]"+sGNBActions);
   while(GetStringLength(sGNBActions)>0&&nGNBMaxHB==0)
   { // get commands
    string sAct="";
    while(GetStringLeft(sGNBActions,1)!="_"&&GetStringLength(sGNBActions)>0)
    {
      sAct=sAct+GetStringLeft(sGNBActions,1);
      sGNBActions=GetStringRight(sGNBActions,GetStringLength(sGNBActions)-1);
    }
    if (GetStringLeft(sGNBActions,1)=="_")
      sGNBActions=GetStringRight(sGNBActions,GetStringLength(sGNBActions)-1);
     // Got the command  interpret it
     nGNBMaxHB=GNBDoAction(sAct,sGNBActions);
     sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
   } // Get commands
   SetLocalString(OBJECT_SELF,"sGNBActions",sGNBActions);
   SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nGNBMaxHB);
  } // Process another command
} // ProcessGNBCommands3()

//----------------------------------------------------[ParseGNBDest]----------
string ParseGNBDest(string sIn)
{
  string sReturn=sIn;
  if (GetStringLeft(sIn,2)=="00")
  {
   SetLocalString(OBJECT_SELF,"sGNBDTag","00"); // POST_
   sReturn=GetStringRight(sIn,GetStringLength(sIn)-3);
  }
  else if (StringToInt(GetStringLeft(sIn,2))>0)
  {
   SetLocalString(OBJECT_SELF,"sGNBDTag",GetStringLeft(sIn,2)); // WP_
   sReturn=GetStringRight(sIn,GetStringLength(sIn)-3);
  }
  else if (GetStringLeft(sIn,1)=="R")
  { // Random
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
   int nRv=StringToInt(GetStringLeft(sReturn,2));
   nRv=Random(nRv)+1;
   SetLocalString(OBJECT_SELF,"sGNBDTag","0"+IntToString(nRv));
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
  } // Random
  else if (GetStringLeft(sIn,1)=="B")
  { // Bounded Random
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
   int nSv=StringToInt(GetStringLeft(sReturn,2));
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-2);
   int nEv=StringToInt(GetStringLeft(sReturn,2));
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
   if (nEv>nSv)
   { // bounds okay
    int nRv=nEv-nSv;
    nRv=Random(nRv)+1+nSv;
    SetLocalString(OBJECT_SELF,"sGNBDTag","0"+IntToString(nRv));
   } // bounds okay
   else
    SetLocalString(OBJECT_SELF,"sGNBDTag","00"); // POST_
  } // Bounded Random
  else if (GetStringLeft(sIn,1)=="S")
  { // SHARED WAYPOINT
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1); // Trim S
   string sTag="";
   // parse tag
   while(GetStringLeft(sReturn,1)!="_"&&GetStringLength(sReturn)>0)
   { // get the tag
     sTag=sTag+GetStringLeft(sReturn,1);
     sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
   } // get the tag
   if (GetStringLeft(sReturn,1)=="_")
   { // valid
     sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
      if (GetStringLeft(sReturn,2)=="00")
      { // Post
        SetLocalString(OBJECT_SELF,"sGNBDTag",sTag);
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
      } // Post
      else if (StringToInt(GetStringLeft(sReturn,2))>0)
      { // Specific Waypoint
        SetLocalString(OBJECT_SELF,"sGNBDTag",sTag+"_"+GetStringLeft(sReturn,2));
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
      } // Specific Waypoint
      else if (GetStringLeft(sReturn,1)=="R")
      { // Random
       sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
       int nRv=StringToInt(GetStringLeft(sReturn,2));
       nRv=Random(nRv)+1;
       SetLocalString(OBJECT_SELF,"sGNBDTag",sTag+"_"+GetGNBWPNum(nRv));
       sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
      } // Random
      else if (GetStringLeft(sReturn,1)=="B")
      { // Bounded Random
       sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
       int nSv=StringToInt(GetStringLeft(sReturn,2));
       sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-2);
       int nEv=StringToInt(GetStringLeft(sReturn,2));
       sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
       if(nEv<nSv)
       { // Post
        SetLocalString(OBJECT_SELF,"sGNBDTag","00");
       } // Post
       else
       { // bound it
         int nRv=nEv-nSv;
         nRv=Random(nRv)+1+nSv;
         SetLocalString(OBJECT_SELF,"sGNBDTag",sTag+"_"+GetGNBWPNum(nRv));
       } // bound it
      } // Bounded Random
      else
      {
       SetLocalString(OBJECT_SELF,"sGNBDTag",sTag);
      }
   } // valid
   else
     SetLocalString(OBJECT_SELF,"sGNBDTag",sTag);
  } // SHARED WAYPOINT
  else
  { // unknown
    SetLocalString(OBJECT_SELF,"sGNBDTag","00"); // POST_
    while(GetStringLeft(sReturn,1)!="_"&&GetStringLength(sReturn)>0)
      sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
    if (GetStringLeft(sReturn,1)=="_")
      sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
  } // unknown
  return sReturn;
} // ParseGNBDest()

//----------------------------------------------------[ParseGNBPause]---------
string ParseGNBPause(string sIn)
{
  string sReturn=sIn;
  SetLocalFloat(OBJECT_SELF,"fGNBPause",0.0);
  if (GetStringLength(sIn)>1)
  {
   int nV=StringToInt(GetStringLeft(sIn,2));
   SetLocalFloat(OBJECT_SELF,"fGNBPause",IntToFloat(nV));
   sReturn=GetStringRight(sIn,GetStringLength(sIn)-3);
  }
  else
   sReturn="";
  return sReturn;
} // ParseGNBPause()

//----------------------------------------------------[ParseGNBWalkType]------
string ParseGNBWalkType(string sIn)
{
  string sReturn=sIn;
  SetLocalInt(OBJECT_SELF,"nGNBRun",0);
  if (GetStringLength(sIn)>0)
  { // valid
    int nV=0;
    string cChar=GetStringLeft(sIn,1);
    sReturn=GetStringRight(sIn,GetStringLength(sIn)-2);
    if (cChar=="R") nV=NPCACT_MOVE_RUN;
    else if (cChar=="H") nV=NPCACT_MOVE_HIDE;
    else if (cChar=="S") nV=NPCACT_MOVE_SEARCH;
    else if (cChar=="C") nV=NPCACT_MOVE_HIDE|NPCACT_MOVE_SEARCH;
    else if (cChar=="T") nV=NPCACT_MOVE_TELEP;
    else if (cChar=="V") nV=NPCACT_MOVE_VFX|NPCACT_MOVE_TELEP;
    SetLocalInt(OBJECT_SELF,"nGNBRun",nV);
  } // valid
  else
   sReturn="";
  return sReturn;
} // ParseGNBWalkType()

//----------------------------------------------------[ParseGNBHours]---------
string ParseGNBHours(string sIn)
{
  string sReturn=sIn;
  string sHours="";
  while(GetStringLeft(sReturn,1)!="_"&&GetStringLength(sReturn)>0)
  { // get the hours
    sHours=sHours+GetStringLeft(sReturn,1);
    sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
  } // get the hours
  if (GetStringLeft(sReturn,1)=="_")
    sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
  string cChar=GetStringLeft(sHours,1);
  if (cChar=="N"&&GetGNBTime()!=NPCACT_TIME_NIGHT)
  {
    sReturn=""; // no actions
  }
  else if (cChar=="D"&&GetGNBTime()!=NPCACT_TIME_DAY)
  {
    sReturn=""; // no actions
  }
  else if (cChar=="U"&&GetGNBTime()!=NPCACT_TIME_DUSK)
  {
    sReturn=""; // no actions
  }
  else if (cChar=="W"&&GetGNBTime()!=NPCACT_TIME_DAWN)
  {
    sReturn=""; // no actions
  }
  else if (cChar=="S")
  { // specific range
    string sWork=GetStringRight(sHours,6);
    int Sv=StringToInt(GetStringLeft(sWork,2));
    sWork=GetStringRight(sWork,GetStringLength(sWork)-4);
    int Ev=StringToInt(sWork);
    int Ch=GetTimeHour();
    if (Ev>Sv)
    {
     if (Ch<Sv||Ch>Ev)  sReturn=""; // no actions
    }
    else
    {
     if (Ch<Ev||Ch>Sv)  sReturn=""; // no actions
    }
  } // specific range
  SetLocalString(OBJECT_SELF,"sGNBHours",sHours);
  return sReturn;
} // ParseGNBHours()

//----------------------------------------------------[GetGNBWPNum]-----------
string GetGNBWPNum(int nN)
{
  string sRet="01";
  if (nN<10)
   sRet="0"+IntToString(nN);
  else
   sRet=IntToString(nN);
  return sRet;
} // GetGNBWPNum()

//----------------------------------------------------[MoveNPCToDestination]--
void MoveNPCToDestination(int nRun,object oD)
{
  //object oPC=GetFirstPC(); // debug
  //SendMessageToPC(oPC,GetTag(OBJECT_SELF)+":MOVE->"+GetTag(oD));
 if (oD!=OBJECT_INVALID)
 { // !OI
  int nRunFlag=FALSE;
  if ((nRun&NPCACT_MOVE_RUN)>0)
    nRunFlag=TRUE;
  if ((nRun&NPCACT_MOVE_HIDE)>0)
    ActionUseSkill(SKILL_HIDE,OBJECT_SELF); // enable hide
  if ((nRun&NPCACT_MOVE_SEARCH)>0)
    ActionUseSkill(SKILL_SEARCH,OBJECT_SELF); // enable search
  if ((nRun&NPCACT_MOVE_VFX)>0)
  { // teleport visual effects
    effect eImplode=EffectVisualEffect(VFX_FNF_IMPLOSION);
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eImplode,OBJECT_SELF,3.0));
  } // teleport visual effects
  if ((nRun&NPCACT_MOVE_TELEP)>0)
  { // teleport
    ActionJumpToObject(oD); // teleport
  } // teleport
  else
  { // move normal
    ActionForceMoveToObject(oD,nRunFlag,1.0,120.0);
  } // move normal
 } // !OI
} // MoveNPCToDestination()

//---------------------------------------------------------[GetNPCWaypoint]---
object GetNPCWaypoint(int nTime,string sIn)
{
  object oReturn=OBJECT_INVALID;
  string sPost1="POST_";
  string sPost2="NIGHT_";
  string sPre="WP_";
  string sTry;
  if (nTime==NPCACT_TIME_DUSK||nTime==NPCACT_TIME_NIGHT)
  { // switch posts and pre
    sPost1="NIGHT_";
    sPost2="POST_";
    sPre="WN_";
  } // switch posts and pre
  if (GetStringLength(sIn)<1)
  { // no specified destination
    sTry=sPost1+GetTag(OBJECT_SELF);
    oReturn=GetObjectByTag(sTry);
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPost2+GetTag(OBJECT_SELF);
      oReturn=GetObjectByTag(sTry);
    } // OI
  } // no specified destination
  else if (StringToInt(sIn)==0)
  { // specific non-numeric destination
    sTry=sIn;
    oReturn=GetObjectByTag(sTry);
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPre+sIn;
      oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPost1+sIn;
      oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI - post
      sTry=sPost1+GetTag(OBJECT_SELF);
      oReturn=GetObjectByTag(sTry);
    } // OI - post
    if (oReturn==OBJECT_INVALID)
    { // OI - post 2
      sTry=sPost2+GetTag(OBJECT_SELF);
      oReturn=GetObjectByTag(sTry);
    } // OI - post 2
  } // specific non-numeric destination
  else
  { // numeric destination
    sTry=sPre+GetTag(OBJECT_SELF)+"_";
    if (StringToInt(sIn)<10)
      sTry=sTry+"0"+IntToString(StringToInt(sIn));
    else
      sTry=sTry+IntToString(StringToInt(sIn));
    oReturn=GetObjectByTag(sTry);
    if (oReturn==OBJECT_INVALID)
    { // OI - POST
      sTry=sPost1+GetTag(OBJECT_SELF);
      oReturn=GetObjectByTag(sTry);
    } // OI - POST
    if (oReturn==OBJECT_INVALID)
    { // OI - POST 2
      sTry=sPost2+GetTag(OBJECT_SELF);
      oReturn=GetObjectByTag(sTry);
    } // OI - POST 2
  } // numeric destination
  return oReturn;
} // GetNPCWaypoint()

//---------------------------------------------------------[GetGNBTime]-------
int GetGNBTime()
{
  int nReturn=NPCACT_TIME_DUSK;
  if (GetIsDawn())nReturn=NPCACT_TIME_DAWN;
  else if (GetIsDay()) nReturn=NPCACT_TIME_DAY;
  else if (GetIsNight()) nReturn=NPCACT_TIME_NIGHT;
  return nReturn;
} // GetGNBTime()

//--------------------------------------------------------[GetObjectWithin]---
object GetObjectWithin(int nObjectType,float fDistance,string sTagPattern,int nNth)
{ // Function returns an object within a specified distance with a
  // tag with the pattern matching characteristics.  or OBJECT_INVALID
  // if no such object can be found.
  object oResult=OBJECT_INVALID;
  //object oPC=GetFirstPC();
  //SendMessageToPC(oPC,"GOW:"+IntToString(nObjectType)+"DIST:"+FloatToString(fDistance)+"PATTERN:"+sTagPattern+":Nth:"+IntToString(nNth));
  int nCounter=0;
  object oArea=GetArea(OBJECT_SELF);
  int nLoop=1;
  object oTest=GetFirstObjectInArea(oArea);
  if (oArea!=OBJECT_INVALID)
  { // !OI
    while(nCounter!=nNth&&oTest!=OBJECT_INVALID)
    { // while
     if ((GetObjectType(oTest)==nObjectType)&&(oTest!=OBJECT_SELF))
     { // first test passed
      if(GetDistanceToObject(oTest)<=fDistance)
      { // second test passed
       if (TestStringAgainstPattern(sTagPattern,GetTag(oTest)))
       { // passed final test
         nCounter++;
         if (nCounter==nNth) oResult=oTest;
       } // passed final test
      } // second test passed
     } // first test passed
     if (oResult==OBJECT_INVALID)
      oTest=GetNextObjectInArea(oArea);
    } // while
  } // !OI
  //if (oResult!=OBJECT_INVALID) SendMessageToPC(oPC,"OBJECT FOUND:"+GetTag(oResult));
  //else SendMessageToPC(oPC,"OBJECT_INVALID");
  return oResult;
} // GetObjectWithin()

//-----------------------------------------------------[GetObjectCloseToFar]--
object GetObjectCloseToFar(int nPlaceable,string sPlace,int nLp)
{ // GetObjectCloseToFar
  object oUse=GetObjectWithin(nPlaceable,1.0,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,1.5,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,2.0,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,3.0,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,4.0,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,5.0,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,6.0,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,8.0,sPlace,nLp);
  if (oUse==OBJECT_INVALID) oUse=GetObjectWithin(nPlaceable,10.0,sPlace,nLp);
  return oUse;
} // GetObjectCloseToFar()

//--------------------------------------------------
int GetHasEffect2(int nEffectType, object oTarget = OBJECT_SELF)
{
    effect eCheck = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck) == nEffectType)
        {
             return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
} // GetHasEffect2()

/////////////////////////////////////////////////////////////////////////////
////  COMMANDS FOR WAYPOINTS FUNCTIONS
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

//-------------------------------------------------
void NPCActionSitChair()
{
  object oChair;
  oChair=GetObjectCloseToFar(OBJECT_TYPE_PLACEABLE,
        "(Chair|Couch|Stool|BenchPew|ThroneEvil|ThroneGood|InvisChair)",1);
  if (oChair!=OBJECT_INVALID)
  { // !OI
      ActionMoveToObject(oChair);
      ActionSit(oChair);
  } // !OI
} // NPCActionSitChair()

//-------------------------------------------------
void NPCActionUseNearby()
{
  object oUse=GetObjectCloseToFar(OBJECT_TYPE_PLACEABLE,"**",1);
  if (oUse!=OBJECT_INVALID)
  { // !OI
    ActionForceMoveToObject(oUse,FALSE,1.0,6.0);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
    ActionInteractObject(oUse);
  } // !OI
} // NPCActionUseNearby()

//-------------------------------------------------
void NPCActionTalkNearby(int nParm)
{
  object oTalkTo=GetObjectCloseToFar(OBJECT_TYPE_CREATURE,"**",1);
  if (oTalkTo!=OBJECT_INVALID)
  { // !OI
    if (nParm==0) nParm=Random(4)+1;
    ActionMoveToObject(oTalkTo);
    switch(nParm)
    { // switch
     case 2: { // Forceful
      ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,3.0);
      break;
     } // forceful
     case 3: { // Pleading
      ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,3.0);
      break;
     } // Pleading
     case 4: { // Laughing
      ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING,1.0,3.0);
      break;
     } // Laughing
     default: { // default
      ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.0);
      break;
     } // default
    } // switch
    ActionStartConversation(oTalkTo);
  } // !OI
} // NPCActionTalkNearby()

//-------------------------------------------------
void NPCActionHardSleep()
{
  effect eSleep=EffectSleep();
  DelayCommand(115.0,RemoveEffect(OBJECT_SELF, eSleep));
  effect eSleepFX=EffectVisualEffect(VFX_IMP_SLEEP);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleepFX,OBJECT_SELF,100.0);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,OBJECT_SELF,110.0);
} // NPCActionHardSleep()

//-------------------------------------------------
void NPCActionRest()
{ // Rest - simulated
 ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,110.0);
 effect eSleep=EffectVisualEffect(VFX_IMP_SLEEP);
 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,OBJECT_SELF,110.0);
} // NPCActionRest()

//-------------------------------------------------
void NPCActionCleanup()
{ // find items laying about and clean them up
  object oItem=GetObjectCloseToFar(OBJECT_TYPE_ITEM,"**",1);
  if (oItem!=OBJECT_INVALID)
  { // !OI
    ActionMoveToObject(oItem,FALSE,0.5);
    if (!GetPlotFlag(oItem))
    { //!plot item
      ActionPickUpItem(oItem);
      DestroyObject(oItem);
    } //!plot item
  } // !OI
} // NPCActionCleanup()

//-------------------------------------------------
void NPCActionCloseDoor()
{
  int nLoop=1;
  //object oPC=GetFirstPC();
  object oDoor=GetObjectCloseToFar(OBJECT_TYPE_DOOR,"**",nLoop);
  //SendMessageToPC(oPC,"DOOR:"+GetTag(oDoor)+" checked for "+GetTag(OBJECT_SELF));
  while(oDoor!=OBJECT_INVALID)
  { // !OI
   //SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" door check:"+IntToString(GetIsOpen(oDoor)));
   if(GetIsOpen(oDoor)&&GetDistanceToObject(oDoor)<4.0)
   { // it is open
    //ActionForceMoveToObject(oDoor,TRUE,1.0);
    //ActionSpeakString("Someone left the door open.");
    AssignCommand(oDoor,ActionCloseDoor(oDoor));
   } // it is open
   nLoop++;
   oDoor=GetObjectCloseToFar(OBJECT_TYPE_DOOR,"**",nLoop);
  } // !OI
} // NPCActionCloseDoor()

//-------------------------------------------------
void NPCActionCloseContainer()
{
  object oContainer=GetObjectCloseToFar(OBJECT_TYPE_PLACEABLE,"**",1);
  if (oContainer!=OBJECT_INVALID)
  { // !OI
    if (GetIsOpen(oContainer)&&GetDistanceToObject(oContainer)<4.0)
    {
      ActionMoveToObject(oContainer,FALSE,0.5);
      ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.0);
      AssignCommand(oContainer,ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE,1.0,1.0));
    }
  } // !OI
} // NPCActionCloseContainer()

//-------------------------------------------------
void NPCActionPickPockets()
{ // takes random 1-20 gold pieces
  object oTarget;
  int nLoop;
  if (GetHasSkill(SKILL_PICK_POCKET,OBJECT_SELF))
  { // has skill
  for(nLoop=1;nLoop<10;nLoop++)
  { // FOR
   oTarget=GetObjectCloseToFar(OBJECT_TYPE_CREATURE,"**",
         nLoop);
   if (oTarget!=OBJECT_INVALID)
   { // !OI
    if ((GetIsPC(oTarget))||(!GetFactionEqual(oTarget)))
      nLoop=12;
   } // !OI
  } // FOR
  if (nLoop==12)
  { // Found a victim
    if(GetHasSkill(SKILL_HIDE,OBJECT_SELF))
     ActionUseSkill(SKILL_HIDE,OBJECT_SELF);
    ActionMoveToObject(oTarget,FALSE,0.5);
    ActionUseSkill(SKILL_PICK_POCKET,oTarget);
    int nCheck= (d20()+(GetSkillRank(SKILL_PICK_POCKET, OBJECT_SELF))) - (d20()+(GetSkillRank(SKILL_SPOT,oTarget)));
    if (nCheck>0)
    { // success
       TakeGoldFromCreature(Random(20)+1,oTarget,FALSE);
       if(GetIsPC(oTarget))
        DelayCommand(60.0,SendMessageToPC(oTarget,"You have been robbed."));
       ActionMoveAwayFromObject(oTarget,FALSE,20.0);
    } // success
    else if (nCheck<-2)
    { // failed and noticed
     if (GetIsPC(oTarget))
      SendMessageToPC(oTarget,GetName(OBJECT_SELF)+" attempted to pick your pocket.");
     else
      { // NPC noticed
        ActionMoveAwayFromObject(oTarget,TRUE,20.0);
        string sRandStatement="That's right run away you scoundrel!";
        switch(Random(4))
          { // switch
          case 0: sRandStatement="You thief!! Next time I see you I'll...";
           break;
          case 1: sRandStatement="Stop! That thief just tried to rob me.";
           break;
          case 2: sRandStatement="You highway robber! I'm warning the authorities about you.";
           default: break;
          }// switch
         AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,2.0));
         AssignCommand(oTarget,ActionSpeakString(sRandStatement));
      } // NPC Noticed
    } // failed and noticed
  } // Found a victim
 } // has skill
} // NPCActionPickPockets()

//-------------------------------------------------
void NPCActionDrink()
{
    object oDrink=GetObjectCloseToFar(OBJECT_TYPE_ITEM,
      "(NW_IT_MPOTION021|NW_IT_MPOTION022|NW_IT_MPOTION023)",1);
    if (oDrink!=OBJECT_INVALID)
    { // !oi
      ActionPickUpItem(oDrink);
      DelayCommand(2.0,DestroyObject(oDrink));
    } // !oi
    ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0,2.0);
    DelayCommand(3.0,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0,2.0));
} // NPCActionDrink()

//-------------------------------------------------
void NPCActionRandomInn()
{
} // NPCActionRandomInn()

//-------------------------------------------------
void NPCActionHealOthers()
{ // Heal other people
  int nLoop=1;
  object oHealee=GetObjectWithin(OBJECT_TYPE_CREATURE,2.0,"**",nLoop);
  while(oHealee!=OBJECT_INVALID)
  { // test others for need of healing
   if (GetMaxHitPoints(oHealee)>GetCurrentHitPoints(oHealee))
   { // healing needed
     ActionMoveToObject(oHealee,FALSE,0.5);
     effect eHeal=EffectHeal(GetMaxHitPoints(oHealee)-GetCurrentHitPoints(oHealee));
     ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,2.0);
     ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oHealee,1.5));
   } // healing needed
   nLoop++;
   oHealee=GetObjectWithin(OBJECT_TYPE_CREATURE,2.0,"**",nLoop);
  } // while
} // NPCActionHealOthers()

 //-------------------------------------------------
void NPCActionTaunt()
{ // look for someone not of your faction or a PC to taunt
 int nLoop=1;
 int nFound=FALSE;
 object oVictim;
 while(!nFound)
 { // look for a victim
   oVictim=GetObjectWithin(OBJECT_TYPE_CREATURE,5.0,"**",nLoop);
   nLoop++;
   if (oVictim!=OBJECT_INVALID)
   { // !OI
    if ((GetIsPC(oVictim))||(!GetFactionEqual(oVictim)))
     nFound=TRUE;
   } // !OI
   else
    nFound=TRUE; // hit end of objects
 } // look for a victim
 if (oVictim!=OBJECT_INVALID)
 { // a victim was found
  ActionMoveToObject(oVictim,FALSE,0.8);
  ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT,1.0,2.0);
  if (GetHasSkill(SKILL_TAUNT))
   ActionUseSkill(SKILL_TAUNT,oVictim);
 } // a victim was found
} //NPCActionTaunt()

//-------------------------------------------------
void NPCActionCreate(int nParm)
{
  object oItem;
  object oTable=GetObjectCloseToFar(OBJECT_TYPE_PLACEABLE,
         "(Table|Desk|Cabinet)",1);
  string sITag="nw_it_mmidmisc05";
  if (nParm==1) sITag="nw_it_msmlmisc20";
  else if (nParm==2) sITag="nw_it_mpotion021";
  else if (nParm==3) sITag="nw_it_mpotion023";
  else if (nParm==4) sITag="nw_it_mpotion022";
  oItem=CreateItemOnObject(sITag,OBJECT_SELF,1);
  if (oItem!=OBJECT_INVALID)
  { // !oi
    if (oTable!=OBJECT_INVALID)
      ActionMoveToObject(oTable,FALSE,0.5);
    ActionPutDownItem(oItem);
  } // !oi
} // NPCActionCreate()

//-------------------------------------------------
void NPCActionEatNearbyFood()
{
  object oFood=GetObjectCloseToFar(OBJECT_TYPE_ITEM,
    "(NW_IT_MSMLMISC20|NW_IT_MMIDMISC05)",1);
  if (oFood!=OBJECT_INVALID)
  { // !OI
    ActionMoveToObject(oFood,FALSE,0.5);
    ActionPickUpItem(oFood);
    ActionDoCommand(DestroyObject(oFood));
  } // !OI
} // NPCActionEatNearbyFood()

//-------------------------------------------------
void NPCActionRandomWalk()
{
} // NPCActionRandomWalk()

//-------------------------------------------------
void NPCActionBully()
{ // Be a bully
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // while not found
    oTarget=GetObjectWithin(OBJECT_TYPE_CREATURE,5.0,"**",nLoop);
    nLoop++;
    if (oTarget!=OBJECT_INVALID)
    { // !OI
     if (GetHitDice(OBJECT_SELF)>=GetHitDice(oTarget))
      nFound=TRUE;
    } // !OI
    else
     nFound=TRUE; // end of objects
  } // while not found
  if (oTarget!=OBJECT_INVALID)
  { // act on target
    ActionMoveToObject(oTarget,TRUE,0.8);
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,3.0);
    effect eKnockdown=EffectKnockdown();
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eKnockdown,oTarget,3.0));
  } // act on target
}// NPCActionBully()

//-------------------------------------------------
void NPCActionProposition()
{
  string sProp="Why don't you come sit with me for awhile.";
  object oTarget;
  int nLoop=1;
  int nFound=FALSE;
  switch(Random(3))
  { // random statement
   case 0: sProp="Are you looking for a good time?";
    break;
   case 1: sProp="Would you like some company tonight?";
   default: break;
  } // random statement
  while(!nFound)
  { // look for client
   oTarget=GetObjectWithin(OBJECT_TYPE_CREATURE,8.0,"**",nLoop);
   nLoop++;
   if(oTarget!=OBJECT_INVALID)
   { // !OI
    if(GetGender(oTarget)!=GetGender(OBJECT_SELF))
     nFound=TRUE;
   } // !OI
   else
    nFound=TRUE; // end of objects
  } // look for client
  if (oTarget!=OBJECT_INVALID)
  { // client found
    ActionMoveToObject(oTarget,FALSE,0.8);
    ActionSpeakString(sProp);
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.0);
  } // client found
} // NPCActionProposition()

//-------------------------------------------------
void NPCActionFollow(int nParm)
{ // Follow a target
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // look for someone to follow
    oTarget=GetObjectCloseToFar(OBJECT_TYPE_CREATURE,"**",nLoop);
    nLoop++;
    if (oTarget!=OBJECT_INVALID)
    { // !OI
      if((nParm==0)&&(GetGender(oTarget)==GENDER_FEMALE))
        nFound=TRUE;
      else if ((nParm==1)&&(GetGender(oTarget)==GENDER_MALE))
        nFound=TRUE;
      else if (nParm==2)
        nFound=TRUE;
      else if ((nParm==3)&&(GetIsPC(oTarget)))
        nFound=TRUE;
      else if ((nParm==4)&&(GetIsPC(oTarget))&&(GetGender(oTarget)==GENDER_FEMALE))
        nFound=TRUE;
      else if ((nParm==5)&&(GetIsPC(oTarget))&&(GetGender(oTarget)==GENDER_MALE))
        nFound=TRUE;
    } // !OI
    else
      nFound=TRUE; // end of objects
  } // look for someone to follow
  if (oTarget!=OBJECT_INVALID)
  { // follow them
   ActionMoveToObject(oTarget,FALSE,1.5);
   ActionForceFollowObject(oTarget,1.5);
  } // follow them
} // NPCActionFollow()

//-------------------------------------------------
void NPCActionWorship(int nParm)
{
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // look for target
   oTarget=GetObjectCloseToFar(OBJECT_TYPE_CREATURE,"**",nLoop);
   nLoop++;
   if (oTarget!=OBJECT_INVALID)
   { // !OI
     if((nParm==0)&&(GetIsPC(oTarget)))
       nFound=TRUE;
     if((nParm==1)&&(!GetIsPC(oTarget)))
       nFound=TRUE;
   } // !OI
   else
    nFound=TRUE;
  } // look for target
  if (oTarget!=OBJECT_INVALID)
  { // worship them
    ActionMoveToObject(oTarget,TRUE,1.0);
    ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,4.0);
    DelayCommand(5.0,ActionMoveToObject(oTarget,TRUE,1.0));
    DelayCommand(5.5,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,4.0));
  } // worship them
} // NPCActionWorship()

//-------------------------------------------------
void NPCActionAttackPlaceable()
{
  object oTarget=GetObjectCloseToFar(OBJECT_TYPE_PLACEABLE,"**",1);
  if (oTarget!=OBJECT_INVALID)
  { // !OI
    ActionMoveToObject(oTarget,FALSE,0.8);
    ActionAttack(oTarget,TRUE);
  } // !OI
} // NPCActionAttackPlaceable()

//-------------------------------------------------
void NPCActionLights(int nParm)
{
  int nLoop=1;
  int nOnOff=0;
  int nFlag=FALSE;
  object oArea=GetArea(OBJECT_SELF);
  object oLight=GetObjectCloseToFar(OBJECT_TYPE_PLACEABLE,
   "(LampPost|Brazier|Campfire|CampfireCauldron|CampfirewithSpit|PillarStyle1|Candelabra)",nLoop);
  while(oLight!=OBJECT_INVALID)
  { // !OI
   if (nParm==0) {nOnOff=1; nFlag=TRUE;}
     ActionMoveToObject(oLight,FALSE,0.5);
     SetLocalInt(OBJECT_SELF,"nOffOn",nOnOff);
     ActionInteractObject(oLight);
     SetPlaceableIllumination(oLight, nFlag);
   nLoop++;
   oLight=GetObjectWithin(OBJECT_TYPE_PLACEABLE,5.0,
    "(LampPost|Brazier|Campfire|CampfireCauldron|CampfirewithSpit|PillarStyle1|Candelabra)",nLoop);
  } // !OI
  RecomputeStaticLighting(oArea);
} // NPCActionLights()

//-------------------------------------------------
void NPCActionMagicEffect(int nParm)
{
  effect eMEffect; // effect
  switch(nParm)
  { // switch
    case 0:eMEffect=EffectVisualEffect(VFX_IMP_LIGHTNING_M);
     break;
    case 1:eMEffect=EffectVisualEffect(VFX_IMP_HEAD_FIRE);
     break;
    default:eMEffect=EffectVisualEffect(VFX_IMP_HOLY_AID);
     break;
  } // switch
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMEffect,OBJECT_SELF,5.0);
} // NPCActionMagicEffect()

//-------------------------------------------------
void NPCActionAttackNearby()
{
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // looking
    oTarget=GetObjectCloseToFar(OBJECT_TYPE_CREATURE,"**",nLoop);
    nLoop++;
    if (oTarget!=OBJECT_INVALID)
    { // !OI
     if ((GetIsPC(oTarget))||(!GetFactionEqual(oTarget)))
      nFound=TRUE;
    } // !OI
    else
     nFound=TRUE; // Done looking
  } // looking
  if (oTarget!=OBJECT_INVALID)
  { // Attack the target
    ActionMoveToObject(oTarget,TRUE,1.0);
    ActionAttack(oTarget,FALSE);
  } // Attack the target
} // NPCActionAttackNearby()

//-------------------------------------------------
void NPCActionDie()
{ // So you want the NPC to die... here ya go.
  effect eDeath=EffectDeath(TRUE,TRUE);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDeath,OBJECT_SELF,200.0);
} // NPCActionDie()

//-------------------------------------------------
void NPCActionDisappear(int nParm)
{
  effect eAppear=EffectAppear();
  effect eDisappear=EffectDisappear();
  if (nParm==0)
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDisappear,OBJECT_SELF,6.0);
  else
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,eAppear,OBJECT_SELF,6.0);
} // NPCActionDisappear()

//-------------------------------------------------
void NPCActionTurnUndead()
{
  int nLoop=1;
  object oTarget=GetObjectWithin(OBJECT_TYPE_CREATURE,10.0,"**",nLoop);
  if (GetHasFeat(FEAT_TURN_UNDEAD,OBJECT_SELF))
  {// has turn undead
  while(oTarget!=OBJECT_INVALID)
  { //!OI
    if(GetClassByPosition(1,oTarget)==CLASS_TYPE_UNDEAD)
    { // It is an undead
      ActionMoveToObject(oTarget,TRUE,2.0);
      ActionUseFeat(FEAT_TURN_UNDEAD,oTarget);
    } // It is an undead
    nLoop++;
    oTarget=GetObjectWithin(OBJECT_TYPE_CREATURE,10.0,"**",nLoop);
  } //!OI
  }// has turn undead
} // NPCActionTurnUndead()

//-------------------------------------------------
void NPCActionRandomSpeak(int nParm)
{
  string sSayThis="I really don't know what to say.";
  int nSayNum=Random(9);
  switch (nParm)
  { // switch
   case 0: { // Mercenary
    if(nSayNum==0) sSayThis="Don't it beat all! That merchant took forever to get here.";
    else if(nSayNum==1) sSayThis="I just done my sword cleanin' fo' the day.";
    else if(nSayNum==2) sSayThis="I seen an ogre once that'd shrivel yo' privates if he took to lookin' at ya.";
    else if(nSayNum==3) sSayThis="Some of the walkin' all day wears me down.";
    else if(nSayNum==4) sSayThis="A nice ale usually settles me stomach.";
    else if(nSayNum==5) sSayThis="Once I had to fight off a dozen bandits comin' fo' the merchant I was workin' wif.";
    else if(nSayNum==6) sSayThis="I need to find me a bed warmer. Harhar.";
    else if(nSayNum==7) sSayThis="I think spirits is a stronger drink. That'd be what I needs.";
    else if(nSayNum==8) sSayThis="I have a big scar on me arse too.  Damn badger bit it.";
    break;
   } // Mercenary
  case 1: { // Merchant
    if(nSayNum==0) sSayThis="Come look at my goods.";
    else if(nSayNum==1) sSayThis="I'm looking to trade.";
    else if(nSayNum==2) sSayThis="Fresh in!  Goods from around the world.";
    else if(nSayNum==3) sSayThis="Come one, Come all.  Incredible bargains here.";
    else if(nSayNum==4) sSayThis="Do you need to lighten your load? I'm buying goods of all kinds.";
    else if(nSayNum==5) sSayThis="Quick! Get them before they are gone.  I am selling them like they are jewels.  Maybe they are.";
    else if(nSayNum==6) sSayThis="I have money just waiting to be spent on your goods you wish to sell.";
    else if(nSayNum==7) sSayThis="Buy something for a special occasion!";
    else if(nSayNum==8) sSayThis="Did you forget something? You better talk to me to make sure you didn't.";
    break;
  } // Merchant
  case 2: { // Bard
    if (nSayNum==0) sSayThis="Ode to the poor minded beggar.  A tale of woe an pitty.";
    else if(nSayNum==1) sSayThis="O' to travel the world and find new tales.";
    else if(nSayNum==2) sSayThis="Too many words can tangle the tongue.  A well placed word though, that can win wars.";
    else if(nSayNum==3) sSayThis="If booglytoosome would fondangle the biddyswitch twould ever so simply perdobel.";
    else if(nSayNum==4) sSayThis="It twas a dark and stormy night...  No that sounds too cliche like.";
    else if(nSayNum==5) sSayThis="So many stories, so many songs, and far too little time.";
    else if(nSayNum==6) sSayThis="The orphan dwarf and his adoptive troll parents... nah, that sounds too stupid.";
    else if(nSayNum==7) sSayThis="Time pursues us all.  It follows and cuddles.  It waits for to fall.  Our bodies form as puddles...  That is just awful.";
    else if(nSayNum==8) sSayThis="A song or two to lighten the day.  A coin or two to guide my way.";
    break;
  } // Bard
  case 3: { // Monsters
    if (nSayNum==0) sSayThis="Me findem food.  Is good?";
    else if(nSayNum==1) sSayThis="Me needs me mate.  Is good?";
    else if(nSayNum==2) sSayThis="Me bash things. Is good?";
    else if(nSayNum==3) sSayThis="Smell man flesh.";
    else if(nSayNum==4) sSayThis="No like rain.";
    else if(nSayNum==5) sSayThis="Needs more blood.";
    else if(nSayNum==6) sSayThis="Time for bash.";
    else if(nSayNum==7) sSayThis="Me say NOW!";
    else if(nSayNum==8) sSayThis="Shiny things good.  Man flesh trap.";
    break;
   } // Monsters
  case 4: { // Female
    if (nSayNum==0) sSayThis="I really don't like this outfit.";
    else if(nSayNum==1) sSayThis="Today is depressing.";
    else if(nSayNum==2) sSayThis="I think I need to work on my hair.";
    else if(nSayNum==3) sSayThis="I wonder who that is?";
    else if(nSayNum==4) sSayThis="Did you hear who slept over at you know who's last night?";
    else if(nSayNum==5) sSayThis="My man will support me well.";
    else if(nSayNum==6) sSayThis="I need some new clothes.";
    else if(nSayNum==7) sSayThis="It's just not my day.";
    else if(nSayNum==8) sSayThis="Damn the fates.";
    break;
   } // Female
  case 5: { // Male
    if (nSayNum==0) sSayThis="Did you see her mellons? Whoa.";
    else if(nSayNum==1) sSayThis="She has a nice arse.  I'm talking about her donkey either.";
    else if(nSayNum==2) sSayThis="I got a new tool last week.";
    else if(nSayNum==3) sSayThis="Some weather we're having.";
    else if(nSayNum==4) sSayThis="I hate work.";
    else if(nSayNum==5) sSayThis="I bet I can belch longer.";
    else if(nSayNum==6) sSayThis="No pain, no gain.";
    else if(nSayNum==7) sSayThis="A fool and his money are soon parted.";
    else if(nSayNum==8) sSayThis="If it don't hurt nothin' do what you want.";
    break;
   } // Male
  case 6: { // Magecraft
    if (nSayNum==0) sSayThis="A well placed grease spell often works wonders.";
    else if(nSayNum==1) sSayThis="What spell would you use in that situation?";
    else if(nSayNum==2) sSayThis="I almost am done with that new spell.";
    else if(nSayNum==3) sSayThis="What do I NEED an invisible stalker for?";
    else if(nSayNum==4) sSayThis="The usual spell does fine for me.";
    else if(nSayNum==5) sSayThis="...and then I put the bat guano in with the other powder and...";
    else if(nSayNum==6) sSayThis="...the explosion was quite magnificent.  It only singed my hair a bit.";
    else if(nSayNum==7) sSayThis="It worked last time I cast it.";
    else if(nSayNum==8) sSayThis="I'm not sure the situation calls for an answer to that.";
    break;
   } // Magecraft
  case 7: { // Religion
    if(nSayNum==0) sSayThis="and so what is the universe really?";
    else if(nSayNum==1) sSayThis="...does not preclude the existence of other gods.";
    else if(nSayNum==2) sSayThis="Yes, but that in itself was a contradiction.";
    else if(nSayNum==3) sSayThis="For the love of the gods. Read the book.  It's all in there.";
    else if(nSayNum==4) sSayThis="I'm telling you it is a hidden truth.";
    else if(nSayNum==5) sSayThis="How can you ask such silly questions?";
    else if(nSayNum==6) sSayThis="That is blasphemy if I ever heard it before.";
    else if(nSayNum==7) sSayThis="...might be the reason why...";
    else if(nSayNum==8) sSayThis="...could of been a miracle...";
    break;
   } // Religion
  case 8: { // Commoner
    if(nSayNum==0) sSayThis="What do you think of the weather?";
    else if(nSayNum==1) sSayThis="I don't give it much thought really.";
    else if(nSayNum==2) sSayThis="How has your day been?";
    else if(nSayNum==3) sSayThis="The same as usual.";
    else if(nSayNum==4) sSayThis="That's what she wanted to know.";
    else if(nSayNum==5) sSayThis="I don't know.";
    else if(nSayNum==6) sSayThis="You win some.  Others you lose.";
    else if(nSayNum==7) sSayThis="What did they give you?";
    else if(nSayNum==8) sSayThis="I think something special.";
    break;
   } // Commoner
   default: break;
  } // switch
  ActionSpeakString(sSayThis,TALKVOLUME_TALK);
} // NPCActionRandomSpeak()

//-------------------------------------------------
void NPCActionHealSelf()
{
  if (GetMaxHitPoints(OBJECT_SELF)>GetCurrentHitPoints(OBJECT_SELF))
  {
    effect eHeal=EffectHeal(GetMaxHitPoints(OBJECT_SELF)-GetCurrentHitPoints(OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF,1.0);
  }
} //NPCActionHealSelf()

//-------------------------------------------------
void NPCActionSetTrap()
{
}// NPCActionSetTrap()

//-------------------------------------------------
void NPCActionRemoveTrap()
{
}// NPCActionRemoveTrap()

//-------------------------------------------------
void NPCActionPickLock()
{
}// NPCActionPickLock()

//-------------------------------------------------
void NPCActionKnockSpell()
{
}// NPCActionKnockSpell()

void NPCActSing(float fDelay,string sLyric)
{ // Support for the singing function coming
  ActionWait(fDelay);
  ActionSpeakString(sLyric);
} // NPCActSing()

//-------------------------------------------------
void NPCActionSing(int nParm)
{ // Songs by Deva Bryson Winblood (quickly written)
 switch(nParm)
 { // song switch
   case 0: { // My Lass and her very fine ass
    ActionSpeakString("One bright and kindly summers morning...");
    NPCActSing(4.0,"I perchance passed the field of my toils");
    NPCActSing(5.0,"There I saw my hearts definate warning...");
    NPCActSing(5.0,"I happened to see my woman's donkey");
    NPCActSing(6.0,"Sing with me: My lass has a very fine ass");
    NPCActSing(4.0,"Don't you know it works all day");
    NPCActSing(4.0,"My lass has a very fine ass");
    NPCActSing(4.0,"It works and doesn't get pay");
    NPCActSing(5.0,"So next time your at the market.");
    NPCActSing(5.0,"Make sure its a donkey you buy");
    NPCActSing(5.0,"For prideful they may be");
    NPCActSing(5.0,"But, to work their pay is just right");
    NPCActSing(6.0,"My lass has a very fine ass");
    NPCActSing(4.0,"Don't you know it works all day");
    NPCActSing(4.0,"My lass has a very fine ass");
    NPCActSing(4.0,"It works and doesn't get pay");
    break;
   } // My lass
   case 1: { // Drink them under the table
    ActionSpeakString("Raise your cup high and proud: Sing with me.");
    NPCActSing(5.0,"Stomp your feet, shake the ground.");
    NPCActSing(5.0,"Greet your chums round 'bout.");
    NPCActSing(5.0,"Show them what drinkings all 'bout.");
    NPCActSing(5.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"SLAM THAT ALE DOWN AND DOWN");
    NPCActSing(4.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"WATCH THEIR PRIDE FALLIN' DOWN");
    NPCActSing(5.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"SLAM THAT ALE DOWN AND DOWN");
    NPCActSing(4.0,"DRINK THEM UNDER THE TABLE");
    NPCActSing(4.0,"WATCH THEIR PRIDE FALLIN' DOWN");
    break;
   } // Drink them under the table
   case 2: { // The labors of the sea
    ActionSpeakString("The sea is my larder...");
    NPCActSing(5.0,"It is where the fish grow.");
    NPCActSing(5.0,"The sea provides my staples...");
    NPCActSing(5.0,"As you all surely know.");
    NPCActSing(5.0,"The sea provides shelter...");
    NPCActSing(5.0,"to the wise man they will show.");
    NPCActSing(5.0,"The sea is as stable...");
    NPCActSing(5.0,"as the time honored know.");
    NPCActSing(5.0,"The sea is my roadway...");
    NPCActSing(5.0,"Whereever the winds blow.");
    break;
   } // The labors of the sea
   case 3: { // Unrequited Love
    ActionSpeakString("[SINGING] Why are your eyes so blue all the time...");
    NPCActSing(8.0,"Why are your eyes always looking into mine...");
    NPCActSing(8.0,"Where did you come from, and where will you go...");
    NPCActSing(8.0,"Find my hand and take me where you go...");
    NPCActSing(8.0,"If I love you, will you love me too");
    NPCActSing(8.0,"Will you be there, whenever I need you.");
    break;
   } // Unrequited Love
   case 4: { // Rape and pillage
    ActionSpeakString("[SINGING] See them run, see them crawl.");
    NPCActSing(4.0,"That's what makes it worth it all.");
    NPCActSing(4.0,"Hear them scream, hear them weep.");
    NPCActSing(4.0,"That's what helps me sleep a wink.");
    NPCActSing(4.0,"Rape and Pillage");
    NPCActSing(3.0,"Burn the village");
    NPCActSing(3.0,"Rape and Pillage");
    NPCActSing(3.0,"Rape and Pillage");
    NPCActSing(5.0,"We don't need the pay");
    NPCActSing(4.0,"We just need some prey");
    NPCActSing(4.0,"We don't need friends");
    NPCActSing(4.0,"We prefer bone snapping trends");
    NPCActSing(4.0,"Rape and Pillage");
    NPCActSing(3.0,"Burn the village");
    NPCActSing(3.0,"Rape and pillage");
    NPCActSing(3.0,"RAPE AND PILLAGE!!");
    break;
   } // Rape and pillage
   case 5: { // epic tale of heroism
    ActionSpeakString("[SINGING] T'wards the mountains went the bodies...");
    NPCActSing(4.0,"of those the monster had taken.");
    NPCActSing(4.0,"T'wards the caverns went the fighters.");
    NPCActSing(4.0,"Never seen or heard again.");
    NPCActSing(4.0,"The fear was gripping hearts");
    NPCActSing(4.0,"The pride had fallen low");
    NPCActSing(4.0,"Then came the hero.");
    NPCActSing(4.0,"The one that was unknown.");
    NPCActSing(4.0,"T'wards the mountains he wandered");
    NPCActSing(4.0,"N'er turning to look back.");
    NPCActSing(4.0,"T'wards the caverns he stumbled");
    NPCActSing(4.0,"N'er considering what was there");
    NPCActSing(4.0,"And there he did battle");
    NPCActSing(4.0,"And there he did fall");
    NPCActSing(4.0,"Lo' a woman did return");
    NPCActSing(4.0,"Hail! she escaped it all");
    NPCActSing(4.0,"Hark! it did end.");
    NPCActSing(4.0,"The fear was no more");
    NPCActSing(4.0,"Heads lifted in pride once more.");
    break;
   } // epic tale of heroism
   case 6: { // Rhyming Dance tune
    ActionSpeakString("[SINGING] Find the barrel");
    NPCActSing(3.0,"Bolt and Arrow");
    NPCActSing(3.0,"Grow the crops");
    NPCActSing(3.0,"Tend your shops");
    NPCActSing(3.0,"Sail the ships");
    NPCActSing(3.0,"Sway your hips");
    NPCActSing(3.0,"Kiss the Lass");
    NPCActSing(3.0,"Swat her arse");
    NPCActSing(3.0,"Grab a Potion");
    NPCActSing(3.0,"Forbidden Lotion");
    NPCActSing(3.0,"Swim the River");
    NPCActSing(3.0,"Love your giver");
    NPCActSing(3.0,"Taste the ale");
    NPCActSing(3.0,"Drain it well");
    NPCActSing(3.0,"Close the bin");
    NPCActSing(3.0,"Let's sing again");
    break;
   } // Rhyming Commoner Dance Tune
   default: break;
 } // song switch
}// NPCActionSing()

//-------------------------------------------------
void NPCActionCallForHelp()
{
   ActionSpeakString("HELP!!!");
}// NPCActionCallForHelp()

//-------------------------------------------------
void NPCActionWakeupSleeper()
{
  int nFound=FALSE;
  int nLoop=1;
  object oTarget;
  while(!nFound)
  { // Find target
   oTarget=GetObjectCloseToFar(OBJECT_TYPE_CREATURE,"**",nLoop);
   if (oTarget!=OBJECT_INVALID)
   { // !OI
    if (GetHasEffect2(EFFECT_TYPE_SLEEP))
     nFound=TRUE; // this is the one
   } // !OI
   else
     nFound=TRUE; // end of the line
  } // Find Target
  if (oTarget!=OBJECT_INVALID)
  { // wake
    ActionMoveToObject(oTarget,FALSE,0.5);
    ActionSpeakString("Awaken you.");
    effect eSleep=EffectSleep();
    DelayCommand(2.0,RemoveEffect(oTarget, eSleep));
  } // wake
}// NPCWakeUpSleeper()

//-------------------------------------------------
void NPCActionMakeCampfire()
{
 object oFire=GetObjectWithin(OBJECT_TYPE_PLACEABLE,2.0,"(Campfire)",1);
 if (oFire==OBJECT_INVALID)
 {
  location lHere=GetLocation(OBJECT_SELF);
  ActionMoveAwayFromLocation(lHere,FALSE,0.8);
  oFire=CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfr",lHere,TRUE);
 }
}// NPCActionMakeCampfire()

//-------------------------------------------------
void NPCActionSetVar(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nSetTo=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  SetLocalInt(OBJECT_SELF,sName,nSetTo);
}// NPCActionSetVar()

//-------------------------------------------------
void NPCActionSayPhrase(string sParm)
{
  int nPhrase=StringToInt(GetStringRight(sParm,1));
  string sName="sSayString"+IntToString(nPhrase);
  string sToSay=GetLocalString(OBJECT_SELF,sName);
  if (GetStringLength(sToSay)<1)
  { // look for way points with the phrase
   sName="VAR_"+GetTag(OBJECT_SELF)+"_"+IntToString(nPhrase);
   object oWP=GetObjectByTag(sName);
   if (oWP!=OBJECT_INVALID)
   { // !OI
    sToSay=GetName(oWP);
   } // !OI
  } // look for way points with the phrase
  ActionSpeakString(sToSay);
}// NPCActionSayPhrase()

//-------------------------------------------------
void NPCActionCopyVar(string sParm)
{
  int nVarNum=StringToInt(GetStringRight(sParm,1));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  int nLoop=1;
  int nValue=GetLocalInt(OBJECT_SELF,sName);
  int nCopy=0;
  object oPerson=GetObjectWithin(OBJECT_TYPE_CREATURE,5.0,"**",nLoop);
  while(oPerson!=OBJECT_INVALID)
  { // !OI
   if(GetLocalInt(oPerson,sName)>nCopy) nCopy=GetLocalInt(oPerson,sName);
   nLoop++;
   oPerson=GetObjectWithin(OBJECT_TYPE_CREATURE,5.0,"**",nLoop);
  } // !OI
  if (nCopy>nValue)
   SetLocalInt(OBJECT_SELF,sName,nCopy);
}// NPCActionCopyVar()

//-------------------------------------------------
void NPCActionIfStatement(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nValue=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  if (GetLocalInt(OBJECT_SELF,sName)!=nValue)
  {
    SetLocalInt(OBJECT_SELF,"nDoAnotherCommand",FALSE);
    SetLocalString(OBJECT_SELF,"sActStr","");
  }
}// NPCActionIfStatement()

//-------------------------------------------------
void NPCActionAddTo(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nValue=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  SetLocalInt(OBJECT_SELF,sName,GetLocalInt(OBJECT_SELF,sName)+nValue);
}//NPCActionAddTo()

//-------------------------------------------------
void NPCActionSubtractFrom(string sParm)
{
  int nVarNum=StringToInt(GetStringLeft(GetStringRight(sParm,3),1));
  int nValue=StringToInt(GetStringRight(sParm,2));
  string sName="nNPCActionVar"+IntToString(nVarNum);
  int nCurrent=GetLocalInt(OBJECT_SELF,sName);
  nCurrent=nCurrent-nValue;
  if (nCurrent<0) nCurrent=0;
  SetLocalInt(OBJECT_SELF,sName,nCurrent);
}// NPCActionSubtractFrom()

//-------------------------------------------------
void NPCActionChangeClothes(string sParm)
{
  string sClothVar="sNPCActCloth"+GetStringRight(sParm,1);
  string sClothResRef=GetLocalString(OBJECT_SELF,sClothVar);
  if (GetStringLength(sClothResRef)>2)
  { // we have clothing
    object oClothing=GetItemInSlot(INVENTORY_SLOT_CARMOUR); // currently wearing
    if (sClothResRef!="NONE")
    { // create new clothing
     object oNewCloth=CreateItemOnObject(sClothResRef);
     if (oNewCloth!=OBJECT_INVALID)
     { //!OI
       ActionEquipItem(oNewCloth,INVENTORY_SLOT_CARMOUR);
       ActionDoCommand(DestroyObject(oClothing)); // destroy old clothing
     } //!OI
    } // create new clothing
    else if (sClothResRef=="NONE")
      ActionDoCommand(DestroyObject(oClothing)); // destroy old clothing
  } // we have clothing
}// NPCActionChangeClothes()

//-------------------------------------------------
void NPCActionSummonCreature(string sParm)
{
  string sSC=GetStringRight(sParm,1);
  string sMonResRef="";
  if (sSC=="0")
  { // 0 level
    switch (d4())
    { // 0 level
      case 1: sMonResRef="nw_badger"; break;
      case 2: sMonResRef="nw_bat"; break;
      case 3: sMonResRef="nw_btlfire"; break;
      case 4: sMonResRef="nw_goblina"; break;
    } // 0 level
  } // 0 level
  else if (sSC=="1")
  { // 1 Level
    switch (d4())
    { // Level 1
      case 1: sMonResRef="nw_dog"; break;
      case 2: sMonResRef="nw_nixie"; break;
      case 3: sMonResRef="nw_wolf"; break;
      case 4: sMonResRef="nw_dog"; break;
    } // Level 1
  } // 1 Level
  else if (sSC=="2")
  { // 2 Level
    switch(d4())
    { // Level 2
      case 1: sMonResRef="nw_pixie"; break;
      case 2: sMonResRef="nw_bearblck"; break;
      case 3: sMonResRef="nw_mepdust"; break;
      case 4: sMonResRef="nw_btlfire02"; break;
    } // Level 2
  } // 2 Level
  else if (sSC=="3")
  { // 3 Level
    switch(d4())
    { // Level 3
      case 1: sMonResRef="nw_nymph"; break;
      case 2: sMonResRef="nw_imp"; break;
      case 3: sMonResRef="nw_worg"; break;
      case 4: sMonResRef="nw_spidgiant"; break;
    } // Level 3
  } // 3 Level
  else if (sSC=="4")
  { // 4 Level
    switch(d4())
    { // Level 4
      case 1: sMonResRef="nw_lion"; break;
      case 2: sMonResRef="nw_fenhound"; break;
      case 3: sMonResRef="nw_ettercap"; break;
      case 4: sMonResRef="nw_minotaur"; break;
    } // Level 4
  } // 4 Level
  else if (sSC=="5")
  { // 5 Level
    switch(d4())
    { // Level 5
      case 1: sMonResRef="nw_bearbrwn"; break;
      case 2: sMonResRef="nw_direwolf"; break;
      case 3: sMonResRef="nw_boardire"; break;
      case 4: sMonResRef="nw_troll"; break;
    } // Level 5
  } // 5 Level
  else if (sSC=="6")
  { // 6 Level
    switch(d6())
    { // Level 6
      case 1: sMonResRef="nw_air"; break;
      case 2: sMonResRef="nw_earth"; break;
      case 3: sMonResRef="nw_fire"; break;
      case 4: sMonResRef="nw_water"; break;
      case 5: sMonResRef="nw_bearkodiak"; break;
      case 6: sMonResRef="nw_wolfwint"; break;
    } // Level 6
  } // 6 Level
  else if (sSC=="7")
  { // 7 Level
    switch(d4())
    { // Level 7
      case 1: sMonResRef="nw_umberhulk"; break;
      case 2: sMonResRef="nw_devour"; break;
      case 3: sMonResRef="nw_slaadbl"; break;
      case 4: sMonResRef="nw_shadow"; break;
    } // Level 7
  } // 7 Level
  else if (sSC=="8")
  { // 8 Level
    switch(d4())
    { // Level 8
      case 1: sMonResRef="nw_chound01"; break;
      case 2: sMonResRef="nw_allip"; break;
      case 3: sMonResRef="nw_grayrend"; break;
      case 4: sMonResRef="nw_minchief"; break;
    } // Level 8
  } // 8 Level
  else if (sSC=="9")
  { // 9 Level
    switch(d4())
    { // Level 9
      case 1: sMonResRef="nw_dmsucubus"; break;
      case 2: sMonResRef="nw_slaadgrn"; break;
      case 3: sMonResRef="nw_beardire"; break;
      case 4: sMonResRef="nw_minwiz"; break;
    } // Level 9
  } // 9 Level
  if (GetStringLength(sMonResRef)>4)
  { // conjure
    effect eSummon=EffectSummonCreature(sMonResRef,VFX_FNF_SUMMON_MONSTER_1,2.0);
    vector vSummon;
    location lSelf=GetLocation(OBJECT_SELF);
    vSummon=GetPosition(OBJECT_SELF);
    vSummon.x=vSummon.x+1.0;
    vSummon.y=vSummon.y+1.0;
    location lSummon=Location(GetArea(OBJECT_SELF),vSummon,GetFacing(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eSummon,lSummon,2.0);
    object oCreature=CreateObject(OBJECT_TYPE_CREATURE,sMonResRef,lSummon,TRUE);
    ChangeFaction(oCreature,OBJECT_SELF);
  } // conjure
}// NPCActionSummonCreature()

//-------------------------------------------------
void NPCActionUserDefinedEvent()
{
}// NPCActionUserDefinedEvent()

//-------------------------------------------------
void NPCAct3Set(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sSetTo="";
   string sWork=sIn;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip !
   sVarType=GetStringLeft(sWork,1);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip var type
   while(GetStringLeft(sWork,1)!="."&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)=="."&&GetStringLength(sWork)>1)
   { // strip . and build sSetTo
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
     while(GetStringLength(sWork)!=0)
     { // build set
       sSetTo=sSetTo+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
     } // build set
     if (sVarType=="I")
       SetLocalInt(OBJECT_SELF,sVarName,StringToInt(sSetTo));
     else if (sVarType=="S")
       SetLocalString(OBJECT_SELF,sVarName,sSetTo);
     else if (sVarType=="R")
     {
       int nRV=Random(StringToInt(sSetTo))+1;
       SetLocalInt(OBJECT_SELF,sVarName,nRV);
     }
   } // strip . and build sSetTo
   //SendMessageToPC(GetFirstPC(),GetTag(OBJECT_SELF)+":SET:"+sVarType+"("+sVarName+","+sSetTo+")");
}// NPCAct3Set()

//-----------------------------------------------------
void NPCAct3Add(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sAdd="";
   string sWork=sIn;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip +
   sVarType=GetStringLeft(sWork,1);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip var type
   while(GetStringLeft(sWork,1)!="."&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)=="."&&GetStringLength(sWork)>1)
   { // strip . and build sSetTo
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
     while(GetStringLength(sWork)!=0)
     { // build set
       sAdd=sAdd+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
     } // build set
     if (sVarType=="I")
       SetLocalInt(OBJECT_SELF,sVarName,GetLocalInt(OBJECT_SELF,sVarName)+StringToInt(sAdd));
     else if (sVarType=="S")
       SetLocalString(OBJECT_SELF,sVarName,GetLocalString(OBJECT_SELF,sVarName)+sAdd);
   } // strip . and build sSetTo
   //SendMessageToPC(GetFirstPC(),GetTag(OBJECT_SELF)+":AD:"+sVarType+"("+sVarName+","+sAdd+")");
}// NPCAct3Add()

//-----------------------------------------------------
void NPCAct3Sub(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sAdd="";
   string sWork=sIn;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip -
   sVarType=GetStringLeft(sWork,1);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip var type
   while(GetStringLeft(sWork,1)!="."&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)=="."&&GetStringLength(sWork)>1)
   { // strip . and build sSetTo
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
     while(GetStringLength(sWork)!=0)
     { // build set
       sAdd=sAdd+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
     } // build set
     if (sVarType=="I")
       SetLocalInt(OBJECT_SELF,sVarName,GetLocalInt(OBJECT_SELF,sVarName)-StringToInt(sAdd));
   } // strip . and build sSetTo
   //SendMessageToPC(GetFirstPC(),GetTag(OBJECT_SELF)+":SUB:"+sVarType+"("+sVarName+","+sAdd+")");
}// NPCAct3Sub()

//-----------------------------------------------------
void NPCAct3If(string sIn)
{
   string sVarType="";
   string sVarName="";
   string sAdd="";
   string sWork=sIn;
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip &
   sVarType=GetStringLeft(sWork,2);
   sWork=GetStringRight(sWork,GetStringLength(sWork)-2); // strip var type
   while(GetStringLeft(sWork,1)!="."&&GetStringLength(sWork)>0)
   { // build variable name
     sVarName=sVarName+GetStringLeft(sWork,1);
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
   } // build variable name
   if (GetStringLeft(sWork,1)==".")
     sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip .
     while(GetStringLength(sWork)!=0)
     { // build set
       sAdd=sAdd+GetStringLeft(sWork,1);
       sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
     } // build set
     int nDoAbortActs=TRUE;
     if (sVarType=="IE")
     { // IE
       if (GetLocalInt(OBJECT_SELF,sVarName)==StringToInt(sAdd))
         nDoAbortActs=FALSE;
     } // IE
     else if (sVarType=="IG")
     { // IG
       if (GetLocalInt(OBJECT_SELF,sVarName)>StringToInt(sAdd))
         nDoAbortActs=FALSE;
     } // IG
     else if (sVarType=="IL")
     { // IL
        if (GetLocalInt(OBJECT_SELF,sVarName)<StringToInt(sAdd))
          nDoAbortActs=FALSE;
     } // IL
     else if (sVarType=="IN")
     { // IN
        if (GetLocalInt(OBJECT_SELF,sVarName)!=StringToInt(sAdd))
          nDoAbortActs=FALSE;
     } // IN
     else if (sVarType=="SE")
     { // SE
        if (GetLocalString(OBJECT_SELF,sVarName)==sAdd)
          nDoAbortActs=FALSE;
     } // SE
     else if (sVarType=="SN")
     { // SN
        if (GetLocalString(OBJECT_SELF,sVarName)!=sAdd)
          nDoAbortActs=FALSE;
     } // SN
     else if (sVarType=="HT")
     { // HT
        if(GetItemPossessedBy(OBJECT_SELF,sVarName)!=OBJECT_INVALID)
          nDoAbortActs=FALSE;
     } // HT
     else if (sVarType=="HF")
     { // HF
        if(GetItemPossessedBy(OBJECT_SELF,sVarName)==OBJECT_INVALID)
          nDoAbortActs=FALSE;
     } // HF
     if (nDoAbortActs)// abort further actions at this waypoint
       SetLocalString(OBJECT_SELF,"sGNBActions"," ");
     //SendMessageToPC(GetFirstPC(),GetTag(OBJECT_SELF)+":IF:"+sVarType+"("+sVarName+","+sAdd+")");
}// NPCAct3Add()

//-----------------------------------------------------
void NPCAct3NewWP(string sIn)
{
  string sWork=sIn;
  sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
  //SendMessageToPC(GetFirstPC(),GetTag(OBJECT_SELF)+":NWP:"+sWork);
  SetLocalString(OBJECT_SELF,"sGNBDTag",sWork);
} // NPCAct3NewWP()

//-----------------------------------------------------
void NPCAct3Wait(string sIn)
{
  string sWork=sIn;
  sWork=GetStringRight(sWork,GetStringLength(sWork)-4);
  ActionWait(StringToFloat(sWork));
  int nB=0;
  float fF=StringToFloat(sWork);
  if (fF>0.0)
    nB=FloatToInt(fF/6.0);
  SetLocalInt(OBJECT_SELF,"nGNBMaxHB",nB);
} // NPCAct3Wait()

//-----------------------------------------------------
void NPCAct3Random(string sIn)
{
   string sWork=sIn;
   string sCurrent=GetLocalString(OBJECT_SELF,"sGNBActions");
   int nC=1; // count of current commands
   int nG=0; // goal #
   int nMC=0; // Max Command count
   string sOut=""; // new sGNBActions to output
   sWork=GetStringRight(sWork,GetStringLength(sWork)-2);
   nMC=StringToInt(sWork);
   sCurrent=GetStringRight(sCurrent,GetStringLength(sCurrent)-5);
   if (nMC!=0)
   { // !0
     nG=Random(nMC)+1;
     //SendMessageToPC(GetFirstPC(),GetTag(OBJECT_SELF)+":RND:sIn="+sIn+" nMC="+sWork+" nG="+IntToString(nG));
     while(nC<nG&&GetStringLength(sCurrent)>0)
     { // strip extraneous commands
      if (GetStringLeft(sCurrent,1)=="_")
        nC++;
       sCurrent=GetStringRight(sCurrent,GetStringLength(sCurrent)-1);
     } // strip extraneous commands
     if (nC==nG&&GetStringLength(sCurrent)>0)
     { // this is the command
       while(GetStringLeft(sCurrent,1)!="_"&&GetStringLength(sCurrent)>0)
       { // add it
         sOut=sOut+GetStringLeft(sCurrent,1);
         sCurrent=GetStringRight(sCurrent,GetStringLength(sCurrent)-1);
       } // add it
       if (GetStringLeft(sCurrent,1)=="_")
        {
          nC++;
          sCurrent=GetStringRight(sCurrent,GetStringLength(sCurrent)-1);
        }
     } // this is the command
     while(nC<=nMC&&GetStringLength(sCurrent)>0)
     { // strip extra random options
       if(GetStringLeft(sCurrent,1)=="_")
         nC++;
       sCurrent=GetStringRight(sCurrent,GetStringLength(sCurrent)-1);
     } // strip extra random options
     if (GetStringLength(sCurrent)>0)
     { // add these
      sOut=sOut+"_"+sCurrent;
     } // add these
   } // !0
   //SendMessageToPC(GetFirstPC(),GetTag(OBJECT_SELF)+":RC:"+sOut);
   SetLocalString(OBJECT_SELF,"sGNBActions",sOut);
} // NPCAct3Random()


//-----------------------------------------------------------------[MAIN]-----
void main()
{
  //object oPC=GetFirstPC(); // debug
  //SendMessageToPC(oPC,"Called script->"+GetTag(OBJECT_SELF));
  GenericNPCBehavior();
} // main()
