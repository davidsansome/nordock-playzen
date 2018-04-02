void main()
{
    object oPlayer = GetLastUsedBy();
    object oThisTree = OBJECT_SELF;
    AssignCommand(oPlayer, DoPlaceableObjectAction(oThisTree,PLACEABLE_ACTION_BASH));

}
