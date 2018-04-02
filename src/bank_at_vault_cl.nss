#include "bank_inc"

void main()
{
        object oTempVault = OBJECT_SELF;

        object oMover = GetLocalObject(oTempVault, "mover_obj");
        object oVault = GetLocalObject(oMover, "vault_obj");

        object oItem = GetFirstItemInInventory(oTempVault);

        while(GetIsObjectValid(oItem))
        {
            AssignCommand(oMover, ActionTakeItem(oItem, oTempVault));
            oItem = GetNextItemInInventory(oTempVault);
        }
        AssignCommand(oMover, ActionJumpToObject(oVault));
        AssignCommand(oMover, ActionDoCommand(DestroyObject(oTempVault)));
        AssignCommand(oMover, ActionDoCommand(MoveItemsToVault(oMover, oVault, TRUE)));
        SetLocalObject(GetPCSpeaker(), "vault_obj", oVault);
        AssignCommand(GetNearestObjectByTag("Banker"), SpeakString("Please come back soon."));
}
