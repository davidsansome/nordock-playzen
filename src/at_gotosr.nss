void main()
{
    object oPC = GetPCSpeaker();
    object oPCTarget = GetObjectByTag("tele_StorageRoom");
    AssignCommand(oPC, ActionJumpToObject(oPCTarget));
}
