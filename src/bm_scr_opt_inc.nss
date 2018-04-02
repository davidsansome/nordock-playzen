    //Created By: Brandon Mathis
    //Created On: July 13, 2002
    //This file contains options and settings for the scroll creation system.
    //If you change any of these options you must recompile all the bm_scr_ scripts.
    //Goto Build, Build Module.  Ignore any errors on files ending with _inc.


    // Setting SCROLLWAITTIME to 0 will allow players to create scrolls with no
    // delay.  Setting it to any higher will cause the player to have to wait for
    // that many game hours.  That defaults to 2 minutes per game hour.
    int SCROLLWAITTIME=0;

    //Setting SCROLLDISTANCE to 0 will allow players to wander any distance away from
    //the spot where they initially started creating a scroll.  Setting it to any other
    //number will allow them to travel that distance in meters before creating the
    //scroll fails.
    //float SCROLLDISTANCE=1000.0f; -- Not currently used.
