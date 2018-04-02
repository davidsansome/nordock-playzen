void main()
{
object oPC = GetLastUsedBy();
if (GetItemPossessedBy(oPC, "taip_mcu_key") != OBJECT_INVALID)
{
    location craftLocation = GetLocation(GetWaypointByTag("taip_mcu_yardspawn"));
    ExploreAreaForPlayer(GetAreaFromLocation(craftLocation),oPC);
    AssignCommand(oPC,JumpToLocation(craftLocation));
    }


}
