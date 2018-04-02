/****************************************************
  Forge EndConversation Script
  ats_at_forge_end

  Last Updated: August 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script gets called when the forge's conversation
  ends.  It unlocks the forge.
****************************************************/
void main()
{
    SetLocked(OBJECT_SELF, FALSE);
    SetLocalObject(OBJECT_SELF, "ats_current_user", OBJECT_INVALID);
    SetLocalString(OBJECT_SELF, "ats_current_username", "");
}
