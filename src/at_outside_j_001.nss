void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetAlignmentGoodEvil(oClicker) == ALIGNMENT_GOOD)
    {
        SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
        AssignCommand(oClicker,JumpToObject(oTarget));
    }
    else
        FloatingTextStringOnCreature("*Only the good may enter*", oClicker);
}
