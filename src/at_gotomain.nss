void main()
{
    object oPC = GetPCSpeaker();
    object oPCTarget = GetObjectByTag("tele_Main");
    AssignCommand(oPC, ActionJumpToObject(oPCTarget));
}
