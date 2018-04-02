//::///////////////////////////////////////////////
//:: Generic Scripting Include v1.0
//:: NW_I0_GENERIC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    ********************************************
    WARNING THIS SCRIPT IS CHANGED AT YOUR PERIL
    ********************************************

    This is the master generic script and currently
    handles all combat and some plot behavior
    within NWN. If this script is tampered
    with there is a chance of introducing game
    breaking bugs.  But other than that enjoy.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 20, 2001
//:://////////////////////////////////////////////

//GENERIC STRUCTURES

struct sEnemies
{
    int FIGHTERS;
    int FIGHTER_LEVELS;
    int CLERICS;
    int CLERIC_LEVELS;
    int MAGES;
    int MAGE_LEVELS;
    int MONSTERS;
    int MONTERS_LEVELS;
    int TOTAL;
    int TOTAL_LEVELS;
};

//Flee and move constants
int NW_GENERIC_FLEE_EXIT_FLEE = 0;
int NW_GENERIC_FLEE_EXIT_RETURN = 1;
int NW_GENERIC_FLEE_TELEPORT_FLEE = 2;
int NW_GENERIC_FLEE_TELEPORT_RETURN = 3;

//Shout constants
int NW_GENERIC_SHOUT_I_WAS_ATTACKED = 1;    // NOT USED
int NW_GENERIC_SHOUT_I_AM_DEAD = 12;        //IN OnDeath Script
int NW_GENERIC_SHOUT_BACK_UP_NEEDED = 13;   //IN TalentMeleeAttacked
int NW_GENERIC_SHOUT_BLOCKER = 2;

//Master Constants
int NW_FLAG_SPECIAL_CONVERSATION        = 0x00000001;
int NW_FLAG_SHOUT_ATTACK_MY_TARGET      = 0x00000002;
int NW_FLAG_STEALTH                     = 0x00000004;
int NW_FLAG_SEARCH                      = 0x00000008;
int NW_FLAG_SET_WARNINGS                = 0x00000010;
int NW_FLAG_ESCAPE_RETURN               = 0x00000020; //Failed
int NW_FLAG_ESCAPE_LEAVE                = 0x00000040;
int NW_FLAG_TELEPORT_RETURN             = 0x00000080; //Failed
int NW_FLAG_TELEPORT_LEAVE              = 0x00000100;
int NW_FLAG_PERCIEVE_EVENT              = 0x00000200;
int NW_FLAG_ATTACK_EVENT                = 0x00000400;
int NW_FLAG_DAMAGED_EVENT               = 0x00000800;
int NW_FLAG_SPELL_CAST_AT_EVENT         = 0x00001000;
int NW_FLAG_DISTURBED_EVENT             = 0x00002000;
int NW_FLAG_END_COMBAT_ROUND_EVENT      = 0x00004000;
int NW_FLAG_ON_DIALOGUE_EVENT           = 0x00008000;
int NW_FLAG_RESTED_EVENT                = 0x00010000;
int NW_FLAG_DEATH_EVENT                 = 0x00020000;
int NW_FLAG_SPECIAL_COMBAT_CONVERSATION = 0x00040000;
int NW_FLAG_AMBIENT_ANIMATIONS          = 0x00080000;
int NW_FLAG_HEARTBEAT_EVENT             = 0x00100000;
int NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS = 0x00200000;
int NW_FLAG_DAY_NIGHT_POSTING           = 0x00400000;
int NW_FLAG_AMBIENT_ANIMATIONS_AVIAN    = 0x00800000;
int NW_FLAG_APPEAR_SPAWN_IN_ANIMATION   = 0x01000000;
int NW_FLAG_SLEEPING_AT_NIGHT           = 0x02000000;
int NW_FLAG_FAST_BUFF_ENEMY             = 0x04000000;

//Behavior Constants
int NW_FLAG_BEHAVIOR_SPECIAL       = 0x00000001;
int NW_FLAG_BEHAVIOR_CARNIVORE     = 0x00000002; //Will always attack regardless of faction
int NW_FLAG_BEHAVIOR_OMNIVORE      = 0x00000004; //Will only attack if approached
int NW_FLAG_BEHAVIOR_HERBIVORE     = 0x00000008; //Will never attack.  Will alway flee.

//Talent Type Constants
int NW_TALENT_PROTECT = 1;
int NW_TALENT_ENHANCE = 2;

//PRIVATE FUNCTION DECLARATIONS

//Checks the target for a specific EFFECT_TYPE constant value
int GetHasEffect(int nEffectType, object oTarget = OBJECT_SELF);
//Adds all three of the class levels together.  Used before GetHitDice became available
int GetCharacterLevel(object oTarget);
//Returns the number of persons who are considered friendly to the the target.
int CheckFriendlyFireOnTarget(object oTarget, float fDistance = 5.0);
//Returns the number of enemies on a target.
int CheckEnemyGroupingOnTarget(object oTarget, float fDistance = 5.0);
//Find a single target who is an enemy with 30m of self
object FindSingleRangedTarget();
//Calculate the number of people currently attacking self.
int GetNumberOfMeleeAttackers();
//Calculate the number of people attacking self from beyond 5m
int GetNumberOfRangedAttackers();
//Determine the percentage of HP object-self has left
int GetPercentageHPLoss(object oWounded);
//Determine the number of targets within 20m that are of the specified racial-type
int GetRacialTypeCount(int nRacial_Type);
//Returns the nearest object that can be seen, then checks for the nearest heard target.
object GetNearestSeenOrHeardEnemy();
//Sets a local variable for the last spell used
void SetLastGenericSpellCast(int nSpell);
//Returns a SPELL_ constant for the last spell used
int GetLastGenericSpellCast();
//Compares the current spell with the last one cast
int CompareLastSpellCast(int nSpell);
//If using ambient sleep this will remove the effect
void RemoveAmbientSleep();
//Does a check to determine if the NPC has an attempted spell or attack target
int GetIsFighting(object oFighting);
//Searches for the nearest locked object to the master
object GetLockedObject(object oMaster);
//Equip the weapon appropriate to enemy and position
void EquipAppropriateWeapons(object oTarget);
//Returns the henchmen to a commandable state of grace
void ResetHenchmenState();
//Returns true if self is a henchmen
int AssociateCheck(object oCheck);
//Returns true if the object has any posts or waypoints to walk
int GetIsPostOrWalking(object oWalker = OBJECT_SELF);
//Prints a log string with the ID of the passed in talent.
void DubugPrintTalentID(talent tTalent);
//Inserts a debug print string into the log.
void MyPrintString(string sString);

//DETERMINE COMBAT ROUND SUB FUNCTIONS

int BashDoorCheck(object oIntruder = OBJECT_INVALID);
int DetermineClassToUse();
struct sEnemies DetermineEnemies();
string GetMostDangerousClass(struct sEnemies sCount);
int GetMatchCompatibility(talent tUse, string sClass, int nType);
int MatchCombatProtections(talent tUse);
int MatchSpellProtections(talent tUse);
int MatchElementalProtections(talent tUse);
talent StartProtectionLoop();
int GetAttackCompatibility(talent tUse, int nClass);
int MatchReflexAttacks(talent tUse);
int MatchFortAttacks(talent tUse);
object GetRangedAttackGroup(int bAllowFriendlyFire = FALSE);
int VerifyDisarm(talent tUse, object oTarget);
int VerifyCombatMeleeTalent(talent tUse, object oTarget);

//CURRENT TALENT FUNCTIONS
int TalentUseProtectionOnSelf();
int TalentUseProtectionOthers();
int TalentEnhanceOthers();
int TalentUseEnhancementOnSelf();
int TalentMeleeAttacked(object oIntruder = OBJECT_INVALID);
int TalentRangedAttackers(object oIntruder = OBJECT_INVALID);
int TalentRangedEnemies(object oIntruder = OBJECT_INVALID);
int TalentSummonAllies();
int TalentHealingSelf(); //Use spells and potions
int TalentHeal(int nForce = FALSE); //User spells only on others and self
int TalentMeleeAttack(object oIntruder = OBJECT_INVALID);
int TalentSneakAttack();
int TalentFlee(object oIntruder = OBJECT_INVALID);
int TalentUseTurning();
int TalentPersistentAbilities();
int TalentAdvancedBuff(float fDistance);
int TalentBuffSelf();  //Used for Potions of Enhancement and Protection
int TalentCureCondition();
int TalentDragonCombat(object oIntruder = OBJECT_INVALID);
int TalentBardSong();
int TalentAdvancedProtectSelf();
int TalentSpellAttack(object oIntruder);

// This block of functions were added by Jugalator
int TalentImportantArcaneSpells(int nClass);
int TalentImportantDivineSpells(int nClass);
int TalentImportantRangerSpells();
int TalentImportantPaladinSpells();
int GetAverageHD();
int Jug_AtLocation(int nSpellID, object oTarget, int iModifier, int iRequirement, int iChance = 100);
int Jug_AtObject(int nSpellID, object oTarget, int iModifier, int iRequirement, int iChance = 100);
int Jug_GetHasBeneficialEnhancement(object oTarget);
object Jug_GetNearestAlly();
int Jug_IsArcaneCaster(object oTarget = OBJECT_SELF);
int Jug_IsDivineCaster(object oTarget = OBJECT_SELF);
void Jug_Debug(string sString);

//CORE AI FUNCTIONS
void DetermineCombatRound(object oIntruder = OBJECT_INVALID, int nAI_Difficulty = 10);
void SetListeningPatterns();
void RespondToShout(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID);
void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0);
void WalkWayPoints(int nRun = FALSE, float fPause = 1.0);
void RunNextCircuit(int nRun = FALSE, float fPause = 1.0);
int CheckWayPoints(object oWalker = OBJECT_SELF);

//PLOT FUNCTIONS
void SetNPCWarningStatus(int nStatus = TRUE);
int GetNPCWarningStatus();
void SetSummonHelpIfAttacked();
void CreateSignPostNPC(string sTag, location lLocal);
void ActivateFleeToExit();
int GetFleeToExit();

//MASTER LOCAL FUNCTIONS
void SetSpawnInCondition(int nCondition, int bValid = TRUE);
int GetSpawnInCondition(int nCondition);
void SetSpawnInLocals(int nCondition);

//ASSOCIATE MASTER VARIABLE FUNCTIONS
void SetAssociateState(int nCondition, int bValid = TRUE);
int GetAssociateState(int nCondition);

//ASSOCIATE FUNCTIONS
int GetAssociateCRMax();
int GetAssociateHealMaster();
float GetFollowDistance();
void CheckIsUnlocked(object oLastObject);
void SetAssociateStartLocation();
location GetAssociateStartLocation();

//AMBIENT ANIMATION COMMANDS
void PlayMobileAmbientAnimations();
void PlayImmobileAmbientAnimations();

//BEHAVIOR LOCAL FUNCTIONS
void SetBehaviorState(int nCondition, int bValid = TRUE);
int GetBehaviorState(int nCondition);
void DetermineSpecialBehavior(object oIntruder = OBJECT_INVALID);

//::///////////////////////////////////////////////
//:: Master Local Get and Set
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All On Spawn in conditions in the game are now
    being stored within one local.  The get and set
    changed or checks the condition of this one
    Hex local.  The NW_FLAG_XXX variables above
    allow for the user of these functions throughout
    the generic scripts.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 14, 2001
//:://////////////////////////////////////////////

void SetSpawnInCondition(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetSpawnInLocals(nCondition);
        SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", nPlot);
    }
}

int GetSpawnInCondition(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

void SetSpawnInLocals(int nCondition)
{
    if(nCondition == NW_FLAG_SHOUT_ATTACK_MY_TARGET)
    {
        SetListenPattern(OBJECT_SELF, "NW_ATTACK_MY_TARGET", 5);
    }
    else if(nCondition == NW_FLAG_ESCAPE_RETURN)
    {
        SetLocalLocation(OBJECT_SELF, "NW_GENERIC_START_POINT", GetLocation(OBJECT_SELF));
    }
    else if(nCondition == NW_FLAG_TELEPORT_LEAVE)
    {
        SetLocalLocation(OBJECT_SELF, "NW_GENERIC_START_POINT", GetLocation(OBJECT_SELF));
    }
}

//::///////////////////////////////////////////////
//:: DetermineCombatRound
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function is the master function for the
    generic include and is called from the main
    script.  This function is used in lieu of
    any actual scripting.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

void DetermineCombatRound(object oIntruder = OBJECT_INVALID, int nAI_Difficulty = 10)
{

    if(GetAssociateState(NW_ASC_IS_BUSY))
    {
        return;
    }
    if(BashDoorCheck(oIntruder)) {return;}
    int nClass = DetermineClassToUse();

    //This check is to see if the master is being attacked and in need of help

    if(GetAssociateState(NW_ASC_HAVE_MASTER))
    {
        if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER))
        {
            oIntruder = GetLastHostileActor(GetMaster());
            if(!GetIsObjectValid(oIntruder))
            {
                oIntruder = GetGoingToBeAttackedBy(GetMaster());
                if(!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetLastHostileActor();
                    if(!GetIsObjectValid(oIntruder))
                    {
                        return;
                    }
                    else if(!GetIsEnemy(oIntruder))
                    {
                        oIntruder = OBJECT_INVALID;
                    }
                }
            }
        }
    }
    if(GetIsObjectValid(GetMaster()))
    {
        if(GetDistanceToObject(GetMaster()) > 15.0)
        {
            if(GetCurrentAction(GetMaster()) != ACTION_FOLLOW)
            {
                ClearAllActions();
                //ActionAttack(OBJECT_INVALID);
                ActionForceFollowObject(GetMaster(), GetFollowDistance());
                //ActionForceMoveToObject(GetMaster(), TRUE, GetFollowDistance(), 5.0);
                return;
            }
        }
    }

    int nOffense = d100();

    if(GetIsObjectValid(oIntruder) ||
       GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)) ||
       (GetIsObjectValid(oIntruder) && GetIsObjectValid(GetMaster())))
    {
        int nAlignment = GetAlignmentGoodEvil(OBJECT_SELF);
        //AM I AN ARCANE SPELLCASTER?
        if(nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_BARD)
        {
            if(nClass == CLASS_TYPE_BARD)
            {
                if(TalentHeal()) {return;}
                if(TalentBardSong()) {return;}
            }
            if(GetRacialType(OBJECT_SELF) != RACIAL_TYPE_ABERRATION ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_BEAST ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_ELEMENTAL ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_VERMIN ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_MAGICAL_BEAST ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_UNDEAD ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_DRAGON ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_ANIMAL)
            {
                //Use healing potions to not die
                if(TalentHealingSelf()) {return;}
            }

            // Added by Jugalator:
            if (TalentImportantArcaneSpells(nClass)) { return; }

            //Use a defensive talent fire then offensive if that fails
            if(nOffense > 75)
            {
                if(TalentAdvancedProtectSelf()){return;} //******************************************//
                //Use protections on Self
                if(TalentUseProtectionOnSelf()) {return;}
                //Use protection on allies
                if(TalentUseProtectionOthers()) {return;}
                //Check if the character can enhance themselves
                if(TalentUseEnhancementOnSelf()) {return;}
                //Use Enhancements on the part
                if(TalentEnhanceOthers()) {return;}
                //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                //Check for Allies
                if(TalentSummonAllies()) {return;}
                //Spell Attack
                if(TalentSpellAttack(oIntruder)) {return;}
                   //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            else //Use a offensive talent only
            {
                if(GetIsObjectValid(GetMaster()))
                {
                    if(TalentUseProtectionOthers()) {return;}
                    if(TalentEnhanceOthers()) {return;}
                }
                //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                 //Summon Allies
                if(TalentSummonAllies()) {return;}
                //Spell Attack
                if(TalentSpellAttack(oIntruder)) {return;}
                 //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            return;
        }
        else if((nClass == CLASS_TYPE_CLERIC || nClass == CLASS_TYPE_DRUID) && GetRacialType(OBJECT_SELF) != RACIAL_TYPE_UNDEAD)
        {
            //Cast spells specific to the main enemy I am facing.
            if(TalentAdvancedProtectSelf()) {return;} //******************************************//
            //Remove negative effects from allies
            if(TalentCureCondition()) {return;}
            //Turning check
            if(TalentUseTurning()) {return;}
            //Check if allies or self are injured
            if(TalentHeal()) {return;}
            //Use healing potions to not die
            if(TalentHealingSelf()) {return;}

            if(nOffense > 75)
            {
                if(GetNumberOfMeleeAttackers() > 1)
                {
                    if(TalentMeleeAttacked(oIntruder)) {return;}
                    if(TalentMeleeAttack(oIntruder)) {return;}
                }
                else if(GetNumberOfMeleeAttackers() == 1)
                {
                    if(TalentMeleeAttack(oIntruder)) {return;}
                }
                else
                {
                    // Added by Jugalator:
                    if (TalentImportantDivineSpells(nClass)) {return;}

                    //Check if the character can enhance themselves
                    if(TalentUseEnhancementOnSelf()) {return;}
                    // Check for enhancements on party
                    if(TalentEnhanceOthers()) {return;}
                    //Cast general protection on self
                    if(TalentUseProtectionOnSelf()) {return;}
                    //Check for Allies
                    if(TalentUseProtectionOthers()) {return;}
                    //Check for Allies
                    if(TalentSummonAllies()) {return;}
                     //Check for Personal Attackers
                    if(Random(101) > 75)
                    {
                        if(TalentMeleeAttacked(oIntruder)) {return;}
                    }
                     //Check for Ranged Attackers
                    if(TalentRangedAttackers(oIntruder)) {return;}
                     //Check for Ranged Enemies
                    if(TalentRangedEnemies(oIntruder)) {return;}
                     //Attack if out of spells
                    if(TalentMeleeAttack(oIntruder)) {return;}
                }
            }
            else
            {
                // Added by Jugalator:
                if (TalentImportantDivineSpells(nClass)) {return;}

                //Cast Summon Spells
                if(TalentSummonAllies()) {return;}
                 //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                //Spell Attack
                if(TalentSpellAttack(oIntruder)) {return;}
                 //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            return;
        }
        else if((nClass == CLASS_TYPE_CLERIC || nClass == CLASS_TYPE_DRUID) && GetRacialType(OBJECT_SELF) == RACIAL_TYPE_UNDEAD)
        {
            //Turning check
            if(TalentUseTurning()) {return;}
            if(nOffense > 75)
            {
                if(GetNumberOfMeleeAttackers() > 1)
                {
                    if(TalentMeleeAttacked(oIntruder)) {return;}
                    if(TalentMeleeAttack(oIntruder)) {return;}
                }
                else if(GetNumberOfMeleeAttackers() == 1)
                {
                    if(TalentMeleeAttack(oIntruder)) {return;}
                }
                else
                {
                    //Check if the character can enhance themselves
                    if(TalentUseEnhancementOnSelf()) {return;}
                    // Check for enhancements on party
                    if(TalentEnhanceOthers()) {return;}
                    //Cast general protection on self
                    if(TalentUseProtectionOnSelf()) {return;}
                    //Check for Allies
                    if(TalentUseProtectionOthers()) {return;}
                    //Check for Allies
                    if(TalentSummonAllies()) {return;}
                     //Check for Personal Attackers
                    if(Random(101) > 75)
                    {
                        if(TalentMeleeAttacked(oIntruder)) {return;}
                    }
                     //Check for Ranged Attackers
                    if(TalentRangedAttackers(oIntruder)) {return;}
                     //Check for Ranged Enemies
                    if(TalentRangedEnemies(oIntruder)) {return;}
                     //Attack if out of spells
                    if(TalentMeleeAttack(oIntruder)) {return;}
                }
            }
            else
            {
                //Cast Summon Spells
                if(TalentSummonAllies()) {return;}
                 //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                //Spell Attack
                if(TalentSpellAttack(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                 //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            return;
        }
        else if(nClass == CLASS_TYPE_FIGHTER ||
            nClass == CLASS_TYPE_ROGUE ||
            nClass == CLASS_TYPE_PALADIN ||
            nClass == CLASS_TYPE_RANGER ||
            nClass == CLASS_TYPE_MONK ||
            nClass == CLASS_TYPE_BARBARIAN)
        {
            if(GetRacialType(OBJECT_SELF) != RACIAL_TYPE_ABERRATION ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_BEAST ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_ELEMENTAL ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_VERMIN ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_MAGICAL_BEAST ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_UNDEAD ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_DRAGON ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_ANIMAL ||
               GetRacialType(OBJECT_SELF) != RACIAL_TYPE_CONSTRUCT)
            {
                //Use healing potions to not die
                if(TalentHealingSelf()) {return;}
                //Use potions of enhancement and protection
                if(TalentBuffSelf()) {return;}
            }

/*
 * DISABLED since 0.70 beta since the spell casting appear to be bugged.
 * I'll enable them in a future patch if I manage to get them to work,
 * but until then...
 */
/*
            // Added by Jugalator:
            if (nClass == CLASS_TYPE_RANGER) {
                if (TalentImportantRangerSpells()) { return; }
            } else if (nClass == CLASS_TYPE_PALADIN) {
                if (TalentImportantPaladinSpells()) { return; }
            }
*/
            //Check if the character can enhance themselves
            if(TalentUseEnhancementOnSelf()) {return;}
            //Check for Paladins who can turn undead
            if(TalentUseTurning()) {return;}
            //Sneak Attack Flanking attack
            if(TalentSneakAttack()) {return;}
            //Use melee skills and feats
            if(TalentMeleeAttack(oIntruder)) {return;}
            return;
        }
        else if(nClass == CLASS_TYPE_COMMONER)
        {
            if(TalentFlee(oIntruder)) {return;}
            return;
        }
        else if(nClass == CLASS_TYPE_UNDEAD)
        {
            //SpeakString("Determining Combat Round Undead");
            if(TalentPersistentAbilities()) {return;}

            // Added by Jugalator:
//            if (Jug_IsArcaneCaster())
//            {
                if (TalentImportantArcaneSpells(nClass)) {return;}
//            }
//            if (Jug_IsDivineCaster())
//            {
                if (TalentImportantDivineSpells(nClass)) {return;}
//            }

            if(nOffense > 75)
            {
                if(TalentAdvancedProtectSelf()){return;}
                //Check if the character can enhance themselves
                if(TalentUseEnhancementOnSelf()) {return;}
                // Check for enhancements on party
                if(TalentEnhanceOthers()) {return;}
                //Use protections on Self
                if(TalentUseProtectionOnSelf()) {;return;};
                //Check for Allies
                if(TalentUseProtectionOthers()) {return;}
                //Check for Allies
                if(TalentSummonAllies()) {return;}
                 //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                 //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            else
            {
                if(TalentSummonAllies()) {return;}
                 //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                //Spell Attack
                if(TalentSpellAttack(oIntruder)) {return;}
                 //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            return;
        }
        else if(nClass == CLASS_TYPE_DRAGON)
        {
            //Use healing
            if(TalentHeal()) {return;}
            if(TalentCureCondition()) {return;}
            if(d100() < 15)
            {
                if(TalentRangedEnemies(oIntruder)) {return;}
                if(TalentMeleeAttacked(oIntruder)) {return;}
            }
            if(TalentPersistentAbilities()) {return;}
            if(TalentAdvancedProtectSelf()){return;}
            if(TalentUseProtectionOnSelf()) {return;}
            if(TalentDragonCombat(oIntruder)) {return;}
        }
        else if (nClass == CLASS_TYPE_OUTSIDER)
        {
            if(TalentPersistentAbilities()) {return;}
            if(TalentSummonAllies()) {return;}
            if(d100() > 50)
            {
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            if(GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD)
            {
                if(TalentHeal()) {return;}
            }

            if(TalentHealingSelf()) {return;}

            // Added by Jugalator:
//            if (Jug_IsArcaneCaster())
//            {
                if (TalentImportantArcaneSpells(nClass)) {return;}
//            }
//            if (Jug_IsDivineCaster())
//            {
                if (TalentImportantDivineSpells(nClass)) {return;}
//            }

            if(TalentAdvancedProtectSelf()){return;}
            if(TalentUseProtectionOnSelf()) {return;}
            if(TalentUseEnhancementOnSelf()) {return;}
            if(TalentMeleeAttacked(oIntruder)) {return;}
            if(TalentRangedAttackers(oIntruder)) {return;}
            if(TalentRangedEnemies(oIntruder)) {return;}
            if(TalentSpellAttack(oIntruder)) {return;}
            if(TalentMeleeAttack(oIntruder)) {return;}
        }
        else if (nClass == CLASS_TYPE_CONSTRUCT || nClass == CLASS_TYPE_ELEMENTAL)
        {
            if(TalentPersistentAbilities()) {return;}
            if(TalentSummonAllies()) {return;}
            if(d100() > 50)
            {
                if(TalentMeleeAttack(oIntruder)) {return;}
            }

            // Added by Jugalator:
//            if (Jug_IsArcaneCaster())
//            {
                if (TalentImportantArcaneSpells(nClass)) {return;}
//            }
//            if (Jug_IsDivineCaster())
//            {
                if (TalentImportantDivineSpells(nClass)) {return;}
//            }
            if(TalentAdvancedProtectSelf()){return;}
            if(TalentUseProtectionOnSelf()) {return;}
            if(TalentUseEnhancementOnSelf()) {return;}
            if(TalentMeleeAttacked(oIntruder)) {return;}
            if(TalentRangedAttackers(oIntruder)) {return;}
            if(TalentRangedEnemies(oIntruder)) {return;}
            if(TalentSpellAttack(oIntruder)) {return;}
            if(TalentMeleeAttack(oIntruder)) {return;}
        }
        else
        {
            if(TalentPersistentAbilities()) {return;}
            //Check if I am injured
            if(TalentHeal()) {return;}
            if(nOffense > 75)
            {
            // Added by Jugalator:
//                if (Jug_IsArcaneCaster())
//                {
                    if (TalentImportantArcaneSpells(nClass)) {return;}
//                }
//                if (Jug_IsDivineCaster())
//                {
                    if (TalentImportantDivineSpells(nClass)) {return;}
//                }

                if(TalentAdvancedProtectSelf()){return;}
                //Check if the character can enhance themselves
                if(TalentUseEnhancementOnSelf()) {return;}
                // Check for enhancements on party
                if(TalentEnhanceOthers()) {return;}
                //Use protections on Self
                if(TalentUseProtectionOnSelf()) {return;}
                //Check for Allies
                if(TalentUseProtectionOthers()) {return;}
                //Check for Allies
                if(TalentSummonAllies()) {return;}
                 //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                 //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            else
            {
            // Added by Jugalator:
//                if (Jug_IsArcaneCaster())
//                {
                    if (TalentImportantArcaneSpells(nClass)) {return;}
//                }
//                if (Jug_IsDivineCaster())
//                {
                    if (TalentImportantDivineSpells(nClass)) {return;}
//                }

                if(TalentSummonAllies()) {return;}
                 //Check for Personal Attackers
                if(TalentMeleeAttacked(oIntruder)) {return;}
                 //Check for Ranged Attackers
                if(TalentRangedAttackers(oIntruder)) {return;}
                 //Check for Ranged Enemies
                if(TalentRangedEnemies(oIntruder)) {return;}
                 //Spell Attack
                if(TalentSpellAttack(oIntruder)) {return;}
                  //Attack if out of spells
                if(TalentMeleeAttack(oIntruder)) {return;}
            }
            return;
        }
    }
    //This check is to make sure that people do not drop out of combat before they are supposed to.
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    if(GetIsObjectValid(oTarget))
    {
        SpeakString("Danger Will Robinson Danger");
        DetermineCombatRound(oTarget);
        return;
    }
    //This is a call to the function which determines which way point to go back to.
    ClearAllActions();
    SetLocalObject(OBJECT_SELF, "NW_GENERIC_LAST_ATTACK_TARGET", OBJECT_INVALID);
    WalkWayPoints();
}

//::///////////////////////////////////////////////
//:: SetListeningPatterns
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the correct listen checks on the NPC by
    determining what talents they possess or what
    class they use.

    This is also a good place to set up all of
    the sleep and appear disappear animations for
    various models.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////

void SetListeningPatterns()
{
    //There is a 70% chance to make someone sleep if it is night.
    //If they have no way points to walk.
    if(GetIsNight() && !CheckWayPoints())
    {
        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            if(d10() <= 7)
            {
                int nRand = Random(361);
                SetFacing(IntToFloat(nRand));
                //effect eSleep = EffectSleep();
                //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSleep, OBJECT_SELF);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION))
    {

        effect eAppear = EffectAppear();
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAppear, OBJECT_SELF);
    }

    SetListening(OBJECT_SELF, TRUE);

    SetListenPattern(OBJECT_SELF, "NW_I_WAS_ATTACKED", 1);

    //This sets the commoners listen pattern to mob under
    //certain conditions
    if(GetLevelByClass(CLASS_TYPE_COMMONER) > 0)
    {
        SetListenPattern(OBJECT_SELF, "NW_MOB_ATTACK", 2);
    }
    SetListenPattern(OBJECT_SELF, "NW_I_AM_DEAD", 3);

    //Set a custom listening pattern for the creature so that placables with
    //"NW_BLOCKER" + Blocker NPC Tag will correctly call to their blockers.
    string sBlocker = "NW_BLOCKER_BLK_" + GetTag(OBJECT_SELF);
    SetListenPattern(OBJECT_SELF, sBlocker, 4);
    SetListenPattern(OBJECT_SELF, "NW_CALL_TO_ARMS", 6);
// Removed by Grug 27/09/2003 to try to lessen lag
//    //added for DMFI wand compatibility
//    SetListenPattern(OBJECT_SELF, "**", 20600);
//    SetLocalInt(OBJECT_SELF, "hls_Listening", 1);
}

//::///////////////////////////////////////////////
//:: Respond To Shouts
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the listener to react in a manner
    consistant with the given shout but only to one
    combat shout per round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////

//NOTE ABOUT COMMONERS
/*
    Commoners are universal cowards.  If you attack anyone they will flee for 4 seconds away from the attacker.
    However to make the commoners into a mob, make a single commoner at least 10th level of the same faction.
    If that higher level commoner is attacked or killed then the commoners will attack the attacker.  They will disperse again
    after some of them are killed.  Should NOT make multi-class creatures using commoners.
*/
//NOTE ABOUT BLOCKERS
/*
    It should be noted that the Generic Script for On Dialogue attempts to get a local set on the shouter by itself.
    This object represents the LastOpenedBy object.  It is this object that becomes the oIntruder within this function.
*/

//NOTE ABOUT INTRUDERS
/*
    The intruder object is for cases where a placable needs to pass a LastOpenedBy Object or a AttackMyAttacker
    needs to make his attacker the enemy of everyone.
*/

void RespondToShout(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID)
{
    switch (nShoutIndex)
    {
        case 1://NW_GENERIC_SHOUT_I_WAS_ATTACKED:
            {
                object oTarget = oIntruder;
                if(!GetIsObjectValid(oTarget))
                {
                    oTarget = GetLastHostileActor(oShouter);
                }
                if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                {
                    if(!GetLevelByClass(CLASS_TYPE_COMMONER))
                    {
                        if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
                        {
                            if(GetIsObjectValid(oTarget))
                            {
                                if(!GetIsFriend(oTarget) && GetIsFriend(oShouter))
                                {
                                    RemoveAmbientSleep();
                                    //DetermineCombatRound(oTarget);
                                    DetermineCombatRound(GetLastHostileActor(oShouter));
                                }
                            }
                        }
                    }
                    else if (GetLevelByClass(CLASS_TYPE_COMMONER, oShouter) >= 10)
                    {
                        ActionAttack(GetLastHostileActor(oShouter));
                    }
                    else
                    {
                        DetermineCombatRound(oIntruder);
                    }
                }
                else
                {
                    DetermineSpecialBehavior();
                }
            }
        break;

        case 2://NW_GENERIC_SHOUT_MOB_ATTACK:
            {
                if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                {
                    //Is friendly check to make sure that only like minded commoners attack.
                    if(GetIsFriend(oShouter))
                    {
                        ActionAttack(GetLastHostileActor(oShouter));
                    }
                    //if(TalentMeleeAttack()) {return;}
                }
                else
                {
                    DetermineSpecialBehavior();
                }
            }
        break;

        case 3://NW_GENERIC_SHOUT_I_AM_DEAD:
            {
                if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                {
                    //Use I was attacked script above
                    if(!GetLevelByClass(CLASS_TYPE_COMMONER))
                    {
                        if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
                        {
                            if(GetIsObjectValid(GetLastHostileActor(oShouter)))
                            {
                                if(!GetIsFriend(GetLastHostileActor(oShouter)) && GetIsFriend(oShouter))
                                {
                                    DetermineCombatRound(GetLastHostileActor(oShouter));
                                }
                            }
                        }
                    }
                    else if (GetLevelByClass(CLASS_TYPE_COMMONER, oShouter) >= 10)
                    {
                        ActionAttack(GetLastHostileActor(oShouter));
                    }
                    else
                    {
                        DetermineCombatRound();
                    }

                }
                else
                {
                    DetermineSpecialBehavior();
                }
            }
        break;
        //For this shout to work the object must shout the following
        //string sHelp = "NW_BLOCKER_BLK_" + GetTag(OBJECT_SELF);
        case 4: //BLOCKER OBJECT HAS BEEN DISTURBED
            {
                if(!GetLevelByClass(CLASS_TYPE_COMMONER))
                {
                    if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
                    {
                        if(GetIsObjectValid(oIntruder))
                        {
                            SetIsTemporaryEnemy(oIntruder);
                            DetermineCombatRound(oIntruder);
                        }
                    }
                }
                else if (GetLevelByClass(CLASS_TYPE_COMMONER, oShouter) >= 10)
                {
                    ActionAttack(oIntruder);
                }
                else
                {
                    DetermineCombatRound();
                }
            }
        break;

        case 5: //ATTACK MY TARGET
            {
                AdjustReputation(oIntruder, OBJECT_SELF, -100);
                if(GetIsFriend(oShouter))
                {
                    SetIsTemporaryEnemy(oIntruder);
                    ClearAllActions();
                    DetermineCombatRound(oIntruder);
                }
            }
        break;

        case 6: //CALL_TO_ARMS
            {
                //This was once commented out.
                DetermineCombatRound();
            }
        break;

        //ASSOCIATE SHOUT RESPONSES  ******************************************************************************

        case ASSOCIATE_COMMAND_ATTACKNEAREST: //Used to de-activate AGGRESSIVE DEFEND MODE
            {
                ResetHenchmenState();
                SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
                SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
                DetermineCombatRound();
            }
        break;

        case ASSOCIATE_COMMAND_FOLLOWMASTER: //Only used to retreat, or break free from Stand Ground Mode
            {
                ResetHenchmenState();
                SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
                DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_CANDO));

                if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                {
                   //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                }
                if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                {
                   ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                }
                ActionForceFollowObject(GetMaster(), GetFollowDistance());
                SetAssociateState(NW_ASC_IS_BUSY);
                DelayCommand(5.0, SetAssociateState(NW_ASC_IS_BUSY, FALSE));
            }
        break;

        case ASSOCIATE_COMMAND_GUARDMASTER: //Used to activate AGGRESSIVE DEFEND MODE
            {
                ResetHenchmenState();
                DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_CANDO));
                //Companions will only attack the Masters Last Attacker
                SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
                SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
                if(GetIsObjectValid(GetLastHostileActor(GetMaster())))
                {
                    DetermineCombatRound(GetLastHostileActor(GetMaster()));
                }
            }
        break;

        case ASSOCIATE_COMMAND_HEALMASTER: //Ignore current healing settings and heal me now
            {
                ResetHenchmenState();
                //SetCommandable(TRUE);
                if(TalentCureCondition()) {DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_CANDO)); return;}
                if(TalentHeal(TRUE)) {DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_CANDO)); return;}
                DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_CANTDO));
            }
        break;

        case ASSOCIATE_COMMAND_MASTERFAILEDLOCKPICK: //Check local for Re-try locked doors and
            {
                if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if(GetAssociateState(NW_ASC_RETRY_OPEN_LOCKS))
                    {
                        int bValid = TRUE;
                        object oLastObject = GetLockedObject(GetMaster());
                        int nSkill = GetSkillRank(SKILL_OPEN_LOCK) - GetAbilityModifier(ABILITY_DEXTERITY);

                        if(GetIsObjectValid(oLastObject) && GetPlotFlag(oLastObject) == FALSE)
                        {
                            if(GetIsDoorActionPossible(oLastObject, DOOR_ACTION_KNOCK) || GetIsPlaceableObjectActionPossible(oLastObject, PLACEABLE_ACTION_KNOCK))
                            {
                                ClearAllActions();
                                PlayVoiceChat(VOICE_CHAT_CANDO);
                                ActionCastSpellAtObject(SPELL_KNOCK, oLastObject);
                                ActionWait(1.0);
                                bValid = FALSE;
                            }
                            else if (GetIsDoorActionPossible(oLastObject, DOOR_ACTION_UNLOCK)|| GetIsPlaceableObjectActionPossible(oLastObject, PLACEABLE_ACTION_UNLOCK))
                            {
                                ClearAllActions();
                                PlayVoiceChat(VOICE_CHAT_PICKLOCK);
                                ActionWait(1.0);
                                ActionUseSkill(SKILL_OPEN_LOCK,oLastObject);
                                bValid = FALSE;
                            }
                            else if(nSkill < 5 && GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH) >= 16 && GetSkillRank(SKILL_OPEN_LOCK) <= 0)
                            {
                                if(GetIsDoorActionPossible(oLastObject, DOOR_ACTION_BASH) || GetIsPlaceableObjectActionPossible(oLastObject, PLACEABLE_ACTION_BASH))
                                {
                                    ClearAllActions();
                                    PlayVoiceChat(VOICE_CHAT_CANDO);
                                    ActionEquipMostDamagingMelee(oLastObject);
                                    ActionAttack(oLastObject);
                                    SetLocalObject(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH", oLastObject);
                                    bValid = FALSE;
                                }
                            }
                            if(bValid == TRUE)
                            {
                                //ClearAllActions();
                                PlayVoiceChat(VOICE_CHAT_CANTDO);
                            }
                            else
                            {
                                ActionDoCommand(PlayVoiceChat(VOICE_CHAT_TASKCOMPLETE));
                            }
                        }
                    }
                }
            }
        break;

        case ASSOCIATE_COMMAND_MASTERUNDERATTACK:  //Check whether the master has you in AGGRESSIVE DEFEND MODE
            {
                if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    //Check the henchmens current target
                    object oTarget = GetAttemptedAttackTarget();
                    if(!GetIsObjectValid(oTarget))
                    {
                        oTarget = GetAttemptedSpellTarget();
                        if(!GetIsObjectValid(oTarget))
                        {
                            if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER))
                            {
                                //PlayVoiceChat(VOICE_CHAT_ENEMIES);
                                DetermineCombatRound(GetLastHostileActor(GetMaster()));
                            }
                            else
                            {
                                //PlayVoiceChat(VOICE_CHAT_ENEMIES);
                                DetermineCombatRound();
                            }
                        }
                    }
                    //Switch targets only if the target is not attacking the master and is greater than 6.0 from
                    //the master.
                    if(GetAttackTarget(oTarget) != GetMaster() && GetDistanceBetween(oTarget, GetMaster()) > 6.0)
                    {
                        if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER) && GetIsObjectValid(GetLastHostileActor(GetMaster())))
                        {
                            //PlayVoiceChat(VOICE_CHAT_ENEMIES);
                            DetermineCombatRound(GetLastHostileActor(GetMaster()));
                        }
                    }
                }
            }
        break;

        case ASSOCIATE_COMMAND_STANDGROUND: //No longer follow the master or guard him
            {
                SetAssociateState(NW_ASC_MODE_STAND_GROUND);
                SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
                DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_CANDO));
                ActionAttack(OBJECT_INVALID);
                ClearAllActions();
            }
        break;

        case ASSOCIATE_COMMAND_MASTERSAWTRAP:
            {
                int nCheck = 0;
                if(!GetIsInCombat())
                {
                    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                    {
                        object oTrap = GetLastTrapDetected();
                        if(GetIsObjectValid(oTrap))
                        {
                            int nTrapDC = GetTrapDisarmDC(oTrap);
                            int nSkill = GetSkillRank(SKILL_DISABLE_TRAP);
                            int nMod = GetAbilityModifier(ABILITY_DEXTERITY);
                            if((nSkill - nMod) > 0)
                            {
                                nSkill = nSkill + 20 - nTrapDC;
                            }
                            else
                            {
                                nSkill = 0;
                                nCheck = 1;
                            }

                            if(GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP && nSkill > 0)
                            {
                                PlayVoiceChat(VOICE_CHAT_STOP);
                                if(GetHasSkill(SKILL_DISABLE_TRAP, OBJECT_SELF))
                                {
                                    ClearAllActions();
                                    ActionUseSkill(SKILL_DISABLE_TRAP, oTrap);
                                    ActionDoCommand(SetCommandable(TRUE));
                                    ActionDoCommand(PlayVoiceChat(VOICE_CHAT_TASKCOMPLETE));
                                    SetCommandable(FALSE);
                                    nCheck = 2;
                                }
                            }
                            else if(nCheck = 0 &&
                                    GetSkillRank(SKILL_DISABLE_TRAP) > 0 &&
                                    GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP)
                            {
                                PlayVoiceChat(VOICE_CHAT_CANTDO);
                            }
                        }
                    }
                }
            }
        break;

        case ASSOCIATE_COMMAND_MASTERATTACKEDOTHER:
            {
                if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if(!GetAssociateState(NW_ASC_MODE_DEFEND_MASTER))
                    {
                        if(!GetIsFighting(OBJECT_SELF))
                        {
                            //PlayVoiceChat(VOICE_CHAT_ENEMIES);
                            object oAttack = GetAttackTarget(GetMaster());
                            if(GetIsObjectValid(oAttack) && GetObjectSeen(oAttack))
                            {
                                ClearAllActions();
                                DetermineCombatRound(oAttack);
                            }
                        }
                    }
                }
            }
        break;

        case ASSOCIATE_COMMAND_MASTERGOINGTOBEATTACKED:
            {
                if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if(!GetIsFighting(OBJECT_SELF))
                    {
                        object oAttacker = GetGoingToBeAttackedBy(GetMaster());
                        if(GetIsObjectValid(oAttacker) && GetObjectSeen(oAttacker))
                        {
                            ClearAllActions();
                            //PlayVoiceChat(VOICE_CHAT_ENEMIES);
                            DetermineCombatRound(oAttacker);
                        }
                    }
                }
            }
        break;

        case ASSOCIATE_COMMAND_LEAVEPARTY:
            {
                object oMaster = GetMaster();
                if(GetIsObjectValid(oMaster))
                {
                    ClearAllActions();
                    if(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster()) == OBJECT_SELF)
                    {
                        AddJournalQuestEntry("Henchman",50,GetMaster(),FALSE,FALSE,TRUE);
                    }
                    SetLocalObject(OBJECT_SELF,"NW_L_FORMERMASTER", oMaster);
                    RemoveHenchman(oMaster, OBJECT_SELF);
                }
            }
        break;
    }
}

//::///////////////////////////////////////////////
//:: Set and Get NPC Warning Status
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function sets a local int on OBJECT_SELF
    which will be checked in the On Attack, On
    Damaged and On Disturbed scripts to check if
    the offending poarty was a PC and was friendly.
    The Get will return the status of the local.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

void SetNPCWarningStatus(int nStatus = TRUE)
{
    SetLocalInt(OBJECT_SELF, "NW_GENERIC_WARNING_STATUS", nStatus);
}

int GetNPCWarningStatus()
{
    return GetLocalInt(OBJECT_SELF, "NW_GENERIC_WARNING_STATUS");
}

//::///////////////////////////////////////////////
//:: Set SummonHelpIfAttacked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function works in tandem with an encounter
    to spawn in guards to fight for the attacked
    NPC.  MAKE SURE THE ENCOUNTER TAG IS SET TO:

             "ENC_" + NPC TAG
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

//Presently Does not work with the current implementation of encounter trigger
void SetSummonHelpIfAttacked()
{
    string sEncounter = "ENC_" + GetTag(OBJECT_SELF);
    object oTrigger = GetObjectByTag(sEncounter);

    if(GetIsObjectValid(oTrigger))
    {
        SetEncounterActive(TRUE, oTrigger);
    }
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//
// ESCAPE FUNCTIONS
//
//************************************************************************************************************************************
//************************************************************************************************************************************

//::///////////////////////////////////////////////
//:: Set, Get Activate,Flee to Exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The target object flees to the specified
    way point and then destroys itself, to be
    respawned at a later point.  For unkillable
    sign post characters who are not meant to fight
    back.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

//This function is used only because ActionDoCommand can only accept void functions
void CreateSignPostNPC(string sTag, location lLocal)
{
    CreateObject(OBJECT_TYPE_CREATURE, sTag, lLocal);
}

void ActivateFleeToExit()
{
     object oExitWay = GetWaypointByTag("EXIT_" + GetTag(OBJECT_SELF));
     int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
     location lLocal = GetLocalLocation(OBJECT_SELF, "NW_GENERIC_START_POINT");
     float fDelay =  6.0;
      string sTag = GetTag(OBJECT_SELF);

     if(nPlot & NW_FLAG_TELEPORT_RETURN || nPlot & NW_FLAG_TELEPORT_LEAVE)
     {
        effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        if(nPlot & NW_FLAG_TELEPORT_RETURN)
        {
            DelayCommand(fDelay, ActionDoCommand(CreateSignPostNPC(sTag, lLocal)));
        }
        ActionDoCommand(DestroyObject(OBJECT_SELF, 0.75));
     }
     else
     {
        if(nPlot & NW_FLAG_ESCAPE_LEAVE)
        {
            ActionMoveToObject(oExitWay, TRUE);
            ActionDoCommand(DestroyObject(OBJECT_SELF, 1.0));
        }
        else if(nPlot & NW_FLAG_ESCAPE_RETURN)
        {
            ActionMoveToObject(oExitWay, TRUE);
            DelayCommand(fDelay, ActionDoCommand(CreateSignPostNPC(sTag, lLocal)));
            ActionDoCommand(DestroyObject(OBJECT_SELF, 1.0));
        }
     }
}

int GetFleeToExit()
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(nPlot & NW_FLAG_ESCAPE_RETURN)
    {
        return TRUE;
    }
    else if(nPlot & NW_FLAG_ESCAPE_LEAVE)
    {
        return TRUE;
    }
    else if(nPlot & NW_FLAG_TELEPORT_RETURN)
    {
        return TRUE;
    }
    else if(nPlot & NW_FLAG_TELEPORT_LEAVE)
    {
       return TRUE;
    }
    return FALSE;
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//
//WAY POINT WALK FUNCTIONS
//
//************************************************************************************************************************************
//************************************************************************************************************************************

//::///////////////////////////////////////////////
//:: Walk Way Point Path
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows specified person walk a waypoint path
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)  //Run first circuit
{
    ClearAllActions();
    string DayWayString;
    string NightWayString;
    string DayPostString;
    string NightPostString;
    string sWay;
    string sPost;

    //The block of code below deals with night and day cycle for postings and walkway points.
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        DayWayString = "WP_";
        NightWayString = "WN_";
        DayPostString = "POST_";
        NightPostString = "NIGHT_";
    }
    else
    {
        DayWayString = "WP_";
        NightWayString = "WP_";
        DayPostString = "POST_";
        NightPostString = "POST_";
    }

    if(GetIsDay() || GetIsDawn())
    {
        SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX", DayWayString);
        SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_PREFIX", DayPostString);
    }
    else
    {
        SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX", NightWayString);
        SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_PREFIX", NightPostString);
    }


    sWay = GetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX");
    sPost = GetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_PREFIX");

    //I have now determined what the prefixs for the current walkways and postings are and will use them instead
    // of POST_ and WP_

    if(GetSpawnInCondition(NW_FLAG_STEALTH))
    {
        //
        ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    }
    if(GetSpawnInCondition(NW_FLAG_SEARCH))
    {
        //
        ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
    }

    //Test if OBJECT_SELF has waypoints to walk
    string sWayTag = GetTag( OBJECT_SELF );
    sWayTag = sWay + sWayTag + "_01";
    object oWay1 = GetNearestObjectByTag(sWayTag);
    if(!GetIsObjectValid(oWay1))
    {
        oWay1 = GetObjectByTag(sWayTag);
    }
    if(GetIsObjectValid(oWay1) && GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS))
    {
        //turn off the ambient animations if the creature should walk way points.
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE);
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, FALSE);
    }

    if(GetIsObjectValid(oWay1))
    {
        int nNth = 1;
        int nTens;
        int nNum;
        object oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, nNth);
        while (GetIsObjectValid(oNearest))
        {
           string sNearestTag = GetTag(oNearest);
           //removes the first 3 and last three characters from the waypoint's tag
           //and checks it against his own tag.  Waypoint tag format is WP_MyTag_XX.
           if( GetSubString( sNearestTag, 3, GetStringLength( sNearestTag ) - 6 ) == GetTag( OBJECT_SELF ) )
           {
                string sTens = GetStringRight(GetTag(oNearest),2);
                nTens = StringToInt(sTens)/10;
                nNum= StringToInt(GetStringRight(GetTag(oNearest),1));
                oNearest = OBJECT_INVALID;
           }
           else
           {
               nNth++;
               oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT,OBJECT_SELF,nNth);
           }
        }
        RunCircuit(nTens, nNum, nRun, fPause); //***************************************
        ActionWait(fPause);
        ActionDoCommand(RunNextCircuit(nRun, fPause));
        //ActionDoCommand(SignalEvent(OBJECT_SELF,EventUserDefined(2)));
    }
    else
    {
        sWayTag = GetTag( OBJECT_SELF );
        sWayTag = sPost + sWayTag;
        oWay1 = GetNearestObjectByTag(sWayTag);
        if(!GetIsObjectValid(oWay1))
        {
            oWay1 = GetObjectByTag(sWayTag);
        }

        if(GetIsObjectValid(oWay1))
        {
            ActionForceMoveToObject(oWay1, nRun, 1.0, 60.0);
            float fFacing = GetFacing(oWay1);
            ActionDoCommand(SetFacing(fFacing));
        }
    }
    if(GetIsObjectValid(oWay1) && GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS))
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE);
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, FALSE);
    }
}

void RunNextCircuit(int nRun = FALSE, float fPause = 1.0)
{
    RunCircuit(0,1, nRun, fPause);  //***************************************
    ActionWait(fPause);
    ActionDoCommand(RunNextCircuit(nRun, fPause));
    //ActionDoCommand(SignalEvent(OBJECT_SELF,EventUserDefined(2)));
}

//::///////////////////////////////////////////////
//:: Run Circuit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the proper path to follow along a
    predetermined set of way points
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0)
{
    // starting at a given way point, move sequentialy through incrementally
    // increasing points until there are no more valid ones.
    string sWay = GetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX");

    object oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));

    while(GetIsObjectValid(oTargetPoint))
    {
        ActionWait(fPause);
        ActionMoveToObject(oTargetPoint, nRun);
        nNum++;
        if (nNum > 9)
        {
            nTens++;
            nNum = 0;
        }
        oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
    }
    // once there are no more waypoints available, decriment back to the last
    // valid point.
    nNum--;
    if (nNum < 0)
    {
        nTens--;
        nNum = 9;
    }

    // start the cycle again going back to point 01
    oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
    while(GetIsObjectValid(oTargetPoint))
    {
        ActionWait(fPause);
        ActionMoveToObject(oTargetPoint, nRun);
        nNum--;
        if (nNum < 0)
        {
            nTens--;
            nNum = 9;
        }
        oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
    }
}

//::///////////////////////////////////////////////
//:: Check Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks the passed in object to
    see if they are supposed to be walking to
    day or night postings.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 26, 2002
//:://////////////////////////////////////////////

int CheckWayPoints(object oWalker = OBJECT_SELF)
{
    object oWay1;
    object oWay2;
    object oWay3;
    object oWay4;
    string sTag = GetTag(oWalker);
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        oWay2 = GetWaypointByTag("NIGHT_" + sTag);
        oWay4 = GetWaypointByTag("WN_" + sTag + "_01");
    }

    oWay1 = GetWaypointByTag("POST_" + sTag);
    oWay3 = GetWaypointByTag("WP_" + sTag + "_01");

    if(GetIsObjectValid(oWay2) || GetIsObjectValid(oWay4) || GetIsObjectValid(oWay1) || GetIsObjectValid(oWay3))
    {
        return TRUE;
    }
    return FALSE;
}


//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//:: Talent checks and use functions
//:: Copyright (c) 2001 Bioware Corp.
//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    This is a series of functions that check
    if a particular type of talent is available and
    if so then use that talent.
*/
//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// PROTECT SELF
int TalentUseProtectionOnSelf()
{
    talent tUse;
    int nType, nIndex;
    int bValid = FALSE;
    int nCR = GetAssociateCRMax();

    tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SELF, 20);
    if(!GetIsTalentValid(tUse))
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE, 20);
        if(GetIsTalentValid(tUse))
        {
           //
           bValid = TRUE;
        }
    }
    else
    {
        //
        bValid = TRUE;
    }

    if(bValid == TRUE)
    {
        nType = GetTypeFromTalent(tUse);
        nIndex = GetIdFromTalent(tUse);

        if(nType == TALENT_TYPE_SPELL)
        {
            if(!GetHasSpellEffect(nIndex))
            {
                ClearAllActions();


                ActionUseTalentOnObject(tUse, OBJECT_SELF);
                return TRUE;
            }
        }
        else if(nType == TALENT_TYPE_FEAT)
        {
            if(!GetHasFeatEffect(nIndex))
            {
                ClearAllActions();

                ActionUseTalentOnObject(tUse, OBJECT_SELF);
                return TRUE;
            }
        }
        else
        {
            ActionUseTalentOnObject(tUse, OBJECT_SELF);
            return TRUE;
        }
    }

    return FALSE;
}

//PROTECT PARTY
int TalentUseProtectionOthers()
{
    talent tUse, tMass;
    int nType, nFriends, nIndex;
    int nCnt = 1;
    int bValid = FALSE;
    int nCR = GetAssociateCRMax();
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE, nCR);
    tMass = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_AREAEFFECT, nCR);

    //Override the nearest target if the master wants aggressive buff spells
    if(GetAssociateState(NW_ASC_AGGRESSIVE_BUFF) && GetAssociateState(NW_ASC_HAVE_MASTER))
    {
        oTarget = GetMaster();
    }

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsTalentValid(tMass))
        {
            if(CheckFriendlyFireOnTarget(oTarget) > 2)
            {
                nType = GetTypeFromTalent(tMass);
                nIndex = GetIdFromTalent(tMass);
                if(nType == TALENT_TYPE_SPELL)
                {
                    if(!GetHasSpellEffect(nIndex, oTarget))
                    {
                        ClearAllActions();
                        ActionUseTalentOnObject(tMass, oTarget);
                        return TRUE;
                    }
                }
                else if(nType == TALENT_TYPE_FEAT)
                {
                    if(!GetHasFeatEffect(nIndex, oTarget))
                    {
                        ClearAllActions();

                        ActionUseTalentOnObject(tUse, OBJECT_SELF);
                        return TRUE;
                    }
                }
                else
                {
                    ClearAllActions();
                    ActionUseTalentOnObject(tMass, oTarget);
                    return TRUE;
                }
            }
        }

        if(GetIsTalentValid(tUse))
        {
            nType = GetTypeFromTalent(tUse);
            nIndex = GetIdFromTalent(tUse);
            if(nType == TALENT_TYPE_SPELL)
            {
                if(!GetHasSpellEffect(nIndex, oTarget))
                {
                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
            else if(nType == TALENT_TYPE_FEAT)
            {
                if(!GetHasFeatEffect(nIndex, oTarget))
                {
                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, OBJECT_SELF);
                    return TRUE;
                }
            }
            else
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }

    return FALSE;
}

// ENHANCE OTHERS
int TalentEnhanceOthers()
{
    talent tUse, tMass;
    int nType, nFriends, nIndex;
    int nCnt = 1;
    int bValid = FALSE;
    int nCR = GetAssociateCRMax();
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SINGLE, nCR);
    tMass = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_AREAEFFECT, nCR);

    //Override the nearest target if the master wants aggressive buff spells
    if(GetAssociateState(NW_ASC_AGGRESSIVE_BUFF) && GetAssociateState(NW_ASC_HAVE_MASTER))
    {
        oTarget = GetMaster();
    }
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsTalentValid(tMass))
        {
            if(CheckFriendlyFireOnTarget(oTarget) > 2)
            {
                nType = GetTypeFromTalent(tMass);
                nIndex = GetIdFromTalent(tMass);
                if(nType == TALENT_TYPE_SPELL)
                {
                    if(!GetHasSpellEffect(nIndex, oTarget))
                    {
                        ClearAllActions();
                        ActionUseTalentOnObject(tMass, oTarget);
                        return TRUE;
                    }
                }
                else if(nType == TALENT_TYPE_FEAT)
                {
                    if(!GetHasFeatEffect(nIndex, oTarget))
                    {
                        ClearAllActions();
                        ActionUseTalentOnObject(tUse, OBJECT_SELF);
                        return TRUE;
                    }
                }
                else
                {
                    ClearAllActions();
                    ActionUseTalentOnObject(tMass, oTarget);
                    return TRUE;
                }
            }
        }

        if(GetIsTalentValid(tUse))
        {
            nType = GetTypeFromTalent(tUse);
            nIndex = GetIdFromTalent(tUse);
            if(nType == TALENT_TYPE_SPELL)
            {

                if(!GetHasSpellEffect(nIndex, oTarget))
                {
                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
            else if(nType == TALENT_TYPE_FEAT)
            {
                if(!GetHasFeatEffect(nIndex, oTarget))
                {
                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, OBJECT_SELF);
                    return TRUE;
                }
            }
            else
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }

    return FALSE;
}

// ENHANCE SELF
int TalentUseEnhancementOnSelf()
{
    talent tUse;
    int nType;
    int bValid = FALSE;
    int nIndex;
    int nCR = GetAssociateCRMax();

    tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SELF, 20);
    if(!GetIsTalentValid(tUse))
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SINGLE, 20);
        if(GetIsTalentValid(tUse))
        {
           bValid = TRUE;
        }
    }
    else
    {
        bValid = TRUE;
    }

    if(bValid == TRUE)
    {
        nType = GetTypeFromTalent(tUse);
        nIndex = GetIdFromTalent(tUse);

        if(nType == TALENT_TYPE_SPELL)
        {
            if(!GetHasSpellEffect(nIndex))
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, OBJECT_SELF);
                return TRUE;
            }
        }
        else if(nType == TALENT_TYPE_FEAT)
        {
            if(!GetHasFeatEffect(nIndex))
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, OBJECT_SELF);
                return TRUE;
            }
        }
        else
        {
            ActionUseTalentOnObject(tUse, OBJECT_SELF);
            return TRUE;
        }
    }

    return FALSE;
}

// SPELL CASTER MELEE ATTACKED
int TalentMeleeAttacked(object oIntruder = OBJECT_INVALID)
{
    talent tUse;
    int nMelee = GetNumberOfMeleeAttackers();
    object oTarget = oIntruder;
    int nCR = GetAssociateCRMax();

    if(!GetIsObjectValid(oIntruder) && GetIsObjectValid(GetLastHostileActor()))
    {
        oTarget = GetLastHostileActor();
    }
    else
    {
        return FALSE;
    }
    /*
        ISSUE 1: The check in this function to use a random ability after failing to use best will fail in the following
        case.  The creature is unable to affect the target with the spell and has only 1 spell of that type.  This can
        be eliminated with a check in the else to the effect of :

            else if(!CompareLastSpellCast(GetIdFromTalent(tUse)))

        This check was not put in in version 1.0 due to time constraints.

        ISSUE 2: Given the Spell Attack is the drop out check the else statements in this talent should be cut.
    */

    if(nMelee == 1)
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_TOUCH, nCR);
        if(GetIsTalentValid(tUse))
        {
            // Jugalator: BioWare not allowing casters to cast
            // two or more spells of the same kind in a row??
            if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
            {
                if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                {
                    SetLastGenericSpellCast(GetIdFromTalent(tUse));
                }
                DubugPrintTalentID(tUse);

                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
            else
            {
                // Jugalator: Note - only cast random spell if best failed
                tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_TOUCH);
                if(GetIsTalentValid(tUse))
                {
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }

        tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_RANGED, nCR);
        if(GetIsTalentValid(tUse))
        {
            // Jugalator: BioWare not allowing casters to cast
            // two or more spells of the same kind in a row??
            if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
            {
                if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                {
                    SetLastGenericSpellCast(GetIdFromTalent(tUse));
                }
                DubugPrintTalentID(tUse);

                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
            else
            {
                // Jugalator: Note - only cast random spell if best failed
                tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_RANGED);
                if(GetIsTalentValid(tUse))
                {
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }

        tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, nCR);
        if(GetIsTalentValid(tUse))
        {
            // Jugalator: BioWare not allowing casters to cast
            // two or more spells of the same kind in a row??
            if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
            {
                if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                {
                    SetLastGenericSpellCast(GetIdFromTalent(tUse));
                }
                DubugPrintTalentID(tUse);

                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
            else
            {
                // Jugalator: Note - only cast random spell if best failed
                tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT);
                if(GetIsTalentValid(tUse))
                {
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
    }
    else if (nMelee > 1)
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, nCR);
        if(GetIsTalentValid(tUse))
        {
            // Jugalator: BioWare not allowing casters to cast
            // two or more spells of the same kind in a row??
             if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
             {
                if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                {
                    SetLastGenericSpellCast(GetIdFromTalent(tUse));
                }
                DubugPrintTalentID(tUse);

                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
            else
            {
                // Jugalator: Note - only cast random spell if best failed
                tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT);
                if(GetIsTalentValid(tUse))
                {
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_TOUCH, nCR);
        if(GetIsTalentValid(tUse))
        {
            // Jugalator: BioWare not allowing casters to cast
            // two or more spells of the same kind in a row??
            if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
            {
                if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                {
                    SetLastGenericSpellCast(GetIdFromTalent(tUse));
                }
                DubugPrintTalentID(tUse);

                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
            else
            {
                // Jugalator: Note - only cast random spell if best failed
                tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_TOUCH);
                if(GetIsTalentValid(tUse))
                {
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }

        tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_RANGED, nCR);
        if(GetIsTalentValid(tUse))
        {
            // Jugalator: BioWare not allowing casters to cast
            // two or more spells of the same kind in a row??
            if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
            {
                if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                {
                    SetLastGenericSpellCast(GetIdFromTalent(tUse));
                }
                DubugPrintTalentID(tUse);

                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
            else
            {
                // Jugalator: Note - only cast random spell if best failed
                tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_RANGED);
                if(GetIsTalentValid(tUse))
                {
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
    }

    return FALSE;
}

// SPELL CASTER RANGED ATTACKED
int TalentRangedAttackers(object oIntruder = OBJECT_INVALID)
{
    //Check for Single Ranged Targets
    talent tUse;
    object oTarget = oIntruder;
    int nCR = GetAssociateCRMax();
    if(!GetIsObjectValid(oIntruder))
    {
        oTarget = GetLastHostileActor();
    }
    if(GetIsObjectValid(oTarget) && GetDistanceBetween(oTarget, OBJECT_SELF) > 5.0)
    {
        if(CheckFriendlyFireOnTarget(oTarget) > 0)
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, nCR);
            if(GetIsTalentValid(tUse))
            {
                // Jugalator: BioWare not allowing casters to cast
                // two or more spells of the same kind in a row??
                if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                    !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget)/* &&
                    !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                    GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                {
                    if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                    {
                        SetLastGenericSpellCast(GetIdFromTalent(tUse));
                    }
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
        else if(CheckEnemyGroupingOnTarget(oTarget) > 0)
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_INDISCRIMINANT, nCR);
            if(GetIsTalentValid(tUse))
            {
                // Jugalator: BioWare not allowing casters to cast
                // two or more spells of the same kind in a row??
                if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                    !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                    !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                    GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                {
                    if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                    {
                        SetLastGenericSpellCast(GetIdFromTalent(tUse));
                    }
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    //ActionUseTalentOnObject(tUse, oTarget);
                    ActionUseTalentAtLocation(tUse, GetLocation(oTarget));
                    return TRUE;
                }
            }
        }
        else
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_RANGED, nCR);
            if(GetIsTalentValid(tUse))
            {
                // Jugalator: BioWare not allowing casters to cast
                // two or more spells of the same kind in a row??
                if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                    !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                    !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                    GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                {
                    if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                    {
                        SetLastGenericSpellCast(GetIdFromTalent(tUse));
                    }
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
    }

    return FALSE;
}

// SPELL CASTER WITH RANGED ENEMIES
int TalentRangedEnemies(object oIntruder = OBJECT_INVALID)
{
    talent tUse;
    object oTarget = oIntruder;
    int nCR = GetAssociateCRMax();
    if(!GetIsObjectValid(oIntruder))
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
    if(GetIsObjectValid(oTarget))
    {
        int nEnemy = CheckEnemyGroupingOnTarget(oTarget);
        if(CheckFriendlyFireOnTarget(oTarget) > 0 &&  nEnemy > 0)
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, nCR);
            if(GetIsTalentValid(tUse))
            {
                // Jugalator: BioWare not allowing casters to cast
                // two or more spells of the same kind in a row??
                if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                    !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                    !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                    GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                {
                    if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                    {
                        SetLastGenericSpellCast(GetIdFromTalent(tUse));
                    }
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
        else if(nEnemy > 0)
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_INDISCRIMINANT, nCR);
            if(GetIsTalentValid(tUse))
            {
                // Jugalator: BioWare not allowing casters to cast
                // two or more spells of the same kind in a row??
                if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                    !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                    !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                    GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                {
                    if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                    {
                        SetLastGenericSpellCast(GetIdFromTalent(tUse));
                    }
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentAtLocation(tUse, GetLocation(oTarget));
                    //ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
            else
            {
                tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, nCR);
                if(GetIsTalentValid(tUse))
                {
                    // Jugalator: BioWare not allowing casters to cast
                    // two or more spells of the same kind in a row??
                    if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                        !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                        !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                        GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                    {
                        if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                        {
                            SetLastGenericSpellCast(GetIdFromTalent(tUse));
                        }
                        DubugPrintTalentID(tUse);

                        ClearAllActions();
                        ActionUseTalentOnObject(tUse, oTarget);
                        return TRUE;
                    }
                }
            }
        }
        else if(GetDistanceToObject(oTarget) > 5.0)
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_RANGED, nCR);
            if(GetIsTalentValid(tUse))
            {
                // Jugalator: BioWare not allowing casters to cast
                // two or more spells of the same kind in a row??
                if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                    !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                    !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                    GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                {
                    if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                    {
                        SetLastGenericSpellCast(GetIdFromTalent(tUse));
                    }
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
        else
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_TOUCH, nCR);
            if(GetIsTalentValid(tUse))
            {
                // Jugalator: BioWare not allowing casters to cast
                // two or more spells of the same kind in a row??
                if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL &&
                    !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) /*&&
                    !CompareLastSpellCast(GetIdFromTalent(tUse))*/ ) ||
                    GetTypeFromTalent(tUse) != TALENT_TYPE_SPELL )
                {
                    if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
                    {
                        SetLastGenericSpellCast(GetIdFromTalent(tUse));
                    }
                    DubugPrintTalentID(tUse);

                    ClearAllActions();
                    ActionUseTalentOnObject(tUse, oTarget);
                    return TRUE;
                }
            }
        }
    }

    return FALSE;
}
    /*
        ISSUE 1: The check in this function to use a random ability after failing to use best will fail in the following
        case.  The creature is unable to affect the target with the spell and has only 1 spell of that type.  This can
        be eliminated with a check in the else to the effect of :

            else if(!CompareLastSpellCast(GetIdFromTalent(tUse)))

        This check was not put in in version 1.0 due to time constraints.
        May cause an AI loop in some Mages with limited spell selection.
    */
int TalentSpellAttack(object oIntruder)
{
    talent tUse;
    object oTarget = oIntruder;
    if(!GetIsObjectValid(oTarget) || GetArea(oTarget) != GetArea(OBJECT_SELF) || GetPlotFlag(OBJECT_SELF) == TRUE)
    {
        oTarget = GetLastHostileActor();

        if(!GetIsObjectValid(oTarget)
            || GetIsDead(oTarget)
            || GetArea(oTarget) != GetArea(OBJECT_SELF)
            || GetPlotFlag(OBJECT_SELF) == TRUE)
        {
            oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);

            if(!GetIsObjectValid(oTarget))
            {
                return FALSE;
            }
        }
    }
    //Attack chosen target
    int bValid = FALSE;

    tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT);

    if(GetIsTalentValid(tUse))
    {
        if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL && !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget)) )
        {
            bValid = TRUE;
        }
    }
    if(bValid == FALSE)
    {
        tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_RANGED);
        if(GetIsTalentValid(tUse))
        {
            if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL && !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget)) )
            {
                bValid = TRUE;
            }
        }
    }
    if(bValid == FALSE)
    {
        tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_TOUCH);
        if(GetIsTalentValid(tUse))
        {
            if( (GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL && !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget)) )
            {
                bValid = TRUE;
            }
        }
    }
    if (bValid == TRUE)
    {
        if( GetTypeFromTalent(tUse) == TALENT_TYPE_SPELL)
        {
            SetLastGenericSpellCast(GetIdFromTalent(tUse));
        }
        DubugPrintTalentID(tUse);

        ClearAllActions();
        ActionUseTalentOnObject(tUse, oTarget);
        return TRUE;
    }

    return FALSE;
}


// SUMMON ALLIES
int TalentSummonAllies()
{
    talent tUse;
    int nCR = GetAssociateCRMax();
    object oTarget;
    location lSelf;

    if(!GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED)))
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, 20);
        if(GetIsTalentValid(tUse))
        {
            oTarget =  FindSingleRangedTarget();
            if(GetIsObjectValid(oTarget))
            {
                vector vTarget = GetPosition(oTarget);
                vector vSource = GetPosition(OBJECT_SELF);
                vector vDirection = vTarget - vSource;
                float fDistance = VectorMagnitude(vDirection) / 2.0f;
                vector vPoint = VectorNormalize(vDirection) * fDistance + vSource;
                lSelf = Location(GetArea(OBJECT_SELF), vPoint, GetFacing(OBJECT_SELF));
                //lSelf = GetLocation(oTarget);
            }
            else
            {
                lSelf = GetLocation(OBJECT_SELF);
            }
            ClearAllActions();
            //This is for henchmen wizards, so they do no run off and get killed
            //summoning in allies.
            if(GetIsObjectValid(GetMaster()))
            {
                ActionUseTalentAtLocation(tUse, GetLocation(GetMaster()));
            }
            else
            {
                ActionUseTalentAtLocation(tUse, lSelf);
            }
            return TRUE;
        }
    }

    return FALSE;
}

// HEAL SELF WITH POTIONS AND SPELLS
int TalentHealingSelf()
{
    talent tUse;
    int nCurrent = GetCurrentHitPoints(OBJECT_SELF) * 2;
    int nBase = GetMaxHitPoints(OBJECT_SELF);
    if(nCurrent < nBase)
    {
        tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH);
        if(GetIsTalentValid(tUse))
        {
            ClearAllActions();
            ActionUseTalentOnObject(tUse, OBJECT_SELF);
            return TRUE;
        }
        else
        {
            tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_HEALING_POTION);
            if(GetIsTalentValid(tUse))
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, OBJECT_SELF);
                return TRUE;
            }
        }
    }

    return FALSE;
}

// HEAL ALL ALLIES
int TalentHeal(int nForce = FALSE)
{
    talent tUse;
    int nCurrent = GetCurrentHitPoints(OBJECT_SELF) * 2;
    int nBase = GetMaxHitPoints(OBJECT_SELF);
    int nCR;

    if(GetAssociateHealMaster() || nForce == TRUE)
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
        if(GetIsTalentValid(tUse) && !GetIsDead(GetMaster()))
        {
            ClearAllActions();
            ActionUseTalentOnObject(tUse, GetMaster());
            return TRUE;
        }
    }
    if(nCurrent < nBase)
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
        if(GetIsTalentValid(tUse))
        {
            ClearAllActions();
            ActionUseTalentOnObject(tUse, OBJECT_SELF);
            return TRUE;
        }
    }

    object oTarget = GetFactionMostDamagedMember(OBJECT_SELF);
    if(GetIsObjectValid(oTarget))
    {
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            return FALSE;
        }
        nCurrent = GetCurrentHitPoints(oTarget)*2;
        nBase = GetMaxHitPoints(oTarget);

        if(nCurrent < nBase && !GetIsDead(oTarget))
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
            if(GetIsTalentValid(tUse))
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
                return TRUE;
            }
        }
    }

    return FALSE;
}

// MELEE ATTACK OTHERS
/*
    ISSUE 1: Talent Melee Attack should set the Last Spell Used to 0 so that melee casters can use
    a single special ability.
*/

int TalentMeleeAttack(object oIntruder = OBJECT_INVALID)
{


    object oTarget = oIntruder;
    if(!GetIsObjectValid(oTarget) || GetArea(oTarget) != GetArea(OBJECT_SELF) || GetPlotFlag(OBJECT_SELF) == TRUE)
    {
        oTarget = GetAttemptedAttackTarget();

        if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget) ||
          (!GetObjectSeen(oTarget) && !GetObjectHeard(oTarget))
           || GetArea(oTarget) != GetArea(OBJECT_SELF)
           || GetPlotFlag(OBJECT_SELF) == TRUE)
        {
            oTarget = GetLastHostileActor();

            if(!GetIsObjectValid(oTarget)
                || GetIsDead(oTarget)
                || GetArea(oTarget) != GetArea(OBJECT_SELF)
                || GetPlotFlag(OBJECT_SELF) == TRUE)
            {
                oTarget = GetNearestSeenOrHeardEnemy();

                if(!GetIsObjectValid(oTarget))
                {
                    return FALSE;
                }
            }
        }
    }
    else
    {
        //
    }


    talent tUse;
    int nAC = GetAC(oTarget);
    float fAttack;
    int nAttack = GetCharacterLevel(OBJECT_SELF);

    fAttack = (IntToFloat(nAttack) * 0.75) + IntToFloat(GetAbilityModifier(ABILITY_STRENGTH));
    //fAttack = IntToFloat(nAttack) + GetAbilityModifier(ABILITY_STRENGTH);

    int nDiff = nAC - nAttack;


    if(nDiff < 10)
    {
        ClearAllActions();
        EquipAppropriateWeapons(oTarget);
        tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_MELEE);



        if(GetIsTalentValid(tUse) && VerifyDisarm(tUse, oTarget) && VerifyCombatMeleeTalent(tUse, oTarget))
        {
            ActionUseTalentOnObject(tUse, oTarget);
            return TRUE;
        }
        else
        {
            ActionAttack(oTarget);
            return TRUE;
        }
    }
    else
    {
        ClearAllActions();
        EquipAppropriateWeapons(oTarget);
        ActionAttack(oTarget);
        return TRUE;
    }

    return FALSE;
}

// SNEAK ATTACK OTHERS
int TalentSneakAttack()
{
     object oTarget;
     int nFriends;

     if(GetHasFeat(FEAT_SNEAK_ATTACK))
     {
         nFriends = CheckFriendlyFireOnTarget(OBJECT_SELF);
         if(nFriends > 0)
         {
            oTarget = GetLastHostileActor(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN));
            if(GetIsObjectValid(oTarget) && !GetIsDead(oTarget))
            {
                ActionAttack(oTarget);
                return TRUE;
            }
         }
     }

     return FALSE;
}

// FLEE COMBAT AND HOSTILES
int TalentFlee(object oIntruder = OBJECT_INVALID)
{
    object oTarget = oIntruder;
    if(!GetIsObjectValid(oIntruder))
    {
        oTarget = GetLastHostileActor();
        if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget))
        {
            oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
            float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
            if(!GetIsObjectValid(oTarget))
            {
                return FALSE;
            }
        }
    }

    ClearAllActions();
    //Look at this to remove the delay
    ActionMoveAwayFromObject(oTarget, TRUE, 10.0f);
    DelayCommand(4.0, ClearAllActions());
    return TRUE;
}

// TURN UNDEAD
int TalentUseTurning()
{
    int nCount;
    if(GetHasFeat(FEAT_TURN_UNDEAD))
    {
        object oUndead = GetNearestSeenOrHeardEnemy();
        int nHD = GetHitDice(oUndead);
        if(GetHasEffect(EFFECT_TYPE_TURNED, oUndead) || GetHitDice(OBJECT_SELF) <= nHD)
        {
            return FALSE;
        }
        int nElemental = GetHasFeat(FEAT_AIR_DOMAIN_POWER) + GetHasFeat(FEAT_EARTH_DOMAIN_POWER) + GetHasFeat(FEAT_FIRE_DOMAIN_POWER) + GetHasFeat(FEAT_FIRE_DOMAIN_POWER);
        int nVermin = GetHasFeat(FEAT_PLANT_DOMAIN_POWER) + GetHasFeat(FEAT_ANIMAL_COMPANION);
        int nConstructs = GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER);
        int nOutsider = GetHasFeat(FEAT_GOOD_DOMAIN_POWER) + GetHasFeat(FEAT_EVIL_DOMAIN_POWER);

        if(nElemental == TRUE)
        {
            nCount += GetRacialTypeCount(RACIAL_TYPE_ELEMENTAL);
        }
        if(nVermin == TRUE)
        {
            nCount += GetRacialTypeCount(RACIAL_TYPE_VERMIN);
        }
        if(nOutsider == TRUE)
        {
            nCount += GetRacialTypeCount(RACIAL_TYPE_OUTSIDER);
        }
        if(nConstructs == TRUE)
        {
            nCount += GetRacialTypeCount(RACIAL_TYPE_CONSTRUCT);
        }
        nCount += GetRacialTypeCount(RACIAL_TYPE_UNDEAD);

        if(nCount > 0)
        {
            ClearAllActions();
            //ActionCastSpellAtObject(SPELLABILITY_TURN_UNDEAD, OBJECT_SELF);
            ActionUseFeat(FEAT_TURN_UNDEAD, OBJECT_SELF);// GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY));
            return TRUE;
        }
    }

    return FALSE;
}

// ACTIVATE AURAS
int TalentPersistentAbilities()
{
    talent tUse = GetCreatureTalentBest(TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 20);
    int nSpellID;
    if(GetIsTalentValid(tUse))
    {
        nSpellID = GetIdFromTalent(tUse);
        if(!GetHasSpellEffect(nSpellID))
        {
            ClearAllActions();
            ActionUseTalentOnObject(tUse, OBJECT_SELF);
            return TRUE;
        }
    }

    return FALSE;
}

// FAST BUFF SELF
int TalentAdvancedBuff(float fDistance)
{
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    if(GetIsObjectValid(oPC))
    {
        if(GetDistanceToObject(oPC) <= fDistance)
        {
            if(!GetIsFighting(OBJECT_SELF))
            {
                ClearAllActions();
                //Combat Protections
                if(GetHasSpell(SPELL_PREMONITION))
                {
                    ActionCastSpellAtObject(SPELL_PREMONITION, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_GREATER_STONESKIN))
                {
                    ActionCastSpellAtObject(SPELL_GREATER_STONESKIN, OBJECT_SELF, METAMAGIC_NONE, 0, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_STONESKIN))
                {
                    ActionCastSpellAtObject(SPELL_STONESKIN, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                //Visage Protections
                if(GetHasSpell(SPELL_SHADOW_SHIELD))
                {
                    ActionCastSpellAtObject(SPELL_SHADOW_SHIELD, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_ETHEREAL_VISAGE))
                {
                    ActionCastSpellAtObject(SPELL_ETHEREAL_VISAGE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_GHOSTLY_VISAGE))
                {
                    ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                //Mantle Protections
                if(GetHasSpell(SPELL_GREATER_SPELL_MANTLE))
                {
                    ActionCastSpellAtObject(SPELL_GREATER_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SPELL_MANTLE))
                {
                    ActionCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_LESSER_SPELL_BREACH))
                {
                    ActionCastSpellAtObject(SPELL_LESSER_SPELL_BREACH, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                // Globes
                if(GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY))
                {
                    ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY))
                {
                    ActionCastSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }

                //Misc Protections
                if(GetHasSpell(SPELL_ELEMENTAL_SHIELD))
                {
                    ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }

                //Elemental Protections
                if(GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS))
                {
                    ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_RESIST_ELEMENTS))
                {
                    ActionCastSpellAtObject(SPELL_RESIST_ELEMENTS, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_ENDURE_ELEMENTS))
                {
                    ActionCastSpellAtObject(SPELL_ENDURE_ELEMENTS, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }

                //Mental Protections
                if(GetHasSpell(SPELL_MIND_BLANK))
                {
                    ActionCastSpellAtObject(SPELL_MIND_BLANK, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_LESSER_MIND_BLANK))
                {
                    ActionCastSpellAtObject(SPELL_LESSER_MIND_BLANK, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_CLARITY))
                {
                    ActionCastSpellAtObject(SPELL_CLARITY, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                //Summon Ally
                if(GetHasSpell(SPELL_SUMMON_CREATURE_IX))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_IX, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_VIII))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_VIII, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_VII))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_VII, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_VI))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_VI, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_V))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_V, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_IV))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_IV, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_III))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_III, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_II))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_II, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }
                else if(GetHasSpell(SPELL_SUMMON_CREATURE_I))
                {
                    ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_I, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                }


                return TRUE;
            }
        }
    }

    return FALSE;
}

// USE POTIONS
int TalentBuffSelf()
{
    talent tUse;
    int nType;
    int bValid = FALSE;
    int nIndex;

    tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_POTION, 20);
    if(!GetIsTalentValid(tUse))
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, 20);
        if(!GetIsTalentValid(tUse))
        {
            return FALSE;
        }
    }
    nType = GetTypeFromTalent(tUse);
    nIndex = GetIdFromTalent(tUse);

    if(nType == TALENT_TYPE_SPELL)
    {
        if(!GetHasSpellEffect(nIndex))
        {
            ClearAllActions();
            ActionUseTalentOnObject(tUse, OBJECT_SELF);
            return TRUE;
        }
    }

    return FALSE;
}

// CURE DISEASE, POISON ETC
int TalentCureCondition()
{
    int nCurse = 0x00000001;
    int nPoison = 0x00000002;
    int nDisease = 0x00000004;
    int nAbility = 0x00000008;
    int nDrained = 0x00000010;
    int nBlindDeaf = 0x00000020;
    int nSum;
    int nType;
    int nSpell;
    effect eEffect;

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsFriend(oTarget))
        {
            eEffect = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eEffect))
            {
                nType = GetEffectType(eEffect);

                if(nType == EFFECT_TYPE_DISEASE)
                {
                    nSum = nSum | nDisease;
                }
                else if(nType == EFFECT_TYPE_POISON)
                {
                    nSum = nSum | nPoison;
                }
                else if(nType == EFFECT_TYPE_CURSE)
                {
                    nSum = nSum | nCurse;
                }
                else if(nType == EFFECT_TYPE_NEGATIVELEVEL)
                {
                    nSum = nSum | nDrained;
                }
                else if(nType == EFFECT_TYPE_ABILITY_DECREASE)
                {
                    nSum = nSum | nAbility;
                }
                else if(nType == EFFECT_TYPE_BLINDNESS || nType == EFFECT_TYPE_DEAF)
                {
                    nSum = nSum | nBlindDeaf;
                }
                eEffect = GetNextEffect(oTarget);
            }
        }
        if(nSum != 0)
        {
            if(((nSum & nDrained) ||
                (nSum & nDisease & nPoison) ||
                (nSum & nDisease) ||
                (nSum & nBlindDeaf) ||
                (nSum & nCurse & nPoison) ||
                (nSum & nCurse & nDisease) ||
                (nSum & nBlindDeaf & nPoison) ||
                (nSum & nCurse & nBlindDeaf) ||
                (nSum & nBlindDeaf & nDisease)) &&
                (GetHasSpell(SPELL_GREATER_RESTORATION) || GetHasSpell(SPELL_RESTORATION))
               )
            {
                nSpell = SPELL_GREATER_RESTORATION;
                if(!GetHasSpell(SPELL_GREATER_RESTORATION))
                {
                    nSpell = SPELL_RESTORATION;
                }
            }
            else if((nSum & nAbility) &&
                    (GetHasSpell(SPELL_GREATER_RESTORATION) || GetHasSpell(SPELL_RESTORATION) || GetHasSpell(SPELL_LESSER_RESTORATION)))
            {
                nSpell = SPELL_GREATER_RESTORATION;
                if(!GetHasSpell(SPELL_GREATER_RESTORATION))
                {
                    nSpell = SPELL_RESTORATION;
                    if(!GetHasSpell(SPELL_RESTORATION))
                    {
                        nSpell = SPELL_LESSER_RESTORATION;
                    }
                }
            }
            else if(((nSum & nPoison) ||
                    (nSum & nDisease & nPoison) ||
                    (nSum & nDisease)) &&
                    GetHasSpell(SPELL_NEUTRALIZE_POISON))
            {
                nSpell = SPELL_NEUTRALIZE_POISON;
            }
            else if((nSum & nDisease) && GetHasSpell(SPELL_REMOVE_DISEASE))
            {
                nSpell = SPELL_REMOVE_DISEASE;
            }
            else if((nSum & nCurse) && GetHasSpell(SPELL_REMOVE_CURSE))
            {
                nSpell = SPELL_REMOVE_CURSE;
            }
            else if((nSum & nBlindDeaf) && GetHasSpell(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS))
            {
                nSpell = SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
            }
            if(nSpell != 0)
            {
                ClearAllActions();
                ActionCastSpellAtObject(nSpell, oTarget);
                return TRUE;
            }
        }
        nSum = 0;
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }

    return FALSE;
}

// DRAGON COMBAT
int TalentDragonCombat(object oIntruder = OBJECT_INVALID)
{
    object oTarget = oIntruder;
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = GetAttemptedAttackTarget();
        if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget))
        {
            oTarget = GetLastHostileActor();
            if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget))
            {
                oTarget = GetNearestSeenOrHeardEnemy();
                if(!GetIsObjectValid(oTarget))
                {
                    return FALSE;
                }
            }
        }
    }
    talent tUse;
    int nCnt = GetLocalInt(OBJECT_SELF, "NW_GENERIC_DRAGONS_BREATH");
    tUse = GetCreatureTalentBest(TALENT_CATEGORY_DRAGONS_BREATH, 20);
    //SpeakString(IntToString(nCnt));
    if(GetIsTalentValid(tUse) && nCnt >= 2)
    {
        ClearAllActions();
        ActionUseTalentOnObject(tUse, oTarget);
        nCnt = 0;
        SetLocalInt(OBJECT_SELF, "NW_GENERIC_DRAGONS_BREATH", nCnt);
        return TRUE;
    }
    nCnt++;
    tUse = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_MELEE);
    if(GetIsTalentValid(tUse) && VerifyDisarm(tUse, oTarget))
    {
        ClearAllActions();
        ActionUseTalentOnObject(tUse, oTarget);
        SetLocalInt(OBJECT_SELF, "NW_GENERIC_DRAGONS_BREATH", nCnt);
        return TRUE;
    }
    else
    {
        ClearAllActions();
        ActionAttack(oTarget);
        SetLocalInt(OBJECT_SELF, "NW_GENERIC_DRAGONS_BREATH", nCnt);
        return TRUE;
    }

    SetLocalInt(OBJECT_SELF, "NW_GENERIC_DRAGONS_BREATH", nCnt);
    return FALSE;
}

// BARD SONG
int TalentBardSong()
{
    //BARD SONG CONSTANT PENDING
    if(!GetHasSpellEffect(411))
    {
        if(GetHasFeat(FEAT_BARD_SONGS))
        {
            ClearAllActions();
            ActionUseFeat(FEAT_BARD_SONGS, OBJECT_SELF);
            return TRUE;
        }
    }

    return FALSE;
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************
// VERSION 2.0 TALENTS
//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************

// ADVANCED PROTECT SELF Talent 2.0
// This will use the class specific defensive spells first and leave the rest for the normal defensive AI

int TalentAdvancedProtectSelf()
{

    talent tUse;
    struct sEnemies sCount = DetermineEnemies();
    int bValid = FALSE;
    int nCnt;
    string sClass = GetMostDangerousClass(sCount);
    tUse = StartProtectionLoop();
    while(GetIsTalentValid(tUse) && nCnt < 10)
    {
        tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SELF);
        if(GetIsTalentValid(tUse) && GetMatchCompatibility(tUse, sClass, NW_TALENT_PROTECT))
        {
            bValid = TRUE;
            nCnt = 11;
        }
        else
        {
            tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE);
            if(GetIsTalentValid(tUse) && GetMatchCompatibility(tUse, sClass, NW_TALENT_PROTECT))
            {
                bValid = TRUE;
                nCnt = 11;
            }
            else
            {
                tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_PROTECTION_AREAEFFECT);
                if(GetIsTalentValid(tUse) && GetMatchCompatibility(tUse, sClass, NW_TALENT_PROTECT))
                {
                    bValid = TRUE;
                    nCnt = 11;
                }
            }
        }
        nCnt++;
    }
    if(bValid == TRUE)
    {
        int nType = GetTypeFromTalent(tUse);
        int nIndex = GetIdFromTalent(tUse);

        if(nType == TALENT_TYPE_SPELL)
        {
            if(!GetHasSpellEffect(nIndex))
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, OBJECT_SELF);
                return TRUE;
            }
        }
        else if(nType == TALENT_TYPE_FEAT)
        {
            if(!GetHasFeatEffect(nIndex))
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, OBJECT_SELF);
                return TRUE;
            }
        }
        else
        {
            ClearAllActions();
            ActionUseTalentOnObject(tUse, OBJECT_SELF);
            return TRUE;
        }
    }

    return FALSE;
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************
// PRIVATE FUNCTIONS
//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************

//::///////////////////////////////////////////////
//:: Get Character Levels
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns the combined class levels of the
    target.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////

int GetCharacterLevel(object oTarget)
{
    return GetLevelByPosition(1, oTarget) + GetLevelByPosition(2, oTarget) + GetLevelByPosition(3, oTarget);
}

//::///////////////////////////////////////////////
//:: Get Has Effect
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if the target has a given
    spell effect
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////
int GetHasEffect(int nEffectType, object oTarget = OBJECT_SELF)
{
    effect eCheck = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck) == nEffectType)
        {
             return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Check Friendly Fire on Target
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes a target object and a radius and
    returns how many targets of the caster's faction
    are in that zone.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:  , 2001
//:://////////////////////////////////////////////

int CheckFriendlyFireOnTarget(object oTarget, float fDistance = 5.0)
{
    int nCnt, nHD, nMyHD;
    nMyHD = GetHitDice(OBJECT_SELF);
    object oCheck = GetFirstObjectInShape(SHAPE_SPHERE, fDistance, GetLocation(oTarget));
    while(GetIsObjectValid(oCheck))
    {
        //Use this instead of GetIsFriend to make sure that friendly casualties do not occur.
        //Formerlly GetIsReactionTypeFriendly(oCheck)
        nHD = GetHitDice(oCheck);
        if((GetIsFriend(oCheck)) &&
            oTarget != oCheck &&
            nMyHD <= (nHD * 2))
        {
            if(!GetIsReactionTypeFriendly(oCheck) || !AssociateCheck(oCheck))
            {
                nCnt++;
            }
        }
        oCheck = GetNextObjectInShape(SHAPE_SPHERE, fDistance, GetLocation(oTarget));
    }
    return nCnt;
}

//::///////////////////////////////////////////////
//:: Check For Enemies Around Target
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes a target object and a radius and
    returns how many targets of the enemy faction
    are in that zone.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
int CheckEnemyGroupingOnTarget(object oTarget, float fDistance = 5.0)
{
    int nCnt;
    object oCheck = GetFirstObjectInShape(SHAPE_SPHERE, fDistance, GetLocation(oTarget));
    while(GetIsObjectValid(oCheck))
    {
        if(GetIsEnemy(oCheck) && oTarget != oCheck)
        {
            nCnt++;
        }
        oCheck = GetNextObjectInShape(SHAPE_SPHERE, fDistance, GetLocation(oTarget));
    }
    return nCnt;
}

//::///////////////////////////////////////////////
//:: Find Single Ranged Target
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Seeks out an enemy more than 5m away and alone
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: October 5, 2001
//:://////////////////////////////////////////////

object FindSingleRangedTarget()
{
    int nCnt = FALSE;
    object oTarget;
    float fDistance = 50.0;
    object oCount = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF));
    while (GetIsObjectValid(oCount) && nCnt == FALSE)
    {
        if(oCount != OBJECT_SELF)
        {
            if(GetIsEnemy(oCount) && oTarget != OBJECT_SELF)
            {
                fDistance = GetDistanceBetween(oTarget, OBJECT_SELF);
                if(fDistance == 0.0)
                {
                    fDistance = 60.0;
                }
                if(GetDistanceBetween(oCount, OBJECT_SELF) < fDistance && fDistance > 3.0)
                {
                    oTarget = oCount;
                    //nCnt = TRUE;
                }
            }
        }
        oCount = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF));
    }
    return oTarget;
}

//::///////////////////////////////////////////////
//:: GetNumberOfMeleeAttackers
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check how many enemies are within 5m of the
    target object.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 11, 2001
//:://////////////////////////////////////////////
int GetNumberOfMeleeAttackers()
{
    int nCnt = 0;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE);
    while(GetIsObjectValid(oTarget))
    {
         if(GetIsEnemy(oTarget))
         {
            nCnt++;
         }
         oTarget = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE);
    }
    return nCnt;
}

//::///////////////////////////////////////////////
//:: GetNumberOfRangedAttackers
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check how many enemies are attacking the
    target from as distance
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 12, 2001
//:://////////////////////////////////////////////
int GetNumberOfRangedAttackers()
{
    int nCnt;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), TRUE);
    while(GetIsObjectValid(oTarget))
    {
         if(GetAttackTarget(oTarget) == OBJECT_SELF && GetDistanceBetween(OBJECT_SELF, oTarget) > 5.0)
         {
            nCnt++;
         }
         oTarget = GetNextObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), TRUE);
    }
    return nCnt;
}

//::///////////////////////////////////////////////
//:: Get Percentage of HP Loss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns a number between 0 and 1.0 that gives
    a representation of how wounded the target is.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetPercentageHPLoss(object oWounded)
{
    float fMaxHP = IntToFloat(GetMaxHitPoints(oWounded));
    float fCurrentHP = IntToFloat(GetCurrentHitPoints(oWounded));
    float fHP_Perc = (fCurrentHP / fMaxHP) * 100;

    int nHP = FloatToInt(fHP_Perc);

    return nHP;
}

//::///////////////////////////////////////////////
//:: Get Racial Type Count
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Counts and returns the number of a certain
    racial type within a certain radius.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetRacialTypeCount(int nRacial_Type)
{
    int nCnt = 1;
    int nCount = 0;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_RACIAL_TYPE, nRacial_Type);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 20.0)
    {
        if(!GetHasEffect(EFFECT_TYPE_TURNED, oTarget))
        {
            nCount++;
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_RACIAL_TYPE, nRacial_Type);
    }
    return nCount;
}

//::///////////////////////////////////////////////
//:: Get Enemy Creature Seen or Heard
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function finds an enemy that can be seen
    first and if that fails an enemy that can be
    heard only.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 28, 2002
//:://////////////////////////////////////////////

object GetNearestSeenOrHeardEnemy()
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN);
        if(!GetIsObjectValid(oTarget))
        {
           return OBJECT_INVALID;
        }
    }
    return oTarget;
}

//::///////////////////////////////////////////////
//:: Get / Set Compare Last Spell Cast
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gets the local int off of the character
    determining what the Last Spell Cast was.

    Sets the local int on of the character
    storing what the Last Spell Cast was.

    Compares whether the local is the same as the
    currently selected spell.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 27, 2002
//:://////////////////////////////////////////////

int GetLastGenericSpellCast()
{
    return GetLocalInt(OBJECT_SELF, "NW_GENERIC_LAST_SPELL");
}

void SetLastGenericSpellCast(int nSpell)
{
    SetLocalInt(OBJECT_SELF, "NW_GENERIC_LAST_SPELL", nSpell);
}

int CompareLastSpellCast(int nSpell)
{
    int nLastSpell = GetLastGenericSpellCast();
    if(nSpell == nLastSpell)
    {
        return TRUE;
        SetLastGenericSpellCast(-1);
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Remove Ambient Sleep
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks if the NPC has sleep on them because
    of ambient animations. Sleeping creatures
    must make a DC 15 listen check.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 27, 2002
//:://////////////////////////////////////////////

void RemoveAmbientSleep()
{
    if(GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        effect eSleep = GetFirstEffect(OBJECT_SELF);
        while(GetIsEffectValid(eSleep))
        {
            if(GetEffectCreator(eSleep) == OBJECT_SELF)
            {
                int nRoll = d20();
                nRoll += GetSkillRank(SKILL_LISTEN);
                nRoll += GetAbilityModifier(ABILITY_WISDOM);
                if(nRoll > 15)
                {
                    RemoveEffect(OBJECT_SELF, eSleep);
                }
            }
            eSleep = GetNextEffect(OBJECT_SELF);
        }
    }
}

//::///////////////////////////////////////////////
//:: GetIsFighting
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks if the passed object has an Attempted
    Attack or Spell Target
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 13, 2002
//:://////////////////////////////////////////////
int GetIsFighting(object oFighting)
{
    object oAttack = GetAttemptedAttackTarget();
    object oSpellTarget = GetAttemptedSpellTarget();

    if(GetIsObjectValid(oAttack) || GetIsObjectValid(oSpellTarget))
    {
        return TRUE;
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Get Locked Object
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Finds the closest locked object to the object
    passed in up to a maximum of 10 objects.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 15, 2002
//:://////////////////////////////////////////////

object GetLockedObject(object oMaster)
{
    int nCnt = 1;
    int bValid = TRUE;
    object oLastObject = GetNearestObjectToLocation(OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetLocation(oMaster), nCnt);
    while (GetIsObjectValid(oLastObject) && bValid == TRUE)
    {
        //COMMENT THIS BACK IN WHEN DOOR ACTION WORKS ON PLACABLE.

        //object oItem = GetFirstItemInInventory(oLastObject);
        if(GetLocked(oLastObject))
        {
            return oLastObject;
        }
        nCnt++;
        if(nCnt == 10)
        {
            bValid = FALSE;
        }
        oLastObject = GetNearestObjectToLocation(OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetLocation(oMaster), nCnt);
    }
    return OBJECT_INVALID;
}

//::///////////////////////////////////////////////
//:: Equip Appropriate Weapons
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the user get his best weapons.  If the
    user is a Henchmen then he checks the player
    preference.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 2, 2002
//:://////////////////////////////////////////////

void EquipAppropriateWeapons(object oTarget)
{
    if(GetIsObjectValid(GetMaster()))
    {
        if(GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
        {
            ActionEquipMostDamagingRanged(oTarget);
        }
        else
        {
            ActionEquipMostDamagingMelee(oTarget);
        }
    }
    else
    {
        //if(!GetIsWeaponEffective(oTarget))
        //{
            if(GetDistanceToObject(oTarget) > 5.0)
            {
                ActionEquipMostDamagingRanged(oTarget);
            }
            else
            {
                ActionEquipMostDamagingMelee(oTarget);
            }
        //}
    }
}

int AssociateCheck(object oCheck)
{
    object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN);
    if(oCheck != oHench)
    {
        return TRUE;
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Verify Disarm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks that the melee talent being used
    is Disarm and if so then if the target has a
    weapon.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int VerifyDisarm(talent tUse, object oTarget)
{
    int bValid = FALSE;

    if(GetTypeFromTalent(tUse) == TALENT_TYPE_FEAT)
    {
        int nFeat = GetIdFromTalent(tUse);
        if(nFeat == FEAT_DISARM)
        {
            object oSlot1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
            object oSlot2 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
            object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
            object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

            if(GetIsObjectValid(oSlot1) || GetIsObjectValid(oSlot2))
            {
                if(GetIsObjectValid(oWeapon) && !GetWeaponRanged(oWeapon))
                {

                    return TRUE;
                }
                else if(GetIsObjectValid(oWeapon2) && !GetWeaponRanged(oWeapon2))
                {
                    return TRUE;
                }
            }

            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }

    return TRUE;
}

//::///////////////////////////////////////////////
//:: Verify Melee Talent Use
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes sure that certain talents are not used
    on Elementals, Undead or Constructs
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 23, 2002
//:://////////////////////////////////////////////
int VerifyCombatMeleeTalent(talent tUse, object oTarget)
{
    int nFeatID = GetIdFromTalent(tUse);
    if(nFeatID == FEAT_SAP ||
       nFeatID == FEAT_STUNNING_FIST)
    {
        int nRacial = GetRacialType(oTarget);
        if(nRacial == RACIAL_TYPE_CONSTRUCT ||
           nRacial == RACIAL_TYPE_UNDEAD ||
           nRacial == RACIAL_TYPE_ELEMENTAL ||
           nRacial == RACIAL_TYPE_VERMIN)
        {
            return FALSE;
        }
    }
    return TRUE;
}

//:://////////////////////////////////////////////////////////////////////////////////////////////
//:: Associate Include Functions
//:: NW_I0_ASSOCIATE
//:: Copyright (c) 2001 Bioware Corp.
//:://///////////////////////////////////////////////////////////////////////////////////////////
/*
    Determines and stores the behavior of the
    associates used by the PC
*/
//:://///////////////////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: November 16, 2001
//:://///////////////////////////////////////////////////////////////////////////////////////////

//Distance
int NW_ASC_DISTANCE_2_METERS =   0x00000001;
int NW_ASC_DISTANCE_4_METERS =   0x00000002;
int NW_ASC_DISTANCE_6_METERS =   0x00000004;
//Heal when
int NW_ASC_HEAL_AT_75 =          0x00000008;
int NW_ASC_HEAL_AT_50 =          0x00000010;
int NW_ASC_HEAL_AT_25 =          0x00000020;
//Auto AI
int NW_ASC_AGGRESSIVE_BUFF =     0x00000040;
int NW_ASC_AGGRESSIVE_SEARCH =   0x00000080;
int NW_ASC_AGGRESSIVE_STEALTH =  0x00000100;
//Open Locks on master fail
int NW_ASC_RETRY_OPEN_LOCKS =    0x00000200;
//Casting power
int NW_ASC_OVERKIll_CASTING =    0x00000400; // GetMax Spell
int NW_ASC_POWER_CASTING =       0x00000800; // Get Double CR or max 4 casting
int NW_ASC_SCALED_CASTING =      0x00001000; // CR + 4;

int NW_ASC_USE_CUSTOM_DIALOGUE = 0x00002000;
int NW_ASC_DISARM_TRAPS =        0x00004000;
int NW_ASC_USE_RANGED_WEAPON   = 0x00008000;
int NW_ASC_MODE_DEFEND_MASTER =  0x04000000; //Guard Me Mode, Attack Nearest sets this to FALSE.
int NW_ASC_MODE_STAND_GROUND =   0x08000000; //The Henchman will ignore move to object in the heartbeat
                                             //If this is set to FALSE then they are in follow mode
int NW_ASC_MASTER_GONE =         0x10000000;
int NW_ASC_MASTER_REVOKED =      0x20000000;
int NW_ASC_IS_BUSY =             0x40000000; //Only busy if attempting to bash or pick a lock
int NW_ASC_HAVE_MASTER =         0x80000000; //Not actually used, here for system continuity

void SetAssociateState(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER");
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER", nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER", nPlot);
    }
}

int GetAssociateState(int nCondition)
{
    if(nCondition == NW_ASC_HAVE_MASTER)
    {
        if(GetIsObjectValid(GetMaster()))
        {
            return TRUE;
        }
    }
    else
    {
        int nPlot = GetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER");
        if(nPlot & nCondition)
        {
            return TRUE;
        }
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Get CR Max for Talents
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the Spell CR to be used in the
    given situation
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetAssociateCRMax()
{
    return 20;
}

//::///////////////////////////////////////////////
//:: Should I Heal My Master
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the healing variable for the master
    and then asks if the master if below that level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetAssociateHealMaster()
{
    if(GetAssociateState(NW_ASC_HAVE_MASTER))
    {
        object oMaster = GetMaster();
        int nLoss = GetPercentageHPLoss(oMaster);
        if(!GetIsDead(oMaster))
        {
            if(GetAssociateState(NW_ASC_HEAL_AT_75) && nLoss <= 75)
            {
                return TRUE;
            }
            else if(GetAssociateState(NW_ASC_HEAL_AT_50) && nLoss <= 50)
            {
                return TRUE;
            }
            else if(GetAssociateState(NW_ASC_HEAL_AT_25) && nLoss <= 25)
            {
                return TRUE;
            }
        }
    }
    return FALSE;
}

float GetFollowDistance()
{
    float fDistance;
    if(GetAssociateState(NW_ASC_DISTANCE_2_METERS))
    {
        fDistance = 2.0;
    }
    else if(GetAssociateState(NW_ASC_DISTANCE_4_METERS))
    {
        fDistance = 4.0;
    }
    else if(GetAssociateState(NW_ASC_DISTANCE_6_METERS))
    {
        fDistance = 6.0;
    }
    //SpeakString(FloatToString(fDistance, 5, 5));
    return fDistance;
}


//::///////////////////////////////////////////////
//:: Check if an item is locked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks that an item was unlocked.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////

void CheckIsUnlocked(object oLastObject)
{
    if(GetLocked(oLastObject))
    {
        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_CUSS));
    }
    else
    {
        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_CANDO));
    }
}

//::///////////////////////////////////////////////
//:: Set and Get Associate Start Location
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watmaniuk
//:: Created On: Nov 21, 2001
//:://////////////////////////////////////////////

void SetAssociateStartLocation()
{
    SetLocalLocation(OBJECT_SELF, "NW_ASSOCIATE_START", GetLocation(OBJECT_SELF));
}

location GetAssociateStartLocation()
{
    return GetLocalLocation(OBJECT_SELF, "NW_ASSOCIATE_START");
}

//::///////////////////////////////////////////////
//:: Play Mobile Ambient Animations
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used for spawned creatures to not look like
    zombies
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

void PlayMobileAmbientAnimations()
{
    location lLocal;
    vector vFrnd;
    int nRoll = Random(5)+1;
    object oFriend = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nRoll, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    int nHDMe = GetHitDice(OBJECT_SELF);
    int nHDOther = GetHitDice(oFriend);

    //If a bird
    if(!GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN))
    {
        /*
            Use this animation for all player races and humanoids
            who are civilized. Monstrous races will wonder about
            and try to look busy in as non-social manner.
        */
        if(GetRacialType(OBJECT_SELF) == RACIAL_TYPE_ELF ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_GNOME ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HALFELF ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HALFLING ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HALFORC ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HUMAN ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HUMANOID_GOBLINOID ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HUMANOID_REPTILIAN ||
           GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HUMANOID_ORC)
        {
            if(nRoll == 4 || nRoll == 5)
            {
                ClearAllActions();
                ActionRandomWalk();
            }
            else
            {
                if(!GetIsObjectValid(oFriend) || GetIsPC(oFriend) || IsInConversation(oFriend))
                {
                    ClearAllActions();
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
                }
                else
                {
                    if(GetDistanceToObject(oFriend) >= 3.0 && GetDistanceToObject(oFriend) <= 5.0 )
                    {
                        ClearAllActions();
                        ActionMoveToObject(oFriend, FALSE, 2.0);
                    }
                    else if(GetDistanceToObject(oFriend) >= 5.0)
                    {
                        ClearAllActions();
                        ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING, 0.75);
                        ActionMoveToObject(oFriend, FALSE, 2.0);
                    }
                    vFrnd = GetPosition(oFriend);
                    SetFacingPoint(vFrnd);
                    nRoll = d4();
                }

                if(GetIsObjectValid(oFriend))
                {
                    ClearAllActions();
                    if(nHDMe == nHDOther)
                    {
                        if(nRoll == 1)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0);
                        }
                        else if(nRoll == 2)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0);
                        }
                        else if(nRoll == 3)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0);
                        }
                        else
                        {
                            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
                        }
                    }
                    else if(nHDMe > nHDOther)
                    {
                        if(nRoll == 1)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0);
                        }
                        else if(nRoll == 2)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0);
                        }
                        else if(nRoll == 3)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 6.0);
                        }
                        else
                        {
                            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
                        }
                    }
                    else if (nHDMe < nHDOther)
                    {
                        if(nRoll == 1)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0);
                        }
                        else if(nRoll == 2)
                        {
                            ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0);
                        }
                        else if(nRoll == 3)
                        {
                            ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE, 0.75);
                        }
                        else
                        {
                            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
                        }
                    }
                }
            }
        }
        else
        {
            ClearAllActions();
            int nRand = d6();
            if(nRand == 1)
            {
                if(GetDistanceToObject(oFriend) >= 3.0 && GetDistanceToObject(oFriend) <= 10.0 )
                {
                    ActionMoveToObject(oFriend, FALSE, 2.0);
                    vFrnd = GetPosition(oFriend);
                    SetFacingPoint(vFrnd);
                }
            }
            else if(nRand == 2 || nRand == 3 || nRand == 4)
            {
                ActionRandomWalk();
            }
            else if(nRand == 5)
            {
                ActionPlayAnimation(ANIMATION_LOOPING_GET_MID);
            }
            else if(nRand == 6)
            {
            }
        }
    }
    else //Birds Ambient Behavior
    {
        int nBird = d4();
        location lFriend;
        effect eBird;
        if(GetIsObjectValid(oFriend))
        {
            lFriend = GetLocation(oFriend);
        }
        else
        {
            lFriend = GetLocation(OBJECT_SELF);
        }
        if(nBird == 0)
        {
            ClearAllActions();
            ActionMoveToObject(oFriend, TRUE, 4.0);
   // BK: Commenting this out because the effect wasn't meant to be played here
           // ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBird, OBJECT_SELF, 5.0);
        }
        else if (nBird == 1 || nBird == 2 || nBird == 3)
        {
            ClearAllActions();
            ActionMoveAwayFromObject(oFriend, TRUE, 100.0);
        }
        else
        {
            ClearAllActions();
            eBird = EffectDisappearAppear(lFriend);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBird, OBJECT_SELF, 4.0);
            ActionMoveAwayFromObject(oFriend, TRUE, 100.0);
        }
    }
}

//::///////////////////////////////////////////////
//:: Play Immobile Ambient Animations
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used for spawned creatures to not look like
    zombies
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

void PlayImmobileAmbientAnimations()
{
    location lLocal;
    vector vFrnd;
    int nRoll = d2();
    object oFriend = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nRoll, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    int nHDMe = GetHitDice(OBJECT_SELF);
    int nHDOther = GetHitDice(oFriend);
    if(!GetIsObjectValid(oFriend) || GetIsPC(oFriend) || IsInConversation(oFriend))
    {
        ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
        ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
    }
    else
    {
        if(GetIsObjectValid(oFriend) && GetDistanceToObject(oFriend) <= 3.0)
        {
            vFrnd = GetPosition(oFriend);
            SetFacingPoint(vFrnd);
            nRoll = d4();
            ClearAllActions();
            if(nHDMe == nHDOther)
            {
                if(nRoll == 1)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0);
                }
                else if(nRoll == 2)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0);
                }
                else if(nRoll == 3)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0);
                }
                else
                {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
                }
            }
            else if(nHDMe > nHDOther)
            {
                if(nRoll == 1)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0);
                }
                else if(nRoll == 2)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0);
                }
                else if(nRoll == 3)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 6.0);
                }
                else
                {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
                }
            }
            else if (nHDMe < nHDOther)
            {
                if(nRoll == 1)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0);
                }
                else if(nRoll == 2)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0);
                }
                else if(nRoll == 3)
                {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE, 0.75);
                }
                else
                {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
                }
            }
        }
    }
}

//::///////////////////////////////////////////////
//:: Check for Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks if the passed in object
    has waypoints using their tag.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: MAy 13, 2002
//:://////////////////////////////////////////////
int GetIsPostOrWalking(object oWalker = OBJECT_SELF)
{
    string sTag = GetTag(oWalker);

    object oPost = GetWaypointByTag("POST_" + sTag);
    if(!GetIsObjectValid(oPost))
    {
        oPost = GetWaypointByTag("NIGHT_" + sTag);
        if(!GetIsObjectValid(oPost))
        {
            oPost = GetWaypointByTag("WP_" + sTag + "_01");
            if(!GetIsObjectValid(oPost))
            {
                oPost = GetWaypointByTag("WN_" + sTag + "_01");
                if(!GetIsObjectValid(oPost))
                {
                    return FALSE;
                }
            }
        }
    }
    return TRUE;
}
//:://////////////////////////////////////////////////////////////////////////////////////////////
//:: Special Behavior Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://///////////////////////////////////////////////////////////////////////////////////////////
/*
    These commands handle the setting and getting of the Behavioral Master
    If these special behaviors are used they will override the normal behavior expected
    the animals normal Neutral Faction.
*/
//:://///////////////////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 10, 2001
//:://///////////////////////////////////////////////////////////////////////////////////////////
void SetBehaviorState(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER");
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER", nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER", nPlot);
    }
}

int GetBehaviorState(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER");
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Determine Special Behavior
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the special behavior used by the NPC.
    Generally all NPCs who you want to behave differently
    than the defualt behavior.
    For these behaviors, passing in a valid object will
    cause the creature to become hostile the the attacker.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 14, 2001
//:://////////////////////////////////////////////

void DetermineSpecialBehavior(object oIntruder = OBJECT_INVALID)
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF ,1, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE))
    {
        if(!GetIsObjectValid(oIntruder))
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttackTarget()))
            {
                if(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 5.0)
                {
                    if(!GetIsFriend(oTarget))
                    {
                        if(GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 && GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0)
                        {
                            SetIsTemporaryEnemy(oTarget, OBJECT_SELF, FALSE, 20.0);
                            DetermineCombatRound(oTarget);
                        }
                    }
                }
            }
        }
        else if(!IsInConversation(OBJECT_SELF))
        {
            DetermineCombatRound(oIntruder);
        }
        else
        {
            ClearAllActions();
            ActionRandomWalk();
            return;
        }
    }
    else if(GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
    {
        if(!GetIsObjectValid(GetAttemptedAttackTarget()) &&
           !GetIsObjectValid(GetAttemptedSpellTarget()) &&
           !GetIsObjectValid(GetAttackTarget()))
        {
            if(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 6.0)
            {
                if(!GetIsFriend(oTarget))
                {
                    if(GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 && GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0)
                    {
                        TalentFlee(oTarget);
                    }
                }
            }
        }
        else if(!IsInConversation(OBJECT_SELF))
        {
            ClearAllActions();
            ActionRandomWalk();
            return;
        }
    }
}

//::///////////////////////////////////////////////
//:: Reset Henchmen
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the henchmen to commandable, deletes locals
    having to do with doors and clears actions
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

void ResetHenchmenState()
{
    SetCommandable(TRUE);
    DeleteLocalObject(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH");
    DeleteLocalInt(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH_HP");
    SetAssociateState(NW_ASC_IS_BUSY, FALSE);
    ClearAllActions();
}

//::///////////////////////////////////////////////
//:: Bash Doors
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used in DetermineCombatRound to keep a
    henchmen bashing doors.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int BashDoorCheck(object oIntruder = OBJECT_INVALID)
{
    int bDoor = FALSE;
    //This code is here to make sure that henchmen keep bashing doors and placables.
    object oDoor = GetLocalObject(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH");
    if(GetIsObjectValid(oDoor))
    {
        int nDoorMax = GetMaxHitPoints(oDoor);
        int nDoorNow = GetCurrentHitPoints(oDoor);
        int nCnt = GetLocalInt(OBJECT_SELF,"NW_GENERIC_DOOR_TO_BASH_HP");
        if(!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN))
           || (!GetIsObjectValid(oIntruder) && !GetIsObjectValid(GetMaster())))
        {
            if(GetLocked(oDoor))
            {
                if(nDoorMax == nDoorNow)
                {
                    nCnt++;
                    SetLocalInt(OBJECT_SELF,"NW_GENERIC_DOOR_TO_BASH_HP", nCnt);
                }
                if(nCnt <= 0)
                {
                    bDoor = TRUE;
                    if(GetHasFeat(FEAT_IMPROVED_POWER_ATTACK))
                    {
                        ActionUseFeat(FEAT_IMPROVED_POWER_ATTACK, oDoor);
                    }
                    else if(GetHasFeat(FEAT_POWER_ATTACK))
                    {
                        ActionUseFeat(FEAT_POWER_ATTACK, oDoor);
                    }
                    else
                    {
                        ActionAttack(oDoor);
                    }
                }
            }
        }
        if(bDoor == FALSE)
        {
            PlayVoiceChat(VOICE_CHAT_CUSS);
            DeleteLocalObject(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH");
            DeleteLocalInt(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH_HP");
        }
    }
    return bDoor;
}

//::///////////////////////////////////////////////
//:: Determine Class to Use
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines which of a NPCs three classes to
    use in DetermineCombatRound
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int DetermineClassToUse()
{
    int nClass;
    int nTotal = GetCharacterLevel(OBJECT_SELF);
    float fTotal = IntToFloat(nTotal);

    int nState1 = FloatToInt((IntToFloat(GetLevelByClass(GetClassByPosition(1))) / fTotal) * 100);


    int nState2 = FloatToInt((IntToFloat(GetLevelByClass(GetClassByPosition(2))) / fTotal) * 100) + nState1;


    int nState3 = FloatToInt((IntToFloat(GetLevelByClass(GetClassByPosition(3))) / fTotal) * 100) + nState2;


    int nUseClass = d100();


    if(nUseClass <= nState1)
    {
        nClass = GetClassByPosition(1);
    }
    else if(nUseClass > nState1 && nUseClass <= nState2)
    {
        nClass = GetClassByPosition(2);
    }
    else
    {
        nClass = GetClassByPosition(3);
    }


    return nClass;
}

//::///////////////////////////////////////////////
//:: Determine Enemies
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Uses four general categories to determine what
    kinds of enemies the NPC is facing.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

struct sEnemies DetermineEnemies()
{
    struct sEnemies sEnemyCount;

    int nCnt = 1;
    int nClass;
    int nHD;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 40.0)
    {
        nClass = GetClassByPosition(1, oTarget);
        nHD = GetHitDice(oTarget);
        if(nClass == CLASS_TYPE_ANIMAL ||
           nClass == CLASS_TYPE_BARBARIAN ||
           nClass == CLASS_TYPE_BEAST ||
           nClass == CLASS_TYPE_COMMONER ||
           nClass == CLASS_TYPE_CONSTRUCT ||
           nClass == CLASS_TYPE_ELEMENTAL ||
           nClass == CLASS_TYPE_FIGHTER ||
           nClass == CLASS_TYPE_GIANT ||
           nClass == CLASS_TYPE_HUMANOID ||
           nClass == CLASS_TYPE_MONSTROUS ||
           nClass == CLASS_TYPE_PALADIN ||
           nClass == CLASS_TYPE_RANGER ||
           nClass == CLASS_TYPE_ROGUE ||
           nClass == CLASS_TYPE_VERMIN ||
           nClass == CLASS_TYPE_MONK ||
           nClass == CLASS_TYPE_SHAPECHANGER)
        {
            sEnemyCount.FIGHTERS += 1;
            sEnemyCount.FIGHTER_LEVELS += nHD;
        }
        else if(nClass == CLASS_TYPE_CLERIC ||
           nClass == CLASS_TYPE_DRUID)
        {
            sEnemyCount.CLERICS += 1;
            sEnemyCount.CLERIC_LEVELS += nHD;
        }
        else if(nClass == CLASS_TYPE_BARD ||
           nClass == CLASS_TYPE_FEY ||
           nClass == CLASS_TYPE_SORCERER ||
           nClass == CLASS_TYPE_WIZARD)
        {
           sEnemyCount.MAGES += 1;
           sEnemyCount.MAGE_LEVELS += nHD;
        }
        else if(nClass == CLASS_TYPE_ABERRATION ||
           nClass == CLASS_TYPE_DRAGON ||
           nClass == CLASS_TYPE_MAGICAL_BEAST ||
           nClass == CLASS_TYPE_OUTSIDER)
        {
           sEnemyCount.MONSTERS += 1;
           sEnemyCount.MONTERS_LEVELS += nHD;
        }
        sEnemyCount.TOTAL += 1;
        sEnemyCount.TOTAL_LEVELS += nHD;
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
    return sEnemyCount;
}

//::///////////////////////////////////////////////
//:: Get Most Dangerious Class
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Use the four archetypes to determine the
    most dangerous group type facing the NPC
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

string GetMostDangerousClass(struct sEnemies sCount)
{
    string sClass;
    int nFighter = ((sCount.FIGHTER_LEVELS) * 13)/10;
    //SpeakString(IntToString(nFighter) + " " + IntToString(sCount.CLERIC_LEVELS) + " " + IntToString(sCount.MAGE_LEVELS) + " " + IntToString(sCount.MONTERS_LEVELS));

    if(nFighter >= sCount.CLERIC_LEVELS)
    {
        if(nFighter >= sCount.MAGE_LEVELS)
        {
            if(nFighter >= sCount.MONTERS_LEVELS)
            {
                sClass = "FIGHTER";
            }
            else
            {   sClass = "MONSTER";

            }
        }
        else if(sCount.MAGE_LEVELS >= sCount.MONTERS_LEVELS)
        {
            sClass = "MAGE";
        }
        else
        {
            sClass = "MONSTER";
        }
    }
    else if(sCount.CLERIC_LEVELS >= sCount.MAGE_LEVELS)
    {
        if(sCount.CLERIC_LEVELS >= sCount.MONTERS_LEVELS)
        {
            sClass = "CLERIC";
        }
        else
        {
            sClass = "MONSTER";
        }
    }
    else if(sCount.MAGE_LEVELS >= sCount.MONTERS_LEVELS)
    {
        sClass = "MAGE";
    }
    else
    {
        sClass = "MONSTER";
    }
    return sClass;
}

//::///////////////////////////////////////////////
//:: Protection Matching Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    These three functions break protections into
    3 categories COMBAT, SPELL and ELEMENTAL
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int GetMatchCompatibility(talent tUse, string sClass, int nType)
{
    int bValid;
    if(nType == NW_TALENT_PROTECT)
    {
        if(sClass == "FIGHTER")
        {
            if(MatchCombatProtections(tUse))
            {
                bValid = TRUE;
            }
        }
        else if(sClass == "MAGE")
        {
            if(MatchSpellProtections(tUse))
            {
                bValid = TRUE;
            }
            else if(MatchElementalProtections(tUse))
            {
                bValid = TRUE;
            }
        }
        else if(sClass == "CLERIC" || sClass == "MONSTER")
        {
            if(MatchCombatProtections(tUse))
            {
                bValid = TRUE;
            }
            else if(MatchElementalProtections(tUse))
            {
                bValid = TRUE;
            }
        }
    }

    return bValid;
}

int MatchCombatProtections(talent tUse)
{
    int nIndex = GetIdFromTalent(tUse);

    if(nIndex == SPELL_PREMONITION ||
       nIndex == SPELL_ELEMENTAL_SHIELD ||
       nIndex == SPELL_GREATER_STONESKIN ||
       nIndex == SPELL_SHADOW_SHIELD ||
       nIndex == SPELL_ETHEREAL_VISAGE ||
       nIndex == SPELL_STONESKIN ||
       nIndex == SPELL_GHOSTLY_VISAGE)
    {
        return TRUE;
    }
    return FALSE;
}

int MatchSpellProtections(talent tUse)
{
    int nIndex = GetIdFromTalent(tUse);

    if(nIndex == SPELL_GREATER_SPELL_MANTLE ||
       nIndex == SPELL_SPELL_MANTLE ||
       nIndex == SPELL_LESSER_SPELL_MANTLE ||
       nIndex == SPELL_SHADOW_SHIELD ||
       nIndex == SPELL_GLOBE_OF_INVULNERABILITY ||
       nIndex == SPELL_MINOR_GLOBE_OF_INVULNERABILITY ||
       nIndex == SPELL_ETHEREAL_VISAGE ||
       nIndex == SPELL_GHOSTLY_VISAGE ||
       nIndex == SPELL_SPELL_RESISTANCE ||
       nIndex == SPELL_PROTECTION_FROM_SPELLS ||
       nIndex == SPELL_NEGATIVE_ENERGY_PROTECTION)
    {
        return TRUE;
    }
    return FALSE;
}

int MatchElementalProtections(talent tUse)
{
    int nIndex = GetIdFromTalent(tUse);

    if(nIndex == SPELL_ENERGY_BUFFER ||
       nIndex == SPELL_PROTECTION_FROM_ELEMENTS ||
       nIndex == SPELL_RESIST_ELEMENTS ||
       nIndex == SPELL_ENDURE_ELEMENTS)
    {
        return TRUE;
    }
    return FALSE;
}

talent StartProtectionLoop()
{
    talent tUse;
    tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SELF);
    if(GetIsTalentValid(tUse))
    {
        return tUse;
    }
    else
    {
        tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE);
        if(GetIsTalentValid(tUse))
        {
             return tUse;
        }
        else
        {
            tUse = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_PROTECTION_AREAEFFECT);
            if(GetIsTalentValid(tUse))
            {
                 return tUse;
            }
        }
    }
    return tUse;
}

void DubugPrintTalentID(talent tTalent)
{
//    int nID = GetIdFromTalent(tTalent);
}

// Jugalator Script Additions Start -------------------------------------------

int TalentImportantArcaneSpells(int nClass)
{
    // Set oPC to nearest enemy
    object oPC = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    if (!GetIsObjectValid(oPC)) return FALSE;

    // Set oAlly to nearest ally
    object oAlly = Jug_GetNearestAlly();
    int iHasAlly = GetIsObjectValid(oAlly);

    // Set oMaster to summon's master (OBJECT_INVALID if no summon)
    object oMaster = GetMaster(oPC);

    // Set oInvis to nearest heard & invisible enemy
    object oInvis = GetNearestCreature(CREATURE_TYPE_REPUTATION,
        REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION,
        PERCEPTION_HEARD_AND_NOT_SEEN);

    int iPartyHD = GetAverageHD();
    int iMyHD = GetHitDice(OBJECT_SELF);
    int iLostHP = GetMaxHitPoints() - GetCurrentHitPoints();

    // Get primary modifier for class
    int iMod;
    if (nClass == CLASS_TYPE_WIZARD) {
        iMod = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE);
    } else if (nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_BARD) {
        iMod = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA);
    } else { // monster class
        iMod = 20; // monster classes can always cast the spell since it's now a special ability
    }

    // Attempt to detect heard, but not seen, enemies
    if (GetIsObjectValid(oInvis))
    {
        if (Jug_AtLocation(SPELL_TRUE_SEEING, oPC, iMod, 16)) return TRUE;
        if (Jug_AtLocation(SPELL_SEE_INVISIBILITY, oPC, iMod, 12)) return TRUE;
    }

    // Cast Dismissal on summon
    if (GetIsObjectValid(oMaster))
    {
        if (Jug_AtObject(SPELL_DISMISSAL, oPC, iMod, 15)) return TRUE;
    }

    // Dispel Nearest Enemy's Beneficial Spells
    if (Jug_GetHasBeneficialEnhancement(oPC))
    {
        if (Jug_AtObject(SPELL_MORDENKAINENS_DISJUNCTION, oPC, iMod, 19)) return TRUE;
        if (Jug_AtObject(SPELL_GREATER_SPELL_BREACH, oPC, iMod, 16)) return TRUE;
        if (Jug_AtObject(SPELL_GREATER_DISPELLING, oPC, iMod, 16)) return TRUE;
        if (Jug_AtObject(SPELL_LESSER_SPELL_BREACH, oPC, iMod, 14)) return TRUE;
        if (Jug_AtObject(SPELL_DISPEL_MAGIC, oPC, iMod, 13)) return TRUE;
        if (Jug_AtObject(SPELL_LESSER_DISPEL, oPC, iMod, 12)) return TRUE;
    }

    //Haste
    if (!(GetHasSpellEffect(SPELL_MASS_HASTE) || GetHasSpellEffect(SPELL_HASTE)))
    {
        if (Jug_AtLocation(SPELL_MASS_HASTE, OBJECT_SELF, iMod, 16)) return TRUE;
        if (Jug_AtObject(SPELL_HASTE, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    // Haste (same as above, but for allies)
    if (GetHasSpellEffect(SPELL_MASS_HASTE) && iHasAlly &&
         !GetHasSpellEffect(SPELL_MASS_HASTE, oAlly))
    {
        if (Jug_AtObject(SPELL_HASTE, oAlly, iMod, 13)) return TRUE;
    }

    //Time Stop
    if (!GetHasSpellEffect(SPELL_TIME_STOP)) {
        if (Jug_AtObject(SPELL_TIME_STOP, OBJECT_SELF, iMod, 19)) return TRUE;
    }

    //Circle of Death
    //CONDITION: Average enemy party hd less than 10
    if (iPartyHD < 10) {
        if (Jug_AtLocation(SPELL_CIRCLE_OF_DEATH, oPC, iMod, 16)) return TRUE;
    }

    //Power Word: Stun
    //CONDITION: Targeted (and closest) enemy HD less than 14
    if (GetHitDice(oPC) < 14) {
        if (Jug_AtObject(SPELL_POWER_WORD_STUN, oPC, iMod, 17)) return TRUE;
    }

    //Physical Damage Protections

    if (!(GetHasSpellEffect(SPELL_PREMONITION) || GetHasSpellEffect(SPELL_GREATER_STONESKIN) ||
            GetHasSpellEffect(SPELL_STONESKIN)))
    {
        if (Jug_AtObject(SPELL_PREMONITION, OBJECT_SELF, iMod, 18)) return TRUE;
        if (Jug_AtObject(SPELL_GREATER_STONESKIN, OBJECT_SELF, iMod, 16)) return TRUE;
        if (Jug_AtObject(SPELL_STONESKIN, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    // Physical Protections (same as above, but for allies)
    if ((GetHasSpellEffect(SPELL_PREMONITION) || GetHasSpellEffect(SPELL_GREATER_STONESKIN) ||
         GetHasSpellEffect(SPELL_STONESKIN)) && iHasAlly)
    {
        if (!(GetHasSpellEffect(SPELL_PREMONITION, oAlly) ||
              GetHasSpellEffect(SPELL_GREATER_STONESKIN, oAlly) ||
              GetHasSpellEffect(SPELL_STONESKIN, oAlly)))
        {
            if (Jug_AtObject(SPELL_PREMONITION, oAlly, iMod, 18)) return TRUE;
            if (Jug_AtObject(SPELL_GREATER_STONESKIN, oAlly, iMod, 16)) return TRUE;
            if (Jug_AtObject(SPELL_STONESKIN, oAlly, iMod, 14)) return TRUE;
        }
    }

    //Gate

    //CONDITION: Protection from Evil active on self
    if ((GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
        GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL)) &&
        !GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED)))
    {
        if (Jug_AtLocation(SPELL_GATE, oPC, iMod, 19)) return TRUE;
    }

    //Visibility Protections
    if (!(GetHasSpellEffect(SPELL_MASS_BLINDNESS_AND_DEAFNESS, oPC) ||
        GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY)))
    {
        if (Jug_AtLocation(SPELL_MASS_BLINDNESS_AND_DEAFNESS, oPC, iMod, 18)) return TRUE;
        if (Jug_AtObject(SPELL_IMPROVED_INVISIBILITY, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    // Visibility Protections (same as above, but for allies)
    if (GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY) && iHasAlly &&
        !GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY, oAlly))
    {
        if (Jug_AtObject(SPELL_IMPROVED_INVISIBILITY, oAlly, iMod, 14)) return TRUE;
    }

    //Protection from Evil / Magic Circle Against Evil
    // ... in preparation for Gate!
    if (GetHasSpell(SPELL_GATE) && (!(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
        GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL))))
    {
        if (Jug_AtObject(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, OBJECT_SELF, iMod, 13)) return TRUE;
        if (Jug_AtObject(SPELL_PROTECTION_FROM_EVIL, OBJECT_SELF, iMod, 11)) return TRUE;
    }

    // Protections vs Evil (same as above, but for allies)
    if ((GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
        GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL)) && iHasAlly &&
        !(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL, oAlly) ||
          GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oAlly)))
    {
        if (Jug_AtObject(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oAlly, iMod, 13)) return TRUE;
        if (Jug_AtObject(SPELL_PROTECTION_FROM_EVIL, oAlly, iMod, 11)) return TRUE;
    }

    //Dominate
    //CONDITION: Enemies less than 8 levels below me (powerful enemies)
    if (!(GetHasSpellEffect(SPELL_DOMINATE_MONSTER, oPC) ||
        GetHasSpellEffect(SPELL_DOMINATE_PERSON, oPC)) && (iPartyHD - iMyHD) >= -8)
    {
        if (Jug_AtObject(SPELL_DOMINATE_MONSTER, oPC, iMod, 19)) return TRUE;
        if (Jug_AtObject(SPELL_DOMINATE_PERSON, oPC, iMod, 15)) return TRUE;
    }

    //Shapechange
    if (!GetHasSpellEffect(SPELL_SHAPECHANGE)) {
        if (Jug_AtObject(SPELL_SHAPECHANGE, OBJECT_SELF, iMod, 19)) return TRUE;
    }

    //Protection from Spells
    //CONDITION: Enemies less than 5 levels below me (powerful enemies)
    //CONDITION 2: At least 3 allies
    if (!GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS) &&
        (iPartyHD - iMyHD) >= -5 && CheckFriendlyFireOnTarget(OBJECT_SELF) > 2)
    {
        if (Jug_AtObject(SPELL_PROTECTION_FROM_SPELLS, OBJECT_SELF, iMod, 17)) return TRUE;
    }

    //Mantle Protections
    //CONDITION: Enemies less than 5 levels below me (powerful enemies)
    if (!(GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE) || GetHasSpellEffect(SPELL_SPELL_MANTLE) ||
        GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE)) && (iPartyHD - iMyHD) >= -5)
    {
        if (Jug_AtObject(SPELL_GREATER_SPELL_MANTLE, OBJECT_SELF, iMod, 19)) return TRUE;
        if (Jug_AtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, iMod, 17)) return TRUE;
        if (Jug_AtObject(SPELL_LESSER_SPELL_MANTLE, OBJECT_SELF, iMod, 15)) return TRUE;
    }

    //Power Word: Kill
    //CONDITION: Targeted enemy HD less than 10
    if (GetHitDice(oPC) < 10) {
        if (Jug_AtObject(SPELL_POWER_WORD_KILL, oPC, iMod, 19)) return TRUE;
    }

    //Meteor Swarm
    //CONDITION: Closest enemy 5 ft. (1.5 meters) from me
    if (GetDistanceToObject(oPC) > 1.5f) {
        if (Jug_AtLocation(SPELL_METEOR_SWARM, oPC, iMod, 19)) return TRUE;
    }

    //Horrid Wilting
    if (Jug_AtLocation(SPELL_HORRID_WILTING, oPC, iMod, 18)) return TRUE;

    //Mind Blank, 15% chance
    //CONDITION: Avg enemy party HD at least 12
    //NOTE: Lesser Mind Blank a bit wimpy to be in this talent function?
    if (iPartyHD >= 12) {
        if (Jug_AtObject(SPELL_MIND_BLANK, oPC, iMod, 18, 15)) return TRUE;
    }

    //Wail of the Banshee
    if (Jug_AtLocation(SPELL_WAIL_OF_THE_BANSHEE, oPC, iMod, 19)) return TRUE;

    //Weird
    if (Jug_AtObject(SPELL_WEIRD, oPC, iMod, 19)) return TRUE;

    // Energy Drain
    if (Jug_AtObject(SPELL_ENERGY_DRAIN, oPC, iMod, 19)) return TRUE;

    //Visage Protections, 50% chance
    if (!(GetHasSpellEffect(SPELL_SHADOW_SHIELD) || GetHasSpellEffect(SPELL_ETHEREAL_VISAGE) ||
        GetHasSpellEffect(SPELL_GHOSTLY_VISAGE)) && d2() == 1)
    {
        if (Jug_AtObject(SPELL_SHADOW_SHIELD, OBJECT_SELF, iMod, 17)) return TRUE;
        if (Jug_AtObject(SPELL_ETHEREAL_VISAGE, OBJECT_SELF, iMod, 16)) return TRUE;
        if (Jug_AtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, iMod, 12)) return TRUE;
    }

    // Finger of Death
    if (Jug_AtObject(SPELL_FINGER_OF_DEATH, oPC, iMod, 17)) return TRUE;

    // Globes
    if (!(GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY) ||
        GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY)))
    {
        if (Jug_AtObject(SPELL_GLOBE_OF_INVULNERABILITY, oPC, iMod, 16)) return TRUE;
        if (Jug_AtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oPC, iMod, 14)) return TRUE;
    }

    //Elemental Protections
    if (!(GetHasSpellEffect(SPELL_ENERGY_BUFFER) || GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS)))
    {
        if (Jug_AtObject(SPELL_ENERGY_BUFFER, OBJECT_SELF, iMod, 15)) return TRUE;
        if (Jug_AtObject(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    //Misc Protections
    if (!GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD)) {
        if (Jug_AtObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    //Bard War Cry
    if (Jug_AtObject(SPELL_WAR_CRY, OBJECT_SELF, iMod, 14)) return TRUE;

    // Summon Monster, 66% chance
    // NOTE: No Create Undead and others yet, except Mordenkainen's Sword..

    // #### Removed since default AI takes care of summoning in TalentSummonAllies
/*
    if (d3() <= 2) {
        if(!GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED))) { // make sure I don't have a summon already
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_IX, oPC, iMod, 19)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_VIII, oPC, iMod, 18)) return TRUE;
            if (Jug_AtLocation(SPELL_GREATER_PLANAR_BINDING, oPC, iMod, 18)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_VII, oPC, iMod, 17)) return TRUE;
            if (Jug_AtLocation(SPELL_MORDENKAINENS_SWORD, oPC, iMod, 17)) return TRUE;
            if (Jug_AtLocation(SPELL_PLANAR_BINDING, oPC, iMod, 16)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_VI, oPC, iMod, 16)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_V, oPC, iMod, 15)) return TRUE;
            if (Jug_AtLocation(SPELL_ANIMATE_DEAD, oPC, iMod, 15)) return TRUE;
            if (Jug_AtLocation(SPELL_LESSER_PLANAR_BINDING, oPC, iMod, 15)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_IV, oPC, iMod, 14)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_III, oPC, iMod, 13)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_II, oPC, iMod, 12)) return TRUE;
            if (Jug_AtLocation(SPELL_SUMMON_CREATURE_I, oPC, iMod, 11)) return TRUE;
        }
    }
*/
    //
    // Misc mid/low priority offensive spells! :)
    //
    // Some reorganizing (and conditions to avoid wasting precious spell
    // casting time) would very likely be in order here, but just putting those
    // here for now to avoid stupid AI ignoring them. Move to more proper
    // places and add conditions (if necessary) after play testing and getting
    // bright ideas. :)
    //
    // The spells below are (of course) cast in order from most powerful to least.
    //
    // All spells below has 30% chance of being cast
    //

    if (Jug_AtLocation(SPELL_PRISMATIC_SPRAY, oPC, iMod, 17, 30)) return TRUE;

    // Fireballs 100% chance to cast to take the chance while target is in proper range
    if (GetDistanceToObject(oPC) > 5.0 /*&& CheckFriendlyFireOnTarget(oPC, 5.0) > 1*/)
    {
        if (Jug_AtLocation(SPELL_DELAYED_BLAST_FIREBALL, oPC, iMod, 17, 100)) return TRUE;
        if (Jug_AtLocation(SPELL_FIREBALL, oPC, iMod, 13, 100)) return TRUE;
    }

    if (Jug_AtObject(SPELL_CHAIN_LIGHTNING, oPC, iMod, 16, 30)) return TRUE;
    if (Jug_AtLocation(SPELL_ACID_FOG, oPC, iMod, 16, 30)) return TRUE;
//  if (Jug_AtLocation(SPELL_MIND_FOG, oPC, iMod, 16, 30)) return TRUE;
    if (Jug_AtObject(SPELL_HOLD_MONSTER, oPC, iMod, 15, 30)) return TRUE;
    if (Jug_AtObject(SPELL_FEEBLEMIND, oPC, iMod, 15, 30)) return TRUE;
    if (Jug_AtLocation(SPELL_CLOUDKILL, oPC, iMod, 15, 30)) return TRUE;
    if (Jug_AtObject(SPELL_CONE_OF_COLD, oPC, iMod, 15, 30)) return TRUE;
    if (Jug_AtLocation(SPELL_WALL_OF_FIRE, oPC, iMod, 14, 30)) return TRUE;
    if (Jug_AtObject(SPELL_ENERVATION, oPC, iMod, 14, 30)) return TRUE;
    if (Jug_AtLocation(SPELL_EVARDS_BLACK_TENTACLES, oPC, iMod, 14, 30)) return TRUE;
    if (Jug_AtLocation(SPELL_FEAR, oPC, iMod, 14, 30)) return TRUE;
    if (Jug_AtObject(SPELL_ICE_STORM, oPC, iMod, 14, 30)) return TRUE;
    if (Jug_AtObject(SPELL_PHANTASMAL_KILLER, oPC, iMod, 14, 30)) return TRUE;
    if (Jug_AtObject(SPELL_CONFUSION, oPC, iMod, 14, 30)) return TRUE;
    if (Jug_AtObject(SPELL_SLOW, oPC, iMod, 13, 30)) return TRUE;
    if (Jug_AtLocation(SPELL_STINKING_CLOUD, oPC, iMod, 13, 30)) return TRUE;
    if (Jug_AtObject(SPELL_LIGHTNING_BOLT, oPC, iMod, 13, 30)) return TRUE;
    if (Jug_AtObject(SPELL_FLAME_ARROW, oPC, iMod, 13, 30)) return TRUE;
    if (Jug_AtObject(SPELL_BESTOW_CURSE, oPC, iMod, 13, 30)) return TRUE;
    if (Jug_AtObject(SPELL_CONTAGION, oPC, iMod, 13, 30)) return TRUE;

    return FALSE;
}

int TalentImportantDivineSpells(int nClass)
{
    // Generic script for clerics, druids and other divine casters (i.e. monsters)

    // Set oPC to nearest enemy
    object oPC = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    if (!GetIsObjectValid(oPC)) return FALSE;

    // Set oAlly to nearest ally (if found and in reasonable range)
    object oAlly = Jug_GetNearestAlly();
    int iHasAlly = GetIsObjectValid(oAlly);

    // Set oMaster to summon's master (OBJECT_INVALID if no summon)
    object oMaster = GetMaster(oPC);

    // Set oInvis to nearest heard & invisible enemy
    object oInvis = GetNearestCreature(CREATURE_TYPE_REPUTATION,
        REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION,
        PERCEPTION_HEARD_AND_NOT_SEEN);

    int iPartyHD = GetAverageHD();
    int iMyHD = GetHitDice(OBJECT_SELF);
    int iLostHP = GetMaxHitPoints() - GetCurrentHitPoints();

    // Get primary modifier for class
    int iMod = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM);

    int isDruid = (nClass == CLASS_TYPE_DRUID); // TRUE if Druid
    int isMonster = (nClass != CLASS_TYPE_DRUID && nClass != CLASS_TYPE_CLERIC); // TRUE if monster

    // Cure spell adjustment value
    // Cure Wounds spells has +1 Wis requirement for Druids (equivalent spell is 1 level higher)
    int iCureAdj = isDruid ? 1 : 0;

    ///////////////////////////////////////////////////////////////////////////
    // Spell Casting Start
    ///////////////////////////////////////////////////////////////////////////

    // Cure Wounds
    // *** Removed in 0.5 beta since default AI takes care of those ***

    // Attempt to detect heard, but not seen, enemies
    if (GetIsObjectValid(oInvis))
    {
        if (Jug_AtLocation(SPELL_TRUE_SEEING, oPC, iMod, 17 - 2 * iCureAdj)) return TRUE;
        if (!isDruid)
        {
            if (Jug_AtLocation(SPELL_INVISIBILITY_PURGE, oPC, iMod, 13)) return TRUE;
        }
    }

    // Cast Dismissal on summon
    if (GetIsObjectValid(oMaster))
    {
        if (Jug_AtObject(SPELL_DISMISSAL, oPC, iMod, 14)) return TRUE;
    }

    // Dispel Nearest Enemy's Beneficial Spells
    if (Jug_GetHasBeneficialEnhancement(oPC))
    {
        if (Jug_AtObject(SPELL_GREATER_DISPELLING, oPC, iMod, 16)) return TRUE;
        if (Jug_AtObject(SPELL_DISPEL_MAGIC, oPC, iMod, 13 + iCureAdj)) return TRUE;
    }

    //Freedom of Movement - Negates effects of paralysis, Hold, Slow, or Web spells
    //CONDITION: Affected by Slow or Web.
    if ((GetHasSpellEffect(SPELL_SLOW) || GetHasSpellEffect(SPELL_WEB)) &&
        !GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT))
    {
        if (Jug_AtObject(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    // same as above, but for nearest ally
    if (iHasAlly && (GetHasSpellEffect(SPELL_SLOW, oAlly) || GetHasSpellEffect(SPELL_WEB, oAlly)) &&
        !GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT, oAlly))
    {
        if (Jug_AtObject(SPELL_FREEDOM_OF_MOVEMENT, oAlly, iMod, 14)) return TRUE;
    }

    // Healing Circle if having an ally or self lost 50% hp
    if ((iHasAlly || GetPercentageHPLoss(OBJECT_SELF) > 50) && !GetHasSpellEffect(SPELL_HEALING_CIRCLE))
    {
        if (Jug_AtObject(SPELL_HEALING_CIRCLE, OBJECT_SELF, iMod, 15 + iCureAdj)) return TRUE;
    }

    // Harm
    // CONDITION: 6+ hit dice and NOT undead! :)
    if (iPartyHD > 6 && GetRacialType(oPC) != RACIAL_TYPE_UNDEAD) {
        if (Jug_AtObject(SPELL_HARM, oPC, iMod - iCureAdj, 16)) return TRUE;
    }

    // (Mass) Heal (used as Harm for undead)
    // CONDITION: Undead at 4+ hd
    if (GetRacialType(oPC) == RACIAL_TYPE_UNDEAD && iPartyHD >= 4)
    {
        if (Jug_AtObject(SPELL_MASS_HEAL, oPC, iMod - iCureAdj, 18)) return TRUE;
        if (Jug_AtObject(SPELL_HEAL, oPC, iMod - iCureAdj, 16)) return TRUE;
    }

    if (!isDruid || isMonster)
    {
        // >>> LEVEL 9 SPELL SEQUENCE FOR NON-DRUIDS <<<
        if (Jug_AtLocation(SPELL_STORM_OF_VENGEANCE, oPC, iMod, 19)) return TRUE;
        if (Jug_AtLocation(SPELL_IMPLOSION, oPC, iMod, 19)) return TRUE;

        // High prio evil protection if having Gate
        if (GetHasSpell(SPELL_GATE))
        {
            if (Jug_AtObject(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, OBJECT_SELF, iMod, 13)) return TRUE;
            if (Jug_AtObject(SPELL_PROTECTION_FROM_EVIL, OBJECT_SELF, iMod, 11)) return TRUE;
        }

        if (GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL) ||
             GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL))
        {
            if (Jug_AtLocation(SPELL_GATE, oPC, iMod, 19)) return TRUE;
        }

        if (Jug_AtObject(SPELL_ENERGY_DRAIN, oPC, iMod, 19)) return TRUE;
    }

    if (isDruid || isMonster)
    {
        // >>> LEVEL 9 SPELL SEQUENCE FOR NON-CLERICS <<<
        if (Jug_AtObject(SPELL_ELEMENTAL_SWARM, oPC, iMod, 19)) return TRUE;
        if (Jug_AtObject(SPELL_SHAPECHANGE, oPC, iMod, 19, 20)) return TRUE; // 20% chance
    }

    // Regenerate
    if (Jug_AtObject(SPELL_REGENERATE, OBJECT_SELF, iMod + iCureAdj, 17)) return TRUE;
    if (Jug_AtObject(SPELL_SUNBEAM, oPC, iMod, 18)) return TRUE;

    // special case if undeads are nearby
    if ((!isDruid || isMonster) && GetRacialType(oPC) == RACIAL_TYPE_UNDEAD)
    {
        if (Jug_AtLocation(SPELL_SEARING_LIGHT, oPC, iMod, 13)) return TRUE;
    }

    if (Jug_AtLocation(SPELL_FIRE_STORM, oPC, iMod + iCureAdj, 18)) return TRUE;

    // >>> LEVEL 8 SPELL SEQUENCE FOR NON-DRUIDS <<<
    // ### AURA VS ALIGNMENT ??? ###

    if (isDruid || isMonster)
    {
        // >>> LEVEL 8 SPELL SEQUENCE FOR NON-CLERICS <<<

        // Combat Protection - NOTE: including lower levels as well here
        if (!(GetHasSpellEffect(SPELL_PREMONITION) ||
                GetHasSpellEffect(SPELL_GREATER_STONESKIN) ||
                GetHasSpellEffect(SPELL_STONESKIN)))
        {
            if (Jug_AtObject(SPELL_PREMONITION, OBJECT_SELF, iMod, 18)) return TRUE;
            if (Jug_AtObject(SPELL_GREATER_STONESKIN, OBJECT_SELF, iMod, 16)) return TRUE;
            if (Jug_AtObject(SPELL_STONESKIN, OBJECT_SELF, iMod, 14)) return TRUE;
        }

        if (Jug_AtObject(SPELL_FINGER_OF_DEATH, oPC, iMod, 18)) return TRUE;
        if (Jug_AtLocation(SPELL_NATURES_BALANCE, OBJECT_SELF, iMod, 18)) return TRUE;
    }

    if (Jug_AtObject(SPELL_SPELL_RESISTANCE, OBJECT_SELF, iMod, 15)) return TRUE;

    if (!isDruid || isMonster) {
        // >>> LEVEL 7 SPELL SEQUENCE FOR NON-DRUIDS <<<
        if (Jug_AtObject(SPELL_DESTRUCTION, oPC, iMod, 17)) return TRUE;
        if (Jug_AtObject(SPELL_WORD_OF_FAITH, OBJECT_SELF, iMod, 17)) return TRUE; // ## FIX/CHECK
    }

    if (isDruid || isMonster)
    {
        // >>> LEVEL 7 SPELL SEQUENCE FOR NON-CLERICS <<<
        if (Jug_AtObject(SPELL_CREEPING_DOOM, oPC, iMod, 17)) return TRUE;
        if (Jug_AtObject(SPELL_AURA_OF_VITALITY, OBJECT_SELF, iMod, 17)) return TRUE;
    }

    // Anti-undead: Negative Energy Protection
    if (GetRacialType(oPC) == RACIAL_TYPE_UNDEAD) {
        if (Jug_AtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    // Various Summons
    // *** Removed in 0.5 beta since default AI takes care of those (TalentSummonAllies) ***

    // Anti-undead: Control Undead
    if (!isDruid || isMonster) {
        // >>> LEVEL 6 SPELL SEQUENCE FOR NON-DRUIDS <<<
        if (GetRacialType(oPC) == RACIAL_TYPE_UNDEAD) {
            if (Jug_AtObject(SPELL_CONTROL_UNDEAD, oPC, iMod, 16)) return TRUE;
        }
        if (Jug_AtLocation(SPELL_BLADE_BARRIER, oPC, iMod, 16)) return TRUE;
    }

    if (Jug_AtLocation(SPELL_FLAME_STRIKE, oPC, iMod + iCureAdj, 15)) return TRUE;

    // Elemental protections
    if (!(GetHasSpellEffect(SPELL_ENERGY_BUFFER) || GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS)))
    {
        if (isDruid || isMonster) {
            if (iPartyHD - iMyHD > -8) {
                if (Jug_AtObject(SPELL_ENERGY_BUFFER, oPC, iMod, 16)) return TRUE;
            }
        }
        // Both druids & clerics can cast prot from elements
        if (iPartyHD - iMyHD > -8) {
            if (Jug_AtObject(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF, iMod, 13)) return TRUE;
        }
    }

    // Disabling these two for now as well ...

    if (GetRacialType(oPC) != RACIAL_TYPE_UNDEAD && GetRacialType(oPC) != RACIAL_TYPE_CONSTRUCT)
    {
        if (Jug_AtObject(SPELL_SLAY_LIVING, oPC, iMod, 15)) return TRUE;
    }

    if (!isDruid || isMonster) {
        // >>> LEVEL 5 SPELL SEQUENCE FOR NON-DRUIDS <<<
        if (GetRacialType(oPC) != RACIAL_TYPE_UNDEAD)
        {
            if (Jug_AtLocation(SPELL_CIRCLE_OF_DOOM, oPC, iMod, 15)) return TRUE;
        }
    }

    if (isDruid || isMonster) {
        // >>> LEVEL 5 SPELL SEQUENCE FOR NON-CLERICS <<<
        if (Jug_AtLocation(SPELL_ICE_STORM, oPC, iMod, 15)) return TRUE;
        if (Jug_AtLocation(SPELL_WALL_OF_FIRE, OBJECT_SELF, iMod, 15)) return TRUE;
    }

    if (!GetHasSpellEffect(SPELL_DEATH_WARD) && iPartyHD - iMyHD > -5)
    {
        if (Jug_AtObject(SPELL_DEATH_WARD, OBJECT_SELF, iMod - iCureAdj, 14)) return TRUE;
    }

    if (!isDruid || isMonster) {
        // >>> LEVEL 4 SPELL SEQUENCE FOR NON-DRUIDS <<<
        if (Jug_AtLocation(SPELL_HAMMER_OF_THE_GODS, oPC, iMod, 14)) return TRUE;

        if (!GetHasSpellEffect(SPELL_DIVINE_POWER)) {
            if (Jug_AtObject(SPELL_DIVINE_POWER, OBJECT_SELF, iMod, 14)) return TRUE;
        }
    }
    if (isDruid || isMonster) {
        // >>> LEVEL 4 SPELL SEQUENCE FOR NON-CLERICS <<<
        if (Jug_AtObject(SPELL_HOLD_MONSTER, oPC, iMod, 14)) return TRUE;
    }

    if (Jug_AtObject(SPELL_POISON, oPC, iMod + iCureAdj, 14)) return TRUE;
    if (Jug_AtObject(SPELL_CONTAGION, oPC, iMod, 13)) return TRUE;

    if (!isDruid || isMonster) {
        // >>> LEVEL 3 SPELL SEQUENCE FOR NON-DRUIDS <<<
        if (Jug_AtObject(SPELL_BLINDNESS_AND_DEAFNESS, oPC, iMod, 13)) return TRUE;
        if (Jug_AtObject(SPELL_BESTOW_CURSE, oPC, iMod, 13)) return TRUE;
        if (Jug_AtLocation(SPELL_SEARING_LIGHT, oPC, iMod, 13)) return TRUE;
    }

    if (isDruid || isMonster) {
        // >>> LEVEL 3 SPELL SEQUENCE FOR NON-CLERICS <<<
        if (Jug_AtObject(SPELL_CALL_LIGHTNING, oPC, iMod, 13)) return TRUE;

        if (GetRacialType(oPC) == RACIAL_TYPE_ANIMAL) {
            if (Jug_AtObject(SPELL_DOMINATE_ANIMAL, oPC, iMod, 13)) return TRUE;
        }
    }

    return FALSE;
}

int TalentImportantRangerSpells()
{
//    return FALSE;

    // Set oPC to nearest enemy
    object oPC = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);

    // Set oAlly to nearest ally (if found and in reasonable range)
    object oAlly = Jug_GetNearestAlly();
    int iHasAlly = GetIsObjectValid(oAlly);

    // Set oInvis to nearest heard & invisible enemy
    object oInvis = GetNearestCreature(CREATURE_TYPE_REPUTATION,
        REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION,
        PERCEPTION_HEARD_AND_NOT_SEEN);

    int iPartyHD = GetAverageHD();
    int iMyHD = GetHitDice(OBJECT_SELF);
    int iLostHP = GetMaxHitPoints() - GetCurrentHitPoints();

    if (!GetIsObjectValid(oPC)) return FALSE;

    // Get primary modifier for class
    int iMod = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM);

    // Cure Wounds
    // *** Removed in 0.5 beta since default AI takes care of those ***

    // Invisibility Purge
    if (GetIsObjectValid(oInvis))
    {
        if (Jug_AtLocation(SPELL_INVISIBILITY_PURGE, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    //Freedom of Movement - Negates effects of paralysis, Hold, Slow, or Web spells
    //CONDITION: Affected by Slow or Web.
    if ((GetHasSpellEffect(SPELL_SLOW) || GetHasSpellEffect(SPELL_WEB)) &&
        !GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT))
    {
        if (Jug_AtObject(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    // Same as above, but for nearest ally
    if (iHasAlly && (GetHasSpellEffect(SPELL_SLOW, oAlly) ||
        GetHasSpellEffect(SPELL_WEB, oAlly)) &&
        !GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT, oAlly))
    {
        if (Jug_AtObject(SPELL_FREEDOM_OF_MOVEMENT, oAlly, iMod, 14)) return TRUE;
    }

    // Various Summons
    // *** Removed in 0.5 beta since default AI takes care of those (TalentSummonAllies) ***

    //Polymorph Self - Transforms caster into Giant spider, Troll, Umber hulk, Pixie, or Zombie
    //CONDITION: 15% chance to cast
    if (!GetHasSpellEffect(SPELL_POLYMORPH_SELF)) {
        if (Jug_AtObject(SPELL_POLYMORPH_SELF, OBJECT_SELF, iMod, 14, 15)) return TRUE;
    }

    //Aid - +1 on attacks, damage and saves vs fear plus 1d8 temporary hp
    if (!GetHasSpellEffect(SPELL_AID)) {
        if (Jug_AtObject(SPELL_AID, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    //Elemental Protections
    if (!(GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS) ||
        GetHasSpellEffect(SPELL_RESIST_ELEMENTS)))
    {
        if (Jug_AtObject(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF, iMod, 12)) return TRUE;
        if (Jug_AtObject(SPELL_RESIST_ELEMENTS, OBJECT_SELF, iMod, 11)) return TRUE;
    }

    // Same as above, but for nearest ally
    if (iHasAlly && !(GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, oAlly) ||
        GetHasSpellEffect(SPELL_RESIST_ELEMENTS, oAlly)))
    {
        if (Jug_AtObject(SPELL_PROTECTION_FROM_ELEMENTS, oAlly, iMod, 12)) return TRUE;
        if (Jug_AtObject(SPELL_RESIST_ELEMENTS, oAlly, iMod, 11)) return TRUE;
    }

    //Cat's Grace - Target gains 1d4+1 Dex for 1hr/level
    if (!GetHasSpellEffect(SPELL_CATS_GRACE)) {
        if (Jug_AtObject(SPELL_CATS_GRACE, OBJECT_SELF, iMod, 12)) return TRUE;
    }

    //Sleep - Puts 2d4 HD of creatures to sleep
    if (iPartyHD < 8) {
        if (Jug_AtLocation(SPELL_SLEEP, oPC, iMod, 11)) return TRUE;
    }

    return FALSE;
}

int TalentImportantPaladinSpells()
{
//    return FALSE;

    // Set oPC to nearest enemy
    object oPC = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);

    // Set oAlly to nearest ally (if found and in reasonable range)
    object oAlly = Jug_GetNearestAlly();
    int iHasAlly = GetIsObjectValid(oAlly);

    int iPartyHD = GetAverageHD();
    int iMyHD = GetHitDice(OBJECT_SELF);
    int iLostHP = GetMaxHitPoints() - GetCurrentHitPoints();

    if (!GetIsObjectValid(oPC)) return FALSE;

    // Get primary modifier for class
    int iMod = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM);

    // Cure Wounds
    // *** Removed in 0.5 beta since default AI takes care of those ***

    // Dispel Nearest Enemy's Beneficial Spells
    if (Jug_GetHasBeneficialEnhancement(oPC))
    {
        if (Jug_AtObject(SPELL_DISPEL_MAGIC, oPC, iMod, 13)) return TRUE;
    }

    // TODO: Attempt to dispel negative spells on self and allies?

    //Remove Blindness and Deafness
    //CONDITION: Is deaf or silenced
    if (GetHasEffect(EFFECT_TYPE_SILENCE) || GetHasEffect(EFFECT_TYPE_DEAF))
    {
        if (Jug_AtObject(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    // Same as above, but for nearest ally
    if (iHasAlly && (GetHasEffect(EFFECT_TYPE_SILENCE, oAlly) ||
        GetHasEffect(EFFECT_TYPE_DEAF, oAlly)))
    {
        if (Jug_AtObject(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oAlly, iMod, 13)) return TRUE;
    }

    //Freedom of Movement - Negates effects of paralysis, Hold, Slow, or Web spells
    //CONDITION: Affected by Slow or Web.
    if ((GetHasSpellEffect(SPELL_SLOW) || GetHasSpellEffect(SPELL_WEB)) &&
        !GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT))
    {
        if (Jug_AtObject(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    // Same as above, but for nearest ally
    if (iHasAlly && (GetHasSpellEffect(SPELL_SLOW) ||
        GetHasSpellEffect(SPELL_WEB)) && !GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT))
    {
        if (Jug_AtObject(SPELL_FREEDOM_OF_MOVEMENT, oAlly, iMod, 14)) return TRUE;
    }

    //Remove Paralysis - Frees allies from paralysis, Hold, or Slow spells
    if (iHasAlly && GetHasSpell(SPELL_REMOVE_PARALYSIS) &&
        (GetHasEffect(EFFECT_TYPE_PARALYZE, oAlly) || GetHasEffect(EFFECT_TYPE_SLOW, oAlly)))
    {
        if (Jug_AtObject(SPELL_REMOVE_PARALYSIS, oAlly, iMod, 12)) return TRUE;
    }

    // Death Ward
    if (!GetHasSpellEffect(SPELL_DEATH_WARD)) {
        if (Jug_AtObject(SPELL_DEATH_WARD, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    // Same as above, but for nearest ally
    // CONDITION: Death Ward already cast on self
    if (iHasAlly && !GetHasSpellEffect(SPELL_DEATH_WARD, oAlly) &&
        GetHasSpellEffect(SPELL_DEATH_WARD))
    {
        if (Jug_AtObject(SPELL_DEATH_WARD, oAlly, iMod, 14)) return TRUE;
    }

    if (!GetHasSpellEffect(SPELL_PRAYER)) {
        if (Jug_AtObject(SPELL_PRAYER, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    // Magic Circle Against Alignment
    if (!GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL)) {
        if (Jug_AtObject(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    //Aid - +1 on attacks, damage and saves vs fear plus 1d8 temporary hp
    if (!GetHasSpellEffect(SPELL_AID)) {
        if (Jug_AtObject(SPELL_AID, OBJECT_SELF, iMod, 12)) return TRUE;
    }

    //Elemental Protections
    if (!GetHasSpellEffect(SPELL_RESIST_ELEMENTS)) {
        if (Jug_AtObject(SPELL_RESIST_ELEMENTS, OBJECT_SELF, iMod, 12)) return TRUE;
    }

    // Same as above, but for nearest ally
    // CONDITION: Resist Elements already cast on self
    if (iHasAlly && GetHasSpellEffect(SPELL_RESIST_ELEMENTS) &&
        !GetHasSpellEffect(SPELL_RESIST_ELEMENTS, oAlly))
    {
        if (Jug_AtObject(SPELL_RESIST_ELEMENTS, OBJECT_SELF, iMod, 12)) return TRUE;
    }

    //Bull's Strength - Target gains 1d4+1 Str for 1hr/level
    if (!GetHasSpellEffect(SPELL_BULLS_STRENGTH)) {
        if (Jug_AtObject(SPELL_BULLS_STRENGTH, OBJECT_SELF, iMod, 12)) return TRUE;
    }

    return FALSE;
}

//
// Returns the average hit dice of all enemies in a 40' radius
//
int GetAverageHD()
{
    struct sEnemies enemies = DetermineEnemies();

    if (enemies.TOTAL == 0)
    {
        return 0;
    }

    int iAverageHD = enemies.TOTAL_LEVELS / enemies.TOTAL;
    return iAverageHD;
}

// Thanks to FalloutBoy for original Jug_At* ideas!

int Jug_AtLocation(int nSpellID, object oTarget, int iModifier, int iRequirement, int iChance = 100)
{
/*
 * This one apparently cause stack underflows...
 *
 * "Redirecting" calls to AtObject instead of replacing AtLocation calls if
 * any AtLocation bugs are fixed in a future patch and there's a use to call
 * AtLocation.
 *
    if (GetHasSpell(nSpellID) && d100() < iChance && iModifier >= iRequirement)
    {
        ClearAllActions();
        ActionCastSpellAtLocation(nSpellID, GetLocation(oTarget));
        return TRUE;
    }
    return FALSE;
*/
    return Jug_AtObject(nSpellID, oTarget, iModifier, iRequirement, iChance);
}

int Jug_AtObject(int nSpellID, object oTarget, int iModifier, int iRequirement, int iChance = 100)
{
    if (GetHasSpell(nSpellID) && d100() < iChance && iModifier >= iRequirement)
    {
        ClearAllActions();
        ActionCastSpellAtObject(nSpellID, oTarget);
        return TRUE;
    }
    return FALSE;
}

// Return TRUE if target is enhanced with a beneficial
// spell that can be dispelled (= from a spell script), FALSE otherwise.
int Jug_GetHasBeneficialEnhancement(object oTarget)
{
    // Make sure the effects of bard songs (that can't be dispelled) don't
    // confuse this function
    if (GetHasFeatEffect(FEAT_BARD_SONGS, oTarget))
    {
        return FALSE;
    }

    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
        if (GetEffectSpellId(eCheck) != -1)
        {
            // Found an effect applied by a spell script - check the effect type
            // Ignore invisibility effects since that's a special case taken
            // care of elsewhere
            int iType = GetEffectType(eCheck);
            if (iType == EFFECT_TYPE_ABILITY_INCREASE ||
                iType == EFFECT_TYPE_AC_INCREASE ||
                iType == EFFECT_TYPE_ATTACK_INCREASE ||
                iType == EFFECT_TYPE_CONCEALMENT ||
                iType == EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE ||
                iType == EFFECT_TYPE_DAMAGE_INCREASE ||
                iType == EFFECT_TYPE_DAMAGE_REDUCTION ||
                iType == EFFECT_TYPE_DAMAGE_RESISTANCE ||
                iType == EFFECT_TYPE_ELEMENTALSHIELD ||
                iType == EFFECT_TYPE_HASTE ||
                iType == EFFECT_TYPE_ENEMY_ATTACK_BONUS ||
                iType == EFFECT_TYPE_IMMUNITY ||
                iType == EFFECT_TYPE_INVULNERABLE ||
                iType == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE ||
                iType == EFFECT_TYPE_REGENERATE ||
                iType == EFFECT_TYPE_SANCTUARY ||
                iType == EFFECT_TYPE_SAVING_THROW_INCREASE ||
                iType == EFFECT_TYPE_SEEINVISIBLE ||
                iType == EFFECT_TYPE_SKILL_INCREASE ||
                iType == EFFECT_TYPE_SPELL_IMMUNITY ||
                iType == EFFECT_TYPE_SPELL_RESISTANCE_INCREASE ||
                iType == EFFECT_TYPE_SPELLLEVELABSORPTION ||
                iType == EFFECT_TYPE_TEMPORARY_HITPOINTS ||
                iType == EFFECT_TYPE_TRUESEEING ||
                iType == EFFECT_TYPE_ULTRAVISION)
            {
                return TRUE;
            }
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

// Return nearest ally if found, OBJECT_INVALID otherwise.
// Casters use this to buff nearby allies.
object Jug_GetNearestAlly()
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION,
        REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION,
        PERCEPTION_SEEN);

    if (GetIsObjectValid(oTarget) /*&& GetDistanceToObject(oTarget) < 15.0*/)
    {
        return oTarget;
    }
    return OBJECT_INVALID;
}

int Jug_IsArcaneCaster(object oTarget = OBJECT_SELF)
{
    return GetLevelByClass(CLASS_TYPE_WIZARD) >= 1 || GetLevelByClass(CLASS_TYPE_SORCERER) >= 1;
}

int Jug_IsDivineCaster(object oTarget = OBJECT_SELF)
{
    return GetLevelByClass(CLASS_TYPE_CLERIC) >= 1 || GetLevelByClass(CLASS_TYPE_DRUID) >= 1;
}

// As MyPrintString, but to screen instead of log
void Jug_Debug(string sString)
{
    SendMessageToPC(GetFirstPC(), sString);
}

void MyPrintString(string sString)
{
//    PrintString(sString);
}

