void main()
{
    object oDoor1 = GetObjectByTag("PenguinDoor1");
    object oDoor2 = GetObjectByTag("PenguinDoor2");
    object oGong = GetObjectByTag("PenguinGong");

    if ((GetLocalInt(oGong, "Part1") != 1) && (GetLocalInt(oGong, "Part2") != 1))
    {
        SetLocalInt(oGong, "Part1", 1);
        AssignCommand(oGong, ActionDoCommand(SetLocked(oDoor1, FALSE)));
        AssignCommand(oGong, ActionOpenDoor(oDoor1));
        AssignCommand(oGong, ActionDoCommand(SetLocked(oDoor2, FALSE)));
        AssignCommand(oGong, ActionCloseDoor(oDoor2));
        AssignCommand(oGong, ActionDoCommand(SetLocked(oDoor2, TRUE)));

        DelayCommand(600.0f, DeleteLocalInt(oGong, "Part1"));
    }
}
