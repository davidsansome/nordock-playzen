#include "ats_inc_activate"

void main()
{
    ATS_CheckActivatedItem(GetItemActivator(), GetItemActivated(),
                           GetItemActivatedTarget(), GetItemActivatedTargetLocation());
}
