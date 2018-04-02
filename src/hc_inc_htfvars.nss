//hc_inc_htfvars

//Adjust all of the below variables to suite the needs of your Module

//Timer delay in performing the HTF checks in seconds.
//Now relies on in game clock.  Current checks once per 60 min, IN GAME TIME.
//So if your set to 2 min per hour, will check once ever 2 Real Life min if
//set to 60 Game Minutes
int HTFCHKTIMER = 60;
//A user defined event number. Event numbers must be unique!
//Change this number to a value that will be unique, if the default one is not.
int HTFCHKEVENTNUM = 9200;

//The initial levels of virtual hunger/thirst/fatigue Hitpoints
//that all PCs start with.
int INITHUNGERLEVEL = 1800;
int INITTHIRSTLEVEL = 720;
int INITFATIGUELEVEL = 960;

//Amount the PC's current HTF levels can go above the initial levels
//This gives them a bit of a buffer zone before venturing into a place where
//food and water get scarce.
float buffer = 0.2;

//The rate of "damage" to the above levels a PC takes every time
//HTFCHKTIMER number of seconds goes by.
//Noe that these values can be modified with a multiplier based on the
//area the PC is in at the time the check is performed.
//See the function SetAreaConsumeRates, and set it in the file
//hc_setareavars.
int DEFHUNGERCONSUMERATE = 10;
int DEFTHIRSTCONSUMERATE = 10;
int DEFFATIGUECONSUMERATE = 10;

/*
Creating foods and drinks.

To make a new food or drink item compatable with the HTF system, you will
have to give it a special tag that will be used to indicate what properties
the item has.

A Food item must have the word "Food" in the tag, and drinks must have
"Drink" in the tag.  You can create an item that provides for both if both
names are in the tag.

"RICH", "NORM", and "POOR" indicate what quality of hunger satisfaction
a Food item gives to the PC (see values below). Those values are added
to the PC's current hunger level when the food is eaten. Likewise,
"HIGH", "MED", and "LOW" indicate the same for thirst levels for Drink items.
If quality is not specified in either case, the default is NORM and MED.

"Alcohol1" thru "Alcohol5" will produce alcoholic effects on a drink item.
The number indicates the level of intelligene loss. See the function
ApplyAlcoholEffectToPC.

"POISON1" thru "POISON5" on a Food or Drink Item will poison the PC.
"DISEASE1 thru "DISEASE5" on a Food or Drink Item will give the PC a disease.
POISON and DISEASE are mutually exclusive and DISEASE will override POISON.
You cannot stack effects either, only the highest one in number will be used.
Making an item poisoned or diseased will also nullify any positive effects
the item might have had so, dont even bother including them in the tag.
If you want to change the disease or poison types see the functions,
ApplyPoisonToPC and ApplyDiseaseToPC.

"ENERGY1", "ENERGY2", "ENERGY3" will add to the PC's current fatigue level HPs by the
amount specified. (for coffee-like food/drink items)

"HPBONUS1" thru "HPBONUS5" will add hit points to the PC of the amounts indicated
in the below variables. (use this wisely!)

You may use the same tag naming structure and apply it to placeable objects.
If you attach hchtf_fooddrinkp to the placeable's OnUsed event, the PC will
use the object as if he or she consumed an item of the same tag type.
(of course without actually consuming the placeable) You could use this method
to make things such as water fountains, etc.

Another possibility is to create a trigger around a body of water and give that
trigger a tag which also using the above naming conventions. Then be sure to add
hchtf_enterwater to the trigger's OnEnter, and hchtf_exitwater on it OnExit events.
This will enable the PC to target their empty water canteen on the ground, and if they
are standing inside the trigger, it will fill the canteen with the item type
described by the trigger's tag.
*/
int RICH = 450;
int NORM = 300;
int POOR = 150;
int HIGH = 180;
int MED = 120;
int LOW = 60;
int ENERGY3 = 144;
int ENERGY2 = 96;
int ENERGY1 = 48;
int HPBONUS5 = 5;
int HPBONUS4 = 4;
int HPBONUS3 = 3;
int HPBONUS2 = 2;
int HPBONUS1 = 1;
int POISONTYPE5 = POISON_HUGE_SPIDER_VENOM;
int POISONTYPE4 = POISON_LARGE_SPIDER_VENOM;
int POISONTYPE3 = POISON_MEDIUM_SPIDER_VENOM;
int POISONTYPE2 = POISON_SMALL_SPIDER_VENOM;
int POISONTYPE1 = POISON_TINY_SPIDER_VENOM;
int DISEASETYPE5 = DISEASE_BLINDING_SICKNESS;
int DISEASETYPE4 = DISEASE_BURROW_MAGGOTS;
int DISEASETYPE3 = DISEASE_FILTH_FEVER;
int DISEASETYPE2 = DISEASE_RED_ACHE;
int DISEASETYPE1 = DISEASE_SHAKES;

//Set this to 1 to allow automatic eating and drinking.
//Set it to 0 to force PCs to manually eat and drink all the time.
int AUTOEATDRINK = 1;

//This only applies if AUTOEATDRINK = 1.
//Sets when automatic eating and drink is performed in relation to the current
//hunger and thirst levels of the PC.
//A value of 1 will auto eat/drink when PC is at 80% of maximum levels.
//A value of 2 will auto eat/drink when PC is at 60% of maximum levels.
//A value of 3 will auto eat/drink when PC is at 40% of maximum levels.
//A value of 4 will auto eat/drink when PC is at 20% of maximum levels.
int AUTOEATDRINKRATE = 2;

//This determines at what percentage of the maximum hunger and thirst levels
//a PC is unable to rest becuase of hunger and/or thirst.
//The PC cannot rest if their current levels are below the given percentage.
float RESTRESTRICTIONPERCENT = 0.6;

//The next two variables determines what base AC level will cause additonal fatigue
//loss and at what bonus multiplier the extra loss will occur at.
//(see DEFFATIGUECONSUMERATE above) Note that this multiplier will be
//stacked WITH any area based multiplier already in effect.
//For example if your Desert area has a Fatigue multiplier of 3, and the
//Default consume rate is 10, every fatigue check will result in a loss of
//fatigue leves by 3 * 10 on 30 points.  If the PC is wearing Armor with
//AC >= FATIGUEARMORPEN, then it would be 30 multiplied by the
//FATIGUEARMORPENMULTIPLIER as well. If that was equal to 1.5, in the example
//that PC would lose 30 * 1.5, or 45 fatigue level points per check.
//Thus a good lesson to PCs will be if the area environment makes you tired to
//begin with, dont make yourself extra tired by wearing heavy armor all the time.
int FATIGUEARMORPEN = 6;
float FATIGUEARMORPENMULTIPLIER = 1.5;

//Change the below value to increase or decrease the amount of changes the
//water canteen item can hold.
int MAXCANTEENCHARGES = 5;

//End of HTF system variables.
