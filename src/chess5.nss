void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess5"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess5a"),ActionAttack(oPC,FALSE));
    }
}
