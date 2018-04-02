/****************************************************
  Starting Condition Script: Start of Conversation
  ats_sc_forgelock

  Last Updated: August 18, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script locks the forge at the beginning of the
  conversation.
****************************************************/
int StartingConditional()
{
    SetLocked(OBJECT_SELF, TRUE);
    return TRUE;
}
