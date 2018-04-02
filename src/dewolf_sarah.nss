void MakeFairy(object oPC)
{
    location lLoc = GetLocation(oPC);
    object oFairy = CreateObject(OBJECT_TYPE_CREATURE, "dewolf_fairy", lLoc);
    AssignCommand(oFairy, ActionRandomWalk());
    DelayCommand(20.0f, DestroyObject(oFairy));
}

void main()
{
    object oPC = GetPCSpeaker();
    effect ePara = EffectCutsceneParalyze();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oPC, 10.0f);

    ClearAllActions();
    SpeakString("Quiet!  Don't scare away the faries!");
    ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0f, 8.0f);
    DelayCommand(2.0f, MakeFairy(oPC));
    DelayCommand(4.0f, MakeFairy(oPC));
    DelayCommand(6.0f, MakeFairy(oPC));
    DelayCommand(8.0f, MakeFairy(oPC));
    DelayCommand(9.0f, SpeakString("Now, lie down and enjoy the soft beating of their wings"));

    DelayCommand(10.1f, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 10.0f)));
    ePara = EffectCutsceneParalyze();
    DelayCommand(11.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oPC, 9.0f));

    DelayCommand(22.0f, SpeakString("Thank you " + GetName(oPC)));
}
