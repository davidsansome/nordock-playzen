#include "paus_inc_generic"

void main()
{
    object oAss = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,GetPCSpeaker());
    int iBuffed = TalentUseProtectionOthers(oAss);
    if (!iBuffed) iBuffed = TalentEnhanceOthers(oAss,TRUE);
    SetLocalInt(GetPCSpeaker(),"BuffedUp",iBuffed);
}
