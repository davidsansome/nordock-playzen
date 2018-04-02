void ReCloseDoors()
{
    object oDoor1 = GetObjectByTag("TrevorGateS1");
    object oDoor2 = GetObjectByTag("TrevorGateS2");
    object oDoor3 = GetObjectByTag("TrevorGateS3");

    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    ActionCloseDoor(oDoor1);
    ActionCloseDoor(oDoor2);
    ActionCloseDoor(oDoor3);
    SetLocked(oDoor1, TRUE);
    SetLocked(oDoor2, TRUE);
    SetLocked(oDoor3, TRUE);
    ActionOpenDoor(OBJECT_SELF);
}

void main()
{
    object oDoor1 = GetObjectByTag("TrevorGateS1");
    object oDoor2 = GetObjectByTag("TrevorGateS2");
    object oDoor3 = GetObjectByTag("TrevorGateS3");

    int iOpen = GetLocalInt(OBJECT_SELF, "CellsOpen");

    if (iOpen == 0)
    {
        // Open all the doors
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocked(oDoor1, FALSE);
        SetLocked(oDoor2, FALSE);
        SetLocked(oDoor3, FALSE);
        ActionOpenDoor(oDoor1);
        ActionOpenDoor(oDoor2);
        ActionOpenDoor(oDoor3);
        SetLocalInt(OBJECT_SELF, "CellsOpen", 1);

        DelayCommand(180.0, ReCloseDoors());
    }
    else
    {
        // Close all the doors
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        ActionCloseDoor(oDoor1);
        ActionCloseDoor(oDoor2);
        ActionCloseDoor(oDoor3);
        SetLocked(oDoor1, TRUE);
        SetLocked(oDoor2, TRUE);
        SetLocked(oDoor3, TRUE);
        SetLocalInt(OBJECT_SELF, "CellsOpen", 0);
    }
}
