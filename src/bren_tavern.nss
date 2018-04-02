//::///////////////////////////////////////////////
//:: FileName bren_tavern
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/05/2004 9:00:06 PM
//:://////////////////////////////////////////////
void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("BrenTavern");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);

    // Modify the player's reputation
    AdjustReputation(GetPCSpeaker(), OBJECT_SELF, 20);
}
