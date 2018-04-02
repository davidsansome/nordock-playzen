void main()
{
object oPC=GetLastSpeaker();

AssignCommand(oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2));
DelayCommand(3.0, AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 3.0, 2.0)));
DelayCommand(3.0, AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_LAUGH)));
DelayCommand(5.0, AssignCommand(oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY1)));
DelayCommand(8.5, AssignCommand(oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3)));
DelayCommand(11.0, AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_GET_MID, 3.0, 2.0)));
DelayCommand(14.5, AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_LAUGH)));
DelayCommand(13.0, AssignCommand(oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3)));
}
