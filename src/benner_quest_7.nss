int StartingConditional()
{
    object oFollowing = GetLocalObject(OBJECT_SELF, "Following");
    if (GetIsObjectValid(oFollowing) && (oFollowing != GetPCSpeaker()))
    {
        ActionForceFollowObject(oFollowing);
        return TRUE;
    }
    return FALSE;
}
