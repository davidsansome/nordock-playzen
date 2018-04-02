#include "paus_inc_generic"

void main()
{
    ActionPauseConversation();
    if (TalentSummonAllies()) return;
    int iBuffed = TalentUseProtectionOthers(GetPCSpeaker());
    if (!iBuffed) iBuffed = TalentEnhanceOthers(GetPCSpeaker(),TRUE);
    SetLocalInt(GetPCSpeaker(),"BuffedUp",iBuffed);
    ActionResumeConversation();
}
