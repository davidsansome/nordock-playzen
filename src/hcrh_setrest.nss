

#include "hc_inc_helper"

void main()
{
    object oDM=OBJECT_SELF;
    object oImp;
    oImp=CreateObject(OBJECT_TYPE_CREATURE, "worldmaker", GetLocation(oDM), TRUE);
    SetLocalObject(oImp, "Customer", oDM);
    SetLocalString(oImp, "ADJUST", "RESTBREAK");
}

