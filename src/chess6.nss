void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess6"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess6a"),ActionAttack(oPC,FALSE));
    }
}
