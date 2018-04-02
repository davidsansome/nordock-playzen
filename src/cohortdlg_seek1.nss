#include "cohort_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(SEEKEMPLOYMENT)
        if(PWCOHORT)
        {
            if(GetIsObjectValid(GetPersistentObject(OBJECT_SELF, "SeekingEmploymentBy")) && (!GetDidDie()))
            {
                if(oPC == GetPersistentObject(OBJECT_SELF, "SeekingEmploymentBy"))
                    return TRUE;
            }
        }
        else
        {
            if(GetIsObjectValid(GetLocalObject(OBJECT_SELF, "SeekingEmploymentBy")) && (!GetDidDie()))
            {
                if(oPC == GetLocalObject(OBJECT_SELF, "SeekingEmploymentBy"))
                    return TRUE;
            }
        }

    return FALSE;
}
