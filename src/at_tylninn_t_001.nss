
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);

  SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

  SetLocalInt(oClicker, "TylnIntruder", 1);
  AssignCommand(oClicker,JumpToObject(oTarget));
}
