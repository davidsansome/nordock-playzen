//::///////////////////////////////////////////////
//:: Name           _Chest
//:: FileName       _Chest
//:://////////////////////////////////////////////
/*
    This Script is for parsistent Worlds. Place it in the OnOpen-Event of a Chest
    or every Placeable you want to create a Treasure.

    Treasure for PCs is only created when a defined time has passed.
    If a PC has created a treasure in the Placeable, he has to wait
    NumberOfDifferentOpenersSaved * CreateDelayTime until he can create the next
    Treasure.
*/
//:://////////////////////////////////////////////
//:: Created By:    Shahron[MYST]
//:: Created On:    November, 10th 2002
//:://////////////////////////////////////////////


#include "NW_O2_CONINCLUDE"

void main()

{

    //*************** parameters  can be switched by sripter *****************\\

    int     nMaxOpenersDelay    = 5;    /* between 1 and 10: number of different openers saved
                                           => min delaytime for same opener = nMaxOpenersDelay * nHoursDelay
                                           (default = 5)*/
    int     nHoursDelay         = 2;   // CreateDelayTime (inGameHours; default = 24)
    int     nMaxTreasure        = 1;    // times the treasure will be createt by opening once (default = 1)
    int     nTreasure           = 4;    /* kind of treasure:    1 = LowTreasure
                                                                2 = MediumTreasure
                                                                3 = HighTreasure
                                                                4 = BossTreasure
                                                                5 = BookTreasure
                                                                6 = random between them
                                                                (default = 6) */
    int     nDebugMode          = FALSE; /* TRUE or FALSE: enables/disables the DebugMessages when testing ingame
                                           (default = FALSE)*/

    //************************* intern parameters ****************************\\

    object  oLastOpener         = GetLastOpener();
    int     nOpeners            = GetLocalInt(OBJECT_SELF,"NumberOfOpeners") + 1;
    string  sLastOpener         = GetName(oLastOpener);
    string  sPastOpenerHelp     = "PastOpener";
    int     nAllowed            = 1;
    int     nDebugAllowed       = 0;
    int     i                   = 0;
    int     nTotalHoursWaiting  = 0;

    int     nCurrentHour        = GetTimeHour();
    int     nCurrentDay         = GetCalendarDay();
    int     nCurrentMonth       = GetCalendarMonth();
    int     nCurrentYear        = GetCalendarYear();
    int     nLastHour           = GetLocalInt(OBJECT_SELF,"LastHour");
    int     nLastDay            = GetLocalInt(OBJECT_SELF,"LastDay");
    int     nLastMonth          = GetLocalInt(OBJECT_SELF,"LastMonth");
    int     nLastYear           = GetLocalInt(OBJECT_SELF,"LastYear");
    int     nDeltaHour          = 0;
    int     nDeltaDay           = 0;
    int     nDeltaMonth         = 0;
    int     nDeltaYear          = 0;
    int     nDeltaTotalHours    = 0;



    //********************************** Code ********************************\\


    if (!GetIsPC(oLastOpener) || (nMaxOpenersDelay > 10)) return;


    // Calculating time difference between last opening and now
    if (nCurrentHour >= nLastHour)
            nDeltaHour = nCurrentHour - nLastHour;
    else
        {
            nDeltaHour = nCurrentHour + (24 - nLastHour);
            nDeltaDay = -1 ;
        }
     if ((nCurrentDay + nDeltaDay) >= nLastDay)
        nDeltaDay = nCurrentDay - nLastDay + nDeltaDay;
    else
        {
            nDeltaDay = nCurrentDay + (28 - nLastDay) + nDeltaDay;
            nDeltaMonth = -1 ;
        }
     if ((nCurrentMonth + nDeltaMonth) >= nLastMonth)
        nDeltaMonth = nCurrentMonth - nLastMonth + nDeltaMonth;
    else
        {
            nDeltaMonth = nCurrentMonth + (12 - nLastMonth) + nDeltaMonth;
            nDeltaYear = -1 ;
        }
    nDeltaYear = nCurrentYear - nLastYear + nDeltaYear;
    nDeltaTotalHours = nDeltaHour + 24 * (nDeltaDay + 28 * (nDeltaMonth + 12 * nDeltaYear));

    if (nOpeners == 1) // allow first opener to create Treasure
        {
            nLastHour = nCurrentHour;
            nLastDay = nCurrentDay;
            nLastMonth = nCurrentMonth;
            nLastYear = nCurrentYear;
            nDeltaHour = 0;
            nDeltaDay = 0;
            nDeltaMonth = 0;
            nDeltaYear = 0;
            nDeltaTotalHours = 0;
        }
    else
        {
            for (i = (nOpeners - 1); i >=1; i--) // check if nOpener opened the chest before in if he is allowed to create new treasure
            {
                switch(i)
                {
                    case 1: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener1");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours1");
                            break;
                    case 2: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener2");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours2");
                            break;
                    case 3: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener3");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours3");
                            break;
                    case 4: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener4");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours4");
                            break;
                    case 5: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener5");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours5");
                            break;
                    case 6: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener6");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours6");
                            break;
                    case 7: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener7");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours7");
                            break;
                    case 8: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener8");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours8");
                            break;
                    case 9: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener9");
                            nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours9");
                            break;
                    case 10: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener10");
                             nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours10");
                             break;
                }
                if (sPastOpenerHelp == sLastOpener)
                {
                    if ((nTotalHoursWaiting + nDeltaTotalHours) < (nMaxOpenersDelay  * nHoursDelay))
                        nAllowed = 0;
                    if (nDebugMode == TRUE)
                        {
                            if ((nAllowed == 1) || (nDebugAllowed == 1))
                                nDebugAllowed = 1;
                            SendMessageToPC(oLastOpener, ("Pos " + IntToString(i) + ": nAllowed = " + IntToString(nAllowed) + " nDebugAllowed = " + IntToString(nDebugAllowed)));
                        }
                }
            }
            if (nDeltaTotalHours < nHoursDelay)  // if time between last create and now is to short, no treasure willbe created
                {
                    nAllowed = 0;
                    nDebugAllowed = 0;
                }
        }

    if (nDebugMode == TRUE)
    {
        SendMessageToPC(oLastOpener,"Current date is: " + IntToString(nCurrentHour) + ":00 at " + IntToString(nCurrentDay) + "." + IntToString(nCurrentMonth) + "." + IntToString(nCurrentYear));
        SendMessageToPC(oLastOpener,"Last creating date was: " + IntToString(nLastHour) + ":00 at " + IntToString(nLastDay) + "." + IntToString(nLastMonth) + "." + IntToString(nLastYear));
        SendMessageToPC(oLastOpener,"Delta opening date is: " + IntToString(nDeltaHour) + ":00h and " + IntToString(nDeltaDay) + "." + IntToString(nDeltaMonth) + "." + IntToString(nDeltaYear));
        SendMessageToPC(oLastOpener,"DeltaTotalHour = " + IntToString(nDeltaTotalHours));
        SendMessageToPC(oLastOpener, "Current Opener (" + sLastOpener + ") is Opener_nr.: " + IntToString((nOpeners)));
        SendMessageToPC(oLastOpener, "nAllowed = " + IntToString(nAllowed) + "   nDebugAllowed = " + IntToString(nDebugAllowed));
    }

    if ((nAllowed == 1) || (nDebugAllowed == 1))
    {
        for (i = 1; i <= nMaxTreasure; i++)// to create a random worth of the treasure
        {
            int nRandomTreasure = 0;
            if (nTreasure == 6)
                nRandomTreasure = 1;
            else
                nRandomTreasure = 0;
            if (nRandomTreasure == 1)
                nTreasure = Random(5) + 1;
            if (nDebugMode == TRUE)
                SendMessageToPC(oLastOpener,"Current Treasure: " + IntToString(nTreasure));

            switch(nTreasure)
            {
                case 1: GenerateLowTreasure(oLastOpener, OBJECT_SELF);
                        break;
                case 2: GenerateMediumTreasure(oLastOpener, OBJECT_SELF);
                        break;
                case 3: GenerateHighTreasure(oLastOpener, OBJECT_SELF);
                        break;
                case 4: GenerateBossTreasure(oLastOpener, OBJECT_SELF);
                        break;
                case 5: GenerateBookTreasure(oLastOpener, OBJECT_SELF);
                        break;
            }
        }
        SetLocalInt(OBJECT_SELF,"LastHour",nCurrentHour);   // saveing current creating time and number of openers
        SetLocalInt(OBJECT_SELF,"LastDay",nCurrentDay);
        SetLocalInt(OBJECT_SELF,"LastMonth",nCurrentMonth);
        SetLocalInt(OBJECT_SELF,"LastYear",nCurrentYear);
        if (nOpeners <= nMaxOpenersDelay)
            SetLocalInt(OBJECT_SELF,"NumberOfOpeners", nOpeners);

        for (i = nMaxOpenersDelay; i >= 1; i--)     // Saveing names of openers
            {
                switch(i)
                {
                    case 10: SetLocalString(OBJECT_SELF, "PastOpener10", GetLocalString(OBJECT_SELF, "PastOpener9"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours10", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours9")));
                            break;
                    case 9: SetLocalString(OBJECT_SELF, "PastOpener9", GetLocalString(OBJECT_SELF, "PastOpener8"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours9", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours8")));
                            break;
                    case 8: SetLocalString(OBJECT_SELF, "PastOpener8", GetLocalString(OBJECT_SELF, "PastOpener7"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours8", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours7")));
                            break;
                    case 7: SetLocalString(OBJECT_SELF, "PastOpener7", GetLocalString(OBJECT_SELF, "PastOpener6"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours7", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours6")));
                            break;
                    case 6: SetLocalString(OBJECT_SELF, "PastOpener6", GetLocalString(OBJECT_SELF, "PastOpener5"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours6", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours5")));
                            break;
                    case 5: SetLocalString(OBJECT_SELF, "PastOpener5", GetLocalString(OBJECT_SELF, "PastOpener4"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours5", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours4")));
                            break;
                    case 4: SetLocalString(OBJECT_SELF, "PastOpener4", GetLocalString(OBJECT_SELF, "PastOpener3"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours4", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours3")));
                            break;
                    case 3: SetLocalString(OBJECT_SELF, "PastOpener3", GetLocalString(OBJECT_SELF, "PastOpener2"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours3", (nDeltaTotalHours + GetLocalInt(OBJECT_SELF, "DeltaTotalHours2")));
                            break;
                    case 2: SetLocalString(OBJECT_SELF, "PastOpener2", GetLocalString(OBJECT_SELF, "PastOpener1"));
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours2", nDeltaTotalHours);
                            break;
                    case 1: SetLocalString(OBJECT_SELF, "PastOpener1", sLastOpener);
                            SetLocalInt(OBJECT_SELF, "DeltaTotalHours1", 0);
                            break;
                }
            }
    }
    else
    {
        nOpeners = nOpeners - 1;
    }
    if (nDebugMode == TRUE)  // geting the saved information of all openers
    {
        SendMessageToPC(oLastOpener, "****************************************");
        for (i = nOpeners; i >=1; i--)
        {
            switch(i)
            {
                case 1: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener1");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours1");
                        break;
                case 2: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener2");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours2");
                        break;
                case 3: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener3");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours3");
                        break;
                case 4: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener4");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours4");
                        break;
                case 5: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener5");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours5");
                        break;
                case 6: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener6");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours6");
                        break;
                case 7: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener7");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours7");
                        break;
                case 8: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener8");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours8");
                        break;
                case 9: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener9");
                        nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours9");
                        break;
                case 10: sPastOpenerHelp = GetLocalString(OBJECT_SELF, "PastOpener10");
                         nTotalHoursWaiting = GetLocalInt(OBJECT_SELF, "DeltaTotalHours10");
                         break;
                case 11: break; //needed in case of Placeable is opened first time
            }
            if (i <= nMaxOpenersDelay)
            {
                if (!((nAllowed == 1) || (nDebugAllowed == 1)))
                    nTotalHoursWaiting = nTotalHoursWaiting + nDeltaTotalHours;
                if (nTotalHoursWaiting > (nMaxOpenersDelay * nHoursDelay))
                    {nTotalHoursWaiting = nMaxOpenersDelay * nHoursDelay;}
                SendMessageToPC(oLastOpener, "Pos " + IntToString(i) + ": " + sPastOpenerHelp + " is waiting for " + IntToString(nTotalHoursWaiting) + "h");
                SendMessageToPC(oLastOpener, "Pos " + IntToString(i) + ": " + sPastOpenerHelp + " next treasure-create in " + IntToString((nHoursDelay * nMaxOpenersDelay) - nTotalHoursWaiting) + "h");
            }
        }
        SendMessageToPC(oLastOpener, "\n****************************************\n");
    }
      //ShoutDisturbed();
}
