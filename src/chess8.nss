void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess8"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess8a"),ActionAttack(oPC,FALSE));
    }
}
