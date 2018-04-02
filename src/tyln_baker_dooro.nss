void main()
{
    object oPC = GetLastOpenedBy();

    object oObject = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oObject))
    {
        if (GetTag(oObject) == "TylnBakerKey")
        {
            DestroyObject(oObject);
            break;
        }
        oObject = GetNextItemInInventory(oPC);
    }

    DelayCommand(30.0, ActionCloseDoor(OBJECT_SELF));
    DelayCommand(30.0, SetLocked(OBJECT_SELF, TRUE));
}
