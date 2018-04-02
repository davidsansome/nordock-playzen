void main()
{
    location lTarget = GetLocalLocation(GetPCSpeaker(), "TylnTargetLocation");

    object oObject = GetFirstObjectInArea();
    while (GetIsObjectValid(oObject))
    {
        if ((FindSubString(GetTag(oObject), "_TCG") != -1 ) && (GetObjectType(oObject) == OBJECT_TYPE_CREATURE))
        {
            AssignCommand(oObject, ClearAllActions());
            AssignCommand(oObject, ActionMoveToLocation(lTarget));
        }
        oObject = GetNextObjectInArea();
    }
}

