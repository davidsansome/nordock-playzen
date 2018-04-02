void main()
{
    object oTarget = GetLocalObject(GetPCSpeaker(), "TylnTarget");

    object oObject = GetFirstObjectInArea();
    float fDistance = -1.0;
    object oClosestGuard;
    while (GetIsObjectValid(oObject))
    {
        if ((FindSubString(GetTag(oObject), "_TCG") != -1) && (oObject != oTarget) && (GetObjectType(oObject) == OBJECT_TYPE_CREATURE))
        {
            float f = GetDistanceBetween(oTarget, oObject);
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
        AssignCommand(oClosestGuard, ActionAttack(oTarget));
    }
}
