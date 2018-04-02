void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
       AssignCommand(GetObjectByTag("chess7"),ActionAttack(oPC,FALSE));
       AssignCommand(GetObjectByTag("chess7a"),ActionAttack(oPC,FALSE));
    }
}
