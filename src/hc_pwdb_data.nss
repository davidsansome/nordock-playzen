//:://////////////////////////////////////////////////
//:: Created By:   Valerio Santinelli - tanis@mediacom.it
//:: Created On:   2002/08/09
//:://////////////////////////////////////////////////
//***************************************************************************
/*
    Persistent World DataBase data.
    Credits to E.J. Wilburn - zane@supernova.org for the original idea.

    Paste the loading functions from your log files here.  You should delete the
    replace the already existing functions unless you're doing a crash
    recovery.
    In the case of a crash recovery keep your old script and add in
    the changed script and call both from your module OnLoad event.  This file
    should be included in your module's OnLoad script (as well as any others
    that need to take advantage of persistant variables).

    If your PWBLoad() is completely current and you don't need a PWDBLoadChanged()
    then empty the contents of PWDBLoadChanged() but keep that function here.

    *** REMEMBER TO HIT CTRL-R AND REPLACE ALL &QUOT; WITH A DOUBLE QUOTE (")
*/
#include "hc_inc"

void PWDBLoad()
{
}

void PWDBLoadChanged()
{
}

void main()
{
    PWDBLoad();
    PWDBLoadChanged();
}
