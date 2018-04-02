#include "hc_text_traps"

void triggerTrap(object oTrap, object oVictim);

void main()
{
    object oPC = GetPCSpeaker();
    SendMessageToPC(oPC, DISARMING);

    if (oPC != OBJECT_INVALID)
    {
        int nRogueLevel = GetLevelByClass(CLASS_TYPE_ROGUE, oPC);
        int nSkillMod = GetLocalInt(oPC, "nSkillMod");
        object oTrappedItem = GetLocalObject(oPC, "oToolTarget");
        int iTrapDC = GetTrapDisarmDC(oTrappedItem) - 100;
        int bCanDisarmTrap = FALSE; // Assume that the person cannot spot a trap.
        // Determine spotting capability
        if ((iTrapDC <= 20) || ((iTrapDC > 20) && (nRogueLevel >= 1)))
            bCanDisarmTrap = TRUE;
        // Only check to see if detected if not previously detected
        // and the PC has the ability to do detect it.
        int nFeatMod;

        if (bCanDisarmTrap)
        {
            int nDisarm = GetSkillRank(SKILL_DISABLE_TRAP, oPC);
            int nDice = d20();
            if (nDice<20 && GetHasFeat(FEAT_SKILL_MASTERY,oPC))
               {
               nFeatMod = 21-nDice-d4();
               if (nFeatMod<1) nFeatMod=1;
               nDisarm=nDisarm+nFeatMod;
               }
            int nDCCheck = nDice + nDisarm + nSkillMod;
            if (nDCCheck >= iTrapDC && nDisarm >= 1) // Trap disarmed
            {
                SetTrapDisabled(oTrappedItem);
                SendMessageToPC(oPC, DISARMED);
        // Edit by EagleC to work out potential XP reward
                int iSM = nDisarm+nSkillMod;
                int iLM = FloatToInt((41.0-IntToFloat(nRogueLevel))/5);
                if (iLM <1) iLM=1;
                int iAward = iTrapDC-iSM;
                if (iAward<1) iAward = 1;
                iAward = iAward*iLM;
                GiveXPToCreature(oPC,iAward);
        // end of edit by EagleC
            }
            else if ((nDCCheck - iTrapDC) < -4)
            {
                SendMessageToPC(oPC, TRAPTRIGGERED);
                triggerTrap(oTrappedItem, oPC);
            }
            else
                SendMessageToPC(oPC, FAILDISARM);
        }
        else
        {
            triggerTrap(oTrappedItem, oPC);
        }

        DeleteLocalObject(oPC, "oToolTarget");
        DeleteLocalInt(oPC, "nSkillMod");

    }
}

void triggerTrap(object oTrappedObject, object oVictim)
{
    switch (GetObjectType(oTrappedObject))
    {
        case OBJECT_TYPE_DOOR:
            AssignCommand(oVictim, ActionDoCommand(SetLocked(oTrappedObject, FALSE)));
            AssignCommand(oVictim, ActionOpenDoor(oTrappedObject));
            AssignCommand(oVictim, ActionDoCommand(SetLocked(oTrappedObject, TRUE)));
            break;
        case OBJECT_TYPE_PLACEABLE:
            AssignCommand(oVictim, ActionInteractObject(oTrappedObject));
            break;
        case OBJECT_TYPE_TRIGGER:
            AssignCommand(oVictim, ActionForceMoveToLocation(GetLocation(oTrappedObject)));
            break;
    }
}
