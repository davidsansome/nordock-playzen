void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess4"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess4a"),ActionAttack(oPC,FALSE));
    }
}
