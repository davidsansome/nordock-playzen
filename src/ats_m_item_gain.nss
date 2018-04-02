#include "ats_inc_acquire"

void main()
{
    ATS_OnAcquireItem(GetItemPossessor(GetModuleItemAcquired()), GetModuleItemAcquired(), GetModuleItemAcquiredFrom());
}
