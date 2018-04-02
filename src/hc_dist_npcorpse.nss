////////////////////////////////////////////////////////////////////////////////
//                                                  //                        //
//  _kb_ondist_loot                                 //      VERSION 1.1       //
//                                                  //                        //
//  by Keron Blackfeld on 07/17/2002                ////////////////////////////
//                                                                            //
//  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
//  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  This is an OnDisturbed Script to go with my _kb_loot_corpse script for    //
//  LOOTABLE MONSTER/NPC CORPSES. If you were using my _kb_ohb_lootable, be   //
//  sure to remove that script from the onHeartbeat of your lootable, the     //
//  "invis_corpse_obj" placeable.                                             //
//                                                                            //
//  PLACE THIS SCRIPT IN THE ONDISTURBED EVENT OF YOUR "invis_corpse_obj"     //
//  BLUEPRINT. This script checks the inventory of OBJECT_SELF, and when it   //
//  is empty, it checks the LocalInt to see if the now empty corpse should    //
//  be Destroyed along with the Lootable Corpse Object. This script will also //
//  checks to see if it should clear its own inventory prior to fading in     //
//  order to prevent a lootbag from appearing. If the inventory is NOT empty, //
//  it checks to see if the ARMOUR is removed from itself, and if so, it      //
//  destroys the Original Armour on the corpse.                               //
//                                                                            //
//  The _kb_loot_corpse script must have this line:                           //
//  int nKeepEmpties = FALSE;                                                 //
//  in order for the Empty Corpse to Destroy itself in this script.           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/*******************************************
 ** This function is used to clear the    **
 ** entire inventory of an object         **
 *******************************************/
void ClearInventory(object oCorpse)
{
    int nAmtGold = GetGold(oCorpse); //Get any gold from the dead creature
    if(nAmtGold) TakeGoldFromCreature(nAmtGold, oCorpse, TRUE);
    //Get any loot the dead creature has equipped - thanks again to the HCR for strip-equiped
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARMS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARROWS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BELT, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOLTS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOOTS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BULLETS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CLOAK, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_NECK, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oCorpse));
    //Get the remaining loot from the dead creature and move it to the lootable object
    object oLootEQ = GetFirstItemInInventory(oCorpse);
    while(GetIsObjectValid(oLootEQ))
    {
        DestroyObject(oLootEQ);
        oLootEQ = GetNextItemInInventory(oCorpse);
    }
}

/*******************************************
 ** This function checks to see if our    **
 ** corpses discarded weapons have been   **
 ** picked up. If so, it returns TRUE.    **
 *******************************************/
int CheckWeapons(object oCorpse)
{
    //Check to see if a Anyone Possesses the Left Weapon
    object oLeftWpn = GetLocalObject(oCorpse, "oLeftWpn");
    object oLeftTest = GetItemPossessor(oLeftWpn);
    //Check to see if a Anyone Possesses the Right Weapon
    object oRightWpn = GetLocalObject(oCorpse, "oRightWpn");
    object oRightTest = GetItemPossessor(oRightWpn);
    if (oLeftWpn == OBJECT_INVALID && oRightWpn == OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        if (oLeftTest != OBJECT_INVALID && oLeftTest != OBJECT_INVALID)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
}

/*******************************************
 ** Here is our main script, which is     **
 ** fired if the Inventory is disturbed.  **
 ** It then checks to see if it needs to  **
 ** either clean up the corpse or Destroy **
 ** the original suit of armour still on  **
 ** the corpse.                           **
 *******************************************/
void main()
{
    //Get all of our required information
    object oInvDisturbed = GetInventoryDisturbItem(); //Get item that was disturbed to trigger event
    int nInvDistType = GetInventoryDisturbType(); //Get type of inventory disturbance
    object oHostCorpse = GetLocalObject(OBJECT_SELF, "oHostBody"); //Get Value set by _kb_loot_corpse at creation
    object oCorpseBlood = GetLocalObject(OBJECT_SELF, "oBloodSpot"); //Get Value set by _kb_loot_corpse at creation
    object oOrigArmour = GetLocalObject(OBJECT_SELF, "oOrigArmour"); //Get Value set by _kb_loot_corpse at creation
    object oLootArmour = GetLocalObject(OBJECT_SELF, "oLootArmour"); //Get Value set by _kb_loot_corpse at creation

    object oPC = GetLastDisturbed();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));

    object oHasInventory = GetFirstItemInInventory(OBJECT_SELF); //Check for inventory
    if (oHasInventory == OBJECT_INVALID && CheckWeapons(oHostCorpse)) //If no inventory found and Weapons have been claimed
    {
        /*******************************************
         ** Inventory is empty. Now we check the  **
         ** nKeepEmpty value.                     **
         *******************************************/
        int nKeepEmpty = GetLocalInt(OBJECT_SELF, "oKeepEmpty"); //Get Value set by _kb_loot_corpse at creation
        if (!nKeepEmpty)
        {
            /*******************************************
             ** nKeepEmpty is FALSE. Delete empty.    **
             *******************************************/
            ClearInventory(oHostCorpse);
            AssignCommand(oHostCorpse,SetIsDestroyable(TRUE,FALSE,FALSE)); //Set actual corpse to destroyable
            DestroyObject(oHostCorpse); //Delete the actual Creature Corpse
            DestroyObject(oCorpseBlood); //Delete the BloodSpot
            DelayCommand(1.0f,DestroyObject(OBJECT_SELF)); //Delete Lootable Object (Self)
        }
     }
     else
     {
         /*******************************************
          ** If not empty, check to see if armour  **
          ** has been removed from corpse.         **
          *******************************************/
          if (oInvDisturbed == oLootArmour && nInvDistType == INVENTORY_DISTURB_TYPE_REMOVED)
          {
              /*******************************************
               ** The Armour is gone - destroy original **
               ** armour still showing on corpse.       **
               *******************************************/
              DestroyObject(oOrigArmour);
          }
     }
}
