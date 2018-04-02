int StartingConditional()
{
    if((GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR702"))) || (GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"Resurrection"))))
        return TRUE;
    else if((GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR501"))) || (GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"RaiseDead"))))
        return TRUE;

    return FALSE;
}
