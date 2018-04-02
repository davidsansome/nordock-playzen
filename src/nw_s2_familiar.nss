//::///////////////////////////////////////////////
//:: Summon Familiar
//:: NW_S2_Familiar
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell summons an Arcane casters familiar
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 27, 2001
//:://////////////////////////////////////////////

#include "hc_inc"

void main()
{
    if(GetLocalInt(oMod,"REALFAM"))
    {
        if(GetLocalInt(oMod,"FAMDIED"+GetName(OBJECT_SELF)))
        {
            object oPC=OBJECT_SELF;
            if(GetGold(oPC) < 100)
            {
                SendMessageToPC(oPC,"You need 100gp to pay for the materials.");
                return;
            }
            TakeGoldFromCreature(100, oPC, TRUE);
        }
    }
    //Yep thats it
    SummonFamiliar();
}
