//::///////////////////////////////////////////////
//:: bank_inc.nss
//:: Bank Vault include file
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

#include "rr_persist"


// Variable Declarations

// Print Debug Statements.  Set to '1' to Print Debug statements to PC
int Debug = 0;

// Set BanksModule = 1 for Area Banks. Set BankModule = 0 for single Module Bank. Not implemented
int BankModule = 1;

// Set the Chest to being opened for the first time (Do Not Modify)
int FirstTime = 1;

// Storage Limit for Bank Chest.  This limits how many items per PC that can be stored.
int iStorageLimit = 20;

// Internal Identifiers of storage variables. (Do Not Modify)
string sBankBP = "BankItemBP";
string sBankItemID = "BankItemID";
string sBankGold = "BankGold";
string sBankStack = "BankStkAmt";
int iHeaderCount = 0;
int iStackAmt = 0;
object oCurInvObj;



void EncodeGold (object oPC, object oCurItem, int iItemCount, string sItemName)
{
    iStackAmt = GetNumStackedItems(oCurItem);
    SPI(oPC, sBankGold, iStackAmt);
    SPStr(oPC, sBankBP + IntToString(iItemCount), sItemName);
    // Debug Statements
    if (Debug)
    {
        SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount));
        SendMessageToPC(oPC, "This is Gold. StackSize "+IntToString(iStackAmt));
        SendMessageToPC(oPC, "Valid Object:" + IntToString(GetIsObjectValid(oCurItem)) );
        SendMessageToPC(oPC, "ResRef: "+sItemName);
        SendMessageToPC(oPC, "----------");
    }

    return;
}

void EncodeItem (object oPC, object oCurItem, int iItemCount, string sItemName)
{

    SPStr(oPC, sBankBP + IntToString(iItemCount), sItemName);
    if ( GetIdentified(oCurItem) )
    {
        SPI(oPC, sBankItemID + IntToString(iItemCount), 1);
    }
    //Debug Statements
    if (Debug)
    {
        SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount));
        SendMessageToPC(oPC, "This is an Item.");
        SendMessageToPC(oPC, "Valid Object: " + IntToString(GetIsObjectValid(oCurItem)) );
        SendMessageToPC(oPC, "ResRef: "+sItemName);
        SendMessageToPC(oPC, "Identified?: " + IntToString(GetIdentified(oCurItem)));
        SendMessageToPC(oPC, "----------");
    }

    return;
}

int EncodeStackItem (object oPC, object oCurItem, int iItemCount)
{
    iStackAmt = GetNumStackedItems(oCurItem);

    SPStr(oPC, sBankBP + IntToString(iItemCount), "STACK");
    iItemCount = iItemCount + 1;
    SPI(oPC, sBankStack + IntToString(iItemCount), iStackAmt);


    string sItemName = GetResRef(oCurItem);

    if ( sItemName == "" )
    {
        sItemName = GetStringLowerCase(GetTag(oCurItem));
    }


    SPStr(oPC, sBankBP + IntToString(iItemCount), sItemName);

    if ( GetIdentified(oCurItem) )
    {
        SPI(oPC, sBankItemID + IntToString(iItemCount), 1);
    }

    //Debug Statements
    if (Debug)
    {
        SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount));
        SendMessageToPC(oPC, "Stack Item. StackSize: "+IntToString(iStackAmt));
        SendMessageToPC(oPC, "Valid Object:" + IntToString(GetIsObjectValid(oCurItem)) );
        SendMessageToPC(oPC, "ResRef: "+sItemName);
        SendMessageToPC(oPC, "Identified?: " + IntToString(GetIdentified(oCurItem)));
        SendMessageToPC(oPC, "----------");
    }

    return iItemCount;
}

int EncodeContainer (object oPC, object oCurItem, int iItemCount, string sItemName)
{
    iHeaderCount = 0;

    //Debug
    if (Debug)
    {
        SendMessageToPC(oPC, "Encode Container ROUTINE");
    }

    SPStr(oPC, sBankBP + IntToString(iItemCount), "CONTAIN");
    iHeaderCount = iHeaderCount + 1;

    iItemCount = iItemCount + 1;

    EncodeItem(oPC, oCurItem, iItemCount, sItemName);

    oCurInvObj = GetFirstItemInInventory(oCurItem);

    while ( GetIsObjectValid(oCurInvObj) == TRUE || GetResRef(oCurInvObj) == "nw_it_gold001")   //Begin Processing Item in Inventory
    {

        iItemCount = iItemCount + 1;

        sItemName = GetResRef(oCurInvObj);
        if ( sItemName == "" )
        {
            sItemName = GetStringLowerCase(GetTag(oCurInvObj));
        }

        if ( sItemName == "nw_it_gold001")
        {
            EncodeGold(oPC, oCurInvObj, iItemCount, sItemName);

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
                iItemCount = EncodeContainer(oPC, oCurInvObj, iItemCount, sItemName);
            }
            else if (GetNumStackedItems(oCurInvObj) > 1)
                {
                    iHeaderCount = iHeaderCount + 1;
                    iItemCount = EncodeStackItem( oPC, oCurInvObj, iItemCount);
                }
                else
                {
                    EncodeItem(oPC, oCurInvObj, iItemCount, sItemName);
                }
        }


        oCurInvObj = GetNextItemInInventory(oCurItem);


    }
    iItemCount = iItemCount + 1;
    SPStr(oPC, sBankBP + IntToString(iItemCount), "END");
    iHeaderCount = iHeaderCount + 1;

    //Debug
    if (Debug)
    {
        SendMessageToPC(oPC, "END Encode Container ROUTINE");
    }


    return iItemCount;
}


void DecodeGold (object oPC, object oCurContainer, int iItemCount, string sItemName)
{
    iStackAmt = GPI(oPC, sBankGold);
    object oCurItem = CreateItemOnObject(sItemName, oCurContainer, iStackAmt);

    // Debug Statements
    if (Debug)
    {
        SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount));
        SendMessageToPC(oPC, "This Gold. StackSize "+IntToString(iStackAmt));
        SendMessageToPC(oPC, "Valid Object:" + IntToString(GetIsObjectValid(oCurItem)) );
        SendMessageToPC(oPC, "ResRef: "+sItemName);
        SendMessageToPC(oPC, "----------");
    }

    return;
}

object DecodeItem (object oPC, object oCurContainer, int iItemCount, string sItemName)
{
    object oCurItem = CreateItemOnObject(sItemName, oCurContainer, 1);
    if ( GPI(oPC, sBankItemID + IntToString(iItemCount)) )
    {
        SetIdentified(oCurItem, TRUE);
    }
    //Debug Statements
    if (Debug)
    {
        SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount));
        SendMessageToPC(oPC, "This is an Item.");
        SendMessageToPC(oPC, "Valid Object:" + IntToString(GetIsObjectValid(oCurItem)) );
        SendMessageToPC(oPC, "ResRef: "+sItemName);
        SendMessageToPC(oPC, "Identified?: " + IntToString(GPI(oPC, sBankItemID + IntToString(iItemCount))) );
        SendMessageToPC(oPC, "----------");
    }

    DPV(oPC, sBankItemID + IntToString(iItemCount) );

    return oCurItem;
}

int DecodeStackItem (object oPC, object oCurContainer, int iItemCount, string sItemName)
{
    DPV(oPC, sBankBP + IntToString(iItemCount) );
    iItemCount = iItemCount + 1;
    iStackAmt = GPI(oPC, sBankStack + IntToString(iItemCount));
    sItemName = GPStr(oPC, sBankBP + IntToString(iItemCount));
    object oCurItem = CreateItemOnObject(sItemName, oCurContainer, iStackAmt);

    if ( GPI(oPC, sBankItemID + IntToString(iItemCount)) )
    {
        SetIdentified(oCurItem, TRUE);
    }

    DPV(oPC, sBankStack + IntToString(iItemCount) );
    DPV(oPC, sBankItemID + IntToString(iItemCount) );

    //Debug Statements
    if (Debug)
    {
        SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount));
        SendMessageToPC(oPC, "Stack Item. StackSize: "+IntToString(iStackAmt));
        SendMessageToPC(oPC, "Valid Object:" + IntToString(GetIsObjectValid(oCurItem)) );
        SendMessageToPC(oPC, "ResRef: "+sItemName);
        SendMessageToPC(oPC, "Identified?: " + IntToString(GPI(oPC, sBankItemID + IntToString(iItemCount))) );
        SendMessageToPC(oPC, "----------");
    }

    return iItemCount;
}

int DecodeContainer (object oPC, object oCurContainer, string sItemName, int iItemCount)
{
    //Debug
    if (Debug)
    {
        SendMessageToPC(oPC, "Decode Container ROUTINE");
    }

    DPV(oPC, sBankBP + IntToString(iItemCount) );
    iItemCount = iItemCount +1;

    //Debug
    if (Debug)
    {
        SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount) );
    }

    sItemName = GPStr(oPC, sBankBP + IntToString(iItemCount) );
    oCurContainer = DecodeItem(oPC, OBJECT_SELF, iItemCount, sItemName);

    sItemName = GPStr(oPC, sBankBP + IntToString(iItemCount + 1) );

    while ( sItemName != "END")
        {
            iItemCount = iItemCount + 1;
            //Debug
            if (Debug)
            {
                SendMessageToPC(oPC, "Item#: "+IntToString(iItemCount) );
            }

            sItemName = GPStr(oPC, sBankBP + IntToString(iItemCount) );


            if ( sItemName != "nw_it_gold001" )
            {

                    if ( sItemName == "STACK")
                    {
                        iItemCount = DecodeStackItem(oPC, oCurContainer, iItemCount, sItemName);
                    }
                    else
                    {
                        DecodeItem(oPC, oCurContainer, iItemCount, sItemName);
                    }


            }
            else
            {

                DecodeGold(oPC, oCurContainer, iItemCount, sItemName);
                DPV(oPC, sBankGold );


            }
            DPV(oPC, sBankBP + IntToString(iItemCount) );


        }

    return iItemCount;
}

