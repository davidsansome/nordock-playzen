void main()
{
    object oPC = GetLastUsedBy();

    if (!GetIsPC(oPC))
        return;

    if (GetLocked(OBJECT_SELF) && GetIsOpen(OBJECT_SELF))
    {
        object oInUseBy = GetLocalObject(OBJECT_SELF, "ChestInUseBy");
        if (oInUseBy == oPC)
            return;

        FloatingTextStringOnCreature("This chest is in use", oPC);
    }
}
