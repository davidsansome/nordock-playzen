void main()
{
    object oPC = GetClickingObject();

    object oObject = GetFirstObjectInArea();
    while (GetIsObjectValid(oObject))
    {
        if ((GetTag(oObject) == "TylnBaker") && (!GetIsDead(oObject)))
        {
            AssignCommand(oObject, SpeakString("Hey, you can't go through there!"));
            AssignCommand(oObject, ActionMoveToObject(oPC, TRUE));
            return;
        }
        oObject = GetNextObjectInArea();
    }
}
