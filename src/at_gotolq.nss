void main()
{
    object oPC = GetPCSpeaker();
    object oPCTarget = GetObjectByTag("tele_LivingQuarters");
    AssignCommand(oPC, ActionJumpToObject(oPCTarget));
}
