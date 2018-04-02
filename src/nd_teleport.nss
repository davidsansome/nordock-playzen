/////////////////////////////////////////////////
//  Ultimate Teleport Script 1.0
/////////////////////////////////////////////////
//  by Amurayi (mschdesign@hotmail.com)
//
//  based on SirLestat's Secret Trapdoorscripts
/////////////////////////////////////////////////
/* The problem with most of the teleport scripts out there is that your companions
won't be teleported with you if you ar ebeing teleported within the same area.
This easy to configure script here is the solution for this old problem. Simply
alter the way how the teleport shall work by turning the options on and off be
setting the variables to 0 or 1 in the first ppart of this script.

What this script can do:
- teleports player out of conversation, trigger or item
- teleports player with or without companions
- teleports player alone or the whole party (players)
*/
void JumpAssociate(object i_oPC, int i_type, object i_oWP)
{
    object oAssociate = GetAssociate(i_type, i_oPC);
    if(GetIsObjectValid(oAssociate))
        AssignCommand(oAssociate, JumpToObject(i_oWP));
}

void main()
{
    // uncomment one of the next 3 lines depending where you use the script:
    // object oPC = GetPCSpeaker();     // for conversations
    // object oPC = GetEnteringObject;  // for triggers
    object oPC = GetLastUsedBy();       // for items/objects

    // set to 1 if you want to teleport the whole party of the player, whereever every member is:
    int iTeleportWholeParty = 0;
    // set to 1 if you want the Associates of the player to be teleported as well, otherwise to 0:
    int iTeleportAssociateToo = 1;
    // Enter the destination Waypoint in here:
    object oDWP = GetWaypointByTag("nd_CryptExitTeleport");
    // Make the player say something on his departure (so others will now that he teleported but crashed):
    string sGoodbye = "I am leaving this cursed place.";
    // Enter the message being send to the player when teleport starts:
    string sTeleportmessage = "Thou are being teleported to another area.";


    // Don't start Teleport at all if activator isn't a player or DM
    if(!GetIsPC(oPC))
        return;

    if (iTeleportWholeParty == 1)
        {
        object oFM = GetFirstFactionMember(oPC);
        // Step through the party members.
        while(GetIsObjectValid(oFM))
            {
            AssignCommand(oFM, ActionSpeakString(sGoodbye));
            SendMessageToPC(oFM, sTeleportmessage);
            AssignCommand(oFM,  DelayCommand(2.0, JumpToObject(oDWP)));
            if (iTeleportAssociateToo == 1)
                {
                // now send the players companions over as well:
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_ANIMALCOMPANION, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_DOMINATED, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_FAMILIAR, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_HENCHMAN, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_SUMMONED, oDWP));
                }
            // Select the next member of the faction and loop.
            oFM = GetNextFactionMember(oFM);
            }
        }
    else
       {
        // Uncomment the next 2 lines if you like fancy animations (plays the summon monster 3 animation)
        // effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        // ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oFM);
        AssignCommand(oPC, ActionSpeakString(sGoodbye));
        SendMessageToPC(oPC, sTeleportmessage);
        AssignCommand(oPC, DelayCommand(2.0, JumpToObject(oDWP)));
        if (iTeleportAssociateToo == 1)
            {
            // now send the players companions over as well:
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_ANIMALCOMPANION, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_DOMINATED, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_FAMILIAR, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_HENCHMAN, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_SUMMONED, oDWP));
            }
        }
}
