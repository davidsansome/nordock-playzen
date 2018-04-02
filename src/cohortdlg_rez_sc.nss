//::///////////////////////////////////////////////
//:: Resurrecting Cohort Check Script.
//:: cohortdlg_rez_sc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    v1.0.3   This script is to be used on the Check hook for in a
    conversation file, for when the NPC is instructed to resurrect a Death
    Corpse.

*/
//:://////////////////////////////////////////////
//:: Created By: Nathan 'yibble' Reynolds <yibble@yibble.org>
//:: Created On: 02/09/2002
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oCreature = GetNearestObjectByTag("DeathCorpse");
    object oOwner = GetLocalObject(oCreature, "Owner");
    object oMod = GetModule();

    int iResult = FALSE;

    if((GetIsObjectValid(oCreature)) && (GetDistanceBetween(OBJECT_SELF, oCreature) <= 50.0))
    {
        if(GetLocalInt(oMod,"LOOTSYSTEM"))
            SetCustomToken(3850, GetLocalString(oCreature, "Name"));
            iResult = TRUE;
    }
    return iResult;
}
