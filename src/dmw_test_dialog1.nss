#include "dmw_inc"

int StartingConditional()
{
   int nMyNum = 1;

   object oMySpeaker = GetLastSpeaker();
   object oMyTarget = GetLocalObject(oMySpeaker, "dmwandtarget");
   location lMyLoc = GetLocalLocation(oMySpeaker, "dmwandloc");

   string sMyString = GetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nMyNum));

   if(sMyString == "")
   {
      return FALSE;
   }
   else
   {
      SetCustomToken(DMW_START_CUSTOM_TOKEN + nMyNum, sMyString);
      return TRUE;
   }
}
