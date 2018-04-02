void main()
{
    string strDest = GetLocalString(OBJECT_SELF, "strDestination");
    object oPlayer = GetLastUsedBy();

    if (oPlayer != OBJECT_INVALID)
    {
        object oDest = GetObjectByTag(strDest);
        AssignCommand(oPlayer, ClearAllActions());
        AssignCommand(oPlayer, ActionJumpToObject(oDest, FALSE));
        AssignCommand(oPlayer, SetFacing(GetFacing(oDest)));
    }
}

