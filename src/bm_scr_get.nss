#include "bm_scroll_inc"

void main()
{
  string sTalk = GetStringLowerCase(GetLocalString(OBJECT_SELF, "Stack"));
  string sSpellTag;
  int iSpellLevel;
  int iAdditionalCost;
  int iSpellCreated;
  int iSpellID;

  object oCreator = GetPCSpeaker();

//Get Spell Tag of the requested spell
  if (sTalk != "") {
    //Level 0 Spells
    if (sTalk == "daze")
    {
        sSpellTag = "NW_IT_SPARSCR003";
        iSpellLevel = 0;
        iAdditionalCost = 0;
        iSpellID = SPELL_DAZE;
    }
    else if (sTalk == "light")
    {
        sSpellTag = "NW_IT_SPARSCR004";
        iSpellLevel = 0;
        iAdditionalCost = 0;
        iSpellID = SPELL_LIGHT;
    }
    else if (sTalk == "ray of frost")
    {
        sSpellTag = "NW_IT_SPARSCR002";
        iSpellLevel = 0;
        iAdditionalCost = 0;
        iSpellID = SPELL_RAY_OF_FROST;
    }
    else if (sTalk == "resistance")
    {
        sSpellTag = "NW_IT_SPARSCR001";
        iSpellLevel = 0;
        iAdditionalCost = 0;
        iSpellID = SPELL_RESISTANCE;
    }
/*--------------------------    Level 1 Spells    ------------------------*/
    else if (sTalk == "burning hands")
    {
        sSpellTag = "NW_IT_SPARSCR112";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_BURNING_HANDS;
    }
    else if (sTalk == "charm person")
    {
        sSpellTag = "NW_IT_SPARSCR107";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_CHARM_PERSON;
    }
    else if (sTalk == "color spray")
    {
        sSpellTag = "NW_IT_SPARSCR110";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_COLOR_SPRAY;
    }
    else if (sTalk == "grease")
    {
        sSpellTag = "NW_IT_SPARSCR103";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_GREASE;
    }
    else if (sTalk == "identify")
    {
        sSpellTag = "NW_IT_SPARSCR106";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_IDENTIFY;
    }
    else if (sTalk == "mage armor")
    {
        sSpellTag = "NW_IT_SPARSCR104";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_MAGE_ARMOR;
    }
    else if (sTalk == "magic missile")
    {
        sSpellTag = "NW_IT_SPARSCR109";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_MAGIC_MISSILE;
    }
    else if (sTalk == "negative energy ray")
    {
        sSpellTag = "nw_it_sparscr113";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_NEGATIVE_ENERGY_RAY;
    }
    else if (sTalk == "protection from alignment")
    {
        sSpellTag = "NW_IT_SPARSCR102";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_PROTECTION_FROM_EVIL;
    }
    else if (sTalk == "ray of enfeeblement")
    {
        sSpellTag = "NW_IT_SPARSCR111";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_RAY_OF_ENFEEBLEMENT;
    }
    else if (sTalk == "scare")
    {
        sSpellTag = "NW_IT_SPARSCR210";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_SCARE;
    }
    else if (sTalk == "sleep")
    {
        sSpellTag = "NW_IT_SPARSCR108";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_SLEEP;
    }
    else if (sTalk == "summon creature i")
    {
        sSpellTag = "NW_IT_SPARSCR105";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_I;
    }
    else if (sTalk == "endure elements")
    {
        sSpellTag = "NW_IT_SPARSCR101";
        iSpellLevel = 1;
        iAdditionalCost = 0;
        iSpellID = SPELL_ENDURE_ELEMENTS;
    }

/*--------------------------    Level 2 Spells    ------------------------*/
    else if (sTalk == "blindness" || sTalk == "deafness" || sTalk == "blindness/deafness")
    {
        sSpellTag = "NW_IT_SPARSCR211";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_BLINDNESS_AND_DEAFNESS;
    }
    else if (sTalk == "bull's strength")
    {
        sSpellTag = "NW_IT_SPARSCR212";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_BULLS_STRENGTH;
    }
    else if (sTalk == "cat's grace")
    {
        sSpellTag = "NW_IT_SPARSCR213";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_CATS_GRACE;
    }
    else if (sTalk == "darkness")
    {
        sSpellTag = "NW_IT_SPARSCR206";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_DARKNESS;
    }
    else if (sTalk == "eagle's splendor")
    {
        sSpellTag = "nw_it_sparscr219";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_EAGLE_SPLEDOR;
    }
    else if (sTalk == "endurance")
    {
        sSpellTag = "NW_IT_SPARSCR215";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_ENDURANCE;
    }
    else if (sTalk == "fox's cunning")
    {
        sSpellTag = "nw_it_sparscr220";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_FOXS_CUNNING;
    }
    else if (sTalk == "ghostly visage")
    {
        sSpellTag = "NW_IT_SPARSCR208";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_GHOSTLY_VISAGE;
    }
    else if (sTalk == "ghoul touch")
    {
        sSpellTag = "NW_IT_SPARSCR209";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_GHOUL_TOUCH;
    }
    else if (sTalk == "invisibility")
    {
        sSpellTag = "NW_IT_SPARSCR207";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_INVISIBILITY;
    }
    else if (sTalk == "knock")
    {
        sSpellTag = "NW_IT_SPARSCR216";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_KNOCK;
    }
    else if (sTalk == "lesser dispel")
    {
        sSpellTag = "NW_IT_SPARSCR218";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_LESSER_DISPEL;
    }
    else if (sTalk == "melf's acid arrow")
    {
        sSpellTag = "NW_IT_SPARSCR202";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_MELFS_ACID_ARROW;
    }
    else if (sTalk == "owl's wisdom")
    {
        sSpellTag = "nw_it_sparscr221";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_OWLS_WISDOM;
    }
    else if (sTalk == "resist elements")
    {
        sSpellTag = "NW_IT_SPARSCR201";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_RESIST_ELEMENTS;
    }
    else if (sTalk == "see invisibility")
    {
        sSpellTag = "NW_IT_SPARSCR205";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_SEE_INVISIBILITY;
    }
    else if (sTalk == "summon creature ii")
    {
        sSpellTag = "NW_IT_SPARSCR203";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_II;
    }
    else if (sTalk == "web")
    {
        sSpellTag = "NW_IT_SPARSCR204";
        iSpellLevel = 2;
        iAdditionalCost = 0;
        iSpellID = SPELL_WEB;
    }

   /*--------------------------    Level 3 Spells    ------------------------*/
    else if (sTalk == "clairaudience" || sTalk == "clairvoyance" || sTalk == "clairaudience/clairvoyance")
    {
        sSpellTag = "NW_IT_SPARSCR307";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
    }
    else if (sTalk == "clarity")
    {
        sSpellTag = "NW_IT_SPARSCR217";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_CLARITY;
    }
    else if (sTalk == "dispel magic")
    {
        sSpellTag = "NW_IT_SPARSCR301";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_DISPEL_MAGIC;
    }
    else if (sTalk == "find traps")
    {
        sSpellTag = "BM_IT_SCROLL001";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_FIND_TRAPS;
    }
    else if (sTalk == "fireball")
    {
        sSpellTag = "NW_IT_SPARSCR309";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_FIREBALL;
    }
    else if (sTalk == "flame arrow")
    {
        sSpellTag = "NW_IT_SPARSCR304";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_FLAME_ARROW;
    }
    else if (sTalk == "haste")
    {
        sSpellTag = "NW_IT_SPARSCR312";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_HASTE;
    }
    else if (sTalk == "hold person")
    {
        sSpellTag = "NW_IT_SPARSCR308";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_HOLD_PERSON;
    }
    else if (sTalk == "invisibility sphere")
    {
        sSpellTag = "NW_IT_SPARSCR314";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_INVISIBILITY_SPHERE;
    }
    else if (sTalk == "lightning bolt")
    {
        sSpellTag = "NW_IT_SPARSCR310";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_LIGHTNING_BOLT;
    }
    else if (sTalk == "magic circle against alignment")
    {
        sSpellTag = "NW_IT_SPARSCR302";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_MAGIC_CIRCLE_AGAINST_EVIL;
    }
    else if (sTalk == "negative energy burst")
    {
        sSpellTag = "nw_it_sparscr315";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_NEGATIVE_ENERGY_BURST;
    }
    else if (sTalk == "protection from elements")
    {
        sSpellTag = "NW_IT_SPARSCR303";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_PROTECTION_FROM_ELEMENTS;
    }
    else if (sTalk == "slow")
    {
        sSpellTag = "NW_IT_SPARSCR313";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_SLOW;
    }
    else if (sTalk == "stinking cloud")
    {
        sSpellTag = "NW_IT_SPARSCR305";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_STINKING_CLOUD;
    }
    else if (sTalk == "summon creature iii")
    {
        sSpellTag = "NW_IT_SPARSCR306";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_III;
    }
    else if (sTalk == "vampiric touch")
    {
        sSpellTag = "NW_IT_SPARSCR311";
        iSpellLevel = 3;
        iAdditionalCost = 0;
        iSpellID = SPELL_VAMPIRIC_TOUCH;
    }
   /*--------------------------    Level 4 Spells    ------------------------*/
    else if (sTalk == "bestow curse")
    {
        sSpellTag = "NW_IT_SPARSCR414";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_BESTOW_CURSE;
    }
    else if (sTalk == "charm monster")
    {
        sSpellTag = "NW_IT_SPARSCR405";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_CHARM_MONSTER;
    }
    else if (sTalk == "confusion")
    {
        sSpellTag = "NW_IT_SPARSCR406";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_CONFUSION;
    }
    else if (sTalk == "contagion")
    {
        sSpellTag = "NW_IT_SPARSCR411";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_CONTAGION;
    }
    else if (sTalk == "enervation")
    {
        sSpellTag = "NW_IT_SPARSCR412";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_ENERVATION;
    }
    else if (sTalk == "evard's black tentacles")
    {
        sSpellTag = "BM_IT_SCROLL002";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_EVARDS_BLACK_TENTACLES;
    }
    else if (sTalk == "fear")
    {
        sSpellTag = "NW_IT_SPARSCR413";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_FEAR;
    }
    else if (sTalk == "ice storm")
    {
        sSpellTag = "BM_IT_SCROLL003";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_ICE_STORM;
    }
    else if (sTalk == "improved invisibility")
    {
        sSpellTag = "NW_IT_SPARSCR408";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_IMPROVED_INVISIBILITY;
    }
    else if (sTalk == "lesser spell breach")
    {
        sSpellTag = "NW_IT_SPARSCR417";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_LESSER_SPELL_BREACH;
    }
    else if (sTalk == "minor globe of invulnerability")
    {
        sSpellTag = "NW_IT_SPARSCR401";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
    }
    else if (sTalk == "phantasmal killer")
    {
        sSpellTag = "NW_IT_SPARSCR409";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_PHANTASMAL_KILLER;
    }
    else if (sTalk == "ploymorph self")
    {
        sSpellTag = "NW_IT_SPARSCR415";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_POLYMORPH_SELF;
    }
    else if (sTalk == "remove blindness/deafness" || sTalk == "remove blindness" || sTalk == "remove deafness")
    {
        sSpellTag = "NW_IT_SPDVSCR301";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
    }
    else if (sTalk == "remove curse")
    {
        sSpellTag = "NW_IT_SPARSCR402";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_REMOVE_CURSE;
    }
    else if (sTalk == "shadow conjuration")
    {
        sSpellTag = "NW_IT_SPARSCR410";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_SHADOW_CONJURATION_DARKNESS;
    }
    else if (sTalk == "stoneskin")
    {
        sSpellTag = "NW_IT_SPARSCR403";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_STONESKIN;
    }
    else if (sTalk == "summon creature iv")
    {
        sSpellTag = "NW_IT_SPARSCR404";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_IV;
    }
    else if (sTalk == "wall of fire")
    {
        sSpellTag = "NW_IT_SPARSCR407";
        iSpellLevel = 4;
        iAdditionalCost = 0;
        iSpellID = SPELL_WALL_OF_FIRE;
    }
   /*--------------------------    Level 5 Spells    ------------------------*/
    else if (sTalk == "cloudkill")
    {
        sSpellTag = "NW_IT_SPARSCR502";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_CLOUDKILL;
    }
    else if (sTalk == "cone of cold")
    {
        sSpellTag = "NW_IT_SPARSCR507";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_CONE_OF_COLD;
    }
    else if (sTalk == "dismissal")
    {
        sSpellTag = "NW_IT_SPARSCR501";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_DISMISSAL;
    }
    else if (sTalk == "dominate person")
    {
        sSpellTag = "NW_IT_SPARSCR503";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_DOMINATE_PERSON;
    }
    else if (sTalk == "elemental shield")
    {
        sSpellTag = "NW_IT_SPARSCR416";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_ELEMENTAL_SHIELD;
    }
    else if (sTalk == "energy buffer")
    {
        sSpellTag = "BM_IT_SCROLL004";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_ENERGY_BUFFER;
    }
    else if (sTalk == "feeblemind")
    {
        sSpellTag = "NW_IT_SPARSCR504";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_FEEBLEMIND;
    }
    else if (sTalk == "greater shadow conjuration")
    {
        sSpellTag = "NW_IT_SPARSCR508";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW;
    }
    else if (sTalk == "hold monster")
    {
        sSpellTag = "NW_IT_SPARSCR505";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_HOLD_MONSTER;
    }
    else if (sTalk == "lesser mind blank")
    {
        sSpellTag = "NW_IT_SPARSCR511";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_LESSER_MIND_BLANK;
    }
    else if (sTalk == "lesser planer binding")
    {
        sSpellTag = "NW_IT_SPARSCR512";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_LESSER_PLANAR_BINDING;
    }
    else if (sTalk == "lesser planer mantle")
    {
        sSpellTag = "NW_IT_SPARSCR513";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_LESSER_SPELL_MANTLE;
    }
    else if (sTalk == "mind fog")
    {
        sSpellTag = "NW_IT_SPARSCR506";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_MIND_FOG;
    }
    else if (sTalk == "summon creature v")
    {
        sSpellTag = "NW_IT_SPARSCR510";
        iSpellLevel = 5;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_V;
    }

   /*--------------------------    Level 6 Spells    ------------------------*/
    else if (sTalk == "acid fog")
    {
        sSpellTag = "NW_IT_SPARSCR603";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_ACID_FOG;
    }
    else if (sTalk == "chain lightning")
    {
        sSpellTag = "NW_IT_SPARSCR607";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_CHAIN_LIGHTNING;
    }
    else if (sTalk == "circle of death")
    {
        sSpellTag = "NW_IT_SPARSCR610";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_CIRCLE_OF_DEATH;
    }
    else if (sTalk == "ethereal visage")
    {
        sSpellTag = "NW_IT_SPARSCR608";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_ETHEREAL_VISAGE;
    }
    else if (sTalk == "globe of invulnerability")
    {
        sSpellTag = "NW_IT_SPARSCR601";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_GLOBE_OF_INVULNERABILITY;
    }
    else if (sTalk == "greater dispelling")
    {
        sSpellTag = "NW_IT_SPARSCR602";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_GREATER_DISPELLING;
    }
    else if (sTalk == "greater spell breach")
    {
        sSpellTag = "NW_IT_SPARSCR612";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_GREATER_SPELL_BREACH;
    }
    else if (sTalk == "greater stoneskin")
    {
        sSpellTag = "NW_IT_SPARSCR613";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_GREATER_STONESKIN;
    }
    else if (sTalk == "legend lore")
    {
        sSpellTag = "BM_IT_SCROLL005";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_LEGEND_LORE;
    }
    else if (sTalk == "mass haste")
    {
        sSpellTag = "NW_IT_SPARSCR611";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_MASS_HASTE;
    }
    else if (sTalk == "planar binding")
    {
        sSpellTag = "NW_IT_SPARSCR604";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_PLANAR_BINDING;
    }
    else if (sTalk == "shades")
    {
        sSpellTag = "NW_IT_SPARSCR609";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_SHADES_CONE_OF_COLD;
    }
    else if (sTalk == "summon creature vi")
    {
        sSpellTag = "NW_IT_SPARSCR605";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_VI;
    }
    else if (sTalk == "tenser's transfromation")
    {
        sSpellTag = "NW_IT_SPARSCR614";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_TENSERS_TRANSFORMATION;
    }
    else if (sTalk == "true seeing")
    {
        sSpellTag = "NW_IT_SPARSCR606";
        iSpellLevel = 6;
        iAdditionalCost = 0;
        iSpellID = SPELL_TRUE_SEEING;
    }

   /*--------------------------    Level 7 Spells    ------------------------*/
    else if (sTalk == "control undead")
    {
        sSpellTag = "NW_IT_SPARSCR707";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_CONTROL_UNDEAD;
    }
    else if (sTalk == "delayed blast fireball")
    {
        sSpellTag = "NW_IT_SPARSCR704";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_DELAYED_BLAST_FIREBALL;
    }
    else if (sTalk == "finger of death")
    {
        sSpellTag = "NW_IT_SPARSCR708";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_FINGER_OF_DEATH;
    }
    else if (sTalk == "mordenkainen's sword")
    {
        sSpellTag = "NW_IT_SPARSCR705";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_MORDENKAINENS_SWORD;
    }
    else if (sTalk == "power word stun")
    {
        sSpellTag = "NW_IT_SPARSCR702";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_POWER_WORD_STUN;
    }
    else if (sTalk == "prismatic spray")
    {
        sSpellTag = "NW_IT_SPARSCR706";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_PRISMATIC_SPRAY;
    }
    else if (sTalk == "protection from spells")
    {
        sSpellTag = "NW_IT_SPARSCR802";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_PROTECTION_FROM_SPELLS;
    }
    else if (sTalk == "shadow shield")
    {
        sSpellTag = "BM_IT_SCROLL006";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_SHADOW_SHIELD;
    }
    else if (sTalk == "spell mantle")
    {
        sSpellTag = "NW_IT_SPARSCR701";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_SPELL_MANTLE;
    }
    else if (sTalk == "summon creature vii")
    {
        sSpellTag = "NW_IT_SPARSCR703";
        iSpellLevel = 7;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_VII;
    }
   /*--------------------------    Level 8 Spells    ------------------------*/
    else if (sTalk == "create undead")
    {
        sSpellTag = "BM_IT_SCROLL007";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_CREATE_UNDEAD;
    }
    else if (sTalk == "greater planar binding")
    {
        sSpellTag = "NW_IT_SPARSCR803";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_GREATER_PLANAR_BINDING;
    }
    else if (sTalk == "horrid wilting")
    {
        sSpellTag = "NW_IT_SPARSCR809";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_HORRID_WILTING;
    }
    else if (sTalk == "incendiary cloud")
    {
        sSpellTag = "NW_IT_SPARSCR804";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_INCENDIARY_CLOUD;
    }
    else if (sTalk == "mass blindness and deafness")
    {
        sSpellTag = "NW_IT_SPARSCR807";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_MASS_BLINDNESS_AND_DEAFNESS;
    }
    else if (sTalk == "mass charm")
    {
        sSpellTag = "NW_IT_SPARSCR806";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_MASS_CHARM;
    }
    else if (sTalk == "mind blank")
    {
        sSpellTag = "NW_IT_SPARSCR801";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_MIND_BLANK;
    }
    else if (sTalk == "premonition")
    {
        sSpellTag = "NW_IT_SPARSCR808";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_PREMONITION;
    }
    else if (sTalk == "summon creature viii")
    {
        sSpellTag = "NW_IT_SPARSCR805";
        iSpellLevel = 8;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_VIII;
    }

   /*--------------------------    Level 9 Spells    ------------------------*/
    else if (sTalk == "dominate monster")
    {
        sSpellTag = "NW_IT_SPARSCR905";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_DOMINATE_MONSTER;
    }
    else if (sTalk == "energy drain")
    {
        sSpellTag = "NW_IT_SPARSCR908";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_ENERGY_DRAIN;
    }
    else if (sTalk == "gate")
    {
        sSpellTag = "NW_IT_SPARSCR902";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_GATE;
    }
    else if (sTalk == "greater spell mantle")
    {
        sSpellTag = "NW_IT_SPARSCR912";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_GREATER_SPELL_MANTLE;
    }
    else if (sTalk == "meteor swarm")
    {
        sSpellTag = "NW_IT_SPARSCR906";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_METEOR_SWARM;
    }
    else if (sTalk == "mordenkainen's disjunction")
    {
        sSpellTag = "NW_IT_SPARSCR901";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_MORDENKAINENS_DISJUNCTION;
    }
    else if (sTalk == "power word kill")
    {
        sSpellTag = "NW_IT_SPARSCR903";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_POWER_WORD_KILL;
    }
    else if (sTalk == "shapechange")
    {
        sSpellTag = "NW_IT_SPARSCR910";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_SHAPECHANGE;
    }
    else if (sTalk == "summon creature ix")
    {
        sSpellTag = "NW_IT_SPARSCR904";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_SUMMON_CREATURE_IX;
    }
    else if (sTalk == "time stop")
    {
        sSpellTag = "NW_IT_SPARSCR911";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_TIME_STOP;
    }
    else if (sTalk == "wail of the banshee")
    {
        sSpellTag = "NW_IT_SPARSCR909";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_WAIL_OF_THE_BANSHEE;
    }
    else if (sTalk == "weird")
    {
        sSpellTag = "NW_IT_SPARSCR907";
        iSpellLevel = 9;
        iAdditionalCost = 0;
        iSpellID = SPELL_WEIRD;
    }
    //Default if no spell matched
    else
        sSpellTag = "NOTSUPPORTED";

    if (sSpellTag == "NOTSUPPORTED")
    {
        SendMessageToPC(oCreator, "The spell you entered was not found.");
        iSpellCreated = 2;
        SetLocalString(OBJECT_SELF, "Stack", "");
        SetLocalInt(OBJECT_SELF, "iSpellCreated", iSpellCreated);
        return;
    }


    if (sSpellTag != "")
    {   //Perform Check to see if PC can create scroll
        //TestPC
        if (iSpellID == SPELL_PROTECTION_FROM_EVIL) //Check for any of the Protection from Alignment
        {    if  (CheckCasterLevel(oCreator, iSpellLevel) &&
                (GetHasSpell(SPELL_PROTECTION_FROM_EVIL, oCreator) ||
                   GetHasSpell(SPELL_PROTECTION_FROM_GOOD, oCreator) ||
                   GetHasSpell(SPELL_PROTECTION_FROM_LAW, oCreator) ||
                   GetHasSpell(SPELL_PROTECTION__FROM_CHAOS, oCreator) ))
            {
                iSpellCreated = CreateScroll(oCreator, sSpellTag, iSpellLevel, iAdditionalCost);
            }
        }
        else if (iSpellID == SPELL_MAGIC_CIRCLE_AGAINST_EVIL) //Check for any of the Magic Circle Spells
        {    if  (CheckCasterLevel(oCreator, iSpellLevel) &&
                (GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oCreator) ||
                   GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_CHAOS, oCreator) ||
                   GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_GOOD, oCreator) ||
                   GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_LAW, oCreator) ))
            {
                iSpellCreated = CreateScroll(oCreator, sSpellTag, iSpellLevel, iAdditionalCost);
            }
        }
        else if (iSpellID == SPELL_SHADOW_CONJURATION_DARKNESS) //Check for any of the Shadow Conjuration Spells
        {    if  (CheckCasterLevel(oCreator, iSpellLevel) &&
                (GetHasSpell(SPELL_SHADOW_CONJURATION_INIVSIBILITY, oCreator) ||
                   GetHasSpell(SPELL_SHADOW_CONJURATION_MAGE_ARMOR, oCreator) ||
                   GetHasSpell(SPELL_SHADOW_CONJURATION_MAGIC_MISSILE, oCreator) ||
                   GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS, oCreator) ||
                   GetHasSpell(SPELL_SHADOW_CONJURATION_SUMMON_SHADOW, oCreator) ))
            {
                iSpellCreated = CreateScroll(oCreator, sSpellTag, iSpellLevel, iAdditionalCost);
            }
        }
        else if (iSpellID == SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW) //Check for any of the Greater Shadow Conjuration Spells
        {    if  (CheckCasterLevel(oCreator, iSpellLevel) &&
                (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW, oCreator) ||
                   GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE, oCreator) ||
                   GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_MIRROR_IMAGE, oCreator) ||
                   GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW, oCreator) ||
                   GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB, oCreator) ))
            {
                iSpellCreated = CreateScroll(oCreator, sSpellTag, iSpellLevel, iAdditionalCost);
            }
        }
        else if (CheckCasterLevel(oCreator, iSpellLevel) && GetHasSpell(iSpellID, oCreator))
        {
            //Create Scroll
            iSpellCreated = CreateScroll(oCreator, sSpellTag, iSpellLevel, iAdditionalCost);
        }
        else
            iSpellCreated = 4;
    }
    SetLocalString(OBJECT_SELF, "Stack", "");
    SetLocalInt(OBJECT_SELF, "iSpellCreated", iSpellCreated);
  }


}

