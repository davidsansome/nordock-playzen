#include "hc_inc_htf"
#include "hc_inc"
#include "rr_persist"

void DecrementTalentIndex(int iIndex, object oPC)
{
    int iDecrementIndex;
    talent tSpell;
    talent tFeat;
/* create our talent */
    tSpell = TalentSpell(iIndex);
    tFeat = TalentFeat(iIndex);
/* check for all spells */
    if (GetIsTalentValid(tSpell))
    {
        if (GetHasSpell(GetIdFromTalent(tSpell), oPC))
        {
            for (iDecrementIndex = 1; iDecrementIndex < 20; iDecrementIndex++)
            {
                DecrementRemainingSpellUses(oPC, GetIdFromTalent(tSpell));
            }
        }
    }
}

void DecrementFeatIndex(int iIndex, object oPC)
{/* check for all feats*/
    int iDecrementIndex;
    talent tSpell;
    talent tFeat;
    tSpell = TalentSpell(iIndex);
    tFeat = TalentFeat(iIndex);
    if (GetIsTalentValid(tFeat))
    {
        if (GetHasFeat(GetIdFromTalent(tFeat), oPC))
        {
            for (iDecrementIndex = 1; iDecrementIndex < 20; iDecrementIndex++)
            {
                DecrementRemainingFeatUses(oPC, GetIdFromTalent(tFeat));
            }
        }
    }
 }

 void strip_spells(object oPC)
{
    int iIndex;
    for (iIndex = 1; iIndex < 512; iIndex++)
    {
        DecrementTalentIndex(iIndex, oPC);
    }
}

void strip_feats(object oPC)
{
    int iIndex;
    for (iIndex = 1; iIndex < 512; iIndex++)
    {
        DecrementFeatIndex(iIndex, oPC);
    }
}

void main()
{
    object oMod = GetModule();

object oPC=GetEnteringObject();
    if (!GetIsPC(oPC))
        return;

    // Removed by Grug 25-May-2004 to replace with death variable
    //object oFR=CreateItemOnObject("fugue_nod",oPC);
    // SetLocalInt(oMod, "NCP_DEAD_" + GetPCPublicCDKey(oPC), 1); // Set the player as dead
    SPI(oPC, "NCP_DEAD", 1);

    SetPlotFlag(oPC,FALSE);
    DelayCommand(3.0,DeleteLocalInt(oPC,"MOVING"));
    //ExportAllCharacters();
    // ===== This is code for fixing shifters =====
    //object oPCSF = GetFirstPC();
    //while ( GetIsObjectValid(oPCSF) ) // Loop through all the Players
    //{
    //    if ( GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCSF)) )
    //        DelayCommand(0.1, ExecuteScript("ws_saveall_sub", oPCSF));
    //        // We HAVE to use DelayCommand here or else properties will not carry over no matter what you do.
    //
    //    oPCSF = GetNextPC();
    //} // while
    int iHUNGERSYSTEM = GetLocalInt(oMod,"HUNGERSYSTEM");
    int iFATIGUESYSTEM = GetLocalInt(oMod,"FATIGUESYSTEM");
    if (iHUNGERSYSTEM || iFATIGUESYSTEM)
        ResetHTFLevels(oPC);
    if(GetLocalInt(oMod,"GHOSTSYSTEM") && GetIsPC(oPC))
    {
        SetLocalInt(oPC,"GHOST",1);
        location lDeath;
        lDeath=GetPersistentLocation(oMod,"DIED_HERE"+GetName(oPC)+GetPCPublicCDKey(oPC));
        effect eParalyze = EffectParalyze();
        DelayCommand(3.5,AssignCommand(oPC,JumpToLocation(lDeath)));
        DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oPC));
        effect eInvis=EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPC);
        DelayCommand(5.5,SetPlotFlag(oPC,TRUE));
    }
    //if(GetLocalInt(oMod,"GHOSTSYSTEM"))
    strip_feats(oPC);
    strip_spells(oPC);

    // Added by Robin - Apr 05
    // Polymorph the player into a wraith

    /*if (GetIsPC(oPC) || GetIsDM(oPC))
    {
        //effect ePoly = EffectPolymorph(POLYMORPH_TYPE_SPECTRE, TRUE);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, oPC);

        SPI(oPC, "AppearanceType", GetAppearanceType(oPC));

        string sSubrace = GetStringLowerCase(GetSubRace(oPC));
        if ((sSubrace == "drow") || (sSubrace == "duergar"))
            SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ALLIP);
        else
            SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_WRAITH);
    }*/
}
