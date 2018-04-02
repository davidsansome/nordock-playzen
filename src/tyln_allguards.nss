void main()
{
    object oTarget = GetLocalObject(GetPCSpeaker(), "TylnTarget");

    object oObject = GetFirstObjectInArea();
    while (GetIsObjectValid(oObject))
    {
        if ((FindSubString(GetTag(oObject), "_TCG") != -1) && (oObject != oTarget))
        {
            AssignCommand(oObject, ClearAllActions());
            AssignCommand(oObject, ActionAttack(oTarget));
        }
        oObject = GetNextObjectInArea();
    }
}
