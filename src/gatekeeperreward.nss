//::///////////////////////////////////////////////
//:: FileName gatekeeperreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/22/2004 5:35:31 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some gold
	GiveGoldToCreature(GetPCSpeaker(), 50000);

	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 10000);

}
