#include "cohort_inc_vars"
#include "hc_inc_pwdb_func"

void main()
{
    SetPersistentLocation(OBJECT_SELF, "EmergencyHomeBase", GetLocation(OBJECT_SELF));
    SpeakString("Ok. If anything bad happens, I will go to " + GetName(GetAreaFromLocation(GetLocation(OBJECT_SELF))) + ".");
}
