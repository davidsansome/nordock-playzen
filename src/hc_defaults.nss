// Now the location where all features have their default value set.
// This is to allow things to be toggleable on the fly.

#include "hc_inc"

// TRIGGERS, if set to 0 the listed system will be deactivated, defaults to 1
// NOTE: If you change any of these, you must recompile all modules that begin
// with hc_   To do so, open them in script editor, and click compile and save.

    // Set PWEXP to 1 to use the Persistent World Exp system
    int PWEXP=0;

    // If you set GHOSTSYSTEM to 1, players will return to their corpses as a
    // ghost.
    int GHOSTSYSTEM=0;

    // If you use the SPELLSYS add-on, and want MATERCOMPs to be required then
    // you must set MATERCOMP below to 1.
    int MATERCOMP=0;

    // Set SINGLECHARACTER to 1 to restrict players to one character each, even if
    // that character is dead.
    int SINGLECHARACTER=0;

    // Set LOGINMESSAGE to anything you want show to all players when logging in
    // If you want no message show, change LOGINMESSAGE to "NONE"
    string LOGINMESSAGE="Welcome to NTFM Nordock, big thanks to www.playZen.net for hosting.";

    // Set DEATHOVERREBOOT to 0 to allow folks to come back to life after a
    // server reset.
    int DEATHOVERREBOOT=1;

    // SUMMONTIME - If 0, will use normal summoning duration, if 1 will cause creature
    // to last 1 round (6 sec) per HitDice (level) of the summoner.  You can set it to
    // higher numbers to multiple rounds, ie 3 would be 18 seconds per level of summoner.
    // By the book though its 1 round.
    int SUMMONTIME=10;

    // REALFAM - If set to 0, you get BW familiars that instant heal when you
    // "feed" them.
    int REALFAM=0;

    // HCRTRAPS Setting this to 0 makes the Find Traps spell use the normal NWN
    // system.
    int HCRTRAPS=0;

    // Set LEVELTRAINER to 0 to not require players find a trainer to level up.
    // Set LEVELCOST to the amount of gold per level that training costs.
    int LEVELTRAINER = 0;
    int LEVELCOST = 1000;
    // GIVELEVEL - Sets the level that players start at in your world.
    int GIVELEVEL=2;

    // Set DMRESERVE to a number of players you want to be online, then when you
    // start your server, set the max number of players to a number higher than
    // DMRESERVE and you will always be able to log on.  This defaults to disabled.
    int DMRESERVE=64;

    // Setting PKTRACKER enables automatic banning of a player by CDKEY when he
    // exceeds the number of PK's of PKTRACKER.  Helps prevent griefers.  Defaults
    // to 5 (means boots on number 6)
    int PKTRACKER=50;
    // Set this to 0 if you dont want to know when one player kills anothers.
    int TELLONPK=1;

    // Setting WANDERSYSTEM to 1 will add the check for wandering monsters.
    // NOTE: Wandering monsters will only be found if an area has a local int
    // of WANDERCHANCE set to > 0 anyway) so turning this on only uses a few
    // cpu cycles.
    int WANDERSYSTEM=0;

    // Setting GODSYSTEM to 0 will remove ability to pray for resurrection.
    int GODSYSTEM=1;
    // Setting DEATHSYSTEM to 0 will allow respawn and quit and return to get
    // around being dead or dying. (Removes death amulets)
    int DEATHSYSTEM=1;
    // Setting BLEEDSYSTEM to 0 will remove the bleed to death system.
    int BLEEDSYSTEM=1;
    // Setting LOOTSYSTEM to 0 will remove the ability to loot a pc corpse.
    int LOOTSYSTEM=1;
    // REZCHANCE - Controls percent chance of sucessful resurrection IF GODSYSTEM
    int REZCHANCE=5;
    // Setting REZPENALTY to 0 will turn off the losing of 1/2 a level
    int REZPENALTY=0;
    // Setting LIMBO to 0 will stop moving players to Fugue on death
    int LIMBO=1;
    // Nordock Specific - Cost of True Rez
    int TRUEREZCOST = 24000;
    // Nordock Specific - 3rd Edition Death. If 0, use scaling XP loss
    int PNPDEATH = 0;
    // Nordock Specific - if set to 1, a soul frag is issued on Guardian respawn
    int USESOULFRAG = 0;


    // Setting RESTSYSTEM to 0 will remove rest restrictions from play.
    // (You may also just not put hc_resting in OnPlayerResting
    int RESTSYSTEM=0;
    // RESTBREAK - Controls how long between rests if RESTSYSTEM is used
    int RESTBREAK=6;
    // RESTARMORPEN is set to 0 to turn off the penalty for resting in armor > 5
    int RESTARMORPEN=0;
    // Setting LIMITEDRESTHEAL to 0 will allow full healing on each rest (but
    // then why need clerics?
    int LIMITEDRESTHEAL=0;
    // Setting BEDROLLSYSTEM to 0 will turn off the functioning of bedrolls and
    // the requirement to have them to rest.
    int BEDROLLSYSTEM=0;

    // Setting STORESYSTEM to 0 will stop the stripping of and equippign of
    // new characters
    int STORESYSTEM=1;
    // Setting FOODSYSTEM to 0 will turn off need for food to rest.
    int FOODSYSTEM=1;
    // Setting BURNTORCH to 0 will restore torch durations to normal BW settings.
    // Otherwise torches will last 1 hour per BURNTORCH) PER PHB pg 144
    int BURNTORCH=0;

    // Setting HUNGERSYSTEM to 0 will turn off the need for PCs to regularly consume
    // food and water to avoid death by starvation or dehydration.
    // Setting this to 1 will IGNORE the FOODSYSTEM flag, and it will use its
    // own food system instead.
    int HUNGERSYSTEM = 0;

    // Setting FATIGUESYSTEM to 0 will turn of the ill effects recieve by a PC that
    // goes a time without resting. Note that if this is 0 it will NOT stop fatigue
    // penalties resulting from RESTARMORPEN = 1.
    int FATIGUESYSTEM = 0;

    // Setting HCREXP to 0 uses the normal BW experience system
    // See the manual for more information
    int HCREXP=1;
    // Set the base exp used for all creature kills, 300 is the DMG default per CR
    // adjust as needed to match your campaign speed
    int BASEXP=60;
    // BONUSEXP is the factor applied to creature exp amounts to further tweak the
    // advancement rate
    int BONUSXP=20;

    // HCRREAD must be set to 1 before any HCR variables will be set.  It just
    // is a small measure some folks have been asking for to make sure that
    // DM's at least have opened this file once.
    int HCRREAD=1;


void main()
{
    if(!HCRREAD)
    return;

    SetLocalInt(oMod,"PWEXP",PWEXP);

    SetLocalInt(oMod,"GHOSTSYSTEM",GHOSTSYSTEM);

    SetLocalInt(oMod,"HCRREAD",HCRREAD);

    SetLocalInt(oMod,"MATERCOMP", MATERCOMP);

    SetLocalInt(oMod,"SINGLECHARACTER",SINGLECHARACTER);

    SetLocalString(oMod,"LOGINMESSAGE", LOGINMESSAGE);

    SetLocalInt(oMod,"DEATHOVERREBOOT", DEATHOVERREBOOT);

    SetLocalInt(oMod,"SUMMONTIME", SUMMONTIME);

    SetLocalInt(oMod,"REALFAM", REALFAM);

    SetLocalInt(oMod,"HCRTRAPS", HCRTRAPS);

    SetLocalInt(oMod,"RESTARMORPEN", RESTARMORPEN);
    SetLocalInt(oMod,"RESTSYSTEM", RESTSYSTEM);
    SetLocalInt(oMod,"RESTBREAK", RESTBREAK);
    SetLocalInt(oMod,"LIMITEDRESTHEAL", LIMITEDRESTHEAL);
    SetLocalInt(oMod,"BEDROLLSYSTEM", BEDROLLSYSTEM);

    SetLocalInt(oMod,"LEVELTRAINER", LEVELTRAINER);
    SetLocalInt(oMod,"LEVELCOST", LEVELCOST);
    SetLocalInt(oMod,"GIVELEVEL", GIVELEVEL);

    SetLocalInt(oMod,"DMRESERVE", DMRESERVE);
    SetLocalInt(oMod,"PKTRACKER", PKTRACKER);
    SetLocalInt(oMod,"TELLONPK", TELLONPK);
    SetLocalInt(oMod,"WANDERSYSTEM", WANDERSYSTEM);

    SetLocalInt(oMod,"GODSYSTEM", GODSYSTEM);
    SetLocalInt(oMod,"DEATHSYSTEM", DEATHSYSTEM);
    SetLocalInt(oMod,"BLEEDSYSTEM", BLEEDSYSTEM);
    SetLocalInt(oMod,"LOOTSYSTEM", LOOTSYSTEM);
    SetLocalInt(oMod,"REZPENALTY", REZPENALTY);
    SetLocalInt(oMod,"REZCHANCE", REZCHANCE);
    SetLocalInt(oMod,"LIMBO", LIMBO);
    SetLocalInt(oMod,"TRUEREZCOST",TRUEREZCOST);
    SetLocalInt(oMod,"PNPDEATH",PNPDEATH);
    SetLocalInt(oMod,"USESOULFRAG",USESOULFRAG);

    SetLocalInt(oMod,"STORESYSTEM", STORESYSTEM);
    SetLocalInt(oMod,"FOODSYSTEM", FOODSYSTEM);
    SetLocalInt(oMod,"BURNTORCH", BURNTORCH);

    SetLocalInt(oMod,"HUNGERSYSTEM", HUNGERSYSTEM);
    SetLocalInt(oMod,"FATIGUESYSTEM", FATIGUESYSTEM);

    SetLocalInt(oMod,"HCREXP", HCREXP);
    SetLocalInt(oMod,"BASEXP", BASEXP);
    SetLocalInt(oMod,"BONUSXP", BONUSXP);
}

