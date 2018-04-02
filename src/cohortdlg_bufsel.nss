#include "paus_inc_generic"

void main()
{
    //object oAss = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,GetPCSpeaker());
    int iBuffed = TalentUseProtectionOthers(OBJECT_SELF);
    if (!iBuffed) iBuffed = TalentEnhanceOthers(OBJECT_SELF,TRUE);
    SetLocalInt(GetPCSpeaker(),"BuffedUp",iBuffed);
}
