//::///////////////////////////////////////////////
//:: Name       gateway_onenter
//:: FileName   gateway_onenter.nss
//:: Copyright (c) 2003 Richterms Retreat
//:://////////////////////////////////////////////
/*
   OnEnter Script for Gateway.

   Call init_ats
   Set "nomagic" local variable on any PC entering
   and warns them this is a nomagic area.

   DMs and creatures possessed by DMs are not affected.
*/
//:://////////////////////////////////////////////
//:: Created By:      Q'el
//:: Created On:      16 June 2003
//::
//:: Modified:        27 June 2003  by Qel  Qel-1
//::
//:: Modifications:
//:: Qel-1   Prevent familiars getting tradeskill journals
//:://////////////////////////////////////////////
#include "init_ats"

void main()
{
object oPC = GetEnteringObject();

if (GetIsPC(oPC))   //---Qel-1  don't want familiars and any other summons getting initialised for ATS
    init_ats();


if (GetIsPC(oPC) && !GetIsDM(oPC) && !GetIsDM(GetMaster(oPC)))
    {
    DelayCommand(1.2, SendMessageToPC(oPC, "You are entering a NO MAGIC area.  Spellcasting is prohibited."));
    SetLocalInt(oPC, "nomagic", TRUE);
    }
}
