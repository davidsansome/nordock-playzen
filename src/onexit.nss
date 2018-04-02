/*
Function for deleting items and encounters from areas on exit. This allows us
to set a time limit, by modifying line 91 you can set how many times you want to
check the area is free of PC's, by modifying the delay on line 90 you change the
frequency of the checks.


Modification of original script By Roobubba.
Eaglec - 15-Aug-04
Robin - 17-Feb-05
*/

void CleanAreaOnExit()
{
//set the area, PC and area_of_the_PC
object oArea = GetArea(OBJECT_SELF);
object oPC = GetFirstPC();
object oPCAREA = GetArea(oPC);
//Need a variable to find out if there is anyone in the area or not
int iArea=0;
//circle through all PCs on the server and find out if their current area is equal to area being exited
while(oPC != OBJECT_INVALID)
    {
    if(oPCAREA==oArea)
        {
        iArea=1;
        }
    oPC=GetNextPC();
    oPCAREA=GetArea(oPC);

    }
//if none of the areas of the PCs on the server is equal to the area being exited
//then clear everything out of the area
if(iArea==0)
    {
//cycle through objects. Find all items in the area and delete them
    object oFindObj = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oFindObj))
        {
// also close all the doors while we are here
        if(GetObjectType(oFindObj) == OBJECT_TYPE_DOOR)
            {
            AssignCommand(oFindObj, ActionCloseDoor(oFindObj));
            }
//Find items and encounter-spawned creatures and destroy them
        if((GetObjectType(oFindObj) == OBJECT_TYPE_ITEM) || (GetIsEncounterCreature(oFindObj)==TRUE))
            {
            DestroyObject(oFindObj);
            }
        if(GetStringLowerCase(GetName(oFindObj)) == "remains")
            {
//get inventory of all lootables and destroy all items
            object oItem = GetFirstItemInInventory(oFindObj);
            while(GetIsObjectValid(oItem))
               {
               DestroyObject(oItem);
               oItem = GetNextItemInInventory(oFindObj);
               }
           AssignCommand(oFindObj,SetIsDestroyable(TRUE));
           DestroyObject(oFindObj);
            }
         // Some areas (Tyln Castle) use a waypoint spawning system
         // As suggested by Roobubba
         if(GetLocalInt(oFindObj, "WaypointSpawnedCreature") == 1)
            DestroyObject(oFindObj);
        oFindObj = GetNextObjectInArea(oArea);
        }
}
}

// check if the area is clear
void CheckAreaOnExit()
{
//set the area, PC and area_of_the_PC
object oArea = GetArea(OBJECT_SELF);
object oPC = GetFirstPC();
object oPCAREA = GetArea(oPC);
//Need a variable to find out if there is anyone in the area or not
int iArea=0;
int iCount=GetLocalInt(oArea,"Count");
//circle through all PCs on the server and find out if their current area is equal to area being exited
while(oPC != OBJECT_INVALID)
    {
    if(oPCAREA==oArea)
        {
        iArea=1;
        }
    oPC=GetNextPC();
    oPCAREA=GetArea(oPC);

    }

// how long between and how many checks
float fDelay = 300.0;
int iCheck=2;

// If we hve done x checks, clean the area
if (iArea==0 && iCount>=iCheck)
   {
   SetLocalInt(oArea,"Count", 0);
   iCount=0;
   CleanAreaOnExit();
   }

// if there have been less that 2 checks, check again in 300 seconds
else if (iArea==0 && iCount<iCheck)
   {
   SetLocalInt(oArea,"Count", iCount+1);
   DelayCommand(fDelay, CheckAreaOnExit());
   }

// if the area is no longer empty, cancel the checks
else if (iArea==1)
   {
   SetLocalInt(oArea,"Count", 0);
   }

}

#include "0_ntfm_inc"

void main()
{
object oPC=GetExitingObject();
if (GetIsPC(oPC))
    {
    StripExcessPotions(oPC);
    CheckAreaOnExit();
    }
}
