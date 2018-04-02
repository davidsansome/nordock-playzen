void main()
{
ClearAllActions();
SetLocalInt(OBJECT_SELF, "PACK_MODE", 4);
object oPack = GetLocalObject(OBJECT_SELF, "GROUND_PACK");
if (!GetIsObjectValid(oPack) || GetDistanceToObject(oPack) > 30.0) { SpeakString("*No pack*"); return; }

object oItem = GetFirstItemInInventory(oPack);
while (GetIsObjectValid(oItem)) {
    ActionTakeItem(oItem, oPack);
    oItem = GetNextItemInInventory(oPack);
}
DeleteLocalObject(OBJECT_SELF, "GROUND_PACK");
ActionDoCommand(DestroyObject(oPack));
SetLocalInt(OBJECT_SELF, "PACK_MODE", 1);
ActionForceFollowObject(GetLocalObject(OBJECT_SELF, "PACK_OWNER"), 3.0);
}
