#include "paus_inc_generic"

void main()
{
    ResetHenchmenState();
    DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_CANDO));
    //Companions will only attack the Masters Last Attacker
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
    if(GetIsObjectValid(GetLastHostileActor(GetRealMaster())))
    {
        DetermineCombatRound(GetLastHostileActor(GetRealMaster()));
    }
}
