/****************************************************
  Action Taken Script : Master Jewelcrafter Store
  ats_at_jewel

  Last Updated: August 16, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)
    Assisted by Pelemele Malef'carum (Shawn Perreault)

  This script belongs to the conversation file for
  the master jewelcrafter npc.  It is used to open
  the jewelcrafter's store.
****************************************************/
void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("ATS_STORE_MJEWELER");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
