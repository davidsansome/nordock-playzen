/***************************************************
  Config #Include Script
  ats_config

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains configureable constants that
  are used to customize the system.

  Changing these still requires a rebuild of the
  module. In an upcoming version, this will change
  and you will no longer need to rebuild after
  changing these.
****************************************************/

// ***OPTIONS****

// This option activates using tokens on the player to keep
// track of skills instead of using local variables
int CBOOL_PERSISTENT_SKILLS_ACTIVE   = FALSE;

// ***Skill Related****

// Skill Journal Numeric Display
// When set to TRUE, skill values are shown as numbers in the
// skill journal. If set to FASLE, skill values are suppressed
// and only ranks shown.
int CBOOL_SJ_NUMERIC_DISPLAY = TRUE;

// Skill Gain Message Setting
// 0 - Turn off skill gain message
// 1 - Skill gain message without any numeric value display
// 2 - Skill gain message with numeric value displayed
int CINT_SKILL_MESSAGE_SETTING = 2;

// Skill Gain Rate Adjustment (From -1.0f to 1.0f, 0.0f means no adjustment,
// 1.0f means +100% adjustment and -1.0f means -100% adjustment)
float CFLOAT_SKILLGAIN_ADJUST_OVERALL               = 0.0f;

float CFLOAT_SKILLGAIN_ADJUST_BLACKSMITHING         = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_MINING                = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_ARMORCRAFTING         = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_WEAPONCRAFTING        = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_TANNING               = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_GEMCUTTING            = -0.05f;
float CFLOAT_SKILLGAIN_ADJUST_JEWELCRAFTING         = -0.05f;
float CFLOAT_SKILLGAIN_ADJUST_BOWYERING             = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_FLETCHING             = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_TAILOR                = 0.0f;
float CFLOAT_SKILLGAIN_ADJUST_TINKER                = 0.0f;

// Skill Gain Chance on Failure(0-100%)
int CINT_SKILLGAIN_FAILURE                    = 10;

// Flat Failure Rates(From 0% to 100%)
int CINT_FLATFAILURE_OVERALL                  = 0;

int CINT_FLATFAILURE_BLACKSMITHING            = 0;
int CINT_FLATFAILURE_MINING                   = 0;
int CINT_FLATFAILURE_ARMORCRAFTING            = 0;
int CINT_FLATFAILURE_WEAPONCRAFTING           = 0;
int CINT_FLATFAILURE_TANNING                  = 0;
int CINT_FLATFAILURE_GEMCUTTING               = 5;
int CINT_FLATFAILURE_JEWELCRAFTING            = 5;
int CINT_FLATFAILURE_BOWYERING                = 0;
int CINT_FLATFAILURE_FLETCHING                = 0;
int CINT_FLATFAILURE_TAILOR                   = 0;
int CINT_FLATFAILURE_TINKER                   = 0;



// ***Spawn Related****

// Auto spawning Ore Veins - If TRUE, any ore veins spawned will
// automatically respawn within the specified timeframe
int CBOOL_AUTOSPAWN_ORE  = TRUE;
// Minimum time in real-time minutes to respawn ore
int CINT_AUTOSPAWN_ORE_MINTIME = 10;
// Maximum time in real-time minutes to respawn ore
int CINT_AUTOSPAWN_ORE_MAXTIME = 20;

// Mining Spawn Point Defaults
int CINT_MSP_DEFAULT_MST    =  600;
int CINT_MSP_DEFAULT_XST    =  1200;
int CINT_MSP_DEFAULT_DUR    =  100;
int CINT_MSP_DEFAULT_FRS    =  0;
int CINT_MSP_DEFAULT_DST    =  5;

// ***NPC Merchant Related****

// This is the maximum per item that the NPC Crafting merchants
// keeps in their inventory
int CINT_MERCHANT_MAX_PER_ITEM = 3;

// This is the maximum number of items that the NPC Crafting merchants
// keeps in their inventory
int CINT_MERCHANT_MAXITEMS = 25;

// ***Skinnable Animal Related****

// Skinnable Animal(Herbivore) Corpse Fade Time(in seconds)
// Set this to 0 (ZERO) if you DO NOT want the corpses to fade
int CINT_SAH_CORPSE_FADE        = 120;

// Skinnable Animal(Omnivore) Corpse Fade Time(in seconds)
// Set this to 0 (ZERO) if you DO NOT want the corpses to fade
int CINT_SAO_CORPSE_FADE        = 120;

// Skinnable Animal(Carnivore) Corpse Fade Time(in seconds)
// Set this to 0 (ZERO) if you DO NOT want the corpses to fade
int CINT_SAC_CORPSE_FADE        = 120;


// ***Logging Features****

// Log all skill gains
int CBOOL_LOG_SKILLGAIN     = TRUE;

