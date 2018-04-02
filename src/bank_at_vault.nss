#include "bank_inc"

void main()
{
    object oPC = GetPCSpeaker();
    object oTempVault;
    SpeakString("Please wait while I bring up your vault item manifest.");

    object oVault = GetLocalObject(oPC, "vault_obj");
    if(GetIsObjectValid(oVault))
    {
        object oMover = CreateObject(OBJECT_TYPE_CREATURE, "vault_mover", GetLocation(oVault));
        SetLocalObject(oMover, "vault_obj", oVault);
        SetLocalObject(oVault, "mover_obj", oMover);
        AssignCommand(oMover, ActionDoCommand(GrabItemsFromVault(oMover, oVault, oPC, TRUE)));
        oTempVault = CreateObject(OBJECT_TYPE_PLACEABLE, "bank_pvault", GetLocation(oPC));
        SetLocalObject(oPC, "vault_obj", oTempVault);
        SetLocalObject(oTempVault, "mover_obj", oMover);
        DelayCommand(0.5, AssignCommand(oMover, ActionDoCommand(MoveItemsToVault(oMover, oTempVault, FALSE, TRUE))));
        SetLocalObject(oMover, "pc_obj", oPC);
    }
    else
    {
        // Create the vault and populate from tokens
        oTempVault = CreateObject(OBJECT_TYPE_PLACEABLE, "bank_pvault", GetLocation(oPC));
        SetLocalObject(oPC, "vault_obj", oTempVault);
        int iItemCount = 0;
        int iItemHash;
        string sDataString;
        int iQuantity = 0;
        string sItemTag;
        object oCreatedItem;

        int i;
        for(i = 1; i <= BANK_VAULT_SIZE; ++i)
        {
            sDataString = IntToString(GetTokenInt(oPC, "vault_item_"+IntToString(i)));
            iQuantity = StringToInt(GetStringRight(sDataString, 2));
            iItemHash = StringToInt(GetStringLeft(sDataString,GetStringLength(sDataString) - 2));
            sItemTag = GetLocalString(GetModule(), "BANK_STORABLE_" + IntToString(iItemHash));
            if(sItemTag != "")
            {
                oCreatedItem = CreateItemOnObject(GetStringLowerCase(sItemTag), oTempVault, iQuantity);
                ++iItemCount;
            }
        }  // end for

        object oMover = CreateObject(OBJECT_TYPE_CREATURE, "vault_mover", GetLocation(oTempVault));
        SetLocalObject(oTempVault, "mover_obj", oMover);
        oVault = CreateObject(OBJECT_TYPE_PLACEABLE, "bank_pvault", GetLocation(GetWaypointByTag("BANK_VAULT_WP")));
        SetLocalObject(oMover, "vault_obj", oVault);
        SetLocalObject(oVault, "mover_obj", oMover);
        SetTokenInt(oPC, "vault_itemcount", iItemCount);
        AssignCommand(oPC, DoPlaceableObjectAction(oTempVault, PLACEABLE_ACTION_USE));

    }   // end else


}
