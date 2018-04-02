#include "rr_persist"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GPI(oPC,"kat_gatekeeper_reward")==1) return 0;
else return 1;
}
