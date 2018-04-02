#include "dmw_inc"
#include "dmw_start_inc"

int StartingConditional()
{
   int nMyNum = 0;

   //Check whether this conversation has been started already, start it if not.
   int nStarted = GetLocalInt(oMySpeaker, "dmw_started");
   if(! nStarted)
   {
      SetLocalInt(oMySpeaker, "dmw_started", 1);
      dmwand_StartConversation();
   }

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
