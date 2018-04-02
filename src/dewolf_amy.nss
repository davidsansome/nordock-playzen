void main()
{
    object oPC = GetPCSpeaker();

    string sGender;
    int iGender = GetGender(oPC);
    if (iGender == GENDER_FEMALE)
        sGender = "girl";
    else
        sGender = "boy";

    SetBaseAttackBonus(6, OBJECT_SELF);
    SpeakString("*giggles*  You're such a naughty " + sGender + ".");
    DelayCommand(1.0, ActionAttack(oPC));
    DelayCommand(6.0, SpeakString("Oooh yes!"));
    DelayCommand(12.0, ClearAllActions(TRUE));
    DelayCommand(12.1, ClearPersonalReputation(oPC, OBJECT_SELF));
    DelayCommand(12.1, ClearPersonalReputation(OBJECT_SELF, oPC));
}
