//::///////////////////////////////////////////////
//:: FileName lockbox_sell
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/20/2002 9:23:06 PM
//:://////////////////////////////////////////////
void main()
{
    // Remove some gold from the player
    TakeGoldFromCreature(1000, GetPCSpeaker(), TRUE);

    // Give the speaker the items
    CreateItemOnObject("playerlockbox", GetPCSpeaker(), 1);
}
