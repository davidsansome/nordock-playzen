void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess2"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess2a"),ActionAttack(oPC,FALSE));
    }
}
