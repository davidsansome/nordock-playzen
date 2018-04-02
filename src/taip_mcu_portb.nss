void main()
{
object oPC = GetLastUsedBy();
location craftLocation = GetLocation(GetWaypointByTag("taip_mcu_toYard"));
AssignCommand(oPC,JumpToLocation(craftLocation));
}
