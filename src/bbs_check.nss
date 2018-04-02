int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPos = GetLocalInt(oPC, "BBS_Pos");
    SetLocalInt(oPC, "BBS_Pos", iPos+1);

    switch (iPos)
    {
        case 5: // Previous page
            return GetLocalInt(oPC, "BBS_Enable_Prev");
        case 6: // Next page
            return GetLocalInt(oPC, "BBS_Enable_Next");
        case 7: // Post message
            return GetIsObjectValid(GetItemPossessedBy(oPC, "bbs_notice"));
        default:
            return (GetLocalInt(oPC, "BBS_Post_" + IntToString(iPos)) != -1);
    }
    return FALSE;
}
