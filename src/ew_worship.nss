void main()
{
object oPC=GetLastSpeaker();

AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_WORSHIP, 1.0, 6.0));
//AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_PAIN2));
//DelayCommand(2.5, AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_PAIN3)));
}
