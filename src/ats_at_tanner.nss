/****************************************************
  Action Taken Script : Master Tanner Store
  ats_at_tanner

  Last Updated: July 31, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script belongs to the conversation file for
  the master blacksmith npc.  It is used to open
  the blacksmith's store.
****************************************************/
void main()
{

    // Either open the store with that tag or create the store.
    object oStore = GetNearestObjectByTag("ATS_STORE_MTANNER");

    if(GetIsObjectValid(oStore) == FALSE || GetDistanceBetween(oStore, OBJECT_SELF) > 1.0f)
            CreateObject(OBJECT_TYPE_STORE, "ats_store_mtanner", GetLocation(OBJECT_SELF));
    else if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
