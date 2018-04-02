void main()
{
ClearAllActions();
SetLocalInt(OBJECT_SELF, "PACK_MODE", 4); // 4 = Nothing
object oPack = GetLocalObject(OBJECT_SELF, "GROUND_PACK");
if (GetIsObjectValid(oPack)) { DestroyObject(oPack); }

oPack = CreateObject(OBJECT_TYPE_PLACEABLE, "oxpack", GetLocation(OBJECT_SELF));
object oItem = GetFirstItemInInventory();
object oSelf = OBJECT_SELF;
AssignCommand(oPack, TakeGoldFromCreature(GetGold(oSelf), oSelf));
while (GetIsObjectValid(oItem)) {
    AssignCommand(oPack, ActionTakeItem(oItem, oSelf));
    oItem = GetNextItemInInventory();
}
SetLocalObject(OBJECT_SELF, "GROUND_PACK", oPack);
ActionMoveAwayFromObject(oPack, FALSE, 1.5);
}
