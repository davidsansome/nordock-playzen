#include "cohort_inc"

void main()
{
    if(PWCOHORT)
        DeletePersistentObject(OBJECT_SELF, "SeekingEmploymentBy");
    else
        DeleteLocalObject(OBJECT_SELF, "SeekingEmploymentBy");
}
