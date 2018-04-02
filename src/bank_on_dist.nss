//::///////////////////////////////////////////////
//:: bank_on_dist.nss
//:: Bank Vault on Disturb Inventory file
//:: Version 1.4
//:://////////////////////////////////////////////
/*
  1.0 Orginal Version
  1.1 Fixed problem with multiple opens where items from
      First opener where assign to Second, third, etc PC.
      OnDisturb checks to see if PC Adding/Removing items
      is the orginal Opener.  Returns items if not.
  1.2 Made workaround for Blank Template Problem.  OnDistrub returns
      any items or Containers that have or contain a blank Template
      returned by GetResRef() function back to original PC.
      Made workaround for Multiple PC problem.  Any PC opening Chest
      other then original PC will be teleported to the closest waypoint
      (WP_BankLobby) and told to wait their turn. :)
  1.3 Fixed Blank Template Bug.  Items that are split or bought from
      Merchants can now be placed into the Bank Vault.
      Fixed problem where items were being listed as unidentified even though
      they were list as ID when placed into Bank Vault.
  1.4 Added a Storage Limit variable to limit items per PC that can be stored
      into Bank Chest.  Currently set to 20.  Change the iStorageLimit variable
      in the bank_inc.nss file to increase/decrease.
*/
//:://////////////////////////////////////////////
//:: Created By: Clayten Gillis (a.k.a DragonsWake)
//:: Created On: December 21, 2002
//:://////////////////////////////////////////////

#include "per_bank_inc"

void main()
{
    object oPC = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    object sUsingPC = GetLocalObject(OBJECT_SELF, "ChestInUseBy");
    int iCount = 0;

    object oCurInvObj = GetFirstItemInInventory(OBJECT_SELF);
    while ( GetIsObjectValid(oCurInvObj) == TRUE || GetResRef(oCurInvObj) == "nw_it_gold001")   //Begin Processing Item in Inventory
    {
        iCount = iCount + 1;
        oCurInvObj = GetNextItemInInventory(OBJECT_SELF);
    }

    if (GetHasInventory(oItem) && (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED))
        FloatingTextStringOnCreature("Putting containers in your chest is dangerous.", oPC, FALSE);
    else if (iCount > iStorageLimit)
        FloatingTextStringOnCreature("You have exceeded your storage limit.  Remove some items or you will lose them!", oPC, FALSE);
    else
        FloatingTextStringOnCreature("Storage space used: " + IntToString(iCount) + " of " + IntToString(iStorageLimit), oPC, FALSE);
}
