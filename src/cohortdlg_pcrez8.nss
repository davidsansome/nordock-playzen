void main()
{
    object oItem;
    object oPC = GetPCSpeaker();

    if(GetIsObjectValid(oItem = GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR702")))
        ActionGiveItem(oItem, oPC);
    else if(GetIsObjectValid(oItem = GetItemPossessedBy(OBJECT_SELF,"Resurrection")))
        ActionGiveItem(oItem, oPC);
    else if(GetIsObjectValid(oItem = GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR501")))
        ActionGiveItem(oItem, oPC);
    else if(GetIsObjectValid(oItem = GetItemPossessedBy(OBJECT_SELF,"RaiseDead")))
        ActionGiveItem(oItem, oPC);
}
