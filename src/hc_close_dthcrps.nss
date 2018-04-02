
#include "hc_inc_transfer"

void main()
{
    object oOwner=GetLocalObject(OBJECT_SELF,"Owner");
    object oDC=OBJECT_SELF;
    if(GetIsObjectValid(oOwner))
        hcTransferObjects(oDC, oOwner, 2);
}
