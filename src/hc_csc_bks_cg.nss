//::///////////////////////////////////////////////
//:: FileName hc_csc_bks_cg
//:://////////////////////////////////////////////
int StartingConditional()
{
if (GetLevelByClass(CLASS_TYPE_CLERIC,GetPCSpeaker())>0 ){
    if(GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_EVIL)
        return FALSE;
    if(GetAlignmentLawChaos(GetPCSpeaker()) == ALIGNMENT_LAWFUL)
        return FALSE;
    }

    return TRUE;
}
