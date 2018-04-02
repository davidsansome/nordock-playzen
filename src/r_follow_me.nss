#include "paus_inc_generic"

void main()
{
    ResetHenchmenState();
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
    DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_CANDO));

    if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
    {
       //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    }
    if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
    {
       ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
    }
    ActionForceFollowObject(GetRealMaster(), GetFollowDistance());
    SetAssociateState(NW_ASC_IS_BUSY);
    DelayCommand(5.0, SetAssociateState(NW_ASC_IS_BUSY, FALSE));
}
