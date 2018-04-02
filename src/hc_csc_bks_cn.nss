//::///////////////////////////////////////////////
//:: FileName hc_csc_bks_cn
//:://////////////////////////////////////////////
int StartingConditional()
{
if (GetLevelByClass(CLASS_TYPE_CLERIC,GetPCSpeaker())>0 ){
    if(GetAlignmentLawChaos(GetPCSpeaker()) == ALIGNMENT_LAWFUL)
        return FALSE;
    }

    return TRUE;
}
