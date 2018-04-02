// Recipe Constants

/******* Crafting Constants ***********/

// Crafting type - This is the first character found in all crafted
// item base tags.  It indicates what primary craft skill is responsible
// for making the item.
string ATS_CRAFT_TYPE_ARMOR         = "A";
string ATS_CRAFT_TYPE_WEAPON        = "W";
string ATS_CRAFT_TYPE_LEATHER       = "L"; //Tanning skill
string ATS_CRAFT_TYPE_BLACKSMITH    = "B";
string ATS_CRAFT_TYPE_JEWELCRAFT    = "J";
string ATS_CRAFT_TYPE_GEMCUTTING    = "G";
string ATS_CRAFT_TYPE_BOWYERING     = "C";
string ATS_CRAFT_TYPE_FLETCHING     = "F";
string ATS_CRAFT_TYPE_TAILOR        = "T";
string ATS_CRAFT_TYPE_TINKER        = "Z";
// Armorcrafting Category Types - This is the second character found
// in all armorcrafted item base tags.  It tells what group
// the item belongs in.
int ATS_CRAFT_PART_BODY       = 0;
int ATS_CRAFT_PART_HELMET     = 1;
int ATS_CRAFT_PART_SHIELD     = 2;
int ATS_CRAFT_PART_MISC       = 9;

// Weaponcrafting Category Types-  This is the second character found
// in all weaponcrafted item base tags.  It tells what group
// the item belongs in.
int ATS_CRAFT_PART_AXES       = 0;
int ATS_CRAFT_PART_BLADES     = 1;
int ATS_CRAFT_PART_BLUNTS     = 2;
int ATS_CRAFT_PART_POLEARMS   = 3;
int ATS_CRAFT_PART_EXOTIC     = 4;
int ATS_CRAFT_PART_AMMO       = 7;
int ATS_CRAFT_PART_TOOLS      = 9;

// Jewelcrafting/Gemcutting Category Types- This is the second character found
// in all jewelcrafted/Gemcut item base tags.  It tells what group
// the item belongs in.
int ATS_CRAFT_PART_GEM              = 0;

int ATS_CRAFT_PART_SMOOTHRING       = 0;
int ATS_CRAFT_PART_SMOOTHAMULET     = 1;

// Bowyering/Fletching Category Types- This is the second character found
// in all bowyering/fletching item base tags.  It tells what group
// the item belongs in

int ATS_CRAFT_PART_SHORTBOW              = 0;
int ATS_CRAFT_PART_LONGBOW               = 1;
int ATS_CRAFT_PART_CROSSBOW              = 2;
int ATS_CRAFT_PART_BATTLEBOW             = 3;
int ATS_CRAFT_PART_SPECIALBOW            = 4;


int ATS_CRAFT_PART_ARROW                 = 0;

// Tinkering bits

int ATS_CRAFT_PART_WIDGET                = 0;
int ATS_CRAFT_PART_WIRES                 = 1;
int ATS_CRAFT_PART_CHEMPAKS              = 2;
int ATS_CRAFT_PART_TRINKETS              = 3;
int ATS_CRAFT_PART_TRAPS                 = 4;

///Tailoring Recipes
int ATS_CRAFT_PART_BELTS = 0;
int ATS_CRAFT_PART_CLOAKS = 1;
int ATS_CRAFT_PART_GLOVES = 2;
int ATS_CRAFT_PART_CLOTHES = 3;
int ATS_CRAFT_PART_ARMOR = 4;
int ATS_CRAFT_PART_BAGS = 5;
int ATS_CRAFT_PART_BOOTS = 7;


 /* Recipe Categories  */

//Armorcrafting
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_0      =   "Body Armor";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_1      =   "Helmets";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_2      =   "Shields";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_3      =   "Bracers";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_4      =   "Guantlets";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_5      =   "Boots";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_6      =   "";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_7      =   "";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_8      =   "";
string CSTR_CRAFT_ARMORCRAFTING_CATEGORY_9      =   "Misc";

//Weaponcrafting
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_0     =   "Axes";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_1     =   "Blades";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_2     =   "Blunts";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_3     =   "Polearms";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_4     =   "Exotic";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_5     =   "Throwing";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_6     =   "Double-Sided";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_7     =   "Ammunition";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_8     =   "";
string CSTR_CRAFT_WEAPONCRAFTING_CATEGORY_9     =   "Tools";

//Tanning
string CSTR_CRAFT_TANNING_CATEGORY_0          =   "Cure Pelts";
string CSTR_CRAFT_TANNING_CATEGORY_1          =   "Tan Leather";
string CSTR_CRAFT_TANNING_CATEGORY_2          =   "Harden Leather";
string CSTR_CRAFT_TANNING_CATEGORY_3          =   "";
string CSTR_CRAFT_TANNING_CATEGORY_4          =   "";
string CSTR_CRAFT_TANNING_CATEGORY_5          =   "";
string CSTR_CRAFT_TANNING_CATEGORY_6          =   "";
string CSTR_CRAFT_TANNING_CATEGORY_7          =   "";
string CSTR_CRAFT_TANNING_CATEGORY_8          =   "";
string CSTR_CRAFT_TANNING_CATEGORY_9          =   "";

//Tailoring
//string CSTR_CRAFT_TAILORING_CATEGORY_0          =   "Leather Armor";
//string CSTR_CRAFT_TAILORING_CATEGORY_1          =   "Clothing";
//string CSTR_CRAFT_TAILORING_CATEGORY_2          =   "Bags";
//string CSTR_CRAFT_TAILORING_CATEGORY_3          =   "Cloaks";
//string CSTR_CRAFT_TAILORING_CATEGORY_4          =   "";
//string CSTR_CRAFT_TAILORING_CATEGORY_5          =   "";
//string CSTR_CRAFT_TAILORING_CATEGORY_6          =   "";
//string CSTR_CRAFT_TAILORING_CATEGORY_7          =   "";
//string CSTR_CRAFT_TAILORING_CATEGORY_8          =   "";
//string CSTR_CRAFT_TAILORING_CATEGORY_9          =   "";

//Tailoring - 1.3
string CSTR_CRAFT_TAILOR_CATEGORY_0 = "Belts";
string CSTR_CRAFT_TAILOR_CATEGORY_1 = "Cloaks";
string CSTR_CRAFT_TAILOR_CATEGORY_2 = "Gloves";
string CSTR_CRAFT_TAILOR_CATEGORY_3 = "Clothes";
string CSTR_CRAFT_TAILOR_CATEGORY_4 = "Armors";
string CSTR_CRAFT_TAILOR_CATEGORY_5 = "Bags";
string CSTR_CRAFT_TAILOR_CATEGORY_6 = "";
string CSTR_CRAFT_TAILOR_CATEGORY_7 = "Boots";
string CSTR_CRAFT_TAILOR_CATEGORY_8 = "";
string CSTR_CRAFT_TAILOR_CATEGORY_9 = "Miscellaneous";

//Gemcutting
string CSTR_CRAFT_GEMCUTTING_CATEGORY_0          =   "Cut Gems";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_1          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_2          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_3          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_4          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_5          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_6          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_7          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_8          =   "";
string CSTR_CRAFT_GEMCUTTING_CATEGORY_9          =   "";

//JEWELCRAFTING
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_0          =   "Smooth Rings";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_1          =   "Smooth Amulets";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_2          =   "";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_3          =   "";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_4          =   "";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_5          =   "";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_6          =   "";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_7          =   "";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_8          =   "";
string CSTR_CRAFT_JEWELCRAFTING_CATEGORY_9          =   "";

//BOWYERING
string CSTR_CRAFT_BOWYERING_CATEGORY_0              =   "Short Bows";
string CSTR_CRAFT_BOWYERING_CATEGORY_1              =   "Long Bows";
string CSTR_CRAFT_BOWYERING_CATEGORY_2              =   "Cross Bows";
string CSTR_CRAFT_BOWYERING_CATEGORY_3              =   "Battle Bows";
string CSTR_CRAFT_BOWYERING_CATEGORY_4              =   "Specials";
string CSTR_CRAFT_BOWYERING_CATEGORY_5              =   "";
string CSTR_CRAFT_BOWYERING_CATEGORY_6              =   "";
string CSTR_CRAFT_BOWYERING_CATEGORY_7              =   "";
string CSTR_CRAFT_BOWYERING_CATEGORY_8              =   "";
string CSTR_CRAFT_BOWYERING_CATEGORY_9              =   "";

//FLETCHING
string CSTR_CRAFT_FLETCHING_CATEGORY_0              =   "Arrows";
string CSTR_CRAFT_FLETCHING_CATEGORY_1              =   "Bolts";
string CSTR_CRAFT_FLETCHING_CATEGORY_2              =   "Darts";
string CSTR_CRAFT_FLETCHING_CATEGORY_3              =   "";
string CSTR_CRAFT_FLETCHING_CATEGORY_4              =   "";
string CSTR_CRAFT_FLETCHING_CATEGORY_5              =   "";
string CSTR_CRAFT_FLETCHING_CATEGORY_6              =   "";
string CSTR_CRAFT_FLETCHING_CATEGORY_7              =   "";
string CSTR_CRAFT_FLETCHING_CATEGORY_8              =   "";
string CSTR_CRAFT_FLETCHING_CATEGORY_9              =   "";

//TINKERING

string CSTR_CRAFT_TINKER_CATEGORY_0                = "Widgets";
string CSTR_CRAFT_TINKER_CATEGORY_1                = "Wires and Gears";
string CSTR_CRAFT_TINKER_CATEGORY_2                = "Alchemy Mixes";
string CSTR_CRAFT_TINKER_CATEGORY_3                = "Trinkets and Devices";
string CSTR_CRAFT_TINKER_CATEGORY_4                = "Traps";
string CSTR_CRAFT_TINKER_CATEGORY_5                = "";
string CSTR_CRAFT_TINKER_CATEGORY_6                = "";
string CSTR_CRAFT_TINKER_CATEGORY_7                = "";
string CSTR_CRAFT_TINKER_CATEGORY_8                = "";
string CSTR_CRAFT_TINKER_CATEGORY_9                = "";
