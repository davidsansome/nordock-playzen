#include "hc_text_activate"
void main()
{
    int nFeatMod;
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    string sItemTag=GetLocalString(oUser,"TAG");
    DeleteLocalString(oUser,"TAG");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
        if (GetDistanceBetweenLocations(GetLocation(oUser),
                GetLocation(oOther)) > FeetToMeters(20.0))
            SendMessageToPC(oUser, MOVECLOSER);
        else
        {
            int nSkillMod = 0;
            int nTrapped=GetIsTrapped(oOther);
            int nDetected=GetTrapDetectedBy(oOther, oUser);
            if (sItemTag == "thievesToolsMaster") nSkillMod = 2;

            // Check to see if the item is trapped, and if the trap is detected
            if (nTrapped && nDetected)
            {
                SetLocalObject(oUser, "oToolTarget", oOther);
                SetLocalInt(oUser, "nSkillMod", nSkillMod);
                AssignCommand(oUser, ActionStartConversation(oUser, "hc_c_thieftool", TRUE));
            }
            else if (nTrapped && !nDetected)
            {
                switch (GetObjectType(oOther))
                {
                case OBJECT_TYPE_DOOR:
                    AssignCommand(oUser, ActionDoCommand(SetLocked(oOther, FALSE)));
                    AssignCommand(oUser, ActionOpenDoor(oOther));
                    AssignCommand(oUser, ActionDoCommand(SetLocked(oOther, TRUE)));
                    break;
                case OBJECT_TYPE_PLACEABLE:
                    AssignCommand(oUser, ActionInteractObject(oOther));
                    break;
                case OBJECT_TYPE_TRIGGER:
                    AssignCommand(oUser, ActionForceMoveToObject(oOther));
                    break;
                }
            }
            else if (GetLocked(oOther))
            {
                int nRogueLevel;
                int iTrapDC = GetLockUnlockDC(oOther) - 100;
                int nUnlock = GetSkillRank(SKILL_OPEN_LOCK, oUser);
                int nDice = d20();
                if (nDice<20 && GetHasFeat(FEAT_SKILL_MASTERY,oUser))
                   {
                   nFeatMod = 21-nDice-d4();
                     if (nFeatMod<1) nFeatMod=1;
                   nUnlock=nUnlock+nFeatMod;
                   }
                int nDCCheck = nDice + nUnlock + nSkillMod;
                if (nDCCheck >= iTrapDC && (nUnlock >= 1)) // Door Unlocked
                {
                    SetLocked(oOther, FALSE);
                    SendMessageToPC(oUser, UNLOCK);
                   // Now to award Some XP
                   // Edit by EagleC to work out potential XP reward
                   if (GetLocalObject(oOther, "LockedBy")!=oUser)
                   {
                      nRogueLevel = GetLevelByClass(CLASS_TYPE_ROGUE, oUser);
                      int iSM = nUnlock+nSkillMod;
                      int iLM = FloatToInt((41.0-IntToFloat(nRogueLevel))/5);
                      int iAward = iTrapDC-iSM;
                       if (iLM <1) iLM=1;
                       if (iAward<1) iAward = 1;
                      iAward = iAward*iLM;
                      GiveXPToCreature(oUser,iAward);
                   }
                   // end of edit by EagleC
                }
                else
                {
                    SendMessageToPC(oUser, FAILUNLOCK);
                    if(d100() < (iTrapDC/2))
                    {
                        DestroyObject(oItem);
                        SendMessageToPC(oUser, TOOLBREAK);
                    }
                }
            }
            // added to allow theives tool to LOCK things
            else if (GetLockLockable(oOther) && !GetLocked(oOther))
            {
                int iLockDC = GetLockLockDC(oOther) - 100;
                int nLock = GetSkillRank(SKILL_OPEN_LOCK, oUser);
                int nDice = d20();
                if (nDice<20 && GetHasFeat(FEAT_SKILL_MASTERY,oUser))
                   {
                   nFeatMod = 21-nDice-d4();
                     if (nFeatMod<1) nFeatMod=1;
                   nLock=nLock+nFeatMod;
                   }
                int nDCCheck = nDice + nLock + nSkillMod;
                if (nDCCheck >= iLockDC && (nLock >= 1)) // Door locked
                {
                    SetLocked(oOther, TRUE);
                    SendMessageToPC(oUser, LOCK);
                    SetLocalObject(oOther,"LockedBy",oUser);
                }
                else
                {
                    SendMessageToPC(oUser, FAILLOCK);
                    if(d100() < (iLockDC/2))
                    {
                        DestroyObject(oItem);
                        SendMessageToPC(oUser, TOOLBREAK);
                    }
                }
               // end of lock addition
            }
        }
}
