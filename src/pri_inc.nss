//::///////////////////////////////////////////////
//:: Customize inn in one script
//:: pri_inc
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

There is where you need to add information about your own inns
or where you go to customize the Purple Rose Inn.

Any time you change this script, you MUST BUILD THE MODULE for the changes
to show up.

Note: This script will return an error when trying to compile it. That's okay.
      Don't worry about it.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 20, 2002
//:://////////////////////////////////////////////


//Modify these variables to change how many hit points different types of food heal you when resting
int iRSA_MAGICFOOD = 5;
int iRSA_RICHFOOD = 3;
int iRSA_NORMFOOD = 2;
int iRSA_POORFOOD = 1;

// This is how much damage players will take from eating poisoned food
int iRSA_POISONFOOD = d4(3);
// This is the type of Poison players are effected with when they eat poisoned food
int iRSA_POISONTYPE = POISON_TINY_SPIDER_VENOM;

//Modify these variables to change how many hit points are healed when resting on a certain bed
int iRSA_RICHBED = 5;
int iRSA_NORMBED = 3;
int iRSA_POORBED = 1;

void GetInnArea(object oPC)
{

object oPRIForceInnRest = GetNearestObjectByTag("PRIForceInnRest", oPC);
if (!(GetIsObjectValid(oPRIForceInnRest))) return;

//Nothing needs to be changed here. The Script is just setting up all the Variables that will be used.

string sArea = GetTag(GetArea(oPC));

int iPriceRich = 0;
int iPriceNorm = 0;
int iPricePoor = 0;

int iNumberNorm = 0;
int iNumberPoor = 0;

int iRMNorm = 0;
int iRMPoor = 0;
int iSleepOver = 0;

int iRatChance = 0;

int iRandomBar = 0;

string sInnKeeper = "";
string sRoomArea = "";
string sServant = "";
string sButler = "";

string sKeyRich = "";

string sKeyNorm1 = "";
string sKeyNorm2 = "";
string sKeyNorm3 = "";
string sKeyNorm4 = "";
string sKeyNorm5 = "";
string sKeyNorm6 = "";
string sKeyNorm7 = "";
string sKeyNorm8 = "";
string sKeyNorm9 = "";
string sKeyNorm10 = "";
string sKeyNorm11 = "";
string sKeyNorm12 = "";
string sKeyNorm13 = "";
string sKeyNorm14 = "";
string sKeyNorm15 = "";
string sKeyNorm16 = "";
string sKeyNorm17 = "";
string sKeyNorm18 = "";
string sKeyNorm19 = "";
string sKeyNorm20 = "";

string sKeyPoor1 = "";
string sKeyPoor2 = "";
string sKeyPoor3 = "";
string sKeyPoor4 = "";
string sKeyPoor5 = "";
string sKeyPoor6 = "";
string sKeyPoor7 = "";
string sKeyPoor8 = "";
string sKeyPoor9 = "";
string sKeyPoor10 = "";
string sKeyPoor11 = "";
string sKeyPoor12 = "";
string sKeyPoor13 = "";
string sKeyPoor14 = "";
string sKeyPoor15 = "";
string sKeyPoor16 = "";
string sKeyPoor17 = "";
string sKeyPoor18 = "";
string sKeyPoor19 = "";
string sKeyPoor20 = "";

string sNotEnoughGoldR = "sNotEnoughGoldR not customized correctly! Please inform the DM.";
string sNotEnoughGoldN = "sNotEnoughGoldN not customized correctly! Please inform the DM.";
string sNotEnoughGoldP = "sNotEnoughGoldP not customized correctly! Please inform the DM.";

string sHaveRoom = "sHaveRoom not customized correctly! Please inform the DM.";

string sNoMoreSuite = "sNoMoreSuite not customized correctly! Please inform the DM.";
string sNoMoreNorm = "sNoMoreNorm not customized correctly! Please inform the DM.";
string sNoMorePoor = "sNoMorePoor not customized correctly! Please inform the DM.";

string sWhereRich = "sWhereRich not customized correctly! Please inform the DM.";

string sWhereNorm1 = "sWhereNorm1 not customized correctly! Please inform the DM.";
string sWhereNorm2 = "sWhereNorm2 not customized correctly! Please inform the DM.";
string sWhereNorm3 = "sWhereNorm3 not customized correctly! Please inform the DM.";
string sWhereNorm4 = "sWhereNorm4 not customized correctly! Please inform the DM.";
string sWhereNorm5 = "sWhereNorm5 not customized correctly! Please inform the DM.";
string sWhereNorm6 = "sWhereNorm6 not customized correctly! Please inform the DM.";
string sWhereNorm7 = "sWhereNorm7 not customized correctly! Please inform the DM.";
string sWhereNorm8 = "sWhereNorm8 not customized correctly! Please inform the DM.";
string sWhereNorm9 = "sWhereNorm9 not customized correctly! Please inform the DM.";
string sWhereNorm10 = "sWhereNorm10 not customized correctly! Please inform the DM.";
string sWhereNorm11 = "sWhereNorm11 not customized correctly! Please inform the DM.";
string sWhereNorm12 = "sWhereNorm12 not customized correctly! Please inform the DM.";
string sWhereNorm13 = "sWhereNorm13 not customized correctly! Please inform the DM.";
string sWhereNorm14 = "sWhereNorm14 not customized correctly! Please inform the DM.";
string sWhereNorm15 = "sWhereNorm15 not customized correctly! Please inform the DM.";
string sWhereNorm16 = "sWhereNorm16 not customized correctly! Please inform the DM.";
string sWhereNorm17 = "sWhereNorm17 not customized correctly! Please inform the DM.";
string sWhereNorm18 = "sWhereNorm18 not customized correctly! Please inform the DM.";
string sWhereNorm19 = "sWhereNorm19 not customized correctly! Please inform the DM.";
string sWhereNorm20 = "sWhereNorm20 not customized correctly! Please inform the DM.";

string sWherePoor1 = "sWherePoor1 not customized correctly! Please inform the DM.";
string sWherePoor2 = "sWherePoor2 not customized correctly! Please inform the DM.";
string sWherePoor3 = "sWherePoor3 not customized correctly! Please inform the DM.";
string sWherePoor4 = "sWherePoor4 not customized correctly! Please inform the DM.";
string sWherePoor5 = "sWherePoor5 not customized correctly! Please inform the DM.";
string sWherePoor6 = "sWherePoor6 not customized correctly! Please inform the DM.";
string sWherePoor7 = "sWherePoor7 not customized correctly! Please inform the DM.";
string sWherePoor8 = "sWherePoor8 not customized correctly! Please inform the DM.";
string sWherePoor9 = "sWherePoor9 not customized correctly! Please inform the DM.";
string sWherePoor10 = "sWherePoor10 not customized correctly! Please inform the DM.";
string sWherePoor11 = "sWherePoor11 not customized correctly! Please inform the DM.";
string sWherePoor12 = "sWherePoor12 not customized correctly! Please inform the DM.";
string sWherePoor13 = "sWherePoor13 not customized correctly! Please inform the DM.";
string sWherePoor14 = "sWherePoor14 not customized correctly! Please inform the DM.";
string sWherePoor15 = "sWherePoor15 not customized correctly! Please inform the DM.";
string sWherePoor16 = "sWherePoor16 not customized correctly! Please inform the DM.";
string sWherePoor17 = "sWherePoor17 not customized correctly! Please inform the DM.";
string sWherePoor18 = "sWherePoor18 not customized correctly! Please inform the DM.";
string sWherePoor19 = "sWherePoor19 not customized correctly! Please inform the DM.";
string sWherePoor20 = "sWherePoor20 not customized correctly! Please inform the DM.";

string sServantCommand = "sServantCommand not customized correctly! Please inform the DM.";
string sServantRespond = "sServantRespond not customized correctly! Please inform the DM.";

string sButKitchen = "";
string sButNoMeat = "sButNoMeat not customized correctly! Please inform the DM.";
string sButCook = "sButCook not customized correctly! Please inform the DM.";
string sButMeatDone = "sButMeatDone not customized corrrectly! Please inform the DM.";
string sButSlpOver = "sButSlpOver not customized correctly! Please inform the DM.";

string sButGuests = "sButGuests not customized correctly! Please inform the DM.";
string sButGuests2 = "sButGuests2 not customized correctly! Please inform the DM.";
string sButGuestOut = "sButGuestOut not customized correctly! Please inform the DM.";
string sButNoLeave = "sButNoLeave not customized correctly! Please inform the DM.";
string sButLetOut = "sButLetOut not customized correctly! Please inform the DM.";
string sButLetOut2 = "sButLetOut2 not customized correctly! Please inform the DM.";
string sButDoorOpen = "sButDoorOpen not customized correctly! Please inform the DM.";
string sButDoorLock = "sButDoorLock not customized correctly! Please inform the DM.";
string sButGuestWala = "sButGuestWala not customized correctly! Please inform the DM.";
string sButGuestPa = "sButGuestPA not customized correctly! Please inform the DM.";

string sPoorWake = "sPoorWake not customized correctly! Please inform the DM.";

string sBarmaid = "";
string sBarmaidTalk = "";
string sBarWP = "";
string sWaitWP = "";

string sAsk1 = "sAsk1 not customized correctly! Please inform the DM.";
string sReturn1 = "sReturn1 not customized correctly! Please inform the DM.";
string sAsk2 = "sAsk2 not customized correctly! Please inform the DM.";
string sReturn2 = "sReturn2 not customized correctly! Please inform the DM.";
string sAsk3 = "sAsk3 not customized correctly! Please inform the DM.";
string sReturn3 = "sReturn3 not customized correctly! Please inform the DM.";
string sAsk4 = "sAsk4 not customized correctly! Please inform the DM.";
string sReturn4 = "sReutnr4 not customized correctly! Please inform the DM.";

string sFoodStore = "";
string sDrinkStore = "";

//Done Setting Up

//Edit variables below to customize the Purple Rose Inn
//If you're Adding a new Inn, don't do that here. Do that in the next section.

if (sArea == "PurpleRose" || sArea == "PurpleRoseUpstairs")
 {
  iPriceRich = 100;
  iPriceNorm = 15;
  iPricePoor = 5;

  iRatChance = 85;

  iRMNorm = 2;
  iRMPoor = 3;
  iSleepOver = 4;

  iRandomBar = 11;

  iNumberNorm = 4;
  iNumberPoor = 4;

  sInnKeeper = "Jarnor";
  sRoomArea = "PurpleRoseUpstairs";
  sServant = "PurpleRoseServant";
  sButler = "PurpleRoseButler";

  sKeyRich = "suitekey";

  sKeyNorm1 = "normalkey1";
  sKeyNorm2 = "normalkey2";
  sKeyNorm3 = "normalkey3";
  sKeyNorm4 = "normalkey4";

  sKeyPoor1 = "poorkey1";
  sKeyPoor2 = "poorkey2";
  sKeyPoor3 = "poorkey3";
  sKeyPoor4 = "poorkey4";

  sNotEnoughGoldR = "You don't have enough gold for that room! It costs "+IntToString(iPriceRich)+" gold pieces.";
  sNotEnoughGoldN = "You don't have enough gold for that room! It costs "+IntToString(iPriceNorm)+" gold pieces.";
  sNotEnoughGoldP = "You don't have enough gold for that room! It costs "+IntToString(iPricePoor)+" gold pieces.";

  sHaveRoom = "You've already rented out a room. I won't rent another out to you! Space is limited and I have many customers.";

  sNoMoreSuite = "I'm sorry. Our King's Suite is currently occupied.";
  sNoMoreNorm = "I'm sorry. All our regular rooms are currently full right now.";
  sNoMorePoor = "I'm sorry. All our cheap rooms are currently full right now.";

  sWhereRich = "Here's the key to the suite. It's up the stairs and then straight ahead at the end of the hallway.";

  sWhereNorm1 = "Here's the key to your room. Go up the stairs, continue straight, and it's the first door on the left.";
  sWhereNorm2 = "Here's the key to your room. Go up the stairs, continue straight, and it's the second door on the left.";
  sWhereNorm3 = "Here's the key to your room. Go up the stairs, continue straight, and it's the first door on the right.";
  sWhereNorm4 = "Here's the key to your room. Go up the stairs, continue straight, and it's the second door on the right.";

  sWherePoor1 = "Here's the key to your room. Go up the stairs, turn right, and it's the door at the end of the hall.";
  sWherePoor2 = "Here's the key to your room. Go up the stairs, turn left, and it's the first door you come to.";
  sWherePoor3 = "Here's the key to your room. Go up the stairs, turn left, and it's the second door you come to.";
  sWherePoor4 = "Here's the key to your room. Go up the stairs, turn left, go to the end of that hallway and then turn right. Your room is the door at the end of that hallway.";

  sServantCommand = "Maria, we had someone check out. Can you go clean up their room?";
  sServantRespond = "Yes, Jarnor, I'll go do that now.";

  sButKitchen = "PRButKitchen";
  sButNoMeat = "You don't have any meat!";
  sButCook = "I'll be in the kitchen then preparing your meal.";
  sButMeatDone = "Here are your cooked steaks. I hope you like them.";
  sButSlpOver = "The guests beds are now set up and I will allow the number of guests you specificed to stay the night.";

  sButGuests = "Let me know when all your guests are here, "+GetName(oPC)+".";
  sButGuests2 = "Right away. Talk me to again when all your other guests have arrived.";
  sButGuestOut = "I'll go get the door for them.";
  sButNoLeave = "You must stay in your room if you have guests over!";
  sButLetOut = "I'll get the door for you and send a message to your host that you are leaving.";
  sButLetOut2 = "Hmm, it seems your host cannot be found anywhere. Let me get the door for you.";
  sButDoorOpen = "The door is open, you may leave whenever you wish.";
  sButDoorLock = "I shall lock the door then.";
  sButGuestWala = "Yes, all your guests have left. I shall unlock the doors to your bedroom.";
  sButGuestPa = "You still have guests over! I cannot unlock the door to your bedroom until all your guests leave.";

  sPoorWake = "The filthy conditions of the room, the quality of the cot, and the occasional rat scurrying by makes it impossible for you to get a good night's rest here.";

  sBarmaid = "PurpleRoseBarmaid";
  sBarmaidTalk = "pri_barmaid";
  sBarWP = "KitchenWP";
  sWaitWP = "PRWaitPoint";

  sAsk1 = "Can I get you something?";
  sReturn1 = "Here's your order.";
  sAsk2 = "What'll it be?";
  sReturn2 = "That'll be two gold.";
  sAsk3 = "What do you want to drink?";
  sReturn3 = "Let me know when you need another.";
  sAsk4 = "Do you want anything to eat?";
  sReturn4 = "Watch out, the plate's hot!";

  sFoodStore = "PurpleRoseFood";
  sDrinkStore = "PurpleRoseDrinks";
 }

//End Edit of Purple Rose Inn

//Add other Inn Areas here!

//Copy and paste the Template here and uncomment the /* and */ to activate a new inn

//End Add other Inn Areas

//Template for adding Inn Areas

/*

//This is the Tag of Your Inn Area. You might Need to have an || (or) statement if you have more than
//one area in your Inn (like the Purple Rose Inn does)

if (sArea == "TagOfYourArea")
{

//These Variables control the Price of your Rooms
 iPriceRich = 0;
 iPriceNorm = 0;
 iPricePoor = 0;

//NumberNorm is the number of normal rooms your inn has
//NumberPoor is the number of poor rooms your inn has
 iNumberNorm = 0;
 iNumberPoor = 0;

//RMNorm is how many roommates are allowed in a Normal Room.
//RMPoor is the number of roommates allowed in a Poor Room
 iRMNorm = 0;
 iRMPoor = 0;
//This determines if players are allowed to have sleep overs in the Suite. Set to number of players
//you wish to allow over. Number can in the range of 0-6.
 iSleepOver = 0;

//This is the percent chance of being woken up by Rats in the Poor Room
 iRatChance = 0;

//This should be the number of NPC customers in the Tavern part of the Inn.
//(Used in the Barmaid script to determine which customer to serve)
 iRandomBar = 0;

//These are the Tags that are in your inn.
//InnKeeper is the Tag of the NPC that sells the keys
 sInnKeeper = "";
//This is the Tag of the Area where the Bedrooms are.
 sRoomArea = "";
//This is the Tag of the Person that goes and resets the room when trigged through the DM Option
//found on the Innkeeper. May be the same person as the Innkeeper if you desire
 sServant = "";
//This is the Tag of the Servant (Butler) in the Suite
 sButler = "";

//This is the blueprint ref of the key that works on the suite
 sKeyRich = "";

//These are the blueprint ref's of the keys that work on the normal rooms.
//Note: If you wish to rent out more than four rooms, just keep adding sKeyNorm# strings going
//up in consecutive numbers. If you are going to have more than 20 rooms, you will need to add
//more string sKeyNorm# at the start of the script and then set them as local strings at the
//end of the scripts.
 sKeyNorm1 = "";
 sKeyNorm2 = "";
 sKeyNorm3 = "";
 sKeyNorm4 = "";

//These are the blueprint ref's of the keys that work on the cheap rooms.
//Note: If you wish to rent out more than four rooms, just keep adding sKeyPoor# strings going
//up in consecutive numbers. If you are going to have more than 20 rooms, you will need to add
//more string sKeyPoor# at the start of the script and then set them as local strings at the
//end of the scripts.
 sKeyPoor1 = "";
 sKeyPoor2 = "";
 sKeyPoor3 = "";
 sKeyPoor4 = "";

//These are the strings spoken the Innkeeper when the player doesn't have enough money for the room
//they just tried to buy. R is for the Suite. N is for a normal room. P is for a cheap room.
 sNotEnoughGoldR = "sNotEnoughGoldR not customized correctly! Please inform the DM.";
 sNotEnoughGoldN = "sNotEnoughGoldN not customized correctly! Please inform the DM.";
 sNotEnoughGoldP = "sNotEnoughGoldP not customized correctly! Please inform the DM.";

//This is the string spoken by the Innkeeper when you have already rented a room out.
 sHaveRoom = "sHaveRoom not customized correctly! Please inform the DM.";

//These are the strings spoken by the Innkeeper when all the rooms of that type are full.
 sNoMoreSuite = "sNoMoreSuite not customized correctly! Please inform the DM.";
 sNoMoreNorm = "sNoMoreNorm not customized correctly! Please inform the DM.";
 sNoMorePoor = "sNoMorePoor not customized correctly! Please inform the DM.";

//This is spoken by the Innkeeper after the Suite is bought to tell the players where it is.
 sWhereRich = "sWhereRich not customized correctly! Please inform the DM.";

//This is spoken by the Innkeeper after a normal room is bought to tell the player where the
//correct room is.
//Note: If you wish to rent out more than four rooms, just keep adding sWhereNorm# strings going
//up in consecutive numbers. If you are going to have more than 20 rooms, you will need to add
//more string sWhereNorm# at the start of the script and then set them as local strings at the
//end of the scripts.
 sWhereNorm1 = "sWhereNorm1 not customized correctly! Please inform the DM.";
 sWhereNorm2 = "sWhereNorm2 not customized correctly! Please inform the DM.";
 sWhereNorm3 = "sWhereNorm3 not customized correctly! Please inform the DM.";
 sWhereNorm4 = "sWhereNorm4 not customized correctly! Please inform the DM.";

//This is spoken by the Innkeeper after a cheap room is bought to tell the player where the
//correct room is.
//Note: If you wish to rent out more than four rooms, just keep adding sWherePoor# strings going
//up in consecutive numbers. If you are going to have more than 20 rooms, you will need to add
//more string sWherePoor# at the start of the script and then set them as local strings at the
//end of the scripts.
 sWherePoor1 = "sWherePoor1 not customized correctly! Please inform the DM.";
 sWherePoor2 = "sWherePoor2 not customized correctly! Please inform the DM.";
 sWherePoor3 = "sWherePoor3 not customized correctly! Please inform the DM.";
 sWherePoor4 = "sWherePoor4 not customized correctly! Please inform the DM.";

//These are the strings spoken by the Servant when DM gives the command to reset a room.
//sServantCommand is spoken by the Innkeeper. sServantRespond is spoken by the servant.
//Note: If the servant is the same person as the Innkeeper sServant Respond should be changed to "".
 sServantCommand = "sServantCommand not customized correctly! Please inform the DM.";
 sServantRespond = "sServantRespond not customized correctly! Please inform the DM.";

//This is the Tag of the Waypoint placed in the Suite's Kitchen used by the Butler to cook.
 sButKitchen = "";

//These are the strings spoken by the Servant (Butler) in the Suite.

//This string is spoken by the Butler when players ask Butler to cook but player has no meat.
 sButNoMeat = "sButNoMeat not customized correctly! Please inform the DM.";
//This string is spoken by the Butler when players asks Butler to cook for him.
 sButCook = "sButCook not customized correctly! Please inform the DM.";
//This string is spoken by the Butler when the meat is done cooking and returned to the players.
 sButMeatDone = "sButMeatDone not customized correctly! Please inform the DM.";
//This string is spoken by the Butler after he has set up the guest beds.
 sButSlpOver = "sButSlpOver not customized correctly! Please inform the DM.";

//This one is spoken by the Butler when the player first invites guest in to his room.
 sButGuests = "sButGuests not customized correctly! Please inform the DM.";
//This one is spoken when the butler has to open the door again to let more guests in.
 sButGuests2 = "sButGuests2 not customized correctly! Please inform the DM.";
//This is spoken when the Butler is told to open the door to let guests out.
 sButGuestOut = "sButGuestOut not customized correctly! Please inform the DM.";
//This is spoken by the Butler when the Renter of the Room tries to leave the room while he has
//guests over still.
 sButNoLeave = "sButNoLeave not customized correctly! Please inform the DM.";
//This is spoken by the Butler when the Renter of the Suite is still in the game when a guest
//requests to be let out of the suite if the door is closed.
 sButLetOut = "sButLetOut not customized correctly! Please inform the DM.";
//This is spoken by the Butler when the Renter of the Suite is not in the game when a guests
//requests to be let out of the suite if the door is closed.
 sButLetOut2 = "sButLetOut2 not customized correctly! Please inform the DM.";
//This is spoken by the Butler if a guests requests to leave and the door is already open.
 sButDoorOpen = "sButDoorOpen not customized correctly! Please inform the DM.";
//This is spoken by the Butler when he is told by the Renter to not allow any more guests in.
 sButDoorLock = "sButDoorLock not customized correctly! Please inform the DM.";
//This is spoken by the Butler when the Renter tells the Butler to open the door to the bedroom again
//and there are no more guests in the room.
 sButGuestWala = "sButGuestWala not customized correctly! Please inform the DM.";
//This is spoken by the Butler when there are still guests in the room when the Renter tells the
//Butler to unlock his bedroom doors.
 sButGuestPa = "sButGuestPA not customized correctly! Please inform the DM.";

//This is the error message recieved when woken up by rats in the Cheap room.
 sPoorWake = "sPoorWake not customized correctly! Please inform the DM.";

//This is the Tag of your barmaid.
 sBarmaid = "";
//This is the Barmaid's conversation file
 sBarmaidTalk = "";
//This is the Tag of where the barmaid goes to get orders. Must be a waypoint!
 sBarWP = "";
//This is the Tag where the Barmaid goes after completing an order. Must be a waypoint!
 sWaitWP = "";

//These are the different lines the Barmaid says when taking and return orders. Ask is said first,
//then barmaid goes and gets food, returns to customer, and then return is said.
 sAsk1 = "sAsk1 not customized correctly! Please inform the DM.";
 sReturn1 = "sReturn1 not customized correctly! Please inform the DM.";
 sAsk2 = "sAsk2 not customized correctly! Please inform the DM.";
 sReturn2 = "sReturn2 not customized correctly! Please inform the DM.";
 sAsk3 = "sAsk3 not customized correctly! Please inform the DM.";
 sReturn3 = "sReturn3 not customized correctly! Please inform the DM.";
 sAsk4 = "sAsk4 not customized correctly! Please inform the DM.";
 sReturn4 = "sReutnr4 not customized correctly! Please inform the DM.";

//These are the tags of the stores that the barmaid uses to sell food or drink to the PC's
 sFoodStore = "";
 sDrinkStore = "";
}
*/

//End of Template for adding Inn Areas

//Do Not Edit any Code below this line (Unless you know what you're doing :)

SetLocalInt(oPC, "RSA_PriceRich", iPriceRich);
SetLocalInt(oPC, "RSA_PriceNorm", iPriceNorm);
SetLocalInt(oPC, "RSA_PricePoor", iPricePoor);

SetLocalInt(oPC, "RSA_NumberNorm", iNumberNorm);
SetLocalInt(oPC, "RSA_NumberPoor", iNumberPoor);

SetLocalInt(oPC, "RSA_RMNorm", iRMNorm);
SetLocalInt(oPC, "RSA_RMPoor", iRMPoor);
SetLocalInt(oPC, "RSA_SleepOver", iSleepOver);

SetLocalInt(oPC, "RSA_RatChance", iRatChance);

SetLocalInt(oPC, "RSA_RandomBar", iRandomBar);

SetLocalString(oPC, "RSA_InnKeeper", sInnKeeper);
SetLocalString(oPC, "RSA_RoomArea", sRoomArea);
SetLocalString(oPC, "RSA_Servant", sServant);
SetLocalString(oPC, "RSA_Butler", sButler);

SetLocalString(oPC, "RSA_KeyRich", sKeyRich);

SetLocalString(oPC, "RSA_KeyNorm1", sKeyNorm1);
SetLocalString(oPC, "RSA_KeyNorm2", sKeyNorm2);
SetLocalString(oPC, "RSA_KeyNorm3", sKeyNorm3);
SetLocalString(oPC, "RSA_KeyNorm4", sKeyNorm4);
SetLocalString(oPC, "RSA_KeyNorm5", sKeyNorm5);
SetLocalString(oPC, "RSA_KeyNorm6", sKeyNorm6);
SetLocalString(oPC, "RSA_KeyNorm7", sKeyNorm7);
SetLocalString(oPC, "RSA_KeyNorm8", sKeyNorm8);
SetLocalString(oPC, "RSA_KeyNorm9", sKeyNorm9);
SetLocalString(oPC, "RSA_KeyNorm10", sKeyNorm10);
SetLocalString(oPC, "RSA_KeyNorm11", sKeyNorm11);
SetLocalString(oPC, "RSA_KeyNorm12", sKeyNorm12);
SetLocalString(oPC, "RSA_KeyNorm13", sKeyNorm13);
SetLocalString(oPC, "RSA_KeyNorm14", sKeyNorm14);
SetLocalString(oPC, "RSA_KeyNorm15", sKeyNorm15);
SetLocalString(oPC, "RSA_KeyNorm16", sKeyNorm16);
SetLocalString(oPC, "RSA_KeyNorm17", sKeyNorm17);
SetLocalString(oPC, "RSA_KeyNorm18", sKeyNorm18);
SetLocalString(oPC, "RSA_KeyNorm19", sKeyNorm19);
SetLocalString(oPC, "RSA_KeyNorm20", sKeyNorm20);

SetLocalString(oPC, "RSA_KeyPoor1", sKeyPoor1);
SetLocalString(oPC, "RSA_KeyPoor2", sKeyPoor2);
SetLocalString(oPC, "RSA_KeyPoor3", sKeyPoor3);
SetLocalString(oPC, "RSA_KeyPoor4", sKeyPoor4);
SetLocalString(oPC, "RSA_KeyPoor5", sKeyPoor5);
SetLocalString(oPC, "RSA_KeyPoor6", sKeyPoor6);
SetLocalString(oPC, "RSA_KeyPoor7", sKeyPoor7);
SetLocalString(oPC, "RSA_KeyPoor8", sKeyPoor8);
SetLocalString(oPC, "RSA_KeyPoor9", sKeyPoor9);
SetLocalString(oPC, "RSA_KeyPoor10", sKeyPoor10);
SetLocalString(oPC, "RSA_KeyPoor11", sKeyPoor11);
SetLocalString(oPC, "RSA_KeyPoor12", sKeyPoor12);
SetLocalString(oPC, "RSA_KeyPoor13", sKeyPoor13);
SetLocalString(oPC, "RSA_KeyPoor14", sKeyPoor14);
SetLocalString(oPC, "RSA_KeyPoor15", sKeyPoor15);
SetLocalString(oPC, "RSA_KeyPoor16", sKeyPoor16);
SetLocalString(oPC, "RSA_KeyPoor17", sKeyPoor17);
SetLocalString(oPC, "RSA_KeyPoor18", sKeyPoor18);
SetLocalString(oPC, "RSA_KeyPoor19", sKeyPoor19);
SetLocalString(oPC, "RSA_KeyPoor20", sKeyPoor20);

SetLocalString(oPC, "RSA_NotEnoughGoldR", sNotEnoughGoldR);
SetLocalString(oPC, "RSA_NotEnoughGoldN", sNotEnoughGoldN);
SetLocalString(oPC, "RSA_NotEnoughGoldP", sNotEnoughGoldP);

SetLocalString(oPC, "RSA_HaveRoom", sHaveRoom);

SetLocalString(oPC, "RSA_NoMoreSuite", sNoMoreSuite);
SetLocalString(oPC, "RSA_NoMoreNorm", sNoMoreNorm);
SetLocalString(oPC, "RSA_NoMorePoor", sNoMorePoor);

SetLocalString(oPC, "RSA_WhereRich", sWhereRich);

SetLocalString(oPC, "RSA_WhereNorm1", sWhereNorm1);
SetLocalString(oPC, "RSA_WhereNorm2", sWhereNorm2);
SetLocalString(oPC, "RSA_WhereNorm3", sWhereNorm3);
SetLocalString(oPC, "RSA_WhereNorm4", sWhereNorm4);
SetLocalString(oPC, "RSA_WhereNorm5", sWhereNorm5);
SetLocalString(oPC, "RSA_WhereNorm6", sWhereNorm6);
SetLocalString(oPC, "RSA_WhereNorm7", sWhereNorm7);
SetLocalString(oPC, "RSA_WhereNorm8", sWhereNorm8);
SetLocalString(oPC, "RSA_WhereNorm9", sWhereNorm9);
SetLocalString(oPC, "RSA_WhereNorm10", sWhereNorm10);
SetLocalString(oPC, "RSA_WhereNorm11", sWhereNorm11);
SetLocalString(oPC, "RSA_WhereNorm12", sWhereNorm12);
SetLocalString(oPC, "RSA_WhereNorm13", sWhereNorm13);
SetLocalString(oPC, "RSA_WhereNorm14", sWhereNorm14);
SetLocalString(oPC, "RSA_WhereNorm15", sWhereNorm15);
SetLocalString(oPC, "RSA_WhereNorm16", sWhereNorm16);
SetLocalString(oPC, "RSA_WhereNorm17", sWhereNorm17);
SetLocalString(oPC, "RSA_WhereNorm18", sWhereNorm18);
SetLocalString(oPC, "RSA_WhereNorm19", sWhereNorm19);
SetLocalString(oPC, "RSA_WhereNorm20", sWhereNorm20);

SetLocalString(oPC, "RSA_WherePoor1", sWherePoor1);
SetLocalString(oPC, "RSA_WherePoor2", sWherePoor2);
SetLocalString(oPC, "RSA_WherePoor3", sWherePoor3);
SetLocalString(oPC, "RSA_WherePoor4", sWherePoor4);
SetLocalString(oPC, "RSA_WherePoor5", sWherePoor5);
SetLocalString(oPC, "RSA_WherePoor6", sWherePoor6);
SetLocalString(oPC, "RSA_WherePoor7", sWherePoor7);
SetLocalString(oPC, "RSA_WherePoor8", sWherePoor8);
SetLocalString(oPC, "RSA_WherePoor9", sWherePoor9);
SetLocalString(oPC, "RSA_WherePoor10", sWherePoor10);
SetLocalString(oPC, "RSA_WherePoor11", sWherePoor11);
SetLocalString(oPC, "RSA_WherePoor12", sWherePoor12);
SetLocalString(oPC, "RSA_WherePoor13", sWherePoor13);
SetLocalString(oPC, "RSA_WherePoor14", sWherePoor14);
SetLocalString(oPC, "RSA_WherePoor15", sWherePoor15);
SetLocalString(oPC, "RSA_WherePoor16", sWherePoor16);
SetLocalString(oPC, "RSA_WherePoor17", sWherePoor17);
SetLocalString(oPC, "RSA_WherePoor18", sWherePoor18);
SetLocalString(oPC, "RSA_WherePoor19", sWherePoor19);
SetLocalString(oPC, "RSA_WherePoor20", sWherePoor20);

SetLocalString(oPC, "RSA_ServantCommand", sServantCommand);
SetLocalString(oPC, "RSA_ServantRespond", sServantRespond);

SetLocalString(oPC, "RSA_ButKitchen", sButKitchen);
SetLocalString(oPC, "RSA_ButNoMeat", sButNoMeat);
SetLocalString(oPC, "RSA_ButCook", sButCook);
SetLocalString(oPC, "RSA_ButMeatDone", sButMeatDone);
SetLocalString(oPC, "RSA_ButSlpOver", sButSlpOver);

SetLocalString(oPC, "RSA_ButNoLeave", sButNoLeave);
SetLocalString(oPC, "RSA_ButGuestPa", sButGuestPa);
SetLocalString(oPC, "RSA_ButGuestWala", sButGuestWala);
SetLocalString(oPC, "RSA_ButGuests", sButGuests);
SetLocalString(oPC, "RSA_ButGuests2", sButGuests2);
SetLocalString(oPC, "RSA_ButGuestOut", sButGuestOut);
SetLocalString(oPC, "RSA_ButLetOut", sButLetOut);
SetLocalString(oPC, "RSA_ButLetOut2", sButLetOut2);
SetLocalString(oPC, "RSA_ButDoorOpen", sButDoorOpen);
SetLocalString(oPC, "RSA_ButDoorLock", sButDoorLock);

SetLocalString(oPC, "RSA_PoorWake", sPoorWake);

SetLocalString(oPC, "RSA_Barmaid", sBarmaid);
SetLocalString(oPC, "RSA_BarmaidTalk", sBarmaidTalk);
SetLocalString(oPC, "RSA_BarWP", sBarWP);
SetLocalString(oPC, "RSA_WaitWP", sWaitWP);

SetLocalString(oPC, "RSA_Ask1", sAsk1);
SetLocalString(oPC, "RSA_Ask2", sAsk2);
SetLocalString(oPC, "RSA_Ask3", sAsk3);
SetLocalString(oPC, "RSA_Ask4", sAsk4);
SetLocalString(oPC, "RSA_Return1", sReturn1);
SetLocalString(oPC, "RSA_Return2", sReturn2);
SetLocalString(oPC, "RSA_Return3", sReturn3);
SetLocalString(oPC, "RSA_Return4", sReturn4);

SetLocalString(oPC, "RSA_FoodStore", sFoodStore);
SetLocalString(oPC, "RSA_DrinkStore", sDrinkStore);
}
