/****************************************************
  Action Taken Script : Open Store Script
  ats_at_openstore

  Last Updated: August 24, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script belongs to the conversation file for
  a crafting NPC.  It is used to create the store
  if one doesn't exist and then opens it.
****************************************************/
#include "ats_inc_common"

void main()
{
    string sNPCTag = GetTag(OBJECT_SELF);
    int iTagLength = GetStringLength(sNPCTag);
    string sStoreTag = "ATS_STORE_" + GetStringRight(sNPCTag, iTagLength - 8);

    // Either open the store with that tag or create the store.
    object oStore = GetLocalObject(OBJECT_SELF, "ats_object_store");

    if(GetIsObjectValid(oStore) == FALSE)
    {
        oStore = CreateObject(OBJECT_TYPE_STORE, ATS_GetResRefFromTag(sStoreTag), GetLocation(OBJECT_SELF));
        SetLocalObject(OBJECT_SELF, "ats_object_store", oStore);
        object oCurrentItem = GetFirstItemInInventory(oStore);
        while(oCurrentItem != OBJECT_INVALID)
        {
            SetLocalInt(oCurrentItem, "ats_onstore_original", TRUE);
            oCurrentItem = GetNextItemInInventory(oStore);
        }

   }
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
