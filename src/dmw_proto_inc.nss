//::///////////////////////////////////////////////
//Test functions from dmw_test_inc

// checks if a nearby object is destroyable
int dmwand_isnearbydestroyable();
// Check if the target can be created with CreateObject
int dmwand_istargetcreateable();
//Check if target is a destroyable object
int dmwand_istargetdestroyable();
// checks if the wand was NOT clicked on an object
int dmwand_istargetinvalid();
// check if the target has an inventory
int dmwand_istargetinventory();
//Check if the target is not the wand's user
int dmwand_istargetnotme();
//Check if target is an NPC or monster
int dmwand_istargetnpc();
//Check if the target is a PC
int dmwand_istargetpc();
//Check if the target is a PC and not me
int dmwand_istargetpcnme();
// Check if the target is a PC or NPC
// uses the CON score currently
int dmwand_istargetpcornpc();
//Check if the target is a PC or an npc and not me
int dmwand_istargetpcornpcnme();
// Check if target is a placeable
int dmwand_istargetplaceable();

//::///////////////////////////////////////////////
//Conversation functions from dmw_conv_inc

//Build Conversation by Dopple
//Build a conversation level, adding "next" and "previous" as needed
void dmwand_BuildConversation(string sConversation, string sParams);
//Build Conversation Dialog by Dopple
//Used by BuildConversation to translate string representation of a
// dialog name to its function
int dmwand_BuildConversationDialog(int nCurrent, int nChoice, string sConversation, string sParams);

// Chose which direction something's alignment should change
int dmw_conv_ChangeAlign(int nCurrent, int nChoice, string sParams = "");
// Chose what attributes to display about a creature
int dmw_conv_DispAttribs(int nCurrent, int nChoice, string sParams = "");
// Chose what ability or skill to do a roll with
int dmw_conv_DoRoll(int nCurrent, int nChoice, string sParams = "");
// Chose what to do with an object's inventory
int dmw_conv_Inventory(int nCurrent, int nChoice, string sParams = "");
// Diaplay an item's stats, and chose what to do with that item
int dmw_conv_ItemListConv(int nCurrent, int nChoice, string sParams = "");
// List a creature's inventory
int dmw_conv_ListInventory(int nCurrent, int nChoice, string sParams = "");
// List all players
int dmw_conv_ListPlayers(int nCurrent, int nChoice, string sParams = "");
// Chose how much to modify alignment by
int dmw_conv_ModAlign(int nCurrent, int nChoice, string sParams = "");
// Chose how much to change reputation by
int dmw_conv_ModRep(int nCurrent, int nChoice, string sParams = "");
// Chose whether a roll should be public or private
int dmw_conv_Roll(int nCurrent, int nChoice, string sParams = "");
// Starting conversation, all branches lead from here
int dmw_conv_Start(int nCurrent, int nChoice, string sParams = "");
// Chose how far to advance the time of day
int dmw_conv_TimeOfDay(int nCurrent, int nChoice, string sParams = "");

//::///////////////////////////////////////////////
//dmwand functions from dmw_func_inc

//Ability Roll Funtion by Jhenne
// - nAbility: ABILITY_*
// - nSecret: TRUE if roll should not be shown to other players
void dmwand_AbilityCheck(int nAbility, int nSecret = TRUE);
//Advance time by Dopple
// -nHours: number of hours to advance time by
void dmwand_AdvanceTime(int nHours);
//Alignment by Robert Bernavich, Jhenne, Archaego
// function returns concatenated string version of objects Alignment
string dmwand_Alignment(object oEntity);
//ClassLevel by Robert Bernavich, Jhenne, Archaego
// Returns all three classes and levels in string format of Object
string dmwand_ClassLevel(object oEntity);
//Destroy item by Dopple
//Destroys item in "dmw_item" local object on speaker, then returns to
// inventory list dialog
void dmwand_DestroyItem();
//Destroy nearby by Dopple
// Destroy the first object we find nearby the target location, then
// return to starting dialog
void dmwand_DestroyNearbyTarget();
//Destroy target by Dopple, adapted from Bioware script in World Builder Guide
// destroy target object/creature, then return to starting dialog
void dmwand_DestroyTarget();
//Export Characters suggested by a great number of people
void dmwand_ExportChars();
//Follow me by Jhenne
// force creature or player to follow user
void dmwand_FollowMe();
//Follow Target by Jhenne
// force user to follow target
void dmwand_FollowTarget();
//Gender by Robert Bernavich, Jhenne, Archaego
// function returns a string value of objects gender
string dmwand_Gender(object oEntity);
//Identify item by Dopple
// toggle identified status of item in "dmw_item" local object on user,
// then return to the ItemListConv dialog
void dmwand_IdentifyItem();
//Inventory by Robert Bernavich, Jhenne, Archaego, Dopple
// Loop through the objects inventory and return a string value of entire
// inventory
string dmwand_Inventory(object oEntity);
//Item Info by Robert Bernavich, Jhenne, Archaego, and Dopple
string dmwand_ItemInfo(object oItem, int nLongForm = 0);
//Join player's party
void dmwand_JoinParty();
//Jump player by Jhenne
void dmwand_JumpPlayerHere();
//Jump to player by Jhenne
void dmwand_JumpToPlayer();
//Kick PC by Dopple and Jhenne
// Kick out the target PC
void dmwand_KickPC();
//Kill the target, forcing it to leave a corpse behind
// taken from Bioware's KillAndReplace() in the World Builder Guide
void dmwand_KillAndReplace();
//Leave target's party
void dmwand_LeaveParty();
//Map area by Dopple
// Give the target a full map of the area
void dmwand_MapArea();
//Mod One Rep by Jhenne and Dopple
// Modify the reputations of target creature and player towards each other
void dmwand_ModOneRep(string sPlayer);
//Mod Rep by Jhenne and Dopple
// Modify the reputations of target creature and all players towards each
// other
void dmwand_ModRep(string sAmt);
//Player list conversation by Dopple
// Used to return to starting dialog after selecting a player
void dmwand_PlayerListConv(string sParams);
//Race by Robert Bernavich, Jhenne, Archaego
// Returns string version of objects race
string dmwand_Race(object oEntity);
//Reload Module by Dopple
// reload the current running module
void dmwand_ReloadModule();
//Resume default by Jhenne
// make target resume waypoints if creature, stop everything if player
void dmwand_ResumeDefault();
//Shift Alignment by Jhenne and Dopple
// Shift the alignment of object
// - sAlign: law__/chaos/good_/evil
// - nShift: amount to shift by
void dmwand_ShiftAlignment(string sAlign, int nShift);
//ShowAllAttribs by Robert Bernavich, Jhenne, Archaego
// Return formatted report of player's character information
void dmwand_ShowAllAttribs();
//ShowBasicAttribs by Robert Bernavich, Jhenne, Archaego
// Return formatted report of player's basic character information
void dmwand_ShowBasicAttribs();
//ShowInventory by RRobert Bernavich, Jhenne, Archaego
// Return formatted report of player's inventory
void dmwand_ShowInventory();
//Skill Roll Funtion by Jhenne, modified by Dopple
// - nSkill: SKILL_*
// - nSecret: TRUE if roll should not be shown to other players
void dmwand_SkillCheck(int nSkill, int nSecret = TRUE);
//Swap Day/Night by Dopple
// - nDay: 1 to make it day, 0 to make it night
void dmwand_SwapDayNight(int nDay);
//Take all by Jhenne and Dopple
// Take all items from target
void dmwand_TakeAll();
//Take all equipped by Jhenne and Dopple
// Take all equipped items off of target
void dmwand_TakeAllEquipped();
//Take all unequipped by Jhenne and Dopple
// take all unequipped items from target
void dmwand_TakeAllUnequipped();
//Take Item by Jhenne and Dopple
// take dialog-selected item from target, and return to inventory list dialog
void dmwand_TakeItem();
//Item Stripper by Jhenne - remove item from target
// - oEquip: object to remove
void dmwand_takeoneitem(object oEquip);
//Toad..err..penguin the player by Dopple
// I would rather a chicken, but it seems that's not a valid polymorph type :(
void dmwand_Toad();
//TurnNearOff by Dopple, adapted from Bioware's on/off script
// Turn a placeable near the target location off
void dmwand_TurnNearOff();
//TurnNearOn by Dopple, adapted from Bioware's on/off script
// Turn a placeable near the target location on
void dmwand_TurnNearOn();
//TurnOff by Dopple, adapted from Bioware's on/off script
// Turn a placeable off
void dmwand_TurnOff(object oMyPlaceable);
//TurnOn by Dopple, adapted from Bioware's on/off script
// Turn a placeable on
void dmwand_TurnOn(object oMyPlaceable);
//TurnTargetOff by Dopple, adapted from Bioware's on/off script
// Turn target off
void dmwand_TurnTargetOff();
//TurnTargetOn by Dopple, adapted from Bioware's on/off script
// Turn target on
void dmwand_TurnTargetOn();
//UnToad..err..penguin the player by Dopple
// reverse effects of Toad
void dmwand_Untoad();

//Do Dialog Choice by Dopple
//Dialog function in dmw_dodialog_inc, performs a function or starts
// another dialog function when a dialog choice is selected
void dmwand_DoDialogChoice(int nChoice);

//Start Conversation by Dopple
// Function to start the ball rolling, in dmw_start_inc
void dmwand_StartConversation();
