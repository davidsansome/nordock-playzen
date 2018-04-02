int StartingConditional()
 {
   if (GetStringLowerCase(GetSubRace(GetPCSpeaker()))=="duergar")
        return TRUE;

   return FALSE;
 }
