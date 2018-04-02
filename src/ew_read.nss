void main()
{
object oPC=GetLastSpeaker();

AssignCommand(oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_READ));
DelayCommand(3.0, AssignCommand( oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_READ)));
}
