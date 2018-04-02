//::///////////////////////////////////////////////
//:: FileName epic_store_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/5/2002 1:29:25 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC=GetPCSpeaker();
    SetXP(oPC,(GetXP(oPC)-24000));
    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("epic_store");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
