void main()
{
   object oPC = GetLastSpeaker();
   int nRoll=d100();
   string sName = GetName(oPC);
   string sRoll=IntToString(nRoll);
   AssignCommand( oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
   DelayCommand( 2.0, AssignCommand( oPC, SpeakString(sName+"Rolled a d100 and gets a: "+sRoll)));

}

