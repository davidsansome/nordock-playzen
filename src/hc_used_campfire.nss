// hc_used_campfire
// Archaegeo 2002
// Campfire kumbiya time


void main()
{
    object oPC=GetLastUsedBy();
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,120.0));
}
