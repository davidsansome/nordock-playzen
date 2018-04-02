#include "nw_o2_coninclude"

void main()
{
    object oPC = GetLastOpenedBy();
    object oChest = OBJECT_SELF;

    if (GetLocalInt(oChest, "DO_ONCE") == 1)
        return;

    SetLocalInt(oChest, "DO_ONCE", 1);

    CreateGold(oChest, oPC, TREASURE_HIGH, 10);
    CreateArcaneScroll(oChest, oPC, 10);
    CreateAmmo(oChest, oPC, 10);
    CreatePotion(oChest, oPC, 10);
    CreateGenericMiscItem(oChest, oPC, 10);
    CreateGenericMiscItem(oChest, oPC, 10);
    CreateGenericMiscItem(oChest, oPC, 10);
    CreateGenericMiscItem(oChest, oPC, 10);
    CreateGenericClassItem(oChest, oPC, 10);
    CreateGenericClassItem(oChest, oPC, 10);
    CreateGenericClassItem(oChest, oPC, 10);
}
