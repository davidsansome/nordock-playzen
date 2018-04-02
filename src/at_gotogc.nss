void main()
{
    object oPC = GetPCSpeaker();
    object oPCTarget = GetObjectByTag("tele_GuestsChambers");
    AssignCommand(oPC, ActionJumpToObject(oPCTarget));
}
