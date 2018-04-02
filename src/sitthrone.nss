void main()
{
  object oThroneGood = OBJECT_SELF;
  if(!GetIsObjectValid(GetSittingCreature(oThroneGood)))
  {
    AssignCommand(GetLastUsedBy(), ActionSit(oThroneGood));
  }
}

