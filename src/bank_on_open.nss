//::///////////////////////////////////////////////
//:: bank_on_open.nss
//:: Bank Vault on Open file
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
      Fixed problem where item were being listed as unidentified even though
      they were list as ID when placed into Bank Vault.
  1.4 Added a Storage Limit variable to limit items per PC that can be stored
      into Bank Chest.  Currently set to 20.  Change the iStorageLimit variable
      in the bank_inc.nss file to increase/decrease.
*/
//:://////////////////////////////////////////////
//:: Created By: Clayten Gillis (a.k.a. DragonsWake)
//:: Created On: December 17, 2002
//:://////////////////////////////////////////////

#include "per_bank_inc"

void main()
{
   // check database connection
    if (!CheckODBC())
    {
        FloatingTextStringOnCreature("Database Error. No connection. Do not use the chest now.",GetLastOpenedBy());
//        DelayCommand(1.0,ActionCloseDoor(OBJECT_SELF));
        return;
    }

    object oPC = GetLastOpenedBy();

    if (!GetIsPC(oPC))
        return;
    if (GetLocked(OBJECT_SELF))
        return;

    SetLocalObject(OBJECT_SELF, "ChestInUseBy", oPC);
    SetLocked(OBJECT_SELF, TRUE);

    SendMessageToPC(oPC, "The chest has been locked so its contents can be viewed only by you.  To close the chest, walk away from it.");

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
                I = DecodeContainer(oPC, OBJECT_SELF, sBPRef, I);
            else
            {
                if ( sBPRef == "STACK")
                    I = DecodeStackItem(oPC, OBJECT_SELF, I, sBPRef);
                else
                    oCurInvObj = DecodeItem(oPC, OBJECT_SELF, I, sBPRef);
            }
        }
        else
        {
            DecodeGold(oPC, OBJECT_SELF, I, sBPRef);
            DPV(oPC, sBankGold );
        }

        DPV(oPC, sBankBP + IntToString(I) );

    }
}
