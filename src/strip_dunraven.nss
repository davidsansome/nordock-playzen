// This trigger will remove all Dunraven items from all PCs
// These items were acquired by killing a Commoner NPC in
// North Brosna by the name of Lord Dunraven.
// Written by Jarketh Thavin 12/24/2002
void main()
{
object oPC = GetEnteringObject();

// Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(oPC, "DunravensBattleArmor");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(oPC, "DunravensAxe");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(oPC, "DunravenSIgnetRing");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
