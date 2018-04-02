//::///////////////////////////////////////////////
//:: FileName henchmanequip      v 0.55
//:://////////////////////////////////////////////
//:: This script will cause the henchman to equip the items that
//:: are "in limbo" as a result of the bag of holding having been
//:: deleted.
//:://////////////////////////////////////////////
//:: Created By: Pausanias
//:: Created On: 6/28/2002 20:43:15
//:://////////////////////////////////////////////

// For now, we are assuming that the PC is playing the Official
// Campaign. Therefore we will check the henchman's preferred weapon.

/*
    v1.0.6  - Changed GetTag(oItem) to GetResRef(oItem) on Line 51.
            - Known Issue: Occasionally lose items when transferring in nwn v1.25
            I can't find a fix :(
*/
#include "paus_inc_generic"
#include "paus_i0_array"

void main()
{
    object oBag, oItem, oPC, oSelf, oNew;
    int    i, j, iIdent;

    oSelf = OBJECT_SELF;
    oPC = GetLocalObject(OBJECT_SELF,"MyPC");

    // This is the bag created by the henchmanmanage script.
    oBag = GetLocalObject(OBJECT_SELF,"HenchBag");

    SetAssociateState(NW_ASC_IS_BUSY,TRUE);

    // The number of items on PC just before bag was deleted was set
    // by henchmanequip

    int iInd = GetLocalInt(oPC,"NItem");
    if (oBag != OBJECT_INVALID) {

        // Find the monk's outfit used to prevent the Henchman from being naked
        object oDecency = GetLocalObject(OBJECT_SELF,"Decency");

        int nTransfer = 0;
        for (i = 1; i <= NUM_INVENTORY_SLOTS; ++i) {
            oItem = MyGetObjectArray(oPC,"ItemArr",i);
            if (GetIsObjectValid(oItem) && oItem != oDecency) {
                // SpeakString(GetName(oItem)+GetName(GetItemPossessor(oItem)));
                if (!GetIsObjectValid(GetItemPossessor(oItem))) {
                   ++nTransfer;
                   int iStackSize = MyGetIntArray(oPC,"ItemCnt",i);
                   oNew = CreateItemOnObject(GetResRef(oItem),oSelf,iStackSize);
                   //SendMessageToPC(oPC, "(cohortdlg_infvin) Created " + GetName(oNew)); //DEBUG.
                   if (MyGetIntArray(oPC,"IdentArr",i))
                        SetIdentified(oNew,TRUE);
                   DestroyObject(oItem,0.2);
                }
            }
        }

        // Destroy the monk's robe if it's there.
        if (GetIsObjectValid(oDecency))
            DestroyObject(oDecency);

        // If no items were transferred, we are either running NWN v1.24+,
        // or we are receiving an empty bag. In either case, it is safe to
        // run henchmanxfer without crashing NWN.
        if (nTransfer == 0) {
            SetLocalObject(oBag,"TransferTo",OBJECT_SELF);
            ExecuteScript("henchmanxfer",oBag);
        }

        ExecuteScript("cohort_equip",OBJECT_SELF);

        // This tells the dialogue tree that the PC no longer has henchman's
        // inventory.
        SetLocalInt(OBJECT_SELF,"HenchmanInv",0);
    }

    // Try to conform with the Official Campaign's melee/missile format.
    EquipAppropriateWeapons(OBJECT_SELF);
    SetAssociateState(NW_ASC_IS_BUSY,FALSE);
}

