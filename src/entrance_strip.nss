// This trigger will remove all Dunraven items from all PCs
// These items were acquired by killing a Commoner NPC in
// North Brosna by the name of Lord Dunraven.
// Written by Jarketh Thavin 12/24/2002

#include "rr_persist"

void NewbieGreetPC(object oPC)
{
    // Check the object is still valid
    if (!GetIsObjectValid(oPC))
        return;
    if (!GetIsPC(oPC) || (GetLocalInt(oPC, "CanUseNewbieStore") != TRUE))
        return;
    if (GetLocalInt(oPC, "NewbieGreeted") == TRUE)
        return;

    // Find the merchant
    object oNewbieM = GetObjectByTag("NewbieM");
    if (!GetIsObjectValid(oNewbieM))
        return;

    // If the PC is in a different area to the Merchant
    if (GetAreaFromLocation(GetLocation(oNewbieM)) != GetAreaFromLocation(GetLocation(oPC)))
        return;

    AssignCommand(oNewbieM, ActionDoCommand(SetFacingPoint(GetPosition(oPC))));
    AssignCommand(oNewbieM, SpeakString("Hey " + GetName(oPC) + ".  Over here!"));
    SetLocalInt(oPC, "NewbieGreeted", TRUE);
}

void TakePosessedItem(object oPC, string sTag)
{
    object oItemToTake = GetItemPossessedBy(oPC, sTag);
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    if(GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC)) == sTag)
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC)) == sTag)
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)) == sTag)
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)) == sTag)
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)) == sTag)
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
}

void CreateStar(object oPC)
{
    CreateItemOnObject("staroftheocean", oPC, 1);
}

void main()
{
    object oPC = GetEnteringObject();

    // Remove items from the player's inventory
    TakePosessedItem(oPC, "DunravensBattleArmor");
    TakePosessedItem(oPC, "DunravensAxe");
    TakePosessedItem(oPC, "DunravenSignetRing");
    TakePosessedItem(oPC, "LordTyrmonIlkSuit");
    TakePosessedItem(oPC, "LordTyrmonsIlkRapier");
    TakePosessedItem(oPC, "wizretreatstaff");
    TakePosessedItem(oPC, "wizardretreatrobe");
    TakePosessedItem(oPC, "VeiloftheMoon");
    TakePosessedItem(oPC, "DaggeroftheMoon");
    TakePosessedItem(oPC, "wizretreatstaff_NOD");
    TakePosessedItem(oPC, "wizardretreatrobe_NOD");
    TakePosessedItem(oPC, "VeiloftheMoon_NOD");
    TakePosessedItem(oPC, "DaggeroftheMoon_NOD");

    // Search for Star of the Ocean rings
    object oItem = GetFirstItemInInventory(oPC);
    int bHasRing = FALSE;
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "pirateguildring")
        {
            bHasRing = TRUE;
            DelayCommand(1.0f, DestroyObject(oItem));
        }
        oItem = GetNextItemInInventory(oPC);
    }

    if(GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC)) == "pirateguildring")
    {
        DelayCommand(1.0f, DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC)));
        bHasRing = TRUE;
    }
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC)) == "pirateguildring")
    {
        DelayCommand(1.0f, DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC)));
        bHasRing = TRUE;
    }

    if (bHasRing)
        DelayCommand(2.0f, CreateStar(oPC));

    // If the player is stuck in ghost form... (Robin)
    int iAppearanceType = GetAppearanceType(oPC);
    if ((iAppearanceType == APPEARANCE_TYPE_ALLIP) || (iAppearanceType == APPEARANCE_TYPE_WRAITH))
    {
        switch (GetRacialType(oPC))
        {
            case RACIAL_TYPE_DWARF:    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DWARF);    break;
            case RACIAL_TYPE_ELF:      SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ELF);      break;
            case RACIAL_TYPE_GNOME:    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GNOME);    break;
            case RACIAL_TYPE_HALFELF:  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ELF); break;
            case RACIAL_TYPE_HALFLING: SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALFLING); break;
            case RACIAL_TYPE_HALFORC:  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ORC); break;
            case RACIAL_TYPE_HUMAN:    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN);    break;
        }
    }

    // Make the Newbie Merchant greet the player (Robin)
    if ((!GetIsPC(oPC)) ||(GetLocalInt(oPC, "CanUseNewbieStore") != TRUE))
        return;
    DelayCommand(12.0, NewbieGreetPC(oPC));
}
