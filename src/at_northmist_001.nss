#include "rr_persist"

void main()
{
  // set up
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  object oMod = GetModule();
  int nQuestDone = GetLocalInt(oMod, "nQuestDone");
  int nMainQuest = GPI(oClicker, "nMainQuest");
  string sCaveIn = "There has been a cave in, it is impossible to enter";

// if the quest has not been completed then allow the pc to enter
  if (nQuestDone==FALSE && nMainQuest==FALSE)
    {
    SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
    AssignCommand(oClicker,JumpToObject(oTarget));
    }

// if the quest has been done, use a cave in to deny access
  else
    {
    FloatingTextStringOnCreature(sCaveIn, oClicker);
    }
}
