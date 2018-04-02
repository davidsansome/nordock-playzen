//::///////////////////////////////////////////////
//:: FileName malkmakeselix
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/28/2002 9:15:25 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("emptyvial001", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "EmptyVial");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "NW_IT_MSMLMISC08");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
