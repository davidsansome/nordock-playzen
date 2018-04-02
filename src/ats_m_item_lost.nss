#include "ats_inc_unacq"

void main()
{
    ATS_OnUnAcquireItem(GetModuleItemLost(), GetModuleItemLostBy(), GetModuleItemAcquiredFrom());
}
