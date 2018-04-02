void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess3"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess3a"),ActionAttack(oPC,FALSE));
    }
}
