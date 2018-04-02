//::///////////////////////////////////////////////
//:: FileName perbrewoil
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 1:43:32 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ATS_C_L942_N_SLH");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "Blackberrygem");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    // Give the speaker the items
    CreateItemOnObject("oilofvukas", GetPCSpeaker(), 1);


}
