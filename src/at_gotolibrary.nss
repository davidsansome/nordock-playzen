void main()
{
    object oPC = GetPCSpeaker();
    object oPCTarget = GetObjectByTag("tele_Library");
    AssignCommand(oPC, ActionJumpToObject(oPCTarget));
}
