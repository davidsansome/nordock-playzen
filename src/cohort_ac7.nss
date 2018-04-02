//cohort_ac7, built from nw_ch_ac7
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.
/*
    v1.0.6  Added PW Cohort support.
*/
#include "cohort_inc"

object myMaster;
object realMaster;

void main()
{
    int iCurrentHitPoints=GetCurrentHitPoints(OBJECT_SELF);
    int nBleed=GetLocalInt(GetModule(),"BLEEDSYSTEM");

    realMaster = GetRealMaster();
    myMaster = GetMaster();

    SetDidDie(TRUE);
    //SetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED", TRUE);
    ClearAllActions();
    SetLocalInt(OBJECT_SELF, "NEGATIVEHP", iCurrentHitPoints);
    DeleteLocalInt(oMod,"DR_APPLIED" + GetName(OBJECT_SELF));

    // Unequip all items
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        ActionUnequipItem(oItem);
        oItem = GetNextItemInInventory();
    }

    /*if (iCurrentHitPoints==0 && nBleed) { //They are just disabled
        SPS(OBJECT_SELF, PWS_PLAYER_STATE_DISABLED);
        PlayVoiceChat(VOICE_CHAT_HEALME);
        DeleteLocalInt(oMod,"DR_APPLIED" + GetName(OBJECT_SELF));
        DelayCommand(6.0,ExecuteScript("cohort_bleed", OBJECT_SELF));
    }
    else */if (nBleed && iCurrentHitPoints > -10) {
        SPS(OBJECT_SELF, PWS_PLAYER_STATE_DYING);
        PlayVoiceChat(VOICE_CHAT_NEARDEATH);

        // If using lootable corpses, make one now and move UNEQUIPPED items to it
        if(GetLocalInt(oMod,"LOOTSYSTEM") && iCurrentHitPoints!=0) {
            location lDiedHere = GetLocation(OBJECT_SELF);
            object oDeathCorpse = GetLocalObject(oMod,"DeathCorpse" + GetName(OBJECT_SELF));
            // If no death corpse exists, make one
            if(GetIsObjectValid(oDeathCorpse)==FALSE) {
                oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DyingCorpse", lDiedHere);
                string sID = GetTag(OBJECT_SELF);
                SetLocalObject(oMod,"DeathCorpse" + sID, oDeathCorpse);
                SetLocalObject(oDeathCorpse,"Owner",OBJECT_SELF);
                SetLocalString(oDeathCorpse,"Name",GetName(OBJECT_SELF));
                SetLocalString(oDeathCorpse,"Key",sID);
            }
            // Move all unequipped items to the death corpse
            hcTransferObjects(OBJECT_SELF, oDeathCorpse);
        }
        //DelayCommand(6.0,ExecuteScript("cohort_bleed", OBJECT_SELF));
    }
    else {
        PlayVoiceChat(VOICE_CHAT_DEATH);
        RemoveCohort(realMaster);
        SendDeadCohortToRepository(realMaster);
    }
    if (GPS(OBJECT_SELF)!=PWS_PLAYER_STATE_DEAD)
        DelayCommand(0.1, AddHenchman(myMaster));

}
