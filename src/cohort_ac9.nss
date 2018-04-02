//cohort_ac9, built from nw_ch_ac9
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

/*
    v1.0.6  - Added PW Cohort support. Quite pleased with this ammendment.
              This shows by the fact it's got comments :)

    v1.0.3  - Added SpawnInCondition for custom heartbeat event.
*/
#include "cohort_inc_pw"
#include "r_hen_command"

void main()
{
    SetAssociateListenPatterns();//Sets up the special henchmen listening patterns
    SetListeningPatterns();      // Goes through and sets up which shouts the NPC will listen to.
    SetAssociateRelayPatterns();

    SetAssociateState(NW_ASC_POWER_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE); //User ranged weapons by default if true.
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);

    SetIsDestroyable(FALSE,TRUE,TRUE);


    //SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
    SetAssociateStartLocation();
    // SPECIAL CONVERSATION SETTTINGS
    //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
    //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
            // This causes the creature to say a special greeting in their conversation file
            // upon Perceiving the player. Attach the [NW_D2_GenCheck.nss] script to the desired
            // greeting in order to designate it. As the creature is actually saying this to
            // himself, don't attach any player responses to the greeting.


// CUSTOM USER DEFINED EVENTS
/*
    The following settings will allow the user to fire one of the blank user defined events in the NW_D2_DefaultD.  Like the
    On Spawn In script this script is meant to be customized by the end user to allow for unique behaviors.  The user defined
    events user 1000 - 1010
*/
    SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007

// ADDITIONAL COHORT SYSTEM FLAGS.
/*
    The following flags can be uncommented or edited to further customise the cohorts behaviour. As these are stored in the
    spawn script, you can create multiple instance with slightly different behavioural patterns
*/

    if((SEEKEMPLOYMENT) && (USELEADERSHIP)) { SetCohortEmploymentSeek(OBJECT_SELF); }

    // special persistent magic.
    if(PWCOHORT)
    {
        string sTag = GetTag(OBJECT_SELF);
        object oModule = GetModule();

        // check to see if this cohort has been spawned before.
        if(GetIsObjectValid(GetAreaFromLocation(GetPersistentLocation(OBJECT_SELF, "PV_START_LOCATION"))))
        {

            //check to see if we are the same level compared to the world state.
            if(GetPersistentInt(OBJECT_SELF, "HitDice") != GetHitDice(OBJECT_SELF))
            {
                string sLevel = IntToString(GetPersistentInt(OBJECT_SELF, "HitDice"));
                if (GetStringLength(sLevel) == 1)
                    sLevel = "0" + sLevel;
                sLevel = "0" + sLevel;
                string sNewFile = sTag + sLevel;

                CreateObject(OBJECT_TYPE_CREATURE, sNewFile, GetPersistentLocation(OBJECT_SELF, "PV_START_LOCATION"));
                SetIsDestroyable(TRUE,FALSE,FALSE);
                DestroyObject(OBJECT_SELF, 1.0);
            }
            else
            {
                SetDidDie(TRUE); //Just so we'll offer to re-join our master.

                /* We're the correct iteration of ourselves, so reload last saved state,
                This include items, gold and health status. We'll also re-equip. */
                PWCohort_RestoreState();
            }
        }
        else
        {
            // Set initial Cohort state.
            PWCohort_InitState();
        }
    }
}
