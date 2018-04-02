#include "cohort_inc"

void main()
{
    if(PWCOHORT)
    {
        SetPersistentInt(GetPCSpeaker(), GetTag(OBJECT_SELF) + "RefusedSeekingEmployment", TRUE);
        DeletePersistentObject(OBJECT_SELF, "SeekingEmploymentBy");
    }
    else
    {
        SetLocalInt(GetPCSpeaker(), GetTag(OBJECT_SELF) + "RefusedSeekingEmployment", TRUE);
        DeleteLocalObject(OBJECT_SELF, "SeekingEmploymentBy");
    }
}
