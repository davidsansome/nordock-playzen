//::///////////////////////////////////////////////
//:: FileName hc_csc_bks_ne
//:://////////////////////////////////////////////
int StartingConditional()
{
if (GetLevelByClass(CLASS_TYPE_CLERIC,GetPCSpeaker())>0 ){
    if(GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_GOOD)
        return FALSE;
    }
    return TRUE;
}
