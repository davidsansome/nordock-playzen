/*  HCR Persistent Items

  OVERVIEW
    This file lists the items that currently are considered Persistent via the
    PWDB system by Valerio Santinelli - tanis@mediacom.it

    You should also use this file to keep track of Module specific things you
    make Persistent.

    INSTRUCTIONS FOR RESTORATION OF Persistent VARIABLES:
    When you shut down your server, go into the log file that was created and
    copy the section between PWDBLoad() or PWDBLoadChanged()  and paste it over
    that function in hc_inc_pwdb_date.
    Then rebuild your module and voila, persistance.

    To make things in your module Persistent, instead of using SetLocal<blah> you
    use SetPersistent<blah>  (you also must #include "hc_inc_pwdb_func" at the
    top)

    Many thanks to Valerio Santinelli for coming up with this easy to use system.

 CURRENT HCR Persistent ITEMS
 - Starting Year, Month, Day, Hour
 - Current Year, Month, Day, Hour, Minute, Second.
 - PC's PK Count
 - PC's Current Character (if using Single Character option)
 - Player DM (if Set by a DM with HCRHelper)
 - Player's Last Location.  Whenever you rest your last location is set.
 - PC's Player State
 - Player's Hit points
 - Player's Last Rest Time
 - Player's Last Recovery Check
 - Level cost penalties (if using Leveltrain)
 - Player's Death Location

*/

void main()
{

}
