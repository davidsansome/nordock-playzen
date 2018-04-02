//::///////////////////////////////////////////////
//:: FileName renaldone
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 12:27:29 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("duergervaultkey", GetPCSpeaker(), 1);



    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ATS_C_A921_N_GOL");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    DestroyObject(GetObjectByTag("Renal"));
}
