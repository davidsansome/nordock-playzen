//::///////////////////////////////////////////////
//:: Name
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/* Fixes a new HoU. Players are able to make
temorary spells
Permanent by leaving a server.
This script will strip any
temporary spells of all items upon entering a
trigger.
Place this code in the OnEnter handler of any
trigger.
Place the trigger near the start
of your module.
You could also add this code to the
OnEnterModule handler.
http://groups.yahoo.com/group
/LandofTerraFirma/
*/
//:://////////////////////////////////////////////
//:: Created By: Narc
//:: Created On: 1/3/2003
//:://////////////////////////////////////////////
//function
void tRemoveTempProperty(object oItem);
void main()
{

    object oPC = GetEnteringObject();
  if (GetIsPC(oPC))
  {  //FloatingTextStringOnCreature("CLEANUP!", oPC);
     object oItem = GetFirstItemInInventory(oPC);
     int iType = 0;
     //gets inventory
     while (GetIsObjectValid(oItem))
     {
       iType = GetObjectType(oItem);
       if (iType == BASE_ITEM_LARGEBOX)
       {
          object oInBox = GetFirstItemInInventory(oItem);
          //gets magic bags
          while (GetIsObjectValid(oInBox))
          {
            tRemoveTempProperty(oInBox);
            oInBox = GetNextItemInInventory(oItem);
          }
       }
       else
       { tRemoveTempProperty(oItem);
       }
       oItem = GetNextItemInInventory(oPC);
     }
     //Gets inventory slots
     int i = 0;
     for (i = 0; i < 14 ; i++)
     { object oGear = GetItemInSlot(i, oPC);
       if (GetIsObjectValid(oGear))
       { tRemoveTempProperty(oGear);
       }
     }
  }
}
void tRemoveTempProperty(object oItem)
{
  itemproperty iProp = GetFirstItemProperty(oItem);
  while (GetIsItemPropertyValid(iProp))
  {
    if (GetItemPropertyDurationType(iProp) == DURATION_TYPE_TEMPORARY)
    {
      WriteTimestampedLogEntry("EXPLOIT: Temp Property - "+GetName(GetItemPossessor(oItem)));
      RemoveItemProperty(oItem, iProp);
    }
    iProp = GetNextItemProperty(oItem);
  }
  //SendMessageToAllDMs("cleaner");
}
