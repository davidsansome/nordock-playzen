// hc_areanm_enter
// Hardcore Ruleset Wandering critter setup
// Archaegeo July 9, 2002

// To use:  Set WANDERCHANCE to the percent chance of a wandering creature
//          showing up if someone rests in the area.  Set WANDERSTRENGTH to
//          the summon creature table to be used (1-9).

// Be sure to use a different version of this file (rename it) for each area
// that you need different strength wandering monsters in.

// Place the file once changed in the Areas OnEnter script spot.  If you already
// have one there, just cut and paste the lines below, minus the void main() part.

#include "hc_inc_wandering"

void main()
{
    int WANDERCHANCE=10; // 10% chance, chance this for more or less
    int WANDERSTRENGTH=5; // Something from the Summon Creature V table

    int WANDERTIMER=5; // Check for wandering monsters every X minutes.


    if(WANDERTIMER)
    {
        if(GetLocalInt(OBJECT_SELF,"RANDOMCHECK") < (WANDERTIMER * 10))
        {
            SetLocalInt(OBJECT_SELF,"RANDOMCHECK",
                GetLocalInt(OBJECT_SELF,"RANDOMCHECK")+1);
            return;
        }
        DeleteLocalInt(OBJECT_SELF,"RANDOMCHECK");

        int bAllDeadInParty = TRUE;
        object oPC=GetFirstPC();


        while(GetIsObjectValid(oPC))
        {
            // Has this PC been checked for a wandering monster?
            // Is the PC a DM?
            if (GetLocalInt(oPC, "bChecked") == FALSE &&
                !GetIsDM(oPC))
            {
                // Not been checked, not a DM. so get party information first, and mark each
                // Party member as "checked" so that they are not
                // counted twice for a wandercheck.
                object oPartyMember = GetFirstFactionMember(oPC, TRUE);
                int bChecked = GetLocalInt(oPartyMember, "bChecked");
                while (oPartyMember != OBJECT_INVALID)
                {
                    bChecked = GetLocalInt(oPartyMember, "bChecked");
                    if (GetArea(oPartyMember)==OBJECT_SELF && !bChecked)
                    {
                        SetLocalInt(oPartyMember, "bChecked", TRUE);
                        if (GetCurrentHitPoints(oPartyMember) > 0)
                            bAllDeadInParty = FALSE;
                    }
                    //Get next party member
                    oPartyMember = GetNextFactionMember(oPC);
                }

                // Check for an encounter if in the same area.
                //if (GetArea(oPC)==OBJECT_SELF && !bAllDeadInParty && !GetIsInCombat(oPC))
                //    wander_check(oPC, WANDERCHANCE, WANDERSTRENGTH);
            }

            // Reset variables and go to the next PC.
            bAllDeadInParty = TRUE;
            oPC=GetNextPC();
        }

        // Remove bChecked
        oPC = GetFirstPC();
        {
            DeleteLocalInt(oPC, "bChecked");
            oPC = GetNextPC();
        }

    }
}
