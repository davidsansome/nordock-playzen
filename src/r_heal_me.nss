#include "paus_inc_generic"

void main()
{
    ResetHenchmenState();
    if(TalentCureCondition()) { DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_CANDO)); return; }
    if(TalentHeal(TRUE)) { DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_CANDO)); return; }
    DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_CANTDO));
}
