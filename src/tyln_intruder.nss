void main()
{
    object oPC = GetEnteringObject();
    object oGuard1 = GetObjectByTag("F206_TCG");
    object oGuard2 = GetObjectByTag("F204_TCG");

    if (!GetIsPC(oPC))
        return;

    if (GetLocalInt(oPC, "TylnIntruder") == 1)
    {
        DeleteLocalInt(oPC, "TylnIntruder");
        if (GetIsObjectValid(oGuard1))
        {
            SetIsTemporaryEnemy(oPC, oGuard1);
        }
        if (GetIsObjectValid(oGuard2))
        {
            SetIsTemporaryEnemy(oPC, oGuard2);
        }
    }
}
