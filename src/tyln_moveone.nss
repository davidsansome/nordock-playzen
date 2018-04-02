void main()
{
    location lTarget = GetLocalLocation(GetPCSpeaker(), "TylnTargetLocation");

    object oObject = GetFirstObjectInArea();
    float fDistance = -1.0;
    object oClosestGuard;
    while (GetIsObjectValid(oObject))
    {
        if ((FindSubString(GetTag(oObject), "_TCG") != -1) && (GetObjectType(oObject) == OBJECT_TYPE_CREATURE))
        {
            float f = GetDistanceBetweenLocations(lTarget, GetLocation(oObject));
            if ((f < fDistance) || (fDistance == -1.0))
            {
                oClosestGuard = oObject;
                fDistance = f;
            }
        }
        oObject = GetNextObjectInArea();
    }

    if (GetIsObjectValid(oClosestGuard))
    {
        AssignCommand(oClosestGuard, ClearAllActions());
        AssignCommand(oClosestGuard, ActionMoveToLocation(lTarget));
    }
}

