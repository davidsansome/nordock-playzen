int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iStage = GetLocalInt(oPC, "InmateBennerQuest");
    if ((iStage == 2) || (iStage == 3))
    {
        ActionForceFollowObject(oPC, 1.0f);
        SetLocalObject(oPC, "InmateBenner", OBJECT_SELF);
        SetLocalObject(OBJECT_SELF, "Following", oPC);
        return TRUE;
    }
    return FALSE;
}


