void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetAlignmentGoodEvil(oClicker) == ALIGNMENT_EVIL)
    {
        SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
        AssignCommand(oClicker,JumpToObject(oTarget));
    }
    else
        FloatingTextStringOnCreature("*Only the evil may enter*", oClicker);
}
