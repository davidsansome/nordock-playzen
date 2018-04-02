void main()
{
object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
SetLocalInt(oPC, "bet", 0);
ActionStartConversation (oPC, "", TRUE);
}
