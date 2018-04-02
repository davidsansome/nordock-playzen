void main()
{
    object oVault = OBJECT_SELF;
    AssignCommand(GetPCSpeaker(), DoPlaceableObjectAction(oVault, PLACEABLE_ACTION_USE));

}
