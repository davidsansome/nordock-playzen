//::///////////////////////////////////////////////
//:: FileName silent_success
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/17/2002 7:20:50 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 1000);

    // Give the speaker the items
    CreateItemOnObject("bro_ring_nod", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "TuckersAmulet");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
