//::///////////////////////////////////////////////
//:: Name       gateway_onexit
//:: FileName   gateway_onexit.nss
//:: Copyright (c) 2003 Richterms Retreat
//:://////////////////////////////////////////////
/*
   OnExit Script for Gateway.

   Call ats_init_cust
   Clear "nomagic" local variable on any PC exitng
*/
//:://////////////////////////////////////////////
//:: Created By:      Q'el
//:: Created On:      16 June 2003
//:://////////////////////////////////////////////

// Moved to hc_on_mod_load
//#include "ats_init_cust"

void main()
{
    // Moved to hc_on_mod_load
    //ats_init_cust();

    object oPC = GetExitingObject();

    if (GetIsPC(oPC))
    {
        SetLocalInt(oPC, "nomagic", FALSE);

        // Robin - 15-02-2005
        SetLocalInt(oPC, "CanUseNewbieStore", FALSE);
    }

}
