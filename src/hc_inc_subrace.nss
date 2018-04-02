int SUBRACESYSTEM=1;

void destroy_slot(int nInventorySlot, object oPC)
{
    object oItem = GetItemInSlot(nInventorySlot, oPC);
    if (GetIsObjectValid(oItem))
        DestroyObject(oItem);
}

void give_racial_attributes(string sRacialArmor, object oPC)
{
    object oRacialArmor = CreateItemOnObject(sRacialArmor, oPC);
        AssignCommand(oPC, ActionEquipItem(oRacialArmor, INVENTORY_SLOT_CWEAPON_L));
}

int use_pc_subrace()
{
    object oPC = GetEnteringObject();
    int nValid=0;
    string sSRItem="";
    if (GetIsPC(oPC))
    {
        destroy_slot(INVENTORY_SLOT_CARMOUR, oPC);
        destroy_slot(INVENTORY_SLOT_CWEAPON_B, oPC);
        destroy_slot(INVENTORY_SLOT_CWEAPON_L, oPC);
        destroy_slot(INVENTORY_SLOT_CWEAPON_R, oPC);
        string sSubRace = GetStringLowerCase(GetSubRace(oPC));
        int nRace = GetRacialType(oPC);
        if( nRace == RACIAL_TYPE_DWARF)
        {
            if (sSubRace == GetStringLowerCase("Gold Dwarf"))
            {
                sSRItem="golddwarfsubrace";
                nValid=1;
            }
            if (sSubRace == GetStringLowerCase("Shield Dwarf"))
            {
                nValid=1;
            }
        }
        if( nRace == RACIAL_TYPE_ELF)
        {
            if (sSubRace == GetStringLowerCase("Moon Elf"))
            {
                nValid=1;
            }
            if (sSubRace == GetStringLowerCase("Sun Elf"))
            {
                sSRItem="sunelfsubrace";
                nValid=1;
            }
            if (sSubRace == GetStringLowerCase("Wild Elf"))
            {
                sSRItem="wildelfsubrace";
                nValid=1;
            }
            if (sSubRace == GetStringLowerCase("Wood Elf"))
            {
                sSRItem="woodelfsubrace";
                nValid=1;
            }
        }
        if( nRace == RACIAL_TYPE_HALFLING)
        {
            if (sSubRace == GetStringLowerCase("Strongheart Halfling"))
            {
                sSRItem="strongheartsubrace";
                nValid=1;
            }
            if (sSubRace == GetStringLowerCase("Lightfoot Halfling"))
            {
                nValid=1;
            }
        }
    }
    if(sSRItem!="") give_racial_attributes(sSRItem, oPC);
    return nValid;
}

