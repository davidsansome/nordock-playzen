//::///////////////////////////////////////////////
//:: Name  0_ntfm_inc
//:: Copyright (c) 2005 Eagware Corp.
//:://////////////////////////////////////////////
/*
  Custom Commands for NTFM's Nordock-Playzen
*/
//:://////////////////////////////////////////////
//:: Created By: EagleC
//:: Created On: 1/1/05
//:://////////////////////////////////////////////

// Checks oArea for the object with the tag "BLOCK_PORTAL"
// if found it responds FALSE, otherwise TRUE
int GetAllowTeleport(object oArea);

// Destroys a single equiped item randomly from oPC
void NukeMuppetsEquipment(object oPC);

// cycles through the objects inventory and removes all but 10 heal potions
void StripExcessPotions(object oPC);
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

int GetAllowTeleport(object oArea)
{
object oObject=GetFirstObjectInArea(oArea);

while (oObject!=OBJECT_INVALID)
    {
    if (GetTag(oObject)=="BLOCK_PORTAL") return FALSE;
    oObject=GetNextObjectInArea(oArea);
    }
return TRUE;
}


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

void NukeMuppetsEquipment(object oPC)
{
object oItem;
int nSlot=Random(14);
    switch(nSlot)
        {
        case 0:
            oItem=GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
            break;

        case 1:
            oItem=GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
            break;

        case 2:
            oItem=GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
            break;

        case 3:
            oItem=GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
            break;

        case 4:
            oItem=GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
            break;

        case 5:
            oItem=GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
            break;

        case 6:
            oItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC);
            break;

        case 7:
            oItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
            break;

        case 8:
            oItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
            break;

        case 9:
            oItem=GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
            break;

        case 10:
            oItem=GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
            break;

        case 11:
            oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
            break;

        case 12:
            oItem=GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
            break;

        case 13:
            oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
            break;

        case 14:
            oItem=GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
            break;
        }

if (oItem!=OBJECT_INVALID)
    {
    string sText=GetName(oItem)+" was destroyed by the burst of energy";
    SendMessageToPC(oPC, sText);
    DestroyObject(oItem);
    }

}


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

void StripExcessPotions(object oPC)
{
object oItem, oNew;
string sItemTag, sText;
int i, nStack, nNewStack, nMessage;
  i= 0;
  sText = "Oh dear, something has just broken in your pack...";
  nMessage = FALSE;
  oItem = GetFirstItemInInventory(oPC);

while (oItem!=OBJECT_INVALID)
    {
    sItemTag=GetTag(oItem);
    if (sItemTag == "NW_IT_MPOTION012")
        {
        if (i>9)
            {
            DestroyObject(oItem);
            nMessage = TRUE;
            }
        else
            {
            nStack = GetItemStackSize(oItem);
            i = i + nStack;
            if (i>10)
                {
                nNewStack=nStack-(i-10);
                SetItemStackSize(oItem, nNewStack);
                i=10;
                nMessage = TRUE;
                }
            }
        }
    // get the next item from the PC
    oItem = GetNextItemInInventory(oPC);
    }
// if we've removed some heals then send the pc the message
if (nMessage) SendMessageToPC(oPC, sText);
}
