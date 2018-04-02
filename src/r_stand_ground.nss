#include "paus_inc_generic"

void main()
{
    SetAssociateState(NW_ASC_MODE_STAND_GROUND);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_CANDO));
    ActionAttack(OBJECT_INVALID);
    ClearAllActions();
}
