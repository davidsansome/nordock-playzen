//::///////////////////////////////////////////////
//:: FileName galdorreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 7:30:57 PM
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "rr_persist"
#include "journal_include"

void main()
{

    object oPC = GetPCSpeaker();
    object oItemToTake;
    object oArea = GetArea(OBJECT_SELF);

        if (!GPI(oPC,"nMainQuest"))
        {
            if (!HasItem(oPC,"PendantWing"))
                CreateItemOnObject("pendantwing",oPC,1);
            oItemToTake = GetItemPossessedBy(oPC, "InodrioBasementKey");
            if(GetIsObjectValid(oItemToTake) != 0)
                DestroyObject(oItemToTake);
            oItemToTake = GetItemPossessedBy(oPC, "SummonRoomgatekey");
            if(GetIsObjectValid(oItemToTake) != 0)
                DestroyObject(oItemToTake);
            oItemToTake = GetItemPossessedBy(oPC, "TokenofPossession");
            if(GetIsObjectValid(oItemToTake) != 0)
                DestroyObject(oItemToTake);
            oItemToTake = GetItemPossessedBy(oPC, "BTokenofPossession");
            if(GetIsObjectValid(oItemToTake) != 0)
                DestroyObject(oItemToTake);
            SPI(oPC,"nMainQuest",TRUE);
            dhAddJournalQuestEntry("mainquest", 9, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
        }
}
