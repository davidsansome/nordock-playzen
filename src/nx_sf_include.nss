//////////////////////////////////////////////
//Scroll Casting DC with UMD and Spellcraft //
//File name:  nx_sf_include.nss             //
//Created By: NeoXro                        //
//Created On: March 17, 2003                //
//Version:    1.00                          //
//////////////////////////////////////////////
//Edited to be 3E compliant in terms of DCs and synergy bonuses by Chon May 03, 2003
//For Use in Nordock.

// Further modifications by Q'el... 9-Jun-2003
// All modification surround by comments, starting //---Qel-1
//  - correcting bugs in script, adding shapechange variants, adding UMD skill synergy
//  - add wands, change text to accomodate wands and scrolls
//  - correct some spells that are available to bards, Cure xxx wounds, Neutralise Poison, Healing Circle
// Corrections & Additions by Q'el...16-Jun-2003
// Indicated by comments, starting //---Qel-2
//  - correct DCs for using wands
//  - make gateway a nomagic area. (if spellcaster has localint "nomagic" = TRUE, spell fails.


//This script checks for a DC when a scroll is used.  If caster fails the
//casting DC check, he takes a roll at the penalty check.  Failing that, penalty
//effects are applied.
//
//This script has been applied to all of NWN's default spells as you overwrite
//them when you imported from the .erf file.
//
//Twenty(20) default random penalty effects are included in the script.  Go to
//BOOKMARK_RANDOM_EFFECT for description of each.
//
//To apply this to your own spells, add the following to your spell files.
//Add this lien to the top:     #include "nx_sf_include"
//Wrap this around your main(): if(SpellSuccess()){}
//
//You spell file would look like this:
//------------------------------------
//#include "nx_sf_include"
//void main()
//{
//  if(SpellSuccess())
//  {
//      Beginning of the spell;
//      .
//      .
//      .
//      End of the spell;
//  } //end if(SpellSuccess())
//} //end void main()
//void OtherFunctions();
//------------------------------------
//
//Default DC rules are as follow:
//  Spellcraft DC:
//      5 * Caster Spell Level) * (6 * (Caster Spell Level * Scroll Spell Level
//  Spellcraft Roll Bonus:
//      d20 + Spellcraft + Caster Class Level
//  Spellcraft Penalty DC:
//      d20 + Wisdom Modifier vs DC 5
//
//  Use Magic Device DC:
//      20 + (2 * Scroll Spell Level)
//  Use Magic Device Roll Bonus:
//      d20 + (75% * Use Magic Device) + (25% * Rogue + Bard Class Level) +
//      (Spellcraft / 5)
//  Use Magic Device Penalty DC:
//      Failing Use Magic Device DC by 10 or more
//
//This script was made for easy modification.  Use Find to go to the following
//bookmark names to modify the cooresponding components:
//BOOKMARK_OPTIONS          Go here for the main options of the script
//BOOKMARK_SPELLID          Go here to add a spell to the list
//BOOKMARK_DC               Go here to change DC
//BOOKMARK_PENALTY          Go here to change penalties
//BOOKMARK_RANDOM_EFFECT    Go here to change/add random effects

//Function calls DO NOT CHANGE
int SpellSuccess();
int GetBiggest(int iA, int iB);
void SpellLevel(int iSpellId);
void CasterLevel(object oCaster);
int DCCheck();
int SpellcraftPenaltyCheck();
void ApplyPenalty(object oCaster);
void ApplyRandomEffect(object oCaster);
void CreateCreature(int iType, string sName, location lTarget);
//void main(){}

//Constants DO NOT CHANGE
int INVALID = -1;
int ARCANE  = 0;
int DIVINE  = 1;
int BOTH    = 2;
int SPELLCRAFT = 0;
int UMD        = 1;
int DAMAGE_EFFECT          = 0;
int DAMAGE_BY_LEVEL_EFFECT = 1;
int RANDOM_EFFECT          = 2;

//Variables DO NOT CHANGE
int iSpellType = INVALID;
int iSpellLevel = INVALID;
int iCasterClass = INVALID;
int iCasterLevel = INVALID;
int iCasterSpLevel = INVALID;
int iSpellcraftLevel = INVALID;
int iSpellcraftBonus = INVALID;
int iUMDClassLevel = INVALID;
int iUMDSkillLevel = INVALID;
int iUMDSkillBonus = INVALID;    // UMD synergy bonus
int iDCCheck = FALSE;
int iDCFailBy = INVALID;
int bSuccess = TRUE;

//---Qel-1
//---Addition by Q'el to elegantly handle scrolls useable by all (e.g. Raise Dead).
int bSpellExempt = FALSE;
//---end addition


//////////SCRIPT OPTIONS BEGIN//////////
//BOOKMARK_OPTIONS
//
//DEBUG Shows debug statements when this is TRUE.  Throughout the script, there
//are many if(DEBUG) statements to help out debugging the code.
//Default is FALSE
int DEBUG = FALSE;
//
//CHECK_TYPE This constant determines if only ARCANE or DIVINE or BOTH types of
//scrolls will be checked.
//Default is ARCANE.
int CHECK_TYPE = BOTH;
//
//UM_DDC This is the base DC for using scrolls with UMD.
//Default is 20.
int UMD_DC = 25;
int WAND_UMD_DC = 20;          //---Qel-2
int WAND_SPELLCRAFT_DC = 0;    //---Qel-2
//
//ROGUE_BARD_PERCENT This constant determine how much percentage the rogue/bard
//level affects UMD's DC check set to 0 if you don't want it to play a role.
//This is implemented to penalize spell point hoarding by
//non-primary-rogues/bards
//Default is 25.
int ROGUE_BARD_PERCENT = 0;
//
//SPELLCRAFT_PENALTY_DC This is the DC used to determine spellcraft penalty.
//Adjust this depending on how severe the penalties are.
//Default is 10
int SPELLCRAFT_PENALTY_DC = 10;
//
//UMD_PENALTY_DC UMD caster gets penaltied if the scroll DC exceeds the roll by
//this number.
//Adjust this depending on how severe the penalties are.
//Default is 10.
int UMD_PENALTY_DC = 10;
//
//CRITICAL_SUCCESS and CRITICAL_FAILURE Players will automatically succeed or
//fail if they roll these numbers.  Set both to 0 to disable them.
//Defaults are 20 and 1
int CRITICAL_SUCCESS = 20;
int CRITICAL_FAILURE = 1;
//
//PENALTY_TYPE This determines what type of effect will be applied to the caster
//if he/her fails the penalty check.  Types are:
//DAMAGE_EFFECT
//Damages caster by DAMAGE_AMOUNT
//DAMAGE_BY_LEVEL_EFFECT
//Damages caster by d6 multiplied by the scroll level
//RANDOM_EFFECT
//Applies random effect to the caster, could be damage.
//Default is RANDOM_EFFECT
int PENALTY_TYPE = RANDOM_EFFECT;
//
//DAMAGE_AMOUNT The DAMAGE_EFFECT applied when a caster fails the penalty check.
//Default is d6(2)
int DAMAGE_AMOUNT = d6(2);
//
//////////SCRIPT OPTIONS END//////////



//int SpellSuccess()
//Returns TRUE if scroll passes checks.
//Returns FALSE if scroll doesn't pass checks.
int SpellSuccess()
{
//---Qel-2  all spells fail if nomagic is TRUE
    if (GetLocalInt(OBJECT_SELF, "nomagic"))
    {
        SendMessageToPC(OBJECT_SELF, "Spell failed, NO MAGIC area.");
        return FALSE;
    }
//---end

    //Checks for if the spell is casted off a scroll.  Change this if you wish
    //to check for more items.

//---Qel-1
//add wands to the mix
    int iItemType = GetBaseItemType(GetSpellCastItem());

    if((iItemType == BASE_ITEM_SCROLL) ||
       (iItemType == BASE_ITEM_SPELLSCROLL) ||
       (iItemType == BASE_ITEM_MAGICWAND)
       )
    {
        SpellLevel(GetSpellId());
        if(bSpellExempt == TRUE)
        {
            bSuccess = TRUE;
        }
        else if(iSpellType != INVALID && iSpellLevel != INVALID)
        {
            CasterLevel(OBJECT_SELF);
            if(DCCheck())
            {
                bSuccess = TRUE;
            } //end if
            else
            {
                bSuccess = FALSE;
            } //end else

        } //end if
        else
        {
            SendMessageToPC(OBJECT_SELF, "Spell [ID="+IntToString(GetSpellId())+"] not supported");
        } //end else if
    } //end if

    if(DEBUG)
    {
        SendMessageToPC(OBJECT_SELF, "Spell checked");
    } //end if(DEBUG)
    return bSuccess;
}  //end int SpellSuccess()


//int GetBiggest(int iA, int iB)
//Returns the bigger of the two ints
int GetBiggest(int iA, int iB)
{
    if(iA > iB)
    {
        return iA;
    }  //end if
    else
    {
        return iB;
    }  //end else
}  //end int GetBiggest(int iA, int iB)


void SpellLevel(int iSpellId)
{
    //Checking for the spell's type and level
    //BOOKMARK_SPELLID

//---Qel-1
    bSpellExempt = FALSE;
//---end addition


    switch(iSpellId)
    {
        case SPELL_ACID_FOG:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_AID:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_ANIMATE_DEAD:
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_AURA_OF_VITALITY:
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
        case SPELL_AWAKEN:
            iSpellType = DIVINE;
            iSpellLevel = 5;
            break;
        case SPELL_BARKSKIN:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_BESTOW_CURSE:
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_BLADE_BARRIER:
            iSpellType = DIVINE;
            iSpellLevel = 6;
            break;
        case SPELL_BLESS:
            iSpellType = DIVINE;
            iSpellLevel = 1;
            break;
        case SPELL_BLINDNESS_AND_DEAFNESS:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_BULLS_STRENGTH:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_BURNING_HANDS:
            iSpellType = ARCANE;
            iSpellLevel = 1;
            break;
        case SPELL_CALL_LIGHTNING:
            iSpellType = DIVINE;
            iSpellLevel = 3;
            break;
        case SPELL_CATS_GRACE:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_CHAIN_LIGHTNING:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_CHARM_MONSTER:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_CHARM_PERSON:
            iSpellType = ARCANE;
            iSpellLevel = 1;
            break;
        case SPELL_CHARM_PERSON_OR_ANIMAL:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_CIRCLE_OF_DEATH:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_CIRCLE_OF_DOOM:
            iSpellType = DIVINE;
            iSpellLevel = 5;
            break;
        case SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_CLARITY:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_CLOUDKILL:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_COLOR_SPRAY:
            iSpellType = ARCANE;
            iSpellLevel = 1;
            break;
        case SPELL_CONE_OF_COLD:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_CONFUSION:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_CONTAGION:
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_CONTROL_UNDEAD:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
        case SPELL_CREATE_GREATER_UNDEAD:
            iSpellType = DIVINE;
            iSpellLevel = 8;
            break;
        case SPELL_CREATE_UNDEAD:
            iSpellType = BOTH;
            iSpellLevel = 6;
            break;
        case SPELL_CREEPING_DOOM:
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
//---Qel-1 --- change the cure spells to both, they are usable by Bards
        case SPELL_CURE_CRITICAL_WOUNDS:
            iSpellType = BOTH;               //changed from DIVINE to BOTH
            iSpellLevel = 4;
            break;
        case SPELL_CURE_LIGHT_WOUNDS:
            iSpellType = BOTH;               //changed from DIVINE to BOTH
            iSpellLevel = 1;
            break;
        case SPELL_CURE_MINOR_WOUNDS:
            iSpellType = BOTH;               //changed from DIVINE to BOTH
            iSpellLevel = 0;
            break;
        case SPELL_CURE_MODERATE_WOUNDS:
            iSpellType = BOTH;               //changed from DIVINE to BOTH
            iSpellLevel = 2;
            break;
        case SPELL_CURE_SERIOUS_WOUNDS:
            iSpellType = BOTH;               //changed from DIVINE to BOTH
            iSpellLevel = 4;
            break;
//---end
        case SPELL_DARKNESS:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_DAZE:
            iSpellType = ARCANE;
            iSpellLevel = 0;
            break;
        case SPELL_DEATH_WARD:
            iSpellType = DIVINE;
            iSpellLevel = 4;
            break;
        case SPELL_DELAYED_BLAST_FIREBALL:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
        case SPELL_DESTRUCTION:
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
        case SPELL_DISMISSAL:
            iSpellType = BOTH;
            iSpellLevel = 4;
            break;
        case SPELL_DISPEL_MAGIC:
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_DIVINE_POWER:
            iSpellType = DIVINE;
            iSpellLevel = 4;
            break;
        case SPELL_DOMINATE_ANIMAL:
            iSpellType = DIVINE;
            iSpellLevel = 3;
            break;
        case SPELL_DOMINATE_MONSTER:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_DOMINATE_PERSON:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_DOOM:
            iSpellType = DIVINE;
            iSpellLevel = 1;
            break;
        case SPELL_EAGLE_SPLEDOR:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_ELEMENTAL_SHIELD:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_ELEMENTAL_SWARM:
            iSpellType = DIVINE;
            iSpellLevel = 9;
            break;
        case SPELL_ENDURANCE:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_ENDURE_ELEMENTS:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_ENERGY_BUFFER:
            iSpellType = BOTH;
            iSpellLevel = 5;
            break;
        case SPELL_ENERGY_DRAIN:
            iSpellType = BOTH;
            iSpellLevel = 9;
            break;
        case SPELL_ENERVATION:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_ENTANGLE:
            iSpellType = DIVINE;
            iSpellLevel = 1;
            break;
        case SPELL_ETHEREAL_VISAGE:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_EVARDS_BLACK_TENTACLES:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_FEAR:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_FEEBLEMIND:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_FIND_TRAPS:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_FINGER_OF_DEATH:
            iSpellType = BOTH;
            iSpellLevel = 7;
            break;
        case SPELL_FIRE_STORM:
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
        case SPELL_FIREBALL:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_FLAME_ARROW:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_FLAME_LASH:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_FLAME_STRIKE:
            iSpellType = DIVINE;
            iSpellLevel = 4;
            break;
        case SPELL_FOXS_CUNNING:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_FREEDOM_OF_MOVEMENT:
            iSpellType = DIVINE;
            iSpellLevel = 4;
            break;
        case SPELL_GATE:
            iSpellType = BOTH;
            iSpellLevel = 9;
            break;
        case SPELL_GHOSTLY_VISAGE:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_GHOUL_TOUCH:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_GLOBE_OF_INVULNERABILITY:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_GREASE:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_GREATER_DISPELLING:
            iSpellType = BOTH;
            iSpellLevel = 6;
            break;
        case SPELL_GREATER_PLANAR_BINDING:
            iSpellType = ARCANE;
            iSpellLevel = 8;
            break;
        case SPELL_GREATER_RESTORATION:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
//---Qel-1 Greater Shadow Conjuration, same spell with 4 variant castings.
        case SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW:
        case SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE:
        case SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW:
        case SPELL_GREATER_SHADOW_CONJURATION_WEB:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_GREATER_SPELL_BREACH:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_GREATER_SPELL_MANTLE:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_GREATER_STONESKIN:
            iSpellType = BOTH;
            iSpellLevel = 6;
            break;
        case SPELL_HAMMER_OF_THE_GODS:
            iSpellType = DIVINE;
            iSpellLevel = 4;
            break;
        case SPELL_HARM:
            iSpellType = DIVINE;
            iSpellLevel = 6;
            break;
        case SPELL_HASTE:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_HEAL:
            iSpellType = DIVINE;
            iSpellLevel = 6;
            break;
        case SPELL_HEALING_CIRCLE:
//---Qel-1
            iSpellType = BOTH;               //changed from DIVINE to BOTH
//---end
            iSpellLevel = 5;
            break;
        case SPELL_HOLD_ANIMAL:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_HOLD_MONSTER:
            iSpellType = BOTH;
            iSpellLevel = 4;
            break;
        case SPELL_HOLD_PERSON:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_HORRID_WILTING:
            iSpellType = ARCANE;
            iSpellLevel = 8;
            break;
        case SPELL_ICE_STORM:
            iSpellType = BOTH;
            iSpellLevel = 4;
            break;
        case SPELL_IDENTIFY:
            iSpellType = ARCANE;
            iSpellLevel = 1;
            break;
        case SPELL_IMPLOSION:
            iSpellType = DIVINE;
            iSpellLevel = 9;
            break;
        case SPELL_IMPROVED_INVISIBILITY:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_INCENDIARY_CLOUD:
            iSpellType = ARCANE;
            iSpellLevel = 8;
            break;
        case SPELL_INVISIBILITY:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_INVISIBILITY_PURGE:
            iSpellType = DIVINE;
            iSpellLevel = 3;
            break;
        case SPELL_INVISIBILITY_SPHERE:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_KNOCK:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_LEGEND_LORE:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_LESSER_DISPEL:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_LESSER_MIND_BLANK:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_LESSER_PLANAR_BINDING:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_LESSER_RESTORATION:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_LESSER_SPELL_BREACH:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_LESSER_SPELL_MANTLE:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_LIGHT:
            iSpellType = BOTH;
            iSpellLevel = 0;
            break;
        case SPELL_LIGHTNING_BOLT:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_MAGE_ARMOR:
            iSpellType = ARCANE;
            iSpellLevel = 1;
            break;
        case SPELL_MAGIC_CIRCLE_AGAINST_EVIL:
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_MAGIC_CIRCLE_AGAINST_GOOD:
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_MAGIC_MISSILE:
            iSpellType = ARCANE;
            iSpellLevel = 1;
            break;
        case SPELL_MASS_BLINDNESS_AND_DEAFNESS:
            iSpellType = ARCANE;
            iSpellLevel = 8;
            break;
        case SPELL_MASS_CHARM:
            iSpellType = ARCANE;
            iSpellLevel = 8;
            break;
        case SPELL_MASS_HASTE:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_MASS_HEAL:
            iSpellType = DIVINE;
            iSpellLevel = 8;
            break;
        case SPELL_MELFS_ACID_ARROW:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_METEOR_SWARM:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_MIND_BLANK:
            iSpellType = ARCANE;
            iSpellLevel = 8;
            break;
        case SPELL_MIND_FOG:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        case SPELL_MINOR_GLOBE_OF_INVULNERABILITY:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_MORDENKAINENS_DISJUNCTION:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_MORDENKAINENS_SWORD:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
        case SPELL_NATURES_BALANCE:
            iSpellType = DIVINE;
            iSpellLevel = 8;
            break;
        case SPELL_NEGATIVE_ENERGY_BURST:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_NEGATIVE_ENERGY_PROTECTION:
            iSpellType = DIVINE;
            iSpellLevel = 3;
            break;
        case SPELL_NEGATIVE_ENERGY_RAY:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_NEUTRALIZE_POISON:
//---Qel-1  wand is restricted, scroll is not.
            if (GetBaseItemType(GetSpellCastItem()) == BASE_ITEM_MAGICWAND)
                {
                bSpellExempt = FALSE;
                }
            else
                {
                bSpellExempt = TRUE;
                }
            iSpellType = BOTH;               //changed from DIVINE to BOTH
//---end
            iSpellLevel = 3;
            break;
        case SPELL_OWLS_WISDOM:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_PHANTASMAL_KILLER:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_PLANAR_BINDING:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_POISON:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_POLYMORPH_SELF:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_POWER_WORD_KILL:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_POWER_WORD_STUN:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
        case SPELL_PRAYER:
            iSpellType = DIVINE;
            iSpellLevel = 3;
            break;
        case SPELL_PREMONITION:
            iSpellType = BOTH;
            iSpellLevel = 8;
            break;
        case SPELL_PRISMATIC_SPRAY:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
        case SPELL_PROTECTION_FROM_ELEMENTS:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_PROTECTION_FROM_EVIL:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_PROTECTION_FROM_GOOD:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_PROTECTION_FROM_SPELLS:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
        case SPELL_RAISE_DEAD:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = DIVINE;
            iSpellLevel = 5;
            break;
        case SPELL_RAY_OF_ENFEEBLEMENT:
            iSpellType = ARCANE;
            iSpellLevel = 1;
            break;
        case SPELL_RAY_OF_FROST:
            iSpellType = ARCANE;
            iSpellLevel = 0;
            break;
        case SPELL_REGENERATE:
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
        case SPELL_REMOVE_BLINDNESS_AND_DEAFNESS:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_REMOVE_CURSE:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_REMOVE_DISEASE:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = DIVINE;
            iSpellLevel = 3;
            break;
        case SPELL_REMOVE_FEAR:
            iSpellType = DIVINE;
            iSpellLevel = 1;
            break;
        case SPELL_REMOVE_PARALYSIS:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_RESIST_ELEMENTS:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_RESISTANCE:
            iSpellType = BOTH;
            iSpellLevel = 0;
            break;
        case SPELL_RESTORATION:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = DIVINE;
            iSpellLevel = 4;
            break;
        case SPELL_RESURRECTION:
//---Qel-1
            bSpellExempt = TRUE;
//end
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
        case SPELL_SANCTUARY:
            iSpellType = DIVINE;
            iSpellLevel = 1;
            break;
        case SPELL_SCARE:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_SEARING_LIGHT:
            iSpellType = DIVINE;
            iSpellLevel = 3;
            break;
        case SPELL_SEE_INVISIBILITY:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_SHADES_CONE_OF_COLD:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
//---Qel-1 Shades, same spell with 4 variant castings.
        case SPELL_SHADES_FIREBALL:
        case SPELL_SHADES_STONESKIN:
        case SPELL_SHADES_SUMMON_SHADOW:
        case SPELL_SHADES_WALL_OF_FIRE:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
//---Qel-1 Shadow Conjuration, same spell with 5 variant castings.
        case SPELL_SHADOW_CONJURATION_DARKNESS:
        case SPELL_SHADOW_CONJURATION_INIVSIBILITY:
        case SPELL_SHADOW_CONJURATION_MAGE_ARMOR:
        case SPELL_SHADOW_CONJURATION_MAGIC_MISSILE:
        case SPELL_SHADOW_CONJURATION_SUMMON_SHADOW:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_SHADOW_SHIELD:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
//---Qel-1 Shapechange, same spell with 5 variant castings.
        case SPELL_SHAPECHANGE:
        case 392:  // RED DRAGON
        case 393:  // FIRE GIANT
        case 394:  // BALOR
        case 395:  // DEATH SLAAD
        case 396:  // IRON GOLEM
            iSpellType = BOTH;
            iSpellLevel = 9;
            break;
        case SPELL_SILENCE:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_SLAY_LIVING:
            iSpellType = DIVINE;
            iSpellLevel = 5;
            break;
        case SPELL_SLEEP:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_SLOW:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_SOUND_BURST:
            iSpellType = DIVINE;
            iSpellLevel = 2;
            break;
        case SPELL_SPELL_MANTLE:
            iSpellType = ARCANE;
            iSpellLevel = 7;
            break;
        case SPELL_SPELL_RESISTANCE:
            iSpellType = DIVINE;
            iSpellLevel = 5;
            break;
        case SPELL_STINKING_CLOUD:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_STONESKIN:
            iSpellType = BOTH;
            iSpellLevel = 4;
            break;
        case SPELL_STORM_OF_VENGEANCE:
            iSpellType = DIVINE;
            iSpellLevel = 9;
            break;
        case SPELL_SUMMON_CREATURE_I:
            iSpellType = BOTH;
            iSpellLevel = 1;
            break;
        case SPELL_SUMMON_CREATURE_II:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_SUMMON_CREATURE_III:
            iSpellType = BOTH;
            iSpellLevel = 3;
            break;
        case SPELL_SUMMON_CREATURE_IV:
            iSpellType = BOTH;
            iSpellLevel = 4;
            break;
        case SPELL_SUMMON_CREATURE_IX:
            iSpellType = BOTH;
            iSpellLevel = 9;
            break;
        case SPELL_SUMMON_CREATURE_V:
            iSpellType = BOTH;
            iSpellLevel = 5;
            break;
        case SPELL_SUMMON_CREATURE_VI:
            iSpellType = BOTH;
            iSpellLevel = 6;
            break;
        case SPELL_SUMMON_CREATURE_VII:
            iSpellType = BOTH;
            iSpellLevel = 7;
            break;
        case SPELL_SUMMON_CREATURE_VIII:
            iSpellType = BOTH;
            iSpellLevel = 8;
            break;
        case SPELL_SUNBEAM:
            iSpellType = DIVINE;
            iSpellLevel = 8;
            break;
        case SPELL_TENSERS_TRANSFORMATION:
            iSpellType = ARCANE;
            iSpellLevel = 6;
            break;
        case SPELL_TIME_STOP:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_TRUE_SEEING:
            iSpellType = BOTH;
            iSpellLevel = 5;
            break;
        case SPELL_VAMPIRIC_TOUCH:
            iSpellType = ARCANE;
            iSpellLevel = 3;
            break;
        case SPELL_VIRTUE:
            iSpellType = DIVINE;
            iSpellLevel = 0;
            break;
        case SPELL_WAIL_OF_THE_BANSHEE:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_WALL_OF_FIRE:
            iSpellType = BOTH;
            iSpellLevel = 4;
            break;
        case SPELL_WAR_CRY:
            iSpellType = ARCANE;
            iSpellLevel = 4;
            break;
        case SPELL_WEB:
            iSpellType = ARCANE;
            iSpellLevel = 2;
            break;
        case SPELL_WEIRD:
            iSpellType = ARCANE;
            iSpellLevel = 9;
            break;
        case SPELL_WORD_OF_FAITH:
            iSpellType = DIVINE;
            iSpellLevel = 7;
            break;
        case SPELL_DARKVISION:
            iSpellType = BOTH;
            iSpellLevel = 2;
            break;
        case SPELL_HOLY_AURA:
            iSpellType = DIVINE;
            iSpellLevel = 8;
            break;
        case SPELL_UNHOLY_AURA:
            iSpellType = DIVINE;
            iSpellLevel = 8;
            break;
        case SPELL_GREATER_SHADOW_CONJURATION_MIRROR_IMAGE:
            iSpellType = ARCANE;
            iSpellLevel = 5;
            break;
        default:
            iSpellType = INVALID;
            iSpellLevel = INVALID;
            break;
    } //end switch(iSpellId)
    if(DEBUG)
    {
        SendMessageToPC(OBJECT_SELF, "Spell Type = " + IntToString(iSpellType));
        SendMessageToPC(OBJECT_SELF, "Spell Level = " + IntToString(
                        iSpellLevel));
    } //end if(DEBUG)
}  //end void SpellLevel(int iSpellId)


//void CasterLevel(object oCaster)
//Determines the primary class and level the casting is using for the scroll
//Or if caster isn't a casting class, set cast level to 0
void CasterLevel(object oCaster)
{
    //Get caster's highest spell levels
    int iInt = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE)-10;
    int iWis = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM)-10;
    int iCha = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA)-10;

    //Get caster's class levels
    int iBardLevel = GetLevelByClass(CLASS_TYPE_BARD);
    int iClericLevel = GetLevelByClass(CLASS_TYPE_CLERIC);
    int iDruidLevel = GetLevelByClass(CLASS_TYPE_DRUID);
    int iPaladinLevel = GetLevelByClass(CLASS_TYPE_PALADIN);
    int iRangerLevel = GetLevelByClass(CLASS_TYPE_RANGER);
    int iSorcererLevel = GetLevelByClass(CLASS_TYPE_SORCERER);
    int iWizardLevel = GetLevelByClass(CLASS_TYPE_WIZARD);

    //Get UMD skill level
    iUMDSkillLevel = GetSkillRank(SKILL_USE_MAGIC_DEVICE);

    //Get caster's spell levels
    int iBSpLevel = (iBardLevel + 2 ) / 3;
    if(iBSpLevel > iCha)
    {
        iBSpLevel = iCha;
    } //end if
    if(iBSpLevel > 6)
    {
        iBSpLevel = 6;
    } //end if
    if(iBardLevel == 1)
    {
        iBSpLevel = 0;
    } //end if
    int iCSpLevel = (iClericLevel + 1) / 2;
    if(iCSpLevel > iWis)
    {
        iCSpLevel = iWis;
    } //end if
    int iDSpLevel = (iDruidLevel + 1) / 2;
    if(iDSpLevel > iWis)
    {
        iDSpLevel = iWis;
    } //end if
    int iPSpLevel = ((iPaladinLevel - 2 ) / 3);
    if(iPSpLevel > iWis)
    {
        iPSpLevel = iWis;
    } //end if
    if(iPSpLevel > 4)
    {
        iPSpLevel = 4;
    } //end if
    if(iPaladinLevel == 4)
    {
        iPSpLevel = 1;
    } //end if
    int iRSpLevel = ((iRangerLevel - 2 ) / 3);
    if(iRSpLevel > iWis)
    {
        iRSpLevel = iWis;
    } //end if
    if(iRSpLevel > 4)
    {
        iRSpLevel = 4;
    } //end if
    if(iRangerLevel == 4)
    {
        iPSpLevel = 1;
    } //end if
    int iSSpLevel = iSorcererLevel / 2;
    if(iSSpLevel > iCha)
    {
        iSSpLevel = iCha;
    } //end if
    int iWSpLevel = (iWizardLevel + 1) / 2;
    if(iWSpLevel > iInt)
    {
        iWSpLevel = iInt;
    } //end if

    //iDCCheck TRUE if DCCheck is needed.  FALSE if not.
    iDCCheck = TRUE;

    //Check for both ARCANE and DIVINE spells
    if(CHECK_TYPE == BOTH)
    {
        //Determine highest casting level
        if(iSpellType == ARCANE)
        {
            iCasterSpLevel = GetBiggest(iBSpLevel, GetBiggest(iSSpLevel,
                                        iWSpLevel));
            if(iCasterSpLevel == iBSpLevel)
            {
                iCasterLevel = iBardLevel;
            } //end if
            else if(iCasterSpLevel == iWSpLevel)
            {
                iCasterLevel = iWizardLevel;
            } //end else if
            else if(iCasterSpLevel == iSSpLevel)
            {
                iCasterLevel = iSorcererLevel;
            } //end else if
        } //end if
        else if(iSpellType == DIVINE)
        {
            iCasterSpLevel = GetBiggest(iCSpLevel, GetBiggest(iDSpLevel,
                                        GetBiggest(iPSpLevel, iRSpLevel)));
            if(iCasterSpLevel == iPSpLevel)
            {
                iCasterLevel = iPaladinLevel;
            } //end if
            else if(iCasterSpLevel == iRSpLevel)
            {
                iCasterLevel = iRangerLevel;
            } //end else if
            else if(iCasterSpLevel == iCSpLevel)
            {
                iCasterLevel = iClericLevel;
            } //end else if
            else if(iCasterSpLevel == iDSpLevel)
            {
                iCasterLevel = iDruidLevel;
            } //end else if
        } //end else if
        else if(iSpellType == BOTH)
        {
            iCasterSpLevel = GetBiggest(iBSpLevel, GetBiggest(iSSpLevel,
                                        GetBiggest(iWSpLevel, GetBiggest(
                                        iCSpLevel, GetBiggest(iDSpLevel,
                                        GetBiggest(iPSpLevel, iRSpLevel))))));
            if(iCasterSpLevel == iPSpLevel)
            {
                iCasterLevel = iPaladinLevel;
            } //end if
            else if(iCasterSpLevel == iRSpLevel)
            {
                iCasterLevel = iRangerLevel;
            } //end else if
            else if(iCasterSpLevel == iBSpLevel)
            {
                iCasterLevel = iBardLevel;
            } //end else if
            else if(iCasterSpLevel == iCSpLevel)
            {
                iCasterLevel = iClericLevel;
            } //end else if
            else if(iCasterSpLevel == iDSpLevel)
            {
                iCasterLevel = iDruidLevel;
            } //end else if
            else if(iCasterSpLevel == iSSpLevel)
            {
                iCasterLevel = iSorcererLevel;
            } //end else if
            else if(iCasterSpLevel == iWSpLevel)
            {
                iCasterLevel = iWizardLevel;
            } //end else if
        } //end else if
    }//end if
    //Check for ARCANE spells only
    else if(CHECK_TYPE == ARCANE)
    {
        //Determine highest casting level
        if(iSpellType == ARCANE)
        {
            iCasterSpLevel = GetBiggest(iBSpLevel, GetBiggest(iSSpLevel,
                                        iWSpLevel));
            if(iCasterSpLevel == iBSpLevel)
            {
                iCasterLevel = iBardLevel;
            } //end if
            else if(iCasterSpLevel == iSSpLevel)
            {
                iCasterLevel = iSorcererLevel;
            } //end else if
            else if(iCasterSpLevel == iWSpLevel)
            {
                iCasterLevel = iWizardLevel;
            } //end else if
        } //end if
        else if(iSpellType == DIVINE)
        {
            iDCCheck = FALSE;
        } //end else if
        else if(iSpellType == BOTH)
        {
            iCasterSpLevel = GetBiggest(iBSpLevel, GetBiggest(iSSpLevel,
                                        iWSpLevel));
            if(iCasterSpLevel == iBSpLevel)
            {
                iCasterLevel = iBardLevel;
            } //end else if
            else if(iCasterSpLevel == iSSpLevel)
            {
                iCasterLevel = iSorcererLevel;
            } //end else if
            else if(iCasterSpLevel == iWSpLevel)
            {
                iCasterLevel = iWizardLevel;
            } //end else if
            else if(iCasterSpLevel == iSSpLevel)
            {
                iCasterLevel = iSorcererLevel;
            } //end else if
        } //end else if
    } //end else if
    //Check for DIVINE spells only
    else if(CHECK_TYPE == DIVINE)
    {
        if(iSpellType == ARCANE)
        {
            iDCCheck = FALSE;
        } //end if
        else if(iSpellType == DIVINE)
        {
            iCasterSpLevel = GetBiggest(iCSpLevel, GetBiggest(iDSpLevel,
                                        GetBiggest(iPSpLevel, iRSpLevel)));
            if(iCasterSpLevel == iPSpLevel)
            {
                iCasterLevel = iPaladinLevel;
            } //end if
            else if(iCasterSpLevel == iRSpLevel)
            {
                iCasterLevel = iRangerLevel;
            } //end else if
            else if(iCasterSpLevel == iCSpLevel)
            {
                iCasterLevel = iClericLevel;
            } //end else if
            else if(iCasterSpLevel == iDSpLevel)
            {
                iCasterLevel = iDruidLevel;
            } //end else if
        } //end else if
        else if(iSpellType == BOTH)
        {
            iCasterSpLevel = GetBiggest(iCSpLevel, GetBiggest(iDSpLevel,
                                        GetBiggest(iPSpLevel, iRSpLevel)));
            if(iCasterSpLevel == iPSpLevel)
            {
                iCasterLevel = iPaladinLevel;
            } //end if
            else if(iCasterSpLevel == iRSpLevel)
            {
                iCasterLevel = iRangerLevel;
            } //end else if
            else if(iCasterSpLevel == iCSpLevel)
            {
                iCasterLevel = iClericLevel;
            } //end else if
            else if(iCasterSpLevel == iDSpLevel)
            {
                iCasterLevel = iDruidLevel;
            } //end else if
        } //end else if
    } //end else if

//---Qel-1, iUMDSkillLevel > 0 is not a valid check
//   half-orc rogue, 1 skill rank in UMD and 6 charisma can have a skill of -1

//    //if has UMD skill, get rogue/bard level
//    if(iUMDSkillLevel > 0)
//    {
      iUMDClassLevel = iBardLevel + GetLevelByClass(CLASS_TYPE_ROGUE);
//    } //end if

    if(DEBUG) //Debug Statements
    {
        SendMessageToPC(OBJECT_SELF, "Class Level = " + IntToString(iCasterLevel
                        ));
        SendMessageToPC(OBJECT_SELF, "Class Spell Level = " + IntToString(
                        iCasterSpLevel));
        SendMessageToPC(OBJECT_SELF, "Rogue/Bard Level = " + IntToString(
                        iUMDClassLevel));
        SendMessageToPC(OBJECT_SELF, "UMD Level = " + IntToString(iUMDSkillLevel
                        ));
    } //end if(DEBUG)
} //end void CasterLevel(object oCaster)


//int DCCheck()
//Checks if caster passes the DC of the scroll
int DCCheck()
{
    //Constants
    int SPELLCRAFT_SUCCESS = 0;
    int SPELLCRAFT_FAILURE = 1;
    int UMD_SUCCESS        = 2;
    int UMD_FAILURE        = 3;
    int AUTO_SUCCESS       = 4;
    int AUTO_FAILURE       = 5;

    //iReturn is whether or not DC check was successful
    int iReturn = FALSE;
    //iSDC is spellcraft DC
    int iSDC = INVALID;
    //iUDC is UMD DC
    int iUDC = INVALID;
    //iSBonus is spellcraft bonus
    int iSBonus = INVALID;
    //iUBonus is UMD bonus
    int iUBonus = INVALID;
    //iRoll is the caster's d20 roll
    int iRoll = d20();
    //iMsgType determins what message to be sent to caster.
    int iResult = INVALID;

    iSpellcraftLevel = GetSkillRank(SKILL_SPELLCRAFT);
    iUMDSkillLevel = GetSkillRank(SKILL_USE_MAGIC_DEVICE);

    //Determine if a Spellcraft & UMD Synergy bonus is due and calculate it
    //synergy bonus by Chon
    iSpellcraftBonus = ((iSpellcraftLevel - GetAbilityModifier(ABILITY_INTELLIGENCE)) >= 5) ? 2 : 0;
    iUMDSkillBonus = ((iUMDSkillLevel - GetAbilityModifier(ABILITY_CHARISMA)) >= 5) ? 2 : 0;

    //---Qel-2  If caster level is > 0, then no DC check is required to use a wand.
    if ((iCasterLevel > 0) && (GetBaseItemType(GetSpellCastItem()) == BASE_ITEM_MAGICWAND))
        iDCCheck = FALSE;

    //Check to see if spell need to be DC checked
    if(!iDCCheck)
    {
        if(DEBUG)
        {
            SendMessageToPC(OBJECT_SELF, "No DC needed");
        } //end if(DEBUG)
        iResult = AUTO_SUCCESS;
    } //end if
    else
    {
        //BOOKMARK_DC
        if(iCasterLevel > 0)
        {
//---Qel-2  Assign Wand DC if spell is cast from a wand
            if (GetBaseItemType(GetSpellCastItem()) == BASE_ITEM_MAGICWAND)
            {
                iSDC = WAND_SPELLCRAFT_DC;
            }
            else
            {
                //This is the DC for using spellcraft to cast from scrolls
                //3E comliance change by Chon
                //iSDC = (5 * iCasterSpLevel) + (6 * (iSpellLevel - iCasterSpLevel));
                iSDC = 20 + iSpellLevel;
            }
            //iSBonus = iSpellcraftLevel + iCasterLevel + (iUMDSkillLevel / 3);
            iSBonus = iUMDSkillBonus + iSpellcraftLevel;
        } //end if
        if(iUMDClassLevel > 0)
        {
//---Qel-2  Assign Wand DC if spell is cast from a wand
            if (GetBaseItemType(GetSpellCastItem()) == BASE_ITEM_MAGICWAND)
            {
                iUDC = WAND_UMD_DC;
            }
            else
            {
                //This is the DC for using UMD to cast from scrolls.
                //3E compliance by Chon
                iUDC = UMD_DC + iSpellLevel;
            }
            // old formula iUBonus = ((((100 - ROGUE_BARD_PERCENT) * iUMDSkillLevel) +
            //           (ROGUE_BARD_PERCENT * (3 + GetAbilityModifier(
            //           ABILITY_CHARISMA) + iUMDClassLevel))) / 100 )+
            //           iSpellcraftBonus;
            iUBonus = iSpellcraftBonus  + iUMDSkillLevel;
        } //end if

        //Check if Spellcraft or UMD DC should be used.
        if(iCasterLevel > 0 && iUMDClassLevel == 0)
        {
            if(iSpellLevel > iCasterSpLevel)
            {
                if(DEBUG)
                {
                    SendMessageToPC(OBJECT_SELF, "Spellcraft check");
                } //end if(DEBUG)

                if(iRoll == CRITICAL_SUCCESS)
                {
                    iResult = SPELLCRAFT_SUCCESS;
                } //end if
                else if(iRoll == CRITICAL_FAILURE)
                {
                    iResult = SPELLCRAFT_FAILURE;
                } //end else if
                else if((iRoll + iSBonus) >= iSDC)
                {
                    iResult = SPELLCRAFT_SUCCESS;
                } //end else if
                else
                {
                    iResult = SPELLCRAFT_FAILURE;
                } //end else
            } //end if
            else
            {
                iResult = AUTO_SUCCESS;
            } //end else
        } //end if
        else if(iCasterLevel > 0 && iUMDClassLevel > 0)
        {
            if(iSpellLevel > iCasterSpLevel)
            {
                if((iSBonus - iSDC) >= (iUBonus - iUDC))
                {
                    if(DEBUG)
                    {
                        SendMessageToPC(OBJECT_SELF, "Spellcraft check");
                    } //end if(DEBUG)

                    if(iRoll == CRITICAL_SUCCESS)
                    {
                        iResult = SPELLCRAFT_SUCCESS;
                    } //end if
                    else if(iRoll == CRITICAL_FAILURE)
                    {
                        iResult = SPELLCRAFT_FAILURE;
                    } //end else if
                    else if((iRoll + iSBonus) >= iSDC)
                    {   iResult = SPELLCRAFT_SUCCESS;
                    } //end else if
                    else
                    {
                        iResult = SPELLCRAFT_FAILURE;
                    } //end else
                } //end if
                else
                {
                    if(DEBUG)
                    {
                        SendMessageToPC(OBJECT_SELF, "UMD check");
                    } //end if(DEBUG)

                    if(iRoll == CRITICAL_SUCCESS)
                    {
                        iResult = UMD_SUCCESS;
                    } //end if
                    else if(iRoll == CRITICAL_FAILURE)
                    {
                        iResult = UMD_FAILURE;
                    } //end else if
                    else if((iRoll + iUBonus) >= iUDC)
                    {
                        iResult = UMD_SUCCESS;
                    } //end else if
                    else
                    {
                        iResult = UMD_FAILURE;
                    } //end else
                } //end else
            } //end if
            else
            {
                iResult = AUTO_SUCCESS;
            } //end else
        } //end else if
        else if(iCasterLevel == 0 && iUMDClassLevel > 0)
        {
            if(DEBUG)
            {
                SendMessageToPC(OBJECT_SELF, "UMD check");
            } //end if(DEBUG)

            if(iRoll == CRITICAL_SUCCESS)
            {
                iResult = UMD_SUCCESS;
            } //end if
            else if(iRoll == CRITICAL_FAILURE)
            {
                iResult = UMD_FAILURE;
            } //end else if
            else if((iRoll + iUBonus) >= iUDC)
            {
                iResult = UMD_SUCCESS;
            } //end else if
            else
            {
                iResult = UMD_FAILURE;
            } //end else
        } //end else if
        else if(iCasterLevel == 0 && iUMDClassLevel == 0)
        {
            iResult = AUTO_FAILURE;
        } //end else
    } //end else

    //SendMessageToPC of the DC checking results.
    if(iResult == SPELLCRAFT_SUCCESS)
    {
//---Qel-1
        SendMessageToPC(OBJECT_SELF,
                        "..Attempt to use item. *Success* (" + IntToString(    // scroll changed to item in string
                        iRoll) + " + " + IntToString(iSBonus) + " = " +
                        IntToString(iRoll + iSBonus) + " vs. DC: " +
                        IntToString(iSDC) + ")");
        iReturn = TRUE;
    } //end if
    else if(iResult == SPELLCRAFT_FAILURE)
    {
//---Qel-1
        SendMessageToPC(OBJECT_SELF,
                        "..Attempt to use item. *Failure* (" + IntToString(    // scroll changed to item in string
                        iRoll) + " + " + IntToString(iSBonus) + " = "  +
                        IntToString(iRoll + iSBonus) + " vs. DC: " +
                        IntToString(iSDC) + ")");
        if(!SpellcraftPenaltyCheck())
        {
            ApplyPenalty(OBJECT_SELF);
        } //end if
        iReturn = FALSE;
    } //end else if
    else if(iResult == UMD_SUCCESS)
    {
//---Qel-1
        SendMessageToPC(OBJECT_SELF,
                        "..Attempt to use item. *Success* (" + IntToString(    // scroll changed to item in string
                        iRoll) + " + " + IntToString(iUBonus) + " = " +
                        IntToString(iRoll + iUBonus) + " vs. DC: " +
                        IntToString(iUDC) + ")");
        iReturn = TRUE;
    } //end else if
    else if(iResult == UMD_FAILURE)
    {
//---Qel-1
        SendMessageToPC(OBJECT_SELF,
                        "..Attempt to use item. *Failure* (" + IntToString(    // scroll changed to item in string
                        iRoll) + " + " + IntToString(iUBonus) + " = " +
                        IntToString(iRoll + iUBonus) + " vs. DC: " +
                        IntToString(iUDC) + ")");
        if((iUDC - (iRoll + iUBonus)) >= UMD_PENALTY_DC)
        {
            ApplyPenalty(OBJECT_SELF);
        } //end if
        iReturn = FALSE;
    } //end else if
    else if(iResult == AUTO_SUCCESS)
    {
        SendMessageToPC(OBJECT_SELF,
                        "..Attempt to use item. *Automatic Success*");
        iReturn = TRUE;
    } //end else if
    else if(iResult == AUTO_FAILURE)
    {
        SendMessageToPC(OBJECT_SELF,
                        "..Attempt to use item. *Automatic Failure*");
        ApplyPenalty(OBJECT_SELF);
        iReturn = FALSE;
    } //end else if

    return iReturn;
} //end intDCCheck()


//int SpellcraftPenaltyCheck()
//Returns TRUE if caster bypass penalty check, FALSE if not
int SpellcraftPenaltyCheck()
{
    int iReturn = FALSE;
    int iRoll = d20();
    //Default roll bonus is Wisdom Modifier + (Spellcraft / 5)
    int iWisBonus = GetAbilityModifier(ABILITY_WISDOM);
    int iSpellcraftBonus = GetSkillRank(SKILL_SPELLCRAFT) / 5;
    int iPenaltyRollBonus = iWisBonus + iSpellcraftBonus;
    string sOperator = " + ";

    if(iRoll == CRITICAL_SUCCESS)
    {
        iReturn = TRUE;
    } //end if
    else if(iRoll == CRITICAL_FAILURE)
    {
        iReturn = FALSE;
    } //end else if
    else if(SPELLCRAFT_PENALTY_DC > (iRoll + iPenaltyRollBonus))
    {
        iReturn = FALSE;
    } //end else if
    else if(SPELLCRAFT_PENALTY_DC <= (iRoll + iPenaltyRollBonus))
    {
        iReturn = TRUE;
    } //end else

    if(iWisBonus >= 0)
    {
        sOperator = " + ";
    } //end if
    else
    {
        sOperator = " ";
    } //end else

    if(iReturn == TRUE)
    {
        SendMessageToPC(OBJECT_SELF, "Penalty Check. *Success* (" + IntToString(
                        iRoll) + sOperator + IntToString(iWisBonus) + " + " +
                        IntToString(iSpellcraftBonus) + " = " + IntToString(
                        iRoll + iPenaltyRollBonus) + " vs. DC: " + IntToString(
                        SPELLCRAFT_PENALTY_DC) + ")");
    } //end if
    else
    {
        SendMessageToPC(OBJECT_SELF, "Penalty Check. *Failure* (" + IntToString(
                        iRoll) + sOperator + IntToString(iWisBonus) + " + " +
                        IntToString(iSpellcraftBonus) + " = " + IntToString(
                        iRoll + iPenaltyRollBonus) + " vs. DC: " + IntToString(
                        SPELLCRAFT_PENALTY_DC) + ")");
    } //end else
    return iReturn;
} //end int SpellcraftPenaltyCheck()


//void ApplyPenalty(object oCaster)
//Applies failure penalty to the caster
//BOOKMARK_PENALTY
void ApplyPenalty(object oCaster)
{
    if(PENALTY_TYPE == DAMAGE_EFFECT)
    {
        effect eDamage = EffectDamage(DAMAGE_AMOUNT);
        effect eVis = EffectVisualEffect(VFX_FNF_FIREBALL);
        effect eApply = EffectLinkEffects(eDamage, eVis);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eApply, oCaster);
    } //end if
    else if(PENALTY_TYPE == DAMAGE_BY_LEVEL_EFFECT)
    {
        //eDamage determines how much damage to apply for each spell level.
        //Change d6 to some other die or variable for different damage.
        effect eDamage = EffectDamage(d6(iSpellLevel));
        effect eVis = EffectVisualEffect(VFX_FNF_FIREBALL);
        effect eApply = EffectLinkEffects(eDamage, eVis);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eApply, oCaster);
    } //end else if
    else if(PENALTY_TYPE == RANDOM_EFFECT)
    {
        ApplyRandomEffect(oCaster);
    } //end else if
} //end void ApplyPenalty()


//void ApplyRandomEffect(object oCaster)
//Applies random effect to oCaster
//BOOKMARK_RANDOM_EFFECT
void ApplyRandomEffect(object oCaster)
{
    //iEffect This determines which random effect to use.  If you have more than
    //twenty random effects, change this to a higher number.  For example: if
    //you have total of 25 effects, change this to (d20() + d6() - 1)
    int iEffect = d20();
    if(DEBUG)
    {
        SendMessageToPC(OBJECT_SELF, "Penalty effect roll: " +
                        IntToString(iEffect));
    } //end if(DEBUG)

    //fDuration This is the duration for random temporary effects.  Adjust the
    //number inside RoundsToSeconds if you wish to change.
    //Default is 3
    float fDuration = RoundsToSeconds(3);
    location lCaster = GetLocation(oCaster);
    vector vCaster = GetPosition(oCaster);
    effect e1, e2, e3, e4, eApply;
    object oTemp;
    location lTemp;
    int iTemp;

    //switch(iEffect)  This is where random effects are stored.  If you wish to
    //add more effects, just continue on to the next case.  "default" catches
    //all the unassigned cases and reroll the random effect till the roll is a
    //valid case.
    switch(iEffect)
    {
        case 1: //Lightning strikes the caster with (d6 * Spell Level) damage
            e1 = EffectDamage(d6(iSpellLevel));
            e2 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eApply, oCaster);
            break;
        case 2: //Scroll explodes with (d6 * Spell Level) damage to the caster
                //and knocks the caster to the ground
            e1 = EffectDamage(d6(iSpellLevel));
            e2 = EffectVisualEffect(VFX_FNF_FIREBALL);
            e3 = EffectKnockdown();
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eApply, oCaster);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e3, oCaster, 6.0);
            break;
        case 3: //Polymorphs caster into a confused penguin for the duration
            e1 = EffectPolymorph(POLYMORPH_TYPE_PENGUIN);
            e2 = EffectVisualEffect(VFX_IMP_POLYMORPH);
            e3 = EffectConfused();
            e4 = EffectLinkEffects(e1, e2);
            eApply = EffectLinkEffects(e3, e4);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 4: //Polymorphs caster into a confused cow for the duration
            e1 = EffectPolymorph(POLYMORPH_TYPE_COW);
            e2 = EffectVisualEffect(VFX_IMP_POLYMORPH);
            e3 = EffectConfused();
            e4 = EffectLinkEffects(e1, e2);
            eApply = EffectLinkEffects(e3, e4);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            switch(d2())
            {
                case 1:
                    PlaySound("as_an_cow1");
                    break;
                case 2:
                    PlaySound("as_an_cow2");
                    break;
                default:
                    PlaySound("as_an_cow1");
                    break;
            } //end switch(d2())
            break;
        case 5: //Renders caster blind and deaf for the duration
            e1 = EffectBlindness();
            e2 = EffectDeaf();
            e3 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
            e4 = EffectLinkEffects(e1, e2);
            eApply = EffectLinkEffects(e3, e4);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 6: //Creates a wall of fire under the caster for the duration
            eApply = EffectAreaOfEffect(AOE_PER_WALLFIRE);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eApply, lCaster,
                                fDuration);
            break;
        case 7: //Renders the caster confused for the duration
            e1 = EffectConfused();
            e2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 8: //Lowers all of caster's ability score 1 point for every 3 level
                //of Spell Level for the duration
            iTemp = (iSpellLevel + 2) / 3;
            e1 = EffectCurse(iTemp, iTemp, iTemp, iTemp, iTemp, iTemp);
            e2 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 9: //Summons a hostile imp for Spell Levels 0-4.
                //Summons a hostile balor for Spell Levels 5 and above.
            vCaster = vCaster + Vector(IntToFloat(Random(21) - 10),
                                       IntToFloat(Random(21) - 10));
            lTemp = Location(GetArea(oCaster), vCaster, GetFacingFromLocation(
                             lCaster));
            if(iSpellLevel < 5)
            {
                CreateCreature(OBJECT_TYPE_CREATURE, "nw_imp", lTemp);
                eApply = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eApply, lTemp);
            } //end if
            else
            {
                eApply = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eApply, lTemp);
                DelayCommand(3.0, CreateCreature(OBJECT_TYPE_CREATURE,
                             "NW_S_BALOR_EVIL", lTemp));

            } //end else
            break;
        case 10:  //Render the caster feared for the duration
            e1 = EffectFrightened();
            e2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR );
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 11: //Entangles the caster for the duration
            e1 = EffectEntangle();
            e2 = EffectVisualEffect(VFX_DUR_ENTANGLE);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 12: //Casts Dispel Magic at the caster
            e1 = EffectDispelMagicAll(20);
            e2 = EffectVisualEffect(VFX_FNF_DISPEL_GREATER);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eApply, oCaster);
            break;
        case 13: //Renders the caster slowed for the duration
            e1 = EffectSlow();
            e2 = EffectVisualEffect(VFX_IMP_SLOW);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 14: //Creates a web under the caster for the duration
            eApply = EffectAreaOfEffect(AOE_PER_WEB);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eApply, lCaster,
                                fDuration);
            break;
        case 15: //Creates an stinking fog under the caster for the duration
            eApply = EffectAreaOfEffect(AOE_PER_FOGSTINK);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eApply, lCaster,
                                fDuration);
            break;
        case 16: //Creates darkness at the caster for the duration
            eApply = EffectAreaOfEffect(AOE_PER_DARKNESS);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eApply, lCaster,
                                fDuration);
            break;
        case 17: //Increases one random stat of the caster by (1d4 + 1) for the
                 //duration
            switch(d6())
            {
                case 1:
                    iTemp = ABILITY_CHARISMA;
                    break;
                case 2:
                    iTemp = ABILITY_CONSTITUTION;
                    break;
                case 3:
                    iTemp = ABILITY_DEXTERITY;
                    break;
                case 4:
                    iTemp = ABILITY_INTELLIGENCE;
                    break;
                case 5:
                    iTemp = ABILITY_STRENGTH;
                    break;
                case 6:
                    iTemp = ABILITY_WISDOM;
                    break;
                default:
                    iTemp = ABILITY_STRENGTH;
                    break;
            } //end switch(d6())
            e1 = EffectAbilityIncrease(iTemp, d4() + 1);
            e2 = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 18: //The caster and the surrounding area hears a dragon roar
            switch(d3())
            {
                case 1:
                    PlaySound("as_an_dragonror1");
                    break;
                case 2:
                    PlaySound("as_an_dragonror2");
                    break;
                case 3:
                    PlaySound("as_an_dragonror3");
                    break;
                default:
                    PlaySound("as_an_dragonror1");
                    break;
            } //end switch(d3())
            break;
        case 19: //Casts invisiblity on the caster for the duration
            e1 = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
            e2 = EffectVisualEffect(VFX_DUR_SANCTUARY);
            eApply = EffectLinkEffects(e1, e2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oCaster,
                                fDuration);
            break;
        case 20: //Teleports the caster to a random location within 10 meters
            vCaster = vCaster + Vector(IntToFloat(Random(21) - 10),
                                       IntToFloat(Random(21) - 10));
            lTemp = Location(GetArea(oCaster), vCaster, GetFacingFromLocation(
                             lCaster));
            eApply = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eApply, oCaster);
            ActionJumpToLocation(lTemp);
            break;
        default: //Reroll
            ApplyRandomEffect(oCaster);
            break;
    } //end switch(iEffect)
} //end void ApplyRandomEffect(object oCaster)

//void CreateCreature(string sName, location lTarget)
//This is a wrapper function to wrap around CreateObject
void CreateCreature(int iType, string sName, location lTarget)
{
     CreateObject(iType, sName, lTarget);
} //void CreateCreature(string sName, location lTarget)
