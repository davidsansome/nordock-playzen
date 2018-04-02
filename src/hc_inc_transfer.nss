// Corpse include file
// HCR Archaegeo 2002
//#include "i_tagtests"



void hcTransferObjects(object oFrom, object oTo, int nDesPCT=0)
{
//    SendMessageToPC(oFrom,"Beginning Transfer");
    object oEquip = GetFirstItemInInventory(oFrom);
    object oContainer;
    object oInContainer;
    object oOwner;
    while(GetIsObjectValid(oEquip))
    {
        if(nDesPCT==2 && (GetTag(oEquip)=="PlayerCorpse" &&
            GetLocalString(oEquip,"Key")==GetPCPublicCDKey(oTo)))
        {
            oEquip=GetNextItemInInventory(oFrom);
            continue;
        }
        if(nDesPCT && GetTag(oEquip)=="PlayerCorpse" &&
            GetLocalString(oEquip,"Key")==GetPCPublicCDKey(oTo))
        {
            DestroyObject(oEquip);
            oEquip=GetNextItemInInventory(oFrom);
            continue;
        }
// Removed by Grug 18-Apr-2004 - nodrops are now set by item flag
//if (GetIsNoDrop(oEquip) == FALSE)
            //AssignCommand(oTo, ActionTakeItem(oEquip, oFrom));
            AssignCommand(oFrom,ActionGiveItem(oEquip,oTo));
        oEquip = GetNextItemInInventory(oFrom);
    }


}



