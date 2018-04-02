void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess1"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess1a"),ActionAttack(oPC,FALSE));
    }
}
