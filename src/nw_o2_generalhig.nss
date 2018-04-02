//#include "sy_t_tclass"
#include "RR_TREASURE"
//::///////////////////////////////////////////////
//:: sy_t_genloot.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By:  Syrsuro
//:: Created On:  November - May
//:://////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////This script is intended to be used as the OnDeath and OnOpen script of a container.
///////In addition to sy_t_tlass, the files sy_t_magic.nss and sy_t_mundane are necessary.
///////////////////////////////////////////////////////////////////////////////////////////
//Declarations///////////////////////////
//object GetLastOpener();
//void ShoutDisturbed();
////////////////////////////////////////
//This script is supposed to create an average treasure.  Thus, the modifier is set to 5.
//This modifier is passed to the other scripts and used to determine the quantity of gold and
//the frequency of gems.



///////////////////////////////////////////////////////////////////////////////////
////////This script takes the Level of the PC who opens or destroys the container and
////////uses this to scale the treasure off of.  If you want to pre-set the CR of the
////////encounter/ container; you can set nCR directly.
////////////////////////////////////////////////////////////////////////////////////

//This script generates a RICH treasure.  The odds of a magic item, the amount of
//cash found and the likelihood of finding gems is increased relative to a standard treasure.

void main()
{
int nTModifier = 10; //Default values are 2 (poor), 6 (standard) and 10 (rich).

if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
    object oLastOpener = GetLastOpener();
//    int nCR = GetHitDice(oLastOpener);  /// Sets the CR = level of opener..
    //nCR = 20;                         /// Sets the CR as a pre-set value.
//    TreasureChance(OBJECT_SELF, nCR, nTModifier);   /// The Treasure Generation Function (defined in sy_t_tcass)
    CT_rr_master_lewt_high(oLastOpener, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    ShoutDisturbed();                   /// Should make local NPCs of the same faction as the chest hostile.
}

