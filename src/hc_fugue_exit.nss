#include "ats_inc_cl_enter"
#include "rr_persist"
#include "hc_inc"
void main()
{
    object oMod = GetModule();
object oPC=GetExitingObject();
    object oFR;
    int nGhost=GetLocalInt(GetModule(),"GHOSTSYSTEM");
    // Altered by Grug 25-May-2004 to replace with death variable
    //if((oFR=GetItemPossessedBy(oPC, "fugue_NOD"))!=OBJECT_INVALID && (!nGhost || GetIsPC(oPC)))
        //DestroyObject(oFR);
    if(GPI(oPC, "NCP_DEAD") && (!nGhost || GetIsPC(oPC)))
        {
        SPI(oPC, "NCP_DEAD", 0); // Set the player as alive
        }
    SPS(oPC,PWS_PLAYER_STATE_ALIVE);

    SetPlotFlag(oPC,FALSE);
    ATS_InitializePlayer(oPC);

    // Added by Robin - Apr 05
    // Remove the wraith polymorph effect
    /*effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
        {
            RemoveEffect(oPC, eEffect);
            DelayCommand(10.0f, RemoveEffect(oPC, eEffect));
        }
        eEffect = GetNextEffect(oPC);
    }*/
    /*int iOldAppearanceType = GPI(oPC, "AppearanceType");
    SetCreatureAppearanceType(oPC, iOldAppearanceType);*/

// save the character
ExportSingleCharacter(oPC);

}
