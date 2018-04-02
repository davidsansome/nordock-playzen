void main()
{
   object oPC = GetLastSpeaker();
   int nRoll=d20();
   int nRank=GetAbilityModifier (ABILITY_WISDOM, oPC);
   int nResult=nRoll+nRank;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);
   string sAbility="Wisdom";
   AssignCommand( oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
   AssignCommand( oPC, SpeakString(sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));

}

