// routines for equipment breakage
// should be called everytime a monster does damage or a player damages a monster

void rr_check_weap_break(object oPC)
{
    int BREAK_CHANCE = 5000;    // chance that something will break (1 in break_chance)
    int break_check = Random(BREAK_CHANCE);
    object oBreak;
    string sLoc;
    SendMessageToPC(oPC, "Rolled a "+IntToString(break_check)+" on the weapon break check");
    if (break_check==1)
    {
        if (!(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)==OBJECT_INVALID))
        {
            switch (d2())
            {
                case 1: if (!(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC)==OBJECT_INVALID))
                        {
                         oBreak=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
                         sLoc="Right hand item just broke";
                        }
                        break;
                case 2: if (!(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
                            sLoc="Left hand item just broke";
                        }
                        break;
            }
        }
        else if (!(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
                            sLoc="Right hand item just broke";
                        }
        if (!GetPlotFlag(oBreak))
        {
            DestroyObject(oBreak);
            FloatingTextStringOnCreature(sLoc,oPC,FALSE);
        }

    }
}

void rr_check_equip_break(object oPC)
{
    int BREAK_CHANCE = 5000;    // chance that something will break (1 in break_chance)
    int break_check = Random(BREAK_CHANCE);
    object oBreak;
    string sLoc;
    SendMessageToPC(oPC, "Rolled a "+IntToString(break_check)+" on the equip break check");
    if (break_check==1)
    {
    int b_item=Random(9);
    switch (b_item)
            {
                case 0: if (!(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
                         sLoc="Right ring item just broke";
                        }
                        break;
                case 1: if (!(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
                            sLoc="Left ring item just broke";
                        }
                        break;
                case 2: if (!(GetItemInSlot(INVENTORY_SLOT_ARMS,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
                            sLoc="Arms item just broke";
                        }
                        break;
                case 3: if (!(GetItemInSlot(INVENTORY_SLOT_BELT,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
                            sLoc="Belt item just broke";
                        }
                        break;
                case 4: if (!(GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
                            sLoc="Boots item just broke";
                        }
                        break;
                case 5: if (!(GetItemInSlot(INVENTORY_SLOT_CHEST,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
                            sLoc="Chest item just broke";
                        }
                        break;
                case 6: if (!(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
                            sLoc="Cloak item just broke";
                        }
                        break;
                case 7: if (!(GetItemInSlot(INVENTORY_SLOT_HEAD,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
                            sLoc="Head item just broke";
                        }
                        break;
                case 8: if (!(GetItemInSlot(INVENTORY_SLOT_NECK,oPC)==OBJECT_INVALID))
                        {
                            oBreak=GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
                            sLoc="Neck item just broke";
                        }
                        break;
            }
            if (!GetPlotFlag(oBreak))
            {
                DestroyObject(oBreak);
                FloatingTextStringOnCreature(sLoc,oPC,FALSE);
            }
    }
}

