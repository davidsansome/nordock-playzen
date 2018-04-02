void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC))
        return;

    if ((GetLocalInt(oPC, "InmateBennerQuest") == 3) && (GetIsObjectValid(GetLocalObject(oPC, "InmateBenner"))))
    {
        SetLocalInt(oPC, "InmateBennerQuest", 4);

        object oBenner = GetLocalObject(oPC, "InmateBenner");
        AssignCommand(oBenner, SpeakString("Freedom at last!"));
        AssignCommand(oBenner, ClearAllActions(TRUE));
        AssignCommand(oBenner, ActionJumpToObject(GetObjectByTag("WP_BennerSewers")));
    }
}
