/****************************************************
  Common Constants Script
  ats_const_common

  Last Updated: September 12, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains common internal constants used
  within other scripts.  It is not adviseable to
  modify these constants unless you know what you are
  doing.  All configureable constants are under
  the ats_config script. Changing things in here may
  break parts of the system if not done correctly.
  Also, any changes here WILL require a rebuild of
  the module.

**************************************************/


// Version Number
float CFLOAT_VERSION_NUMBER = 0.58;

// Skill Success Return Values
int CINT_FAILURE    = 0;
int CINT_SUCCESS    = 1;
int CINT_UNSKILLED  = 2;

// Tradeskill Journal Tag
string CSTR_TRADESKILL_JOURNAL = "ATS_JOURNAL_NOD";

// Persistent Skill Bag's Tag
string CSTR_PERSISTENT_SKILLS_BOXTAG = "ATS_SKILLBOX_NOD";

// Persistent Skill Token Base Tag
string CSTR_TOKEN_TAG                 = "ATS_TOKEN";
string CSTR_TOKEN_TAG_BLACKSMITHING   = "ATS_TOKEN_BS_";
string CSTR_TOKEN_TAG_ARMORCRAFTING   = "ATS_TOKEN_AC_";
string CSTR_TOKEN_TAG_WEAPONCRAFTING  = "ATS_TOKEN_WC_";
string CSTR_TOKEN_TAG_MINING          = "ATS_TOKEN_MI_";
string CSTR_TOKEN_TAG_TANNING         = "ATS_TOKEN_TN_";
string CSTR_TOKEN_TAG_JEWELCRAFTING   = "ATS_TOKEN_JC_";
string CSTR_TOKEN_TAG_GEMCUTTING      = "ATS_TOKEN_GC_";
string CSTR_TOKEN_TAG_BOWYERING       = "ATS_TOKEN_BW_";
string CSTR_TOKEN_TAG_FLETCHING       = "ATS_TOKEN_FC_";
string CSTR_TOKEN_TAG_TAILOR          = "ATS_TOKEN_MT_"; //Tailoring Persistent Token
string CSTR_TOKEN_TAG_TINKER          = "ATS_TOKEN_TK_"; //Tinkering

// Mining Failure Return Value
int CINT_MINE_FAILURE = -1;

// Number of materials
int CINT_MATERIAL_COUNT      = 52;

// Quality Values
int CINT_QUALITY_NORMAL         = 1;
int CINT_QUALITY_EXCEPTIONAL    = 2;
int CINT_QUALITY_BROKEN         = 3;

// Quality String Constants
string CSTR_QUALITY_NORMAL         = "N";
string CSTR_QUALITY_EXCEPTIONAL    = "E";
string CSTR_QUALITY_BROKEN         = "R";

// Special Miner's Bag Tag
string CSTR_MINERBAG = "T502";

// The following are the base tags for the tradeskill tools.
// Only change these if you decide you want to change the tool
// associated with a tradeskill.
string CSTR_MINETOOL1 = "W901";  // Mining tool
string CSTR_MINETOOL2 = "W921";  // Mining tool
string CSTR_MINETOOL3 = "W922";  // Mining tool
string CSTR_SMITHTOOL = "W911"; // Smithing(armorcrafting/weaponcrafting) tool
string CSTR_SKINNINGTOOL = "W902"; //Skinning Tool
string CSTR_TANNING_SEWKIT = "K101"; // Tanner's sewing kit
string CSTR_GEMCUTTINGTOOL = "K102";   // Gemcutting Chisel
string CSTR_JEWELCRAFTINGTOOL = "K103";   // Gemsetter
string CSTR_BOWYERINGTOOL = "W903";   // Bowyers Paring Knife
string CSTR_FLETCHINGTOOL = "W904";   // Fletchers Knife
string CSTR_TAILORTOOL = "W905";   // Fletchers Knife
string CSTR_TINKERTOOL = "W906";    // Tinkering Tool

// String displayed when mining has failed
string CSTR_MINE_FAILURE = "You break free some rocks but could not find anything.";

// String displayed when a player does not have a mining tool and tries to mine
string CSTR_ERROR1_MINING = "You do not have the proper equipment to mine that.";

// String displayed when a player does not have a skinning tool and tries to skin
// an animal
string CSTR_ERROR1_SKINNING = "You do not have the proper tool equipped to skin that.";

// String displayed when a placeable is already in use.
string CSTR_ERROR1_INUSE = "This is already in use by someone else.";

// Ingot Base Tag
string CSTR_INGOT_BASETAG       = "B001";
string CSTR_CUTGEM_BASETAG      = "G001";

// Ore Base Tag
string CSTR_ORE_BASETAG         = "ORE1";
// Rough Gem Base Tag
string CSTR_GEM_BASETAG         = "GEM0";

// Tailoring Base Tag
string CSTR_DYE_BASETAG         = "T901";
string CSTR_FLOWER_BASETAG      = "T903";
string CSTR_CLOTHSS_BASETAG     = "T997";
string CSTR_CLOTHSM_BASETAG     = "T998";
string CSTR_CLOTHSL_BASETAG     = "T999";

// Component Type IDs
int CINT_COMPONENT_ID_CUSTOM     = 0;
int CINT_COMPONENT_ID_INGOTS     = 1;
int CINT_COMPONENT_ID_GEMS       = 2;
int CINT_COMPONENT_ID_IDEALGEMS  = 3;
int CINT_COMPONENT_ID_CLOTHSS    = 4;
int CINT_COMPONENT_ID_CLOTHSM    = 5;
int CINT_COMPONENT_ID_CLOTHSL    = 6;
int CINT_COMPONENT_ID_FLOWERS    = 7;
int CINT_COMPONENT_ID_DYES       = 8;

