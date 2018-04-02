// Skill constants

// Maximum skill levels
int CINT_MAXSKILL_MINING            =   200;
int CINT_MAXSKILL_BLACKSMITHING     =   200;
int CINT_MAXSKILL_ARMORCRAFTING     =   400;
int CINT_MAXSKILL_WEAPONCRAFTING    =   400;
int CINT_MAXSKILL_TANNING           =   200;
int CINT_MAXSKILL_GEMCUTTING        =   200;
int CINT_MAXSKILL_JEWELCRAFTING     =   400;
int CINT_MAXSKILL_BOWYERING         =   400;  //
int CINT_MAXSKILL_FLETCHING         =   400;  //
int CINT_MAXSKILL_TAILOR            =   400;  //
int CINT_MAXSKILL_TINKER            =   400;


int CINT_SKILL_COUNT    = 11;  //
// Trade skill constants
int CINT_SKILL_MINING           = 1;
int CINT_SKILL_BLACKSMITHING    = 2;
int CINT_SKILL_ARMORCRAFTING    = 3;
int CINT_SKILL_WEAPONCRAFTING   = 4;
int CINT_SKILL_TANNING          = 5;
int CINT_SKILL_GEMCUTTING       = 6;
int CINT_SKILL_JEWELCRAFTING    = 7;
int CINT_SKILL_BOWYERING        = 8;  //
int CINT_SKILL_FLETCHING        = 9;  //
int CINT_SKILL_TAILOR           = 10;  //
int CINT_SKILL_TINKER           = 11;

//Primary Skills
int CINT_SKILL_PRIMARY_1        = CINT_SKILL_ARMORCRAFTING;
int CINT_SKILL_PRIMARY_2        = CINT_SKILL_WEAPONCRAFTING;
int CINT_SKILL_PRIMARY_3        = CINT_SKILL_JEWELCRAFTING;
int CINT_SKILL_PRIMARY_4        = CINT_SKILL_BOWYERING;     //
int CINT_SKILL_PRIMARY_5        = CINT_SKILL_FLETCHING;     //
int CINT_SKILL_PRIMARY_6        = CINT_SKILL_TAILOR;
int CINT_SKILL_PRIMARY_7        = CINT_SKILL_TINKER;
int CINT_SKILL_PRIMARY_8        = 0;
int CINT_SKILL_PRIMARY_9        = 0;
int CINT_SKILL_PRIMARY_10       = 0;

// Secondary Skills
int CINT_SKILL_SECONDARY_1      = CINT_SKILL_BLACKSMITHING;
int CINT_SKILL_SECONDARY_2      = CINT_SKILL_MINING;
int CINT_SKILL_SECONDARY_3      = CINT_SKILL_TANNING;
int CINT_SKILL_SECONDARY_4      = CINT_SKILL_GEMCUTTING;
int CINT_SKILL_SECONDARY_5      = 0;
int CINT_SKILL_SECONDARY_6      = 0;
int CINT_SKILL_SECONDARY_7      = 0;
int CINT_SKILL_SECONDARY_8      = 0;
int CINT_SKILL_SECONDARY_9      = 0;
int CINT_SKILL_SECONDARY_10     = 0;

// Skill Ranks

string CSTR_SKILLRANK_0     = "Untrained";
string CSTR_SKILLRANK_1     = "Novice";
string CSTR_SKILLRANK_2     = "Junior Apprentice";
string CSTR_SKILLRANK_3     = "Senior Apprentice";
string CSTR_SKILLRANK_4     = "Journeyman";
string CSTR_SKILLRANK_5     = "Senior Journeyman";
string CSTR_SKILLRANK_6     = "Adept";
string CSTR_SKILLRANK_7     = "Master";
string CSTR_SKILLRANK_8     = "Accomplished Master";
string CSTR_SKILLRANK_9     = "Craft Master";
string CSTR_SKILLRANK_10    = "Grand Master";

// Minimum Skill level needed for ranks
int CINT_SKILL_LEVEL_RANK_0     = 0;
int CINT_SKILL_LEVEL_RANK_1     = 1;
int CINT_SKILL_LEVEL_RANK_2     = 20;
int CINT_SKILL_LEVEL_RANK_3     = 50;
int CINT_SKILL_LEVEL_RANK_4     = 100;
int CINT_SKILL_LEVEL_RANK_5     = 150;
int CINT_SKILL_LEVEL_RANK_6     = 175;
int CINT_SKILL_LEVEL_RANK_7     = 200;
int CINT_SKILL_LEVEL_RANK_8     = 250;
int CINT_SKILL_LEVEL_RANK_9     = 325;
int CINT_SKILL_LEVEL_RANK_10    = 399;

// This is the skill rank that is considered master level
int CINT_SKILLRANK_MASTERLEVEL = 7;

//Trade skill display names
string CSTR_SKILLNAME_MINING           = "Mining";
string CSTR_SKILLNAME_BLACKSMITHING    = "Blacksmithing";
string CSTR_SKILLNAME_ARMORCRAFTING    = "Armorcrafting";
string CSTR_SKILLNAME_WEAPONCRAFTING   = "Weaponcrafting";
string CSTR_SKILLNAME_TANNING          = "Tanning";
string CSTR_SKILLNAME_GEMCUTTING       = "Gemcutting";
string CSTR_SKILLNAME_JEWELCRAFTING    = "Jewelcrafting";
string CSTR_SKILLNAME_BOWYERING        = "Bowyering";
string CSTR_SKILLNAME_FLETCHING        = "Fletching";
string CSTR_SKILLNAME_TAILOR           = "Tailoring";
string CSTR_SKILLNAME_TINKER           = "Tinkering";

// Tanning subskill constants
int ATS_TANNING_SUBSKILL_CURING     = 0;
int ATS_TANNING_SUBSKILL_TANNING    = 1;
int ATS_TANNING_SUBSKILL_HARDENING  = 2;
int ATS_TANNING_SUBSKILL_SEWING     = 3;


//Mining Skill Trivial Levels
int CINT_MINELEVEL_COPPER     = 45;
int CINT_MINELEVEL_BRONZE     = 70;
int CINT_MINELEVEL_IRON       = 100;
int CINT_MINELEVEL_SILVER     = 135;
int CINT_MINELEVEL_GOLD       = 170;
int CINT_MINELEVEL_SHADOW     = 210;
int CINT_MINELEVEL_VERDICITE  = 225;
int CINT_MINELEVEL_RUBICITE   = 225;
int CINT_MINELEVEL_SYENITE    = 225;
int CINT_MINELEVEL_MITHRAL    = 235;
int CINT_MINELEVEL_ADAMANTINE = 240;
int CINT_MINELEVEL_MYRKANDITE = 245;

int CINT_MINELEVEL_MALACHITE    = 80;
int CINT_MINELEVEL_AMETHYST     = 110;
int CINT_MINELEVEL_LAPIS_LAZULI = 128;
int CINT_MINELEVEL_TURQUOISE    = 150;
int CINT_MINELEVEL_OPAL         = 167;
int CINT_MINELEVEL_ONYX         = 167;
int CINT_MINELEVEL_JADE         = 175;
int CINT_MINELEVEL_PEARL        = 190;
int CINT_MINELEVEL_SAPPHIRE     = 215;
int CINT_MINELEVEL_BLACK_SAPPHIRE = 215;
int CINT_MINELEVEL_FIRE_OPAL    = 225;
int CINT_MINELEVEL_RUBY         = 235;
int CINT_MINELEVEL_EMERALD      = 239;
int CINT_MINELEVEL_DIAMOND      = 244;

// Blacksmithing(smleting) Trivial Levels
int CINT_SMELTLEVEL_COPPER      = 40;
int CINT_SMELTLEVEL_BRONZE      = 65;
int CINT_SMELTLEVEL_IRON        = 100;
int CINT_SMELTLEVEL_SILVER      = 130;
int CINT_SMELTLEVEL_GOLD        = 165;
int CINT_SMELTLEVEL_SHADOW      = 205;
int CINT_SMELTLEVEL_VERDICITE   = 225;
int CINT_SMELTLEVEL_RUBICITE    = 225;
int CINT_SMELTLEVEL_SYENITE     = 225;
int CINT_SMELTLEVEL_MITHRAL     = 235;
int CINT_SMELTLEVEL_ADAMANTINE  = 240;
int CINT_SMELTLEVEL_MYRKANDITE  = 245;



