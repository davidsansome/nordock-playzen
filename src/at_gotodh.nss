void main()
{
    object oPC = GetPCSpeaker();
    object oPCTarget = GetObjectByTag("tele_DiningHall");
    AssignCommand(oPC, ActionJumpToObject(oPCTarget));
}
