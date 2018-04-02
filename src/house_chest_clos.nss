//::///////////////////////////////////////////////
//:: bank_on_close.nss
//:: Bank Vault on Close file
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
//:: Created By: Clayten Gillis (a.k.a DragonsWake)
//:: Created On: December 17, 2002
//:://////////////////////////////////////////////
#include "per_bank_inc"

void main()
{
    int iNumInv = 0;
    int iConCount = 0;
    int I = 0;
    float fTime = 0.0;
    string sBPName;
    object oPC = GetLastClosedBy();
    string PCKey = GetName(oPC);
    string UsingPC = GPStr(OBJECT_SELF, "PCUsingChest");
    string sBPRef;
    int iStackAmt = 0;

   // check database connection
    if (!CheckODBC())
    {
        FloatingTextStringOnCreature("No connection to database. Take your stuff back or you WILL lose it",GetLastOpenedBy());
//        DelayCommand(1.0,ActionCloseDoor(OBJECT_SELF));
        return;
    }


    if ( TestStringAgainstPattern(UsingPC, PCKey) == FALSE )
    {
        return;
    }
    //Debug
    if (Debug)
    {
        SendMessageToPC(oPC, "On CLOSE ROUTINE");
    }

    oCurInvObj = GetFirstItemInInventory(OBJECT_SELF);

    while ( GetIsObjectValid(oCurInvObj) == TRUE || GetResRef(oCurInvObj) == "nw_it_gold001")   //Begin Processing Item in Inventory
    {

        iNumInv = iNumInv + 1;

        sBPName = GetResRef(oCurInvObj);
        if ( sBPName == "" )
        {
            sBPName = GetStringLowerCase(GetTag(oCurInvObj));
        }

        if ( sBPName == "nw_it_gold001")
        {
            EncodeGold(oPC, oCurInvObj, iNumInv, sBPName);

        }
        else
        {
            //Debug
            if (Debug)
            {
                SendMessageToPC(oPC, "----------");
                SendMessageToPC(oPC, "StackNum: "+IntToString(GetNumStackedItems(oCurInvObj)));
                SendMessageToPC(oPC, "----------");
            }

            if (GetHasInventory(oCurInvObj) == TRUE )
            {
                iConCount = EncodeContainer(oPC, oCurInvObj, iNumInv, sBPName);

                //Debug
                if (Debug)
                {
                   SendMessageToPC(oPC, "iNumInv: "+IntToString(iNumInv));
                    SendMessageToPC(oPC, "iConCount: "+IntToString(iConCount));
                }

                while ( iNumInv < (iConCount - iHeaderCount) )
                {
                    //Debug
                    if (Debug)
                    {
                        SendMessageToPC(oPC, "iNumInv: "+IntToString(iNumInv));
                    }

                    oCurInvObj = GetNextItemInInventory(OBJECT_SELF);
                    iNumInv = iNumInv + 1;
                }
                iNumInv = iConCount;
            }
            else
            {
                if (GetNumStackedItems(oCurInvObj) > 1)
                {
                    iNumInv = EncodeStackItem( oPC, oCurInvObj, iNumInv);
                }
                else
                {
                    EncodeItem(oPC, oCurInvObj, iNumInv, sBPName);
                }
            }
        }


        oCurInvObj = GetNextItemInInventory(OBJECT_SELF);


    }

    //Debug
    if (Debug)
    {
        SendMessageToPC(oPC, "BankCount: "+IntToString(iNumInv) );
    }

    SPI(oPC, "BankCount", iNumInv);

    // Clean UP Items in Bank Chest

    oCurInvObj = GetFirstItemInInventory(OBJECT_SELF);

    while ( GetIsObjectValid(oCurInvObj) == TRUE )   //Begin Processing Item in Inventory
    {
        DestroyObject(oCurInvObj, fTime);

        //Debug
        if (Debug)
        {
            SendMessageToPC(oPC, "Item Destroyed" );
        }

        oCurInvObj = GetNextItemInInventory(OBJECT_SELF);
    }

    SPI(OBJECT_SELF, "ChestNotOpen", 1);
//    SetLocked(OBJECT_SELF,TRUE);

    //iBankChestNotOpen = 1;
    //sPCUsingChest = "";

}
