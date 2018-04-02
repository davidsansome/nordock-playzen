//::///////////////////////////////////////////////
//:: FileName hc_csc_bks_ce
//:://////////////////////////////////////////////
int StartingConditional()
{

if (GetLevelByClass(CLASS_TYPE_CLERIC,GetPCSpeaker())>0 ){
    if(GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_GOOD)
        return FALSE;
    if(GetAlignmentLawChaos(GetPCSpeaker()) == ALIGNMENT_LAWFUL)
        return FALSE;
    }

    return TRUE;
}
