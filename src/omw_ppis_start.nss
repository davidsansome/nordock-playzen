/*
Persistent Player Item Storage - using Bioware campaign database
by OldManWhistler

This is a very simple script to allow players to efficiently store items using the Bioware campaign
database. It is easily extendable via the user defined functions.

If you are running a large scale PW then use NWNX2 instead because the Bioware campaign database does
not scale well at all.

How it works:
- There is a visible chest placeable.
- When the chest placeable is used, it really opens an unique invisible object inventory for that
player that is only accessible through the main object. This prevents other players from stealing.
- Items are transfered over to a creature on database reads/writes to minimize DB size and DB access
time.

Zip includes example module and erf.


FEATURES
- 2 scripts, 2 placeables, 1 creature.
- Stores items and gold. Handles stackable items properly. Can store an unlimited amount of gold (in
50000 gp stacks).
- Does not store containers (prevents container exploit for storing a lot of items).
- Keeps a running total of the items added/removed.
- Has a userdefined function for preventing access to player storage. Default is to always allow
access.
- Has a userdefined function for limiting the number of items that can be stored. Default is 20 items.
- Items are not written to Bioware database until after the player has move 5m away from the inventory
creature. This cache significantly reduces the number of database accesses.
- Database access only happens the first time the player opens their chest at a new location and,
whenever the player walks away from the chest after having used it.
- Unlimited number of players can access the chest at the same time, with each one using their "unique"
storage location. The only physical limit is how close you have to be to the storage location to open
it.
- There can be multiple locations for accessing the storage vault.
- Only uses one database record per character.
- Never deletes database records (no need for packing). This keeps the items database as small as
possible. (It will only have as many records as you have players).


INSTALLATION

#1: Import the ERF.

#2: Place the "Player Storage Locker" placeable in Containers & Switches where you want a player to
have an access point to their storage vault. You can have multiple access points.

#3: Er, that's it.


CUSTOMIZATION

The PPISUserDefinedAllowAccess function in "omw_ppis_start" can be modified to prevent access unless

the player meets specific conditions. Some ideas:
- limit based on player level
- limit based on player class
- limit based on faction
- limit based on having paid a one time fee
- limit based on paying a fee to access the vault

The PPISUserDefinedInventoryLimit function in "omw_ppis_disturb" can be modified to prevent storing

items unless the player meets specific conditions. Some ideas:
- limit based on number of items
- limit based on item type (no gold, no armor, etc)
- limit based on specific item tags
- set up different amounts of storage space for different fees


ANALYSIS: STORING ON CREATURE VS STORING INDIVIDUAL OBJECTS

I actually implemented this storage system two ways. Method A uses a creature to store the objects and
method B individually stores the objects in the database one by one. Profiling was run using the NWNX2
profile and SOU 1.31.

Method A - creature
- Limited to the number of items as can be stored on a single creature (around 100-175 depending on

size of items to be stored).
- Can store 360 grid squares worth of items. Actual limit depends entirely on how items are copied
over, and how well the space is used.
- There is a real NWN limit of 6 10x6 grid squares worth of items that can be stored on a creature
(since it doesn't attempt to use the equippable slots).
- 100 items had DB size of 64kb, storage time of 0.428 sec, retrieval time of 0.092 sec.
- 360 items had DB size of 198kb, storage time of 3.607 sec, retrieval time of 2.397 sec.

Method B - items
- Database is limited to 9999 items (because of unique identifiers).
- Can store 875 grid squares worth of items. Actual limit depends entirely on how items are copied

over, and how well the space is used.
- There is a real NWN limit of 25 7x5 grid spaces worth of items that can be stored on a placeable.
- 100 items had DB size of 128kb, storage time of 26.368 sec, retrieval time of 0.084 sec.
- 360 items had DB size of 448kb, time unknown (storage crashed the server at 86.763 sec).

So the clear winner is using the creature to store the items, because you save on DB size, have faster
storage times, but *might* lose a little on retrieval time.


CREDITS

I got the idea for doing this from reading a thread by Prophecy Eye on the bioware scripting forum. I'd
been thinking of adding persistent storage to the HABD death system for dropped items. Seeing how
poorly the Bioware campaign database functions handle storing large chunks of data convinced me against
it :)

*/

// ****************************************************************************
// ** CONFIGURATION (modify)
// ****************************************************************************

// Use this function to create conditions to prevent a PC from accessing a
// storage location. ie: don't let level 1 players have storage, make sure they have
// purchased a specific item first, etc.
// Return TRUE if the player should be given access.
// Return FALSE if the player should not be given access.
int PPISUserDefinedAllowAccess(object oPC)
{
    // You could set something up where the player has to buy the storage space,
    // or have to pay a fee every time they access the storage vault, etc.
    return(TRUE);
}

// This is the name of the campaign database where the player items will be
// stored.
const string PPIS_DB_NAME = "ppis";
// This string will be preappended to the tag for each record. Try to keep
// the size of this string very small. You should only set a value if you are
// using the same database to store other records.
const string PPIS_DB_UNIQUE = "";

// This is how often the individual storage chests will check the distance between
// themselves and the player. The inventory is cached until the player is far
// enough away from the storage object that we know they won't want to use it again.
const float PPIS_STORAGE_HEARTBEAT = 6.0;

// ****************************************************************************
// ** CONSTANTS (do not modify)
// ****************************************************************************

// How should the items be stored in the database?
// 0 - store the items on a creature and have one creature per player.
// 1 - store the items as individual records.
const int PPIS_STORAGE_TYPE = 0;

// Used with the PPIS_STORAGE_TYPE constant.
const int PPIS_STORAGE_TYPE_CREATURE = 0;
const int PPIS_STORAGE_TYPE_ITEMS = 1;

// Used during development.
const int PPIS_STATE_UNKNOWN = 0;
const int PPIS_STATE_RETRIEVED = 1;
const int PPIS_STATE_STORED = 2;

// Used for keeping track of the state and prevent TMIs.
const string PPIS_STATE = "PPISState";
// Used for storing the storage chest object on the player.
const string PPIS_CHEST = "PPISChest";
// Used for keeping track of the number of items stored. This needs to match the
// constant in omw_ppis_disturb.
const string PPIS_COUNT = "PPISCount";
// Used for keeping track if the chest heartbeat is already running.
const string PPIS_HB_MUTEX = "PPISMutex";
// Used for keeping track of the access point.
const string PPIS_ACCESS_POINT = "PPISAxs";

// ResRef for the storage locker object to create.
const string PPIS_OBJECT_CREATURE = "ppis_individual";
const string PPIS_OBJECT_LOCKER = "ppis_invis_store";

// ****************************************************************************
// ** FUNCTION DECLARATIONS
// ****************************************************************************

// Converts an integer to a string with up to four characters of 0 padding.
//  iNum - the number to convert.
string PPISIntToString(int iNum);

// This function runs on the storage creature every PPIS_STORAGE_HEARTBEAT seconds.
// If oPC is more than 5m away from oChest it will store OBJECT_SELF's inventory in the database.
//  oPC - the player who is accessing their storage.
//  oChest - the placeable they are using as an access point to their storage.
void PPISStorageHeartbeat(object oPC, object chest);

// Retrieve the entire stored inventory as one object and move it to oStorage.
//  oStorage - the placeable to copy the inventory to.
// Returns TRUE if there was a stored inventory to retrieve.
// Returns FALSE if there was not a stored inventory.
int PPISRetrieve(object oPC, object oStorage);

// Store oStorage's inventory as a single object.
//  oStorage - the placeable to copy the inventory from.
// Returns TRUE if inventory was stored.
// Returns FALSE if the inventory was not stored.
int PPISStore(object oStorage);

// Make the player wait until their inventory has been fully retrieved before
// trying to open it.
//  oStorage - the placeable storing their items.
//  iTry - the number of times this function has been run.
void PPISWaitUntilRetrieved(object oStorage, int iTry);

// ****************************************************************************
// ** FUNCTION DEFINITIONS
// ****************************************************************************

// The MigrateChest function is used to copy over items from
// Nordock's old chest system the first time the new chest is used
#include "per_bank_inc"
void MigrateChest(object oPC, object oContainer)
{
    int iBankCount = GPI(oPC, "BankCount");
    if (iBankCount == 0)
        return;

    int I=1;
    for ( ; I<=iBankCount ; I++)
    {
        string sBPRef = GPStr(oPC, sBankBP + IntToString(I) );

        if ( sBPRef != "nw_it_gold001" )
        {
            if (sBPRef == "CONTAIN")
                I = DecodeContainer(oPC, oContainer, sBPRef, I);
            else
            {
                if ( sBPRef == "STACK")
                    I = DecodeStackItem(oPC, oContainer, I, sBPRef);
                else
                    oCurInvObj = DecodeItem(oPC, oContainer, I, sBPRef);
            }
        }
        else
        {
            DecodeGold(oPC, OBJECT_SELF, I, sBPRef);
            DPV(oPC, sBankGold );
        }

        DPV(oPC, sBankBP + IntToString(I) );

    }
    SetLocalInt(oContainer, PPIS_COUNT, iBankCount);
}


string PPISIntToString(int iNum)
{
    if (iNum < 10) return ("000"+IntToString(iNum));
    if (iNum < 100) return ("00"+IntToString(iNum));
    if (iNum < 1000) return ("0"+IntToString(iNum));
    return (IntToString(iNum));
}

// ****************************************************************************

void PPISStorageHeartbeat(object oPC, object oChest)
{
    // Check if the player is still close to the chest.
    float fDist = GetDistanceBetween(oChest, oPC);
    if ((fDist > 0.0) && (fDist < 3.0))
    {
        // Player is still nearby, so do not write to the database yet.
        DelayCommand(PPIS_STORAGE_HEARTBEAT, PPISStorageHeartbeat(oPC, oChest));
        return;
    }
    object oStorage = OBJECT_SELF;
    // Store your inventory.
    DeleteLocalInt(oStorage, PPIS_HB_MUTEX); // Release the mutex.
    if(PPISStore(oStorage))
        SendMessageToPC(oPC, "The contents of you chest has been saved.");
    else
        SendMessageToAllDMs("PPIS Error: unable to store "+GetName(oPC)+"'s items to the database in area:"+GetName(GetArea(OBJECT_SELF)));

    return;
}

// ****************************************************************************

int PPISRetrieve(object oPC, object oStorage)
{
    string sID = GetTag(oStorage);
    if (PPIS_STORAGE_TYPE == PPIS_STORAGE_TYPE_CREATURE)
    {
        // Items are stored as a single object in the database.
        // Get the storage creature from the database, create it behind the current object.
        location lLoc = Location(GetArea(OBJECT_SELF), GetPosition(OBJECT_SELF) - 1.0*AngleToVector(GetFacing(OBJECT_SELF)), GetFacing(OBJECT_SELF));
        object oCreature = RetrieveCampaignObject(PPIS_DB_NAME, sID, lLoc);
        if (GetIsObjectValid(oCreature))
        {
            // Prevent anyone from being able to see the storage creature.
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oCreature);
            // Copy the gold over, have to handle it separately since there isn't a gold item on the creature.
            int iGold = GetGold(oCreature);
            int i = 0;
            while (iGold > 50000) // Break gold into 50k chunks to avoid max stack size errors.
            {
                CreateItemOnObject("NW_IT_GOLD001", oStorage, 50000);
                i++;
                iGold = iGold - 50000;
            }
            if (iGold > 0) // Give out the remainder of the gold.
            {
                CreateItemOnObject("NW_IT_GOLD001", oStorage, iGold);
                i++;
            }
            object oItem = GetFirstItemInInventory(oCreature);
            while(GetIsObjectValid(oItem))
            {
                // Use CopyItem instead of ActionGiveItem to reduce TMIs.
                CopyItem(oItem, oStorage);
                i++;
                oItem = GetNextItemInInventory(oCreature);
            }
            SetLocalInt(oStorage, PPIS_STATE, PPIS_STATE_RETRIEVED);
            DestroyObject(oCreature, 0.3);
            SetLocalInt(oStorage, PPIS_COUNT, i);
            return (TRUE);
        }
        // Creature did not exist in database. Try to copy over items from old chest system
        MigrateChest(oPC, oStorage);
        SetLocalInt(oStorage, PPIS_STATE, PPIS_STATE_RETRIEVED);
        return (FALSE);
    }
    if (PPIS_STORAGE_TYPE == PPIS_STORAGE_TYPE_ITEMS)
    {
        // Items are stored individually in the database.
        location lLoc = GetLocation(oStorage);
        int i = 0;
        int iMax = GetCampaignInt(PPIS_DB_NAME, sID+"0000");
        for (i=1; i<=iMax; i++)
        {
            RetrieveCampaignObject(PPIS_DB_NAME, sID+PPISIntToString(i), lLoc, oStorage);
        }
        SetLocalInt(oStorage, PPIS_STATE, PPIS_STATE_RETRIEVED);
        SetLocalInt(oStorage, PPIS_COUNT, iMax);
        return (TRUE);
    }
    return (FALSE);
}

// ****************************************************************************

int PPISStore(object oStorage)
{
    string sID = GetTag(oStorage);
    if (PPIS_STORAGE_TYPE == PPIS_STORAGE_TYPE_CREATURE)
    {
        // Items are stored as a single object in the database.
        // Create the storage creature and move the items to it, create it behind the current object.
        location lLoc = Location(GetArea(OBJECT_SELF), GetPosition(OBJECT_SELF) - 1.0*AngleToVector(GetFacing(OBJECT_SELF)), GetFacing(OBJECT_SELF));
        object oCreature = CreateObject(OBJECT_TYPE_CREATURE, PPIS_OBJECT_CREATURE, lLoc, FALSE, sID);
        if (GetIsObjectValid(oCreature))
        {
            // Prevent anyone from being able to see the storage creature.
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oCreature);
            object oCopy;
            object oItem = GetFirstItemInInventory(oStorage);
            int i = 0;
            while(GetIsObjectValid(oItem))
            {
                // Don't have to handle gold separately since it will be copied over.
                if (!GetHasInventory(oItem))
                {
                    oCopy = CopyItem(oItem, oCreature);
                    i++;
                }
                else
                    DestroyObject(oItem);
                oItem = GetNextItemInInventory(oStorage);
            }
            // Store the creature.
            int iRet = StoreCampaignObject(PPIS_DB_NAME, sID, oCreature);
            SetLocalInt(oStorage, PPIS_STATE, PPIS_STATE_STORED);
            SetLocalInt(oStorage, PPIS_COUNT, i);
            DestroyObject(oCreature, 0.3);
            return (iRet);
        }
        // Creature did not exist in database. Nothing to do.
        return (FALSE);
    }
    if (PPIS_STORAGE_TYPE == PPIS_STORAGE_TYPE_ITEMS)
    {
        // Items are stored individually in the database.
        int i = 0;
        object oItem = GetFirstItemInInventory(oStorage);
        while(GetIsObjectValid(oItem))
        {
            i++;
            if(!StoreCampaignObject(PPIS_DB_NAME, sID+PPISIntToString(i), oItem))
            {
                // Was not able to store oItem! This is bad.
                SetCampaignInt(PPIS_DB_NAME, sID+"0000", i);
                return(FALSE);
            }
            oItem = GetNextItemInInventory(oStorage);
        }
        // Store the number of items.
        SetCampaignInt(PPIS_DB_NAME, sID+"0000", i);
        SetLocalInt(oStorage, PPIS_STATE, PPIS_STATE_STORED);
        SetLocalInt(oStorage, PPIS_COUNT, i);
        return (TRUE);
    }
    return (FALSE);
}

// ****************************************************************************

void PPISWaitUntilRetrieved(object oStorage, int iTry)
{
    // This function fills up the action queue of the player until the stored
    // items have been retrieved. This should happen near instantly in most
    // cases.
    if (GetLocalInt(oStorage, PPIS_STATE) == PPIS_STATE_UNKNOWN)
    {
        if (iTry < 60)
        {
            AssignCommand(OBJECT_SELF, ActionWait(1.5));
            SendMessageToPC(OBJECT_SELF, "Retrieving stored inventory.");
            AssignCommand(OBJECT_SELF, PPISWaitUntilRetrieved(oStorage, iTry+1));
        } else {
            SpeakString("PPIS ERROR: Unable to load inventory! Too much lag.", TALKVOLUME_SHOUT);
        }
    } else {
        // Inform the PC of how much stuff they have stored.
        //SendMessageToPC(OBJECT_SELF, "You have "+IntToString(GetLocalInt(oStorage, PPIS_COUNT))+" items stored.");
        AssignCommand(OBJECT_SELF, ActionInteractObject(oStorage));
    }
}

// ****************************************************************************
// ** MAIN
// ****************************************************************************

void main()
{
    object oPC = GetLastUsedBy();
    // Check if the player is allowed to have storage.
    if (PPISUserDefinedAllowAccess(oPC) != 1) return;

    // See if the player already has an opened storage location.
    object oStorage = GetLocalObject(oPC, PPIS_CHEST);
    if (GetIsObjectValid(oStorage))
    {
        // If unique storage placeable was accessed from somewhere else, destroy
        // it and open it from the DB. This is the only way to do this because
        // we cannot move placeables dynamically.
        if (GetLocalObject(oPC, PPIS_ACCESS_POINT) != OBJECT_SELF)
        {
            DestroyObject(oStorage);
            oStorage = OBJECT_INVALID;
            // oStorage is now invalid, so it will be recreated.
        }
    }
    if (!GetIsObjectValid(oStorage))
    {
        // Player does not have an ID so create one.
        // Database keys are limited to 32 characters. So do some magic to try
        // to prevent overlaps.
        int iLength = (32 - GetStringLength(PPIS_DB_UNIQUE)) / 2;
        if (PPIS_STORAGE_TYPE == PPIS_STORAGE_TYPE_ITEMS) iLength = iLength - 2; // Need to reserve 4 characters for the number of items.
        string sID = PPIS_DB_UNIQUE + GetStringLeft(GetPCPlayerName(oPC), iLength) + GetStringRight(GetName(oPC), iLength);
        // This is the first time, create the storage object.
        // Create the storage object underground so that it cannot accidently be clicked on by malicious players. (thanks Talmud)
        vector vChest = GetPosition(OBJECT_SELF);
        location lStorage = Location(GetArea(OBJECT_SELF), Vector(vChest.x, vChest.y, vChest.z - 10.0) , GetFacing(OBJECT_SELF));
        oStorage = CreateObject(OBJECT_TYPE_PLACEABLE, PPIS_OBJECT_LOCKER, lStorage, FALSE, sID);
        SetLocalObject(oPC, PPIS_CHEST, oStorage);
        SetLocalObject(oPC, PPIS_ACCESS_POINT, OBJECT_SELF);
        // Try to retrieve the inventory from the database.
        PPISRetrieve(oPC, oStorage);
    }
    // Set up a heartbeat to check the distance between the player and the storage object.
    if (GetLocalInt(oStorage, PPIS_HB_MUTEX) == 0) // Mutex prevents setting up multiple HBs.
    {
        object oChest = OBJECT_SELF;
        AssignCommand(oStorage, DelayCommand(PPIS_STORAGE_HEARTBEAT, PPISStorageHeartbeat(oPC, oChest)));
        SetLocalInt(oStorage, PPIS_HB_MUTEX, 1);
    }

    // Now make the player open the inventory of the storage invisible object.
    AssignCommand(oPC, PPISWaitUntilRetrieved(oStorage, 1));
}
