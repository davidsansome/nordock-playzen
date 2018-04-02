int StartingConditional() { return FALSE; }
//Remove this line if the scripts are included in a Starting Conditional Script.

 // * ----------------------
// * CONSTANTS and SWITCHES
// * ----------------------
int SYR_DEFAULT = 6; int SYR_RICH = 25; int SYR_POOR = 2; int SYR_HIGH = 10; int SYR_LOW = 2;
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//
//      SWITCHES TO CUSTOMIZE THE TREASURE GENERATION SYSTEM
//
//
//
// TURNING THE TREASURE GENERATION SYSTEM ON AND OFF:
// * Setting Syrsuro = TRUE activates this system.
// * If Syrsuro is set to FALSE, the default BioWare Treasure Generation System in enabled.
// * Note:  Using this system also requires altering the nw_c2_default9 script (the default OnSpawn
// * script for NPCs. Two versions of this script are shipped with this package.
// * nw_c2_default9old is the origial unaltered BioWare version of this file.
// *    To use the default BioWare treasure tables you must save this file as nw_c2_default9.
// * sy_c2_default9 is my version of this file (the only change is to include my treasure generation script
// * instead of the BioWare include script (nw_o2_coninclude).
// *    To use this system by default you must save this file (sy_c2_default9) as nw_c2_default9.
// *    Alternately, you can use this system on selected NPCs by using the sy_c2_default9 script as their
// *     on spawn script.
int Syrsuro = TRUE;
//
// * CREATE NPC CONTAINERS?
// * Setting CreateNPCBag = TRUE will cause NPCs to create a container when they are spawned and
// * transfer items they cannot use into the container.  Multiple creatures spawning in the same area
// * will share a single container.  Using this setting allows random encounters to create their own containers.
// * Setting CreateNPCBag = FALSE (default) will result in no container being created although a container placed in
// * the vicinity of the NPC will be used.  This setting gives the maximum control over where the containers are
// * placed.  If no container is placed, the creatures will keep all items in inventory.
int CreateNPCBag = FALSE;
//
// HEALING KITS/ MEDICINE BAGS?
// * Setting BWHeal = TRUE results in the BioWare Healing Kits dropping.
// * Setting BWHeal = FALSE (default) results in Medicine Bags dropping instead.
int BWHeal = FALSE;
//
// HIGH LEVEL POTIONS?
// * Setting HighLevelPotions = FALSE (default) disables the potions which duplicate high level
// * spells (including <Heal>. If you wish to enable these potions (which are not found in the DMG)
// * set HighLevelPotions = TRUE.
int HighLevelPotions = FALSE;
//
// BioWare LockPicks?
// * Setting BWLockPick = TRUE results in the BioWare LockPicks dropping.
// * Setting BWLockPick = FALSE (default) results in the BioWare LockPicks being disabled,
int BWLockPick = FALSE;
//
// HCR LockPicks drop on Treasure?
// Setting HCRPickDrop = TRUE will result in a chance for the HCR LockPicks dropping off of random creatures.
// Setting HCRPickDrop = FALSE (default) will result in the HCR picks not randomly dropping.
int HCRPickDrop = FALSE;
//
//  SETTING THE LEVELS OF MONETARY REWARDS:
// * The CashLevel variable is used by the gold and gem generation functions.
// * The Default setting (= 6) results in a relatively low level compared to the (IMHO)
// * greatly inflated 3rd edition levels.
// * The High setting (= 25) results in around 1/4th of the treasure in the 3rd edition (consistant with
// * the current HCR setting.
// * The Low setting (=2) results in a cash poor world.
int CashLevel = SYR_DEFAULT;  //Options: SYR_DEFAULT / SYR_RICH / SYR_POOR //
//
// SETTING THE MAGIC LEVEL:
// * The MagicLevel variable is used by the magic item generation tables.
// * The Default setting is consistent with the 3rd edition tables.
// * The High Magic setting will result in more and higher 'level' magic items.
// * The Low Magic setting will result in fewer magic items and they will be of lower level.
int MagicLevel = SYR_DEFAULT; //OPTIONS:  SYR_DEFAULT / SYR_HIGH / SYR_LOW //
//
//
