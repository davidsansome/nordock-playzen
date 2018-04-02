//::///////////////////////////////////////////////
//:: FileName getbrock
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/10/2002 5:05:24 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("recipeforbrocksd", GetPCSpeaker(), 1);


    // Remove some gold from the player
    TakeGoldFromCreature(20000, GetPCSpeaker(), TRUE);
}
