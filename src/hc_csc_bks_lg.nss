//::///////////////////////////////////////////////
//:: FileName hc_csc_bks_lg
//:://////////////////////////////////////////////

int StartingConditional()
{
if (GetLevelByClass(CLASS_TYPE_CLERIC,GetPCSpeaker())>0 ){
    if(GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_EVIL)
        return FALSE;
    if(GetAlignmentLawChaos(GetPCSpeaker()) == ALIGNMENT_CHAOTIC)
        return FALSE;
    }

    return TRUE;
}
