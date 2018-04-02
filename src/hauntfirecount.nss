//::///////////////////////////////////////////////
//:: FileName hauntfirecount
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/1/2002 9:19:31 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "FireRose");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    // Set the variables
    int nFRG = GetLocalInt(GetPCSpeaker(),"FireRoseCount");
    nFRG=nFRG+1;
    SetLocalInt(GetPCSpeaker(), "FireRoseCount", nFRG);

}
