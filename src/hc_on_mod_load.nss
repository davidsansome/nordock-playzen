// Now the location where all features have their default value set.
// This is to allow things to be toggleable on the fly.

#include "hc_inc"
#include "hc_inc_on_load"
#include "hc_inc_htf"
#include "subraces"
#include "ats_inc_init"
// Moved from gateway_onexit
#include "ats_init_cust"
#include "aps_include"
#include "rr_persist"

void UpdateClientTime()
{
    // Sending time information to clients is considered low priority by the
    // server.  In large modules, there's so much higher priority stuff to do
    // that the time never gets updated.
    // This forces the server to update the clients with the current time.
    SetCalendar(GetCalendarYear(), GetCalendarMonth(), GetCalendarDay());
    SetTime(GetTimeHour(), GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());

    DelayCommand(120.0f, UpdateClientTime());
}

void SaveServerTime()
{
    // This saves the time in the database so it can be restored after a server
    // reboot
    SPI(oMod, "CurrentYear", GetCalendarYear());
    SPI(oMod, "CurrentMonth", GetCalendarMonth());
    SPI(oMod, "CurrentDay", GetCalendarDay());
    SPI(oMod, "CurrentHour", GetTimeHour());
    SPI(oMod, "CurrentMin", GetTimeMinute());

    DelayCommand(3600.0f, SaveServerTime());
}

void main()
{
    SetLocalString(GetModule(),"NWNX!INIT","1");
    SQLInit();

    ATS_Initialize();
    // Moved over from gateway_onexit
    ats_init_cust();

    int PWDB_HEARTBEAT_EVENT = 502;

    // Added by Grug 05-01-2004
    // Disables Crafting
    // SetLocalInt(oMod, "X2_L_DO_NOT_ALLOW_CRAFTSKILLS", TRUE);

    // Added by wEaglec for character saves
    ExecuteScript("qel_exportall",oMod);

    // Added by Grug 06-01-2004
    // Resets the Nachos Reset Pillar
    SetLocalInt(GetModule(), "reset", 0);
    SetLocalInt(oMod, "ResetTimer", FALSE);
    DelayCommand(180.0, SetLocalInt(oMod, "ResetTimer", TRUE));

    // Load the persistent data
    if (GetLocalInt(oMod,"AlreadyExecutedOMD") ==1)
    {
        postEvent();
        return;
    }
    else
        SetLocalInt(oMod,"AlreadyExecutedOMD",1);
    Subraces_InitSubraces();
    Subraces_SetDefaultAreaSettings( AREA_DARK + SUBRACE_AREA_UNDERGROUND );
    ExecuteScript("hc_pwdb_data",oMod);
    // Setup the event to save the world
    SetLocalInt(GetModule(), "ModLoadEvent",1);
    event evEvent = EventUserDefined(PWDB_HEARTBEAT_EVENT);
    SignalEvent(OBJECT_SELF,evEvent);
    if(!preEvent()) return;
    ExecuteScript("hc_defaults",oMod);
    // Removed by Robin Apr 05
    //ExecuteScript("hc_setareavars",oMod);

    // Added by Robin Jun 05
    int iYear = GPI(oMod, "CurrentYear");
    int iMonth = GPI(oMod, "CurrentMonth");
    int iDay = GPI(oMod, "CurrentDay");
    int iHour = GPI(oMod, "CurrentHour");
    int iMin = GPI(oMod, "CurrentMin");
    SetCalendar(iYear, iMonth, iDay);
    SetTime(iHour, iMin, 0, 0);

    // Force the client's time to be updated every 2 minutes
    DelayCommand(120.0f, UpdateClientTime());
    // Save the time to the database every 60 minutes
    DelayCommand(3600.0f, SaveServerTime());

    // Changes by Nakey 25-01-04
    // Makes ammunition NPC randomly spawn at one of four waypoints
    string sNky_NewTag = "NKY_BAGNPC" + IntToString(d4());
    string sNky_BagNpcSpawn = "WP_" + sNky_NewTag + "_01";
    location lNky_BagNpcSpawn = GetLocation(GetObjectByTag(sNky_BagNpcSpawn));
    CreateObject(OBJECT_TYPE_CREATURE, "Nky_BagNpc", lNky_BagNpcSpawn, FALSE, sNky_NewTag);
    // End Changes by Nakey

//    LoopHTFSystemChk();

// Init placeholders for ODBC gateway
//    SQLInit();

    DelayCommand(1.0, ExecuteScript("bank_init",oMod));
    DelayCommand(1.0, ExecuteScript("tha_load",oMod));
    DelayCommand(5.0, ExecuteScript("ats_init_msp", GetModule()));
    postEvent();
}
